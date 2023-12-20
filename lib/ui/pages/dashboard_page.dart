import 'package:flutter/material.dart';
import 'package:warmindo_pos/ui/shared/gaps.dart';
import 'package:warmindo_pos/ui/shared/theme.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selamat Datang, User!",
              style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 21),
            ),
            gapH24,
            Container(
              padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
              height: 30,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: kGreenColor, borderRadius: BorderRadius.circular(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Warung 1",
                    style:
                        blackTextStyle.copyWith(fontWeight: bold, fontSize: 17),
                  ),
                  Container()
                ],
              ),
            ),
          ],
        ));
  }
}
