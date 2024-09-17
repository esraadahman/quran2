import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qurane2/core/routing/router.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/features/Home/data/network/models.dart';
import 'package:qurane2/features/Home/ui/widgets/home_header.dart';
import 'package:qurane2/features/muslim_features/category/ui/widgets/category_body.dart';
import 'package:qurane2/features/muslim_features/muslim_features/data/model/duaa_model.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategorState();
}

class _CategorState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.back_background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            size.height(35),
            Row(
              children: [size.height(30), HomeHeader(name: "esraa")],
            ),
            //  size.height(10),
            Container(
              height: MediaQuery.sizeOf(context).height,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.2),
                  itemCount: list_home.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                            context.navigateTo(muslim_features[index]);
                      },
                      child: CategoryBody(
                        name: list_home[index].name,
                        imagePath: list_home[index].image_path,
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
