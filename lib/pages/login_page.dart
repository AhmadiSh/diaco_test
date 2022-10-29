// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:diaco_test/providers/chat_provider.dart';
import 'package:diaco_test/providers/login_provider.dart';
import 'package:diaco_test/style/colors.dart';
import 'package:diaco_test/style/dimens.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'chat_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _textEditingController;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  late final Box _box;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _box = Hive.box('users');
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _box.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.white,
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
                color: Color(0x7C4D4C4C),
              )),
              Consumer<LoginProvider>(builder: (context, provider, child) {
                return Positioned(
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: Container(
                      height: fullHeight(context) / 2.3,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
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
                                      key: _globalKey,
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
                                    /* Consumer<UserDataProvider>(
                                       builder: (context, userProvider, child) {
                                         var state = userProvider.responseModel?.status;
                                         switch (state) {
                                           case Status.LOADING:
                                             return Center(
                                                 child: Container(
                                                     margin: EdgeInsets.symmetric(
                                                         vertical: smallSize(context)),
                                                     child:
                                                     const CircularProgressIndicator()));
                                           case Status.COMPLETED:
                                             {

                                               return _registerBtn(context);
                                             }
                                           case Status.FAILED:
                                             {
                                               return Column(
                                                 crossAxisAlignment:
                                                 CrossAxisAlignment.start,
                                                 mainAxisAlignment:
                                                 MainAxisAlignment.center,
                                                 children: [
                                                   _registerBtn(
                                                     context,
                                                   ),
                                                   Row(
                                                     children: [
                                                       Icon(
                                                         Icons.error,
                                                         color: Colors.redAccent,
                                                         size: iconSize(context),
                                                       ),
                                                       const SizedBox(
                                                         width: 6,
                                                       ),
                                                       Text(
                                                         userProvider
                                                             .responseModel!.message,
                                                         style: theme.textTheme.caption!
                                                             .copyWith(
                                                           color: Colors.redAccent,
                                                         ),
                                                       ),
                                                     ],
                                                   )
                                                 ],
                                               );
                                             }
                                           default:
                                             {
                                               return _registerBtn(context);
                                             }
                                         }
                                       },
                                     ),*/
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
                                    await _box.put(
                                        _textEditingController.text.trim(), {
                                      'userName':
                                          _textEditingController.text.trim()
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                ChangeNotifierProvider<
                                                    ChatProvider>(
                                                  create: (context) =>
                                                      ChatProvider(),
                                                  child: ChatPage(
                                                    keyBox:_box.get(_textEditingController.text.trim())!['userName']
                                                  ),
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
