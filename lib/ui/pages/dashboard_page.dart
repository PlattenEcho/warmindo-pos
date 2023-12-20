import 'package:flutter/material.dart';
import 'package:warmindo_pos/ui/shared/gaps.dart';
import 'package:warmindo_pos/ui/shared/theme.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String selectedWarung = 'Warung A';
  List<String> warungList = ['Warung 1', 'Warung 2', 'Warung 3', 'Warung 4'];

  @override
  Widget build(BuildContext context) {
    return Container(
        color: kWhiteColor,
        margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  borderSide:
                      BorderSide(color: kGreenColor), // Warna fokus hijau
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              icon: Icon(Icons.arrow_drop_down,
                  color: kGreenColor.withOpacity(0.8)), // Ikona dropdown
              items: warungList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            gapH12,
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
                    "Warung 1",
                    style:
                        greenTextStyle.copyWith(fontWeight: bold, fontSize: 22),
                  ),
                  gapH12,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height / 4,
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
                              "Rp. 1.000.000,00",
                              style: whiteTextStyle.copyWith(
                                  fontWeight: bold, fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      gapW12,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Shift",
                            style: greenTextStyle.copyWith(
                                fontWeight: regular, fontSize: 14),
                          ),
                          Text(
                            "1",
                            style: greenTextStyle.copyWith(
                                fontWeight: bold, fontSize: 20),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
