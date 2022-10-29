import 'dart:ffi';

import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:diaco_test/style/colors.dart';
import 'package:diaco_test/style/dimens.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  const MessageCard(
      {Key? key,
      required this.index,
        required this.userName,
      required this.text,
      required this.isSender,
      this.replyId,required this.edit,required this.delete})
      : super(key: key);

  final String text;
  final bool isSender;
  final int? replyId;
  final int index;
  final String userName;
  final VoidCallback edit;
  final VoidCallback delete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: isSender?0:smallSize(context),vertical: xxSmallSize(context)),
      child: Row(
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isSender
              ? Container()
              : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: fullWidth(context) / 10,
                      height: fullWidth(context) / 10,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image:
                              DecorationImage(image: AssetImage("assets/img_2.png"))),
                    ),
                  Text(userName,style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 8),)
                ],
              ),
          GestureDetector(
            onTap: isSender?(){
               RelativeRect position =  RelativeRect.fill;
              showMenu(context: context, position: position, items: [
                 PopupMenuItem<int>(
                  onTap: edit,
                  value: 0,
                  child: Text('edit'),
                ),
                 PopupMenuItem<int>(onTap: delete,
                  value: 1,
                  child: Text('delete'),
                ),
              ]);
            }:(){},
            child: BubbleSpecialThree(
              sent: isSender ? true : false,
              text: text,
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: isSender ? AppColors.white : AppColors.gray900),
              isSender: isSender,
              seen: isSender ? true : false,
              delivered: isSender ? true : false,
              color: isSender ? AppColors.primaryColor : AppColors.white,
              tail: false,
            ),
          ),
        ],
      ),
    );
  }

}
