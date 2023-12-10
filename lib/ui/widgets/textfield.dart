import 'package:flutter/material.dart';
import 'package:warmindo_pos/ui/shared/theme.dart';

class NewForm extends StatelessWidget {
  final TextEditingController controller;
  final String nama;
  final String hintText;
  final bool obscureText;
  final double horizontalPadding;

  const NewForm({
    super.key,
    required this.controller,
    required this.nama,
    required this.hintText,
    required this.obscureText,
    required this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: horizontalPadding, right: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nama,
            style: blackTextStyle.copyWith(fontSize: 16),
          ),

          const SizedBox(
            height: 10,
          ),

          //TextField
          TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
                hintText: hintText,
                hintStyle: blackTextStyle.copyWith(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
