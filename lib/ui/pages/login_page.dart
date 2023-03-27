import 'dart:ui';

import 'package:diaco_test/providers/chat_provider.dart';
import 'package:diaco_test/providers/login_provider.dart';
import 'package:diaco_test/ui/style/colors.dart';
import 'package:diaco_test/ui/style/dimens.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'chat_page.dart';

class LoginPage extends StatelessWidget {
   LoginPage({Key? key}) : super(key: key);

   final TextEditingController _textEditingController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Container(
          width: fullWidth(context),
          height: fullHeight(context),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img.png'), fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              Positioned(
                  child: Container(
                color: const Color(0x7C4D4C4C),
              )),
              Consumer<LoginProvider>(builder: (context, provider, child) {
                return Positioned(
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: Container(
                      height: fullHeight(context) / 2.3,
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(32),
                              topLeft: Radius.circular(32))),
                      child: Stack(
                        children: [
                          Positioned(
                            top: smallSize(context),
                            child: SizedBox(
                              width: fullWidth(context),
                              child: Padding(
                                padding: EdgeInsets.all(mediumSize(context)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: smallSize(context),
                                    ),
                                    Text(
                                      "Sign In",
                                      style: theme.textTheme.headline6,
                                    ),
                                    SizedBox(
                                      height: standardSize(context),
                                    ),
                                    Form(
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: _textEditingController,
                                            decoration: InputDecoration(
                                                errorText:
                                                    provider.userNameError,
                                                labelText: "username",
                                                labelStyle: theme.textTheme.bodyText2!
                                                    .copyWith(
                                                        color: theme.textTheme
                                                            .caption!.color),
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(
                                                        smallSize(context)),
                                                    borderSide: const BorderSide(
                                                        width: 0.8,
                                                        color:
                                                            AppColors.gray200)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(
                                                        smallSize(context)),
                                                    borderSide: const BorderSide(
                                                        width: 0.8,
                                                        color: AppColors.gray200)),
                                                errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(smallSize(context)), borderSide: BorderSide(width: 0.8, color: theme.errorColor)),
                                                focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(smallSize(context)), borderSide: BorderSide(width: 0.8, color: theme.errorColor)),
                                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(smallSize(context)), borderSide: BorderSide(width: 0.8, color: theme.primaryColor)),
                                                contentPadding: EdgeInsets.symmetric(vertical: mediumSize(context), horizontal: smallSize(context)),
                                                errorStyle: theme.textTheme.caption!.copyWith(color: theme.errorColor),
                                                prefixIcon: Icon(
                                                  Icons.person_outline_rounded,
                                                  color: AppColors.gray400,
                                                  size: theme.iconTheme.size,
                                                )),
                                            maxLines: 1,
                                            style: theme.textTheme.bodyText1,
                                            onChanged: (text) {
                                              provider.validateUserName(text);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: xSmallSize(context)),
                                      child: Text(
                                        'Creating an account means you\'re okay with our Terms of Services and our Privacy Policy',
                                        style: theme.textTheme.caption,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Padding(
                                padding: EdgeInsets.all(mediumSize(context)),
                                child: _registerBtn(context, () async {
                                  bool isValid =
                                      await provider.validateUserName(
                                          _textEditingController.text.trim());
                                  if (isValid) {
                                  // ignore: use_build_context_synchronously
                                  Provider.of<LoginProvider>(context,listen: false).setUsername(_textEditingController.text.trim());
                                    // ignore: use_build_context_synchronously
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                ChangeNotifierProvider<
                                                    ChatProvider>(
                                                  create: (context) =>
                                                      ChatProvider(),
                                                  child: ChatPage(
                                                      userName: provider.username),
                                                )));
                                  }
                                }),
                              ))
                        ],
                      ),
                    ));
              }),
            ],
          ),
        ),
      ),
    );
  }

  _registerBtn(BuildContext context, VoidCallback onTap) {
    ThemeData theme = Theme.of(context);

    return Container(
      width: fullWidth(context),
      margin: EdgeInsets.symmetric(vertical: smallSize(context)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.primaryColor,
          textStyle: theme.textTheme.button,
          padding: EdgeInsets.symmetric(vertical: smallSize(context)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(smallSize(context))),
        ),
        onPressed: onTap,
        child: Text(
          "Sign in",
          style: theme.textTheme.button,
        ),
      ),
    );
  }
}
