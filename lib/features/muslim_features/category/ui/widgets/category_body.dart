import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';


// ignore: must_be_immutable
class CategoryBody extends StatefulWidget {
  String? name;
  String? imagePath;
  CategoryBody({super.key, required this.name, required this.imagePath});

  @override
  State<CategoryBody> createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
          color: colors.background, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          size.height(10),
          Image(
            image: AssetImage(widget.imagePath!),
            width: 200,
            height: 100,
          ),
          size.height(10),
          Text(
            widget.name!,
            style: textstyle.subtitle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colors.primary),
          ),
        ],
      ),
    );
  }
}
