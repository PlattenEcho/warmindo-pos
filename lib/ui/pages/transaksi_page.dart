import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_pos/ui/pages/detail_page.dart';
import 'package:warmindo_pos/ui/widgets/card.dart';
import 'package:warmindo_pos/main.dart';

import '../shared/gaps.dart';
import '../shared/theme.dart';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({super.key});

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  List<dynamic>? transactionData;

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

  List<String> warungList = ['Shift 1', 'Shift 2'];
  String selectedWarung = 'Shift 1';
  int selectedIndex = 1;

  String selectedDateText = "Pilih Tanggal";
  DateTime tanggal = DateTime.now();
  int countTransaksi = 0;
  String hargaRp = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWhiteColor,
      margin: const EdgeInsets.symmetric(horizontal: 2.5),
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
            child: Column(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(0),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      side: BorderSide(color: kBlackColor.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                    backgroundColor: MaterialStateProperty.all(kWhiteColor),
                    minimumSize: const MaterialStatePropertyAll(
                        Size(double.infinity, 50)),
                  ),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      lastDate: DateTime.now(),
                      firstDate: DateTime(2023, 12, 1),
                      initialDate: DateTime.now(),
                    );
                    if (pickedDate == null) return;

                    setState(() {
                      selectedDateText = DateFormat('d/M/y').format(pickedDate);
                      tanggal = pickedDate;
                    });

                    fetchData();
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      selectedDateText,
                      style: blackTextStyle.copyWith(fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                gapH12,
                //Dropdown Shift
                DropdownButtonFormField<String>(
                  focusColor: kGreenColor,
                  value: selectedWarung,
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedWarung = newValue!;
                      selectedIndex = warungList.indexOf(selectedWarung) + 1;
                    });

                    fetchData();
                  },
                  style: blackTextStyle.copyWith(fontSize: 16),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: kBlackColor.withOpacity(0.2))),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: kGreenColor), // Warna fokus hijau
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                  ),
                  icon: Icon(Icons.arrow_drop_down,
                      color: kGreenColor.withOpacity(0.8)), // Ikona dropdown
                  items:
                      warungList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: transactionData?.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                if (transactionData == null) {
                  return CircularProgressIndicator(); // Tampilkan indikator loading jika data masih diambil
                }

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
                ).format(transaction['total'] - transaction['totaldiskon']);
                final metodePembayaran = transaction['metodepembayaran'];

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
                  onTap: () {
                    Navigator.push(
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
                          ),
                        ));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
