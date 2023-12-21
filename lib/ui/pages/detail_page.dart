import 'package:flutter/material.dart';

import '../shared/gaps.dart';
import '../shared/theme.dart';
import '../widgets/button.dart';

class DetailPage extends StatefulWidget {
  final int status;
  final String date;
  final String transactionID;
  final String noMeja;
  final String namaPelanggan;
  final String total;
  final String metodePembayaran;

  const DetailPage({
    super.key,
    required this.status,
    required this.date,
    required this.transactionID,
    required this.noMeja,
    required this.namaPelanggan,
    required this.total,
    required this.metodePembayaran,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String selectedWarung = 'Warung A';
  List<String> warungList = ['Warung A', 'Warung B', 'Warung C'];

  late bool mode = true;
  static const List<String> _status = <String>[
    "Baru",
    "Diproses",
    "Disajikan",
    "Selesai",
  ];

  static final List<Color> _textColor = <Color>[
    kRedColor,
    kYellowColor,
    kBlueColor,
    kGreenColor,
  ];

  static final List<Color> _containerColor = <Color>[
    kRedLightColor,
    kYellowLightColor,
    kBlueLightColor,
    kGreenLightColor,
  ];

  @override
  Widget build(BuildContext context) {
    final status = widget.status;
    final idTransaksi = widget.transactionID;
    // final date = widget.date;
    final noMeja = widget.noMeja;
    final namaPelanggan = widget.namaPelanggan;
    final total = widget.total;
    final metodePembayaran = widget.metodePembayaran;

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SafeArea(
            child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 5),
                color: kGreenColor,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: kWhiteColor,
                        )),
                    Text("Detail",
                        style: whiteTextStyle.copyWith(
                            fontSize: 22, fontWeight: extraBold)),
                  ],
                )),
          )),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            idTransaksi,
                            style: greenTextStyle.copyWith(
                                fontSize: 22, fontWeight: extraBold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          gapW8,
                          Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                color: _containerColor[status],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(7))),
                            child: Text(
                              _status[status],
                              style: blackTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: extraBold,
                                  color: _textColor[status]),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "$noMeja - ",
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                          Text(
                            namaPelanggan,
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            gapH12,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Metode Pembayaran',
                  style: blackTextStyle.copyWith(fontWeight: medium),
                ),
                Text(
                  metodePembayaran,
                  style: blackTextStyle.copyWith(fontWeight: medium),
                ),
              ],
            ),
            DropdownButtonFormField<String>(
              focusColor: kGreenColor,
              value: selectedWarung,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  selectedWarung = newValue!;
                });
              },
              style: blackTextStyle.copyWith(fontSize: 16),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: kBlackColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: kGreenColor),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              icon: Icon(Icons.arrow_drop_down,
                  color: kGreenColor.withOpacity(0.8)),
              items: warungList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            gapH24,
            Text('Total',
                style: blackTextStyle.copyWith(
                    fontSize: 14, fontWeight: extraBold)),
            gapH8,
            Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: kWhiteColor,
                    border: Border.all(color: kGreenColor, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.monetization_on,
                      color: kGreenColor,
                    ),
                    gapW12,
                    Text(
                      total,
                      style: greenTextStyle.copyWith(
                          fontSize: 18, fontWeight: bold),
                    ),
                  ],
                )),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: kGreenColor, width: 0.7))),
          child: InkWell(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Button(
                      text: "Selesaikan Pemesanan",
                      textColor: kWhiteColor,
                      startColor: kGreenColor,
                      endColor: kGreenColor,
                      onPressed: () {})
                ],
              ),
            ),
          )),
    );
  }
}
