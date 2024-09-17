import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';

class HomeHeader extends StatelessWidget {
  String? name;
  HomeHeader({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        size.width(20),
        Text(
          "Hello",
          style: textstyle.subtitle.copyWith(fontSize: 20),
        ),
        Text(
          " ${name!} !",
          style: textstyle.maintitle.copyWith(fontSize: 25),
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * .4,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(CupertinoIcons.person_alt_circle),
          iconSize: 25,
        ),
      ],
    );
  }
}
