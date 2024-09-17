import 'package:flutter/material.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';

class signHeader extends StatefulWidget {
  String subheader;
  signHeader({super.key, required this.subheader});

  @override
  State<signHeader> createState() => _signHeaderState();
}

class _signHeaderState extends State<signHeader> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            "HELLO",
            style: textstyle.maintitle,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.subheader,
            style: textstyle.subtitle,
          ),
          size.height(30),
        ],
      ),
    );
  }
}
