import 'package:flutter/material.dart';

import '../shared/gaps.dart';
import '../shared/theme.dart';
import '../widgets/button.dart';
import 'package:warmindo_pos/main.dart';

class DetailPage extends StatefulWidget {
  final int status;
  final String date;
  final int idOnly;
  final String transactionID;
  final String noMeja;
  final String namaPelanggan;
  final int diskon;
  final String total;
  final String metodePembayaran;

  const DetailPage({
    super.key,
    required this.status,
    required this.date,
    required this.transactionID,
    required this.noMeja,
    required this.namaPelanggan,
    required this.diskon,
    required this.total,
    required this.metodePembayaran,
    required this.idOnly,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<dynamic>? transactionDetail;

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

  Map<String, dynamic> mapPembayaran = {
    "cash": "Cash",
    "qris": "QRIS",
    "kartu_debit": "Kartu Debit",
  };
  String? selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    fetchData();
    getPaymentMethod();
  }

  Future<void> getPaymentMethod() async {
    final response = await supabase
        .from('transaksi')
        .select('metodepembayaran')
        .eq('idtransaksi', widget.idOnly)
        .single();

    setState(() {
      selectedPaymentMethod = response['metodepembayaran'];
    });
  }

  Future<dynamic> getDetailTransaction() async {
    final int dbTransId = int.parse(
        widget.transactionID.substring(widget.transactionID.length - 1));
    final response = await supabase
        .from('detail_transaksi')
        .select()
        .eq('idtransaksi', dbTransId);
    return response;
  }

  Future<void> fetchData() async {
    final response = await getDetailTransaction();
    setState(() {
      transactionDetail = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    final status = widget.status;
    final idTransaksi = widget.transactionID;
    final idOnly = widget.idOnly;
    // final date = widget.date;
    final noMeja = widget.noMeja;
    final namaPelanggan = widget.namaPelanggan;
    final total = widget.total;
    final diskon = widget.diskon;

    if (transactionDetail == null) {
      return Container(
          color: kWhiteColor,
          child: Center(
            child: Text(
              "Loading...",
              style: blackTextStyle.copyWith(),
            ),
          ));
    }
    final detail = transactionDetail?[0];
    final menu = detail['namamenu'];
    final harga = detail['harga'];
    final jumlah = detail['jumlah'];

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
                          Navigator.pop(context, {'updatedData': true});
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
                  'Nama Menu',
                  style: blackTextStyle.copyWith(fontWeight: medium),
                ),
                Text(
                  menu,
                  style: blackTextStyle.copyWith(fontWeight: medium),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Harga',
                  style: blackTextStyle.copyWith(fontWeight: medium),
                ),
                Text(
                  harga.toString(),
                  style: blackTextStyle.copyWith(fontWeight: medium),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Jumlah',
                  style: blackTextStyle.copyWith(fontWeight: medium),
                ),
                Text(
                  jumlah.toString(),
                  style: blackTextStyle.copyWith(fontWeight: medium),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Diskon',
                  style: blackTextStyle.copyWith(fontWeight: medium),
                ),
                Text(
                  diskon.toString(),
                  style: blackTextStyle.copyWith(fontWeight: medium),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Metode Pembayaran',
                  style: blackTextStyle.copyWith(fontWeight: medium),
                ),
                DropdownButton<String>(
                  value: selectedPaymentMethod,
                  items: mapPembayaran.keys.map((String key) {
                    return DropdownMenuItem<String>(
                      value: key,
                      child: Text(mapPembayaran[key]!),
                    );
                  }).toList(),
                  onChanged: (String? newValue) async {
                    setState(() {
                      selectedPaymentMethod = newValue;
                    });

                    await supabase
                        .from('transaksi')
                        .update({'metodepembayaran': newValue}).eq(
                            'idtransaksi', idOnly);
                    fetchData();
                  },
                ),
              ],
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
                  if (widget.status == 2) // Periksa status
                    Button(
                        text: "Selesaikan Pemesanan",
                        textColor: kWhiteColor,
                        startColor: kGreenColor,
                        endColor: kGreenColor,
                        onPressed: () async {
                          final int newStatus = widget.status + 1;
                          final int dbTransactionID = int.parse(widget
                              .transactionID
                              .substring(widget.transactionID.length - 1));

                          final response = await supabase
                              .from('transaksi')
                              .update({'status': newStatus}).eq(
                                  'idtransaksi', dbTransactionID);

                          Navigator.pop(context, newStatus);
                        }),
                  if (widget.status == 3)
                    Button(
                        text: "",
                        textColor: kWhiteColor,
                        startColor: kWhiteColor,
                        endColor: kWhiteColor,
                        onPressed: () {}),
                  if (widget.status != 2 && widget.status != 3)
                    Button(
                      text:
                          "Ubah Status", // Jika status bukan 2 atau 3, tampilkan teks ini
                      textColor: kWhiteColor,
                      startColor: kGreenColor,
                      endColor: kGreenColor,
                      onPressed: () async {
                        final int newStatus = widget.status + 1;
                        final int dbTransactionID = int.parse(widget
                            .transactionID
                            .substring(widget.transactionID.length - 1));

                        final response = await supabase
                            .from('transaksi')
                            .update({'status': newStatus}).eq(
                                'idtransaksi', dbTransactionID);

                        Navigator.pop(context, newStatus);
                      },
                    ),
                ],
              ),
            ),
          )),
    );
  }
}
