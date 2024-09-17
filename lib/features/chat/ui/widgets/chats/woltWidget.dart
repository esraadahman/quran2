import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/features/chat/cubit/chats/cubit/chats_cubit.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/features/chat/data/network/chatsNetwork.dart';

class WoltWidget extends StatefulWidget {
  final ChatsCubit cubit;
  WoltWidget({super.key, required this.cubit});

  @override
  State<WoltWidget> createState() => _WoltWidgetState();
}

class _WoltWidgetState extends State<WoltWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.h,
      child: Column(
        children: [
          size.height(20),
          Text('Start Chat with Others',
              style: textstyle.maintitle.copyWith(fontSize: 20)),
          size.height(20),
          Container(
            height: 320,
            width: MediaQuery.sizeOf(context).width,
            child: StreamBuilder(
                stream: widget.cubit.getallusers(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var x = ChatsNetwork.checkchat(
                            snapshot.data!.docs[index]["uid"]);
                        return ListTile(
                            leading: CircleAvatar(
                                radius: 30.r,
                                backgroundImage:
                                    //  AssetImage("images/Rectangle5.png"),
                                    NetworkImage(snapshot.data!.docs[index]
                                        ["userimage"])),
                            title: Text(
                              snapshot.data!.docs[index]["name"],
                              style: textstyle.maintitle.copyWith(
                                fontSize: 20,
                              ),
                            ),
                            subtitle: Text(
                              "${snapshot.data!.docs[index]["age"]} Years - ${snapshot.data!.docs[index]["country"]} - ${snapshot.data!.docs[index]["city"].toString().toUpperCase()}",
                              style: textstyle.subtitle
                                  .copyWith(fontSize: 15, color: colors.text),
                            ),
                            trailing: GestureDetector(
                                onTap: () async {
                                  if (await ChatsNetwork.checkchat(
                                          snapshot.data!.docs[index]["uid"]) ==
                                      true) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: colors.background,
                                      content: Text(
                                        'Chat Already Exist',
                                        style: textstyle.subtitle
                                            .copyWith(color: colors.primary),
                                      ),
                                    ));
                                  } else {
                                    ChatsNetwork.createchat(
                                        snapshot.data!.docs[index]["uid"],
                                        snapshot.data!.docs[index]["name"],
                                        snapshot.data!.docs[index]
                                            ["userimage"]);

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            backgroundColor: colors.background,
                                            content: Text(
                                              'Chat Created',
                                              style: textstyle.subtitle
                                                  .copyWith(
                                                      color: colors.primary),
                                            )));
                                  }
                                },
                                child: Icon(Icons.add_circle_outline_sharp)));
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
