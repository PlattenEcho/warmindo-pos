import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_pos/ui/pages/detail_page.dart';
import 'package:warmindo_pos/ui/pages/add_transaction_page.dart';
import 'package:warmindo_pos/ui/widgets/card.dart';
import 'package:warmindo_pos/main.dart';

import '../shared/theme.dart';

class TransaksiByDateShift extends StatefulWidget {
  final int selectedIndex;
  final DateTime tanggal;
  const TransaksiByDateShift(
      {super.key, required this.selectedIndex, required this.tanggal});

  @override
  State<TransaksiByDateShift> createState() => _TransaksiByDateShift();
}

class _TransaksiByDateShift extends State<TransaksiByDateShift> {
  List<dynamic>? transactionData;
  late int selectedIndex = widget.selectedIndex;
  late DateTime tanggal = widget.tanggal;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<dynamic> getDataTransaction() async {
    final response = await supabase
        .from('transaksi')
        .select()
        .eq('tanggal', tanggal)
        .eq('shift', selectedIndex);
    return response;
  }

  Future<void> fetchData() async {
    final response = await getDataTransaction();
    setState(() {
      transactionData = response;
    });
  }

  String selectedWarung = 'Shift 1';
  List<String> warungList = ['Shift 1', 'Shift 2'];
  String selectedDateText = "Pilih Tanggal";
  int countTransaksi = 0;
  String hargaRp = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        title: Text(
          "Transaksi",
          style: blackTextStyle.copyWith(fontWeight: bold),
        ),
        leading: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: kBlackColor,
                )),
          ],
        ),
      ),
      body: Container(
        color: kWhiteColor,
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.5),
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTransactionPage(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 61, 200, 66),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Text(
                    'Tambah',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future: getDataTransaction(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('Tidak ada yang tersedia'));
                      } else {
                        List<dynamic>? transactionData = snapshot.data;
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: transactionData?.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            final transaction = transactionData?[index];
                            final status = transaction['status'];
                            final tanggal = transaction['tanggal'];
                            final idtransaksi = transaction['idtransaksi'];
                            final shift = transaction['shift'];
                            final noMeja = transaction['kodemeja'];
                            final namaPelanggan = transaction['namapelanggan'];
                            final total = NumberFormat.currency(
                              locale: 'id',
                              symbol: 'Rp. ',
                              decimalDigits: 0,
                            ).format(transaction['total'] -
                                transaction['totaldiskon']);
                            Map<String, dynamic> mapPembayaran = {
                              "cash": "Cash",
                              "qris": "QRIS",
                              "kartu_debit": "Kartu Debit",
                            };
                            final diskon = transaction['totaldiskon'];

                            final metodePembayaran =
                                mapPembayaran[transaction['metodepembayaran']];

                            return TransaksiCard(
                              status: status,
                              date: tanggal,
                              transactionID:
                                  "WT1${tanggal.toString().replaceAll('-', '')}$shift$idtransaksi",
                              noMeja: noMeja,
                              namaPelanggan: namaPelanggan,
                              total: "$total,00",
                              metodePembayaran: metodePembayaran,
                              onDelete: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Konfirmasi'),
                                      content: const Text(
                                        'Apakah Anda yakin ingin menghapus transaksi ini?',
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: Text('Tidak'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                          },
                                          child: Text('Ya'),
                                        ),
                                      ],
                                    );
                                  },
                                ).then((shouldDelete) {
                                  if (shouldDelete ?? false) {}
                                });
                              },
                              onTap: () async {
                                final updatedStatus = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                        status: status,
                                        date: tanggal,
                                        transactionID:
                                            "WT1${tanggal.toString().replaceAll('-', '')}$shift$idtransaksi",
                                        noMeja: noMeja,
                                        namaPelanggan: namaPelanggan,
                                        total: "$total,00",
                                        metodePembayaran: metodePembayaran,
                                        diskon: diskon,
                                        idOnly: idtransaksi,
                                      ),
                                    ));
                                if (updatedStatus != null) {
                                  fetchData();
                                }
                              },
                            );
                          },
                        );
                      }
                    })),
          ],
        ),
      ),
    );
  }
}
