import 'package:flutter/material.dart';
import 'package:warmindo_pos/ui/shared/theme.dart';

import '../shared/gaps.dart';

class TransaksiCard extends StatelessWidget {
  final int status;
  final String date;
  final String transactionID;
  final String noMeja;
  final String namaPelanggan;
  final String total;
  final String metodePembayaran;
  final Function() onTap;
  final Function() onDelete;

  const TransaksiCard({
    Key? key,
    required this.onTap,
    required this.onDelete,
    required this.status,
    required this.date,
    required this.transactionID,
    required this.noMeja,
    required this.namaPelanggan,
    required this.total,
    required this.metodePembayaran,
  }) : super(key: key);

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
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 249, 249, 249),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Status - Date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                        Text(
                          date,
                          maxLines: 2,
                          style: blackTextStyle.copyWith(
                              fontSize: 12, color: kGreyColor),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    gapH8,
                    Text(
                      transactionID,
                      maxLines: 2,
                      style: blackTextStyle.copyWith(
                          fontSize: 15,
                          fontWeight: extraBold,
                          color: kGreenColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text(
                          "$noMeja - ",
                          style: blackTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                        Text(
                          namaPelanggan,
                          style: blackTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        )
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "$total - ",
                                style: whiteTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: extraBold,
                                ),
                              ),
                              Text(
                                metodePembayaran,
                                style: whiteTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: extraBold,
                                ),
                              )
                            ],
                          ),
                        ),
                        gapW8,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              child: ElevatedButton(
                                  onPressed: () {
                                    onDelete();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kRedColor,
                                    elevation: 0.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.delete,
                                    color: kWhiteColor,
                                    size: 18,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
