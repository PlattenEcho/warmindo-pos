import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_pos/ui/pages/detail_page.dart';
import 'package:warmindo_pos/ui/widgets/card.dart';

import '../shared/theme.dart';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({super.key});

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
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
              itemCount: 5,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                String hargaRp = NumberFormat.currency(
                  locale: 'id',
                  symbol: 'Rp. ',
                  decimalDigits: 0,
                ).format(125000);

                return TransaksiCard(
                  status: 2,
                  date: "24/09/2023",
                  transactionID: "#ID24092023",
                  noMeja: "12",
                  namaPelanggan: "Dzahwan Anforcom",
                  total: hargaRp,
                  metodePembayaran: "QRIS",
                  onDelete: () {
                    // Show confirmation dialog before deleting
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Konfirmasi'),
                          content: const Text(
                            'Apakah Anda yakin ingin menghapus mahasiswa ini?',
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
