import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';
import 'package:qurane2/core/theming/style.dart';
import 'package:qurane2/core/theming/size.dart';
import 'package:qurane2/features/chat/cubit/chat/cubit/chat_cubit.dart';
import 'package:qurane2/features/chat/data/network/single_chatNetwork.dart';
import 'package:qurane2/features/chat/ui/widgets/chat/ImageMessage.dart';
import 'package:qurane2/features/chat/ui/widgets/chat/deletemessage.dart';
import 'package:qurane2/features/chat/ui/widgets/chat/textMessage.dart';
import 'package:qurane2/features/chat/ui/widgets/chat/voiceMessage.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class ShowMessage extends StatefulWidget {
  String chatid;
  ChatCubit cubit;
  ShowMessage({super.key, required this.chatid, required this.cubit});

  @override
  State<ShowMessage> createState() => _ShowMessageState();
}

class _ShowMessageState extends State<ShowMessage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final cubit = BlocProvider.of<ChatCubit>(context);
        return Container(
            color: colors.back_background,
            child: StreamBuilder<QuerySnapshot>(
              stream: SingleChatNetwork.getmassages(widget.chatid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: colors.primary),
                  );
                } else {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            size.height(10.h),
                            Row(
                              mainAxisAlignment: snapshot.data!.docs[index]
                                          ['senderid'] ==
                                      SingleChatNetwork.getcurrentuserid()
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                snapshot.data!.docs[index]['type'] == 'text'
                                    ? GestureDetector(
                                        onTap: () {
                                            WoltModalSheet.show<void>(
                                            context: context,
                                            pageListBuilder:
                                                (modalSheetContext) {
                                              return [
                                                WoltModalSheetPage(
                                                  backgroundColor:
                                                      colors.back_background,
                                                  child: deleteMessage(cubit: cubit, chatid: widget.chatid, messageid: snapshot.data!.docs[index].id,)
                                                ),
                                              ];
                                            },
                                          );  
                                        },
                                        child: TextMessage(
                                          username: snapshot.data!.docs[index]
                                              ['sendername'],
                                          time: snapshot.data!.docs[index]
                                              ['time'],
                                          message: snapshot.data!.docs[index]
                                              ['massage'],
                                          seen: snapshot.data!.docs[index]
                                              ['seen'],
                                          isSender: snapshot.data!.docs[index]
                                                      ['senderid'] ==
                                                  //  widget.cubit.getcurrentUserId()
                                                  SingleChatNetwork
                                                      .getcurrentuserid()
                                              ? true
                                              : false,
                                        ),
                                      )
                                    : snapshot.data!.docs[index]['type'] ==
                                            'image'
                                        ? GestureDetector(
                                            onTap: () {
                                                WoltModalSheet.show<void>(
                                                context: context,
                                                pageListBuilder:
                                                    (modalSheetContext) {
                                                  return [
                                                    WoltModalSheetPage(
                                                        backgroundColor: colors
                                                            .back_background,
                                                        child: deleteMessage(
                                                          cubit: cubit,
                                                          chatid: widget.chatid,
                                                          messageid: snapshot
                                                              .data!
                                                              .docs[index]
                                                              .id,
                                                        )),
                                                  ];
                                                },
                                              );  
                                            },
                                            child: ImageMessage(
                                              cubit: widget.cubit,
                                              username: snapshot.data!
                                                  .docs[index]['sendername'],
                                              time: snapshot.data!.docs[index]
                                                  ['time'],
                                              messageUrl: snapshot
                                                  .data!.docs[index]['massage'],
                                              seen: snapshot.data!.docs[index]
                                                  ['seen'],
                                              isSender: snapshot
                                                              .data!.docs[index]
                                                          ['senderid'] ==
                                                      SingleChatNetwork
                                                          .getcurrentuserid()
                                                  ? true
                                                  : false,
                                              isVideo: false,
                                            ),
                                          )
                                        : snapshot.data!.docs[index]['type'] ==
                                                'video'
                                            ? GestureDetector(
                                                onTap: () {
                                                    WoltModalSheet.show<void>(
                                                    context: context,
                                                    pageListBuilder:
                                                        (modalSheetContext) {
                                                      return [
                                                        WoltModalSheetPage(
                                                            backgroundColor: colors
                                                                .back_background,
                                                            child:
                                                                deleteMessage(
                                                              cubit: cubit,
                                                              chatid:
                                                                  widget.chatid,
                                                              messageid:
                                                                  snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .id,
                                                            )),
                                                      ];
                                                    },
                                                  );  
                                                },
                                                child: ImageMessage(
                                                  cubit: widget.cubit,
                                                  username:
                                                      snapshot.data!.docs[index]
                                                          ['sendername'],
                                                  time: snapshot.data!
                                                      .docs[index]['time'],
                                                  messageUrl: snapshot.data!
                                                      .docs[index]['massage'],
                                                  seen: snapshot.data!
                                                      .docs[index]['seen'],
                                                  isSender: snapshot.data!
                                                                  .docs[index]
                                                              ['senderid'] ==
                                                          SingleChatNetwork
                                                              .getcurrentuserid()
                                                      ? true
                                                      : false,
                                                  isVideo: true,
                                                ))
                                            :
                                            GestureDetector(
                                                onTap: () {
                                                    WoltModalSheet.show<void>(
                                                    context: context,
                                                    pageListBuilder:
                                                        (modalSheetContext) {
                                                      return [
                                                        WoltModalSheetPage(
                                                            backgroundColor: colors
                                                                .back_background,
                                                            child:
                                                                deleteMessage(
                                                              cubit: cubit,
                                                              chatid:
                                                                  widget.chatid,
                                                              messageid:
                                                                  snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .id,
                                                            )),
                                                      ];
                                                    },
                                                  );  
                                                },
                                                child: VoicMessage(
                                                username: snapshot.data!
                                                    .docs[index]['sendername'],
                                                time: snapshot.data!.docs[index]
                                                    ['time'],
                                                message: snapshot.data!
                                                    .docs[index]['massage'],
                                                seen: snapshot.data!.docs[index]
                                                    ['seen'],
                                                isSender: snapshot.data!
                                                                .docs[index]
                                                            ['senderid'] ==
                                                        // widget.cubit
                                                        //     .getcurrentUserId()
                                                        SingleChatNetwork
                                                            .getcurrentuserid()
                                                    ? true
                                                    : false,
                                              ))
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return Center(
                        child: Text(
                      "No Messages yet",
                      style: textstyle.maintitle.copyWith(
                        fontSize: 25,
                      ),
                    ));
                  }
                }
              },
            ));
      },
    );
  }
}
