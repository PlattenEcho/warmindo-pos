import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_pos/ui/pages/detail_page.dart';
import 'package:warmindo_pos/ui/widgets/card.dart';
import 'package:warmindo_pos/main.dart';

import '../shared/theme.dart';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({super.key});

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

Future<dynamic> getDataTransaction() async {
  final response = await supabase.from('transaksi').select();
  return response;
}

class _TransaksiPageState extends State<TransaksiPage> {
  List<dynamic>? transactionData;

  @override
  void initState() {
    super.initState();
    fetchData(); // Panggil fungsi untuk mengambil data saat halaman dimuat
  }

  Future<void> fetchData() async {
    final response = await getDataTransaction();
    setState(() {
      transactionData = response; // Simpan data respons ke dalam variabel lokal
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWhiteColor,
      margin: const EdgeInsets.symmetric(horizontal: 2.5),
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: transactionData?.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                String hargaRp = NumberFormat.currency(
                  locale: 'id',
                  symbol: 'Rp. ',
                  decimalDigits: 0,
                ).format(125000);

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
                final total = 
                              NumberFormat.currency(
                                locale: 'id',
                                symbol: 'Rp. ',
                                decimalDigits: 0,
                              ).format(transaction['total'] - transaction['totaldiskon']);
                final metodePembayaran = transaction['metodepembayaran'];

                return TransaksiCard(
                  status: status,
                  date: tanggal,
                  transactionID: "WT1${tanggal.toString().replaceAll('-', '')}$shift$idtransaksi",
                  noMeja: noMeja,
                  namaPelanggan: namaPelanggan,
                  total: total,
                  metodePembayaran: metodePembayaran,
                  onDelete: () {
                    // Show confirmation dialog before deleting
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
                                Navigator.of(context).pop(
                                    false); // Close the dialog with a value of false (do not delete)
                              },
                              child: Text('Tidak'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(
                                    true); // Close the dialog with a value of true (will delete)
                              },
                              child: Text('Ya'),
                            ),
                          ],
                        );
                      },
                    ).then((shouldDelete) {
                      // If shouldDelete is true, delete the Mahasiswa data
                      if (shouldDelete ?? false) {}
                    });
                  },
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            status: 1,
                            date: "24/09/2023",
                            transactionID: "#ID24092023",
                            noMeja: "12",
                            namaPelanggan: "Dzahwan Anforcom",
                            total: hargaRp,
                            metodePembayaran: "QRIS",
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
