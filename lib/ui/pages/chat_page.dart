import 'package:diaco_test/data/enums/enums.dart';
import 'package:diaco_test/data/models/message.dart';
import 'package:diaco_test/data/resource_data/response_model.dart';
import 'package:diaco_test/providers/chat_provider.dart';
import 'package:diaco_test/providers/theme_provider.dart';
import 'package:diaco_test/ui/style/colors.dart';
import 'package:diaco_test/ui/style/dimens.dart';
import 'package:diaco_test/ui/widgets/message_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key, required this.userName}) : super(key: key);

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: Container(),
        elevation: 0,
        flexibleSpace: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(24),
                    bottomLeft: Radius.circular(24))),
            width: fullWidth(context),
            height: kToolbarHeight,
            padding: EdgeInsets.symmetric(
              horizontal: xSmallSize(context),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(24),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          color: AppColors.gray500,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Stack(
                          children: [
                            Container(
                              width: fullWidth(context) / 9,
                              height: fullWidth(context) / 9,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage("assets/img_1.png"))),
                            ),
                            Positioned(
                              bottom: 2,
                              right: 2,
                              child: Container(
                                width: fullWidth(context) / 40,
                                height: fullWidth(context) / 40,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: Container(
                                  margin: const EdgeInsets.all(1),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.primaryColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: smallSize(context),
                      ),
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: fullWidth(context) / 2,
                              child: Text(
                                "Friendly Group",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            Text(
                              "3 members online",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                      color: AppColors.primaryColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                CupertinoSwitch(
                    value: context
                        .select<ThemeProvider, bool>((bloc) => bloc.isDark),
                    activeColor: AppColors.primaryColor,
                    onChanged: (val) {
                      if (val) {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .setTheme(ThemeModel.dark);
                      }
                      if (!val) {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .setTheme(ThemeModel.light);
                      }
                    }),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(24),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: const Icon(
                          Icons.call_outlined,
                          color: AppColors.gray400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Consumer<ChatProvider>(builder: (context, provider, child) {
        List<Message> messages = provider.messages;
        return Column(
          children: [
            Expanded(
                child: provider.responseModel.status == Status.LOADING
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : provider.responseModel.status == Status.COMPLETED
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: smallSize(context)),
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: messages.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return MessageCard(
                                    index: index,
                                    userName: messages[index].username!,
                                    text: messages[index].text!,
                                    filePath: messages[index].file,
                                    isSender:
                                        userName == messages[index].username!
                                            ? true
                                            : false,
                                    edit: () async {
                                      provider.changeText(messages[index].text!,
                                          messages[index].id!);
                                      FocusScopeNode().focusedChild;
                                    },
                                    delete: () async {
                                      provider
                                          .deleteMessage(messages[index].id!);
                                      FocusScopeNode().unfocus();
                                    },
                                    isLast: <bool>() {
                                      if (index == messages.length - 1) {
                                        return true;
                                      }
                                      if (index < messages.length - 2 &&
                                          messages[index].username! !=
                                              messages[index + 1].username!) {
                                        return true;
                                      } else {
                                        return false;
                                      }
                                    },
                                  );
                                }),
                          )
                        : provider.responseModel.status == Status.FAILED
                            ? Center(
                                child: Text(provider.responseModel.message),
                              )
                            : Container()),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(24),
                      topLeft: Radius.circular(24))),
              width: fullWidth(context),
              height: kToolbarHeight * 1.6,
              padding: EdgeInsets.symmetric(
                horizontal: xSmallSize(context),
              ),
              child: Container(
                  width: fullWidth(context),
                  margin: EdgeInsets.all(mediumSize(context)),
                  padding: EdgeInsets.symmetric(
                      horizontal: xSmallSize(context), vertical: 0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).dividerColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(48))),
                  child: TextField(
                      controller: provider.chatController,
                      decoration: InputDecoration(
                          hintText: "Type here...",
                          hintStyle: Theme.of(context).textTheme.caption,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: smallSize(context),
                              horizontal: smallSize(context)),
                          suffixIcon: provider.hasText
                              ? GestureDetector(
                                  onTap: () async {
                                    if (provider.isEdit) {
                                      await provider.updateMessage(
                                          provider.chatController.text.trim(),
                                          provider.idEdit);
                                      FocusScopeNode().unfocus();
                                      provider.chatController.clear();
                                      provider.initText();
                                    }

                                    if (provider.uploadState) {
                                      await provider.uploadMessage(
                                          username: userName);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text('file uploaded')));
                                      FocusScopeNode().unfocus();
                                      provider.chatController.clear();
                                    } else {
                                      await provider.sendMessage(
                                        username: userName,
                                        text:
                                            provider.chatController.text.trim(),
                                      );
                                      FocusScopeNode().unfocus();
                                      provider.chatController.clear();
                                      provider.initText();
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle),
                                    child: const Icon(
                                      Icons.send_rounded,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  width: fullWidth(context) / 4,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Material(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(24),
                                        child: InkWell(
                                          onTap: () async {
                                            await provider
                                                .pickImage(ImageSource.gallery);
                                          },
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle),
                                            child: const Icon(
                                              Icons.attachment_rounded,
                                              color: AppColors.gray400,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Material(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          child: InkWell(
                                            onTap: () async {
                                              await provider.pickImage(
                                                  ImageSource.camera);
                                            },
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle),
                                              child: const Icon(
                                                Icons.camera_alt_outlined,
                                                color: AppColors.gray400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyText1,
                      onChanged: (text) {
                        provider.checkTextController();
                      })),
            )
          ],
        );
      }),
    );
  }
}
