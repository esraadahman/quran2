import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qurane2/core/theming/colors.dart';


class SearchStream extends StatelessWidget {
  const SearchStream({super.key});

  @override
  Widget build(BuildContext context) {
    // return BlocConsumer<ChatsCubit, ChatsState>(
    //   listener: (context, state) {
    //     // TODO: implement listener
    //   },
    //   builder: (context, state) {
    //     final cubit = BlocProvider.of<ChatsCubit>(context);
        return Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 5.h),
          child: Container(
            height: 50,
            child: TextField(
              onChanged: (value) {
                //cubit.searchbyname(value);
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: colors.background,
                hintText: 'Search ',
                prefixIcon: Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: colors.sub_background, width: 0)),
              ),
            ),
          ),
        );
  //    },
  //  );
  }
}
