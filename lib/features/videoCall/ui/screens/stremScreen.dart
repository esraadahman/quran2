import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/features/chat/ui/widgets/chats/liveUsers.dart';
import 'package:qurane2/features/videoCall/cubit/cubit/videocall_cubit.dart';
import 'package:qurane2/features/videoCall/data/streamnetwork.dart';
import 'package:qurane2/features/videoCall/ui/widgets/liveuser.dart';
import 'package:qurane2/features/videoCall/ui/widgets/searchStream.dart';
import 'package:qurane2/features/videoCall/ui/widgets/streamcard.dart';
import 'package:qurane2/features/videoCall/ui/widgets/streamheader.dart';

class StreamScreen extends StatelessWidget {
  const StreamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideocallCubit(),
      child: BlocConsumer<VideocallCubit, VideocallState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<VideocallCubit>(context);
          return Scaffold(
            backgroundColor: const Color.fromRGBO(234, 238, 240, 1),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  size.height(40),
                  StreamHeader(
                    text: 'Stream',
                  ),
                  size.height(10),
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
                                        child: LiveStreams(
                                          image: snapshot.data!.docs[index]
                                              ['streamimage'],
                                        ),
                                      ));
                                }));
                      }
                    },
                  ),
                  const SearchStream(),
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
                        return Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                              crossAxisSpacing: 6.w,
                              mainAxisSpacing: 10.h,
                            ),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  //  Navigator.pushNamed(context, streamScreenRoute);
                                    context.navigateTo(JoinScreen(streamname: "",id:snapshot.data!.docs[index]['streamid'],join:true));
                                },
                                child: streamcard(
                                  username: snapshot.data!.docs[index]
                                      ['username'],
                                  userimage: snapshot.data!.docs[index]
                                      ['userimage'],
                                  streamtitle: snapshot.data!.docs[index]
                                      ['streamname'],
                                  streamimage: snapshot.data!.docs[index]
                                      ['streamimage'],
                                  countrycity: snapshot.data!.docs[index]
                                      ['userlocation'],
                                  viewers: snapshot.data!.docs[index]
                                      ['viewers'],
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
