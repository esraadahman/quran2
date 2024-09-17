import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/routing/router.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/Home/cubit/cubit/home_cubit.dart';
import 'package:qurane2/features/Home/data/network/models.dart';
import 'package:qurane2/features/Home/data/network/network.dart';
import 'package:qurane2/features/Home/ui/widgets/home_header.dart';
import 'package:qurane2/features/Home/ui/widgets/liveWidget.dart';
import 'package:qurane2/features/Home/ui/widgets/meni_widget.dart';
import 'package:qurane2/features/muslim_features/muslim_features/data/model/duaa_model.dart';
import 'package:qurane2/features/navi/ui/screens/navi.dart';
import 'package:qurane2/features/videoCall/data/streamnetwork.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getAdan("cairo", "egypt"),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<HomeCubit>(context);
          return Scaffold(
            backgroundColor: colors.back_background,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  size.height(35),
                  Row(
                    children: [size.height(30), HomeHeader(name: "esraa")],
                  ),
                  size.height(10),
                  state is AdanLoading
                      ? CircularProgressIndicator(
                          color: colors.primary,
                        )
                      : Container(
                          width: MediaQuery.sizeOf(context).width - 10,
                          height: 200.h,
                          decoration: BoxDecoration(
                              color: colors.text,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage("images/Rectangle9.png"),
                                fit: BoxFit.cover,
                              )),
                          child: Column(
                            children: [
                              size.height(140),
                              Row(
                                children: [
                                  size.width(10),
                                  Text(
                                    cubit.Adan["Fajr"].toString(),
                                    style: textstyle.subtitle.copyWith(
                                        fontSize: 16.sp,
                                        color: colors.primary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  size.width(10),
                                  Text(
                                    cubit.Adan["Sunrise"].toString(),
                                    style: textstyle.subtitle.copyWith(
                                        fontSize: 16.sp,
                                        color: colors.primary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  size.width(10),
                                  Text(
                                    cubit.Adan["Dhuhr"].toString(),
                                    style: textstyle.subtitle.copyWith(
                                        fontSize: 16.sp,
                                        color: colors.primary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  size.width(10),
                                  Text(
                                    cubit.Adan["Asr"].toString(),
                                    style: textstyle.subtitle.copyWith(
                                        fontSize: 16.sp,
                                        color: colors.primary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  size.width(10),
                                  Text(
                                    cubit.Adan["Maghrib"].toString(),
                                    style: textstyle.subtitle.copyWith(
                                        fontSize: 16.sp,
                                        color: colors.primary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  size.width(10),
                                  Text(
                                    cubit.Adan["Isha"].toString(),
                                    style: textstyle.subtitle.copyWith(
                                        fontSize: 16.sp,
                                        color: colors.primary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                //  size.height(5),
                  StreamBuilder(
                    stream: Streamnetwork.getstreams(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child:
                              CircularProgressIndicator(color: colors.primary),
                        );
                      } else {
                        return Container(
                            height: 100.h,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: LiveWidget(
                                          image: snapshot.data!.docs[index]
                                              ['streamimage'],
                                        ),
                                      ));
                                }));
                      }
                    },
                  ),
                //  size.height(5),
                  Container(
                    height: 150.h,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: list_home.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              context.navigateTo(muslim_features[index]);
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MeniWidget(
                                  name: list_home[index].name,
                                  imagePath: list_home[index].image_path,
                                )),
                          );
                        }),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
