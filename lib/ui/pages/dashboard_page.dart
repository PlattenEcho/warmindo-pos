import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:warmindo_pos/ui/pages/transaksi_by_dateshift.dart';
import 'package:warmindo_pos/ui/shared/gaps.dart';
import 'package:warmindo_pos/ui/shared/theme.dart';

import '../../main.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<String> warungList = ['Shift 1', 'Shift 2'];
  String selectedWarung = 'Shift 1';
  int selectedIndex = 1;

  String selectedDateText = "Pilih Tanggal";
  DateTime tanggal = DateTime.now();
  int countTransaksi = 0;
  String hargaRp = "";

  List<Map<String, dynamic>> transaksiData = [];
  @override
  void initState() {
    super.initState();
    getTransaksi();
  }

  Future<List<Map<String, dynamic>>> getTransaksi() async {
    final res = await supabase
        .from('transaksi')
        .select()
        .eq('tanggal', tanggal)
        .eq('shift', selectedIndex)
        .count(CountOption.exact);

    final data = res.data;
    final count = res.count;
    int harga = 0;
    int totalHarga = 0;
    int diskon = 0;
    setState(() {
      transaksiData = data;
      countTransaksi = count;

      for (var i = 0; i < count; i++) {
        harga = transaksiData[i]['total'];
        diskon = transaksiData[i]['totaldiskon'];
        totalHarga = totalHarga + (harga - diskon);
      }

      hargaRp = NumberFormat.currency(
        locale: 'id',
        symbol: 'Rp. ',
        decimalDigits: 0,
      ).format(totalHarga);
    });

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: kWhiteColor,
        margin: const EdgeInsets.only(top: 5, left: 12.5, right: 12.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                minimumSize:
                    const MaterialStatePropertyAll(Size(double.infinity, 50)),
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
                getTransaksi();
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
                  setState(() {
                    selectedWarung = newValue!;
                    selectedIndex = warungList.indexOf(selectedWarung) + 1;
                  });
                  getTransaksi();
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
            gapH12,
            //Container Data
            Container(
              padding: const EdgeInsets.only(
                  top: 15, left: 15, right: 15, bottom: 15),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ],
                  color: const Color.fromARGB(255, 249, 249, 249),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedWarung,
                    style:
                        greenTextStyle.copyWith(fontWeight: bold, fontSize: 22),
                  ),
                  Text(
                    selectedDateText,
                    style: greenTextStyle.copyWith(
                        fontWeight: regular, fontSize: 17),
                  ),
                  gapH12,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height / 6,
                        width: MediaQuery.of(context).size.width,
                        image: AssetImage('assets/bg_start.png')),
                  ),
                  gapH12,
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: kGreenColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Transaksi",
                              style: whiteTextStyle.copyWith(
                                  fontWeight: regular, fontSize: 14),
                            ),
                            Text(
                              "$hargaRp,00",
                              style: whiteTextStyle.copyWith(
                                  fontWeight: bold, fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      gapW12,
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: kBlackColor.withOpacity(0.2),
                                width: 1.5),
                            color: kWhiteColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Banyak Transaksi",
                                style: greenTextStyle.copyWith(
                                    fontWeight: regular, fontSize: 14),
                              ),
                              Text(
                                countTransaksi.toString(),
                                style: greenTextStyle.copyWith(
                                    fontWeight: bold, fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            gapH12,
            ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
                  backgroundColor: MaterialStateProperty.all(kGreenColor),
                  minimumSize: const MaterialStatePropertyAll(
                      Size(double.infinity, 50))),
              child: Text("Lihat List Transaksi untuk Shift ini ",
                  style: whiteTextStyle.copyWith(fontWeight: bold)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TransaksiByDateShift(
                              selectedIndex: selectedIndex,
                              tanggal: tanggal,
                            )));
              },
            ),
          ],
        ));
  }
}
