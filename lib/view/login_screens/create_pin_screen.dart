import 'dart:async';

import 'package:axix_parent_app/core/utils/app_svgs.dart';
import 'package:axix_parent_app/view/widgets/app_button.dart';
import 'package:axix_parent_app/view/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../main.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';


class CreatePinScreen extends ConsumerStatefulWidget {

  const CreatePinScreen({super.key});

  @override
  ConsumerState<CreatePinScreen> createState() =>
      _VerificationScreenConsumerState();
}


class _VerificationScreenConsumerState
    extends ConsumerState<CreatePinScreen> {

  @override





  String pin ='';
  String wrongCode = '';
  bool isLoading = false;
  String accessCode = "1255";





  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = ref.watch(appThemeProvider);
    final appTextThemeProvider = ref.watch(appTextProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldColor,
      appBar: AppBar(
        toolbarHeight: 83,
        title: AppBackButton(textStyle: appTextThemeProvider.appBarBackColor(theme),),
        backgroundColor: theme.appBarWhite,

      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 48,
            left: 32,
            right: 32,
            bottom: 48
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50, height: 50,
                decoration: BoxDecoration(
                  color: theme.primary2Color,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(5),
                child: SvgPicture.asset(AppSvgs.avatar,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: 32,),
              Text(
                "Create a 4-digit PIN",
                style: appTextThemeProvider.headingBlack(context),
              ),
              const SizedBox(
                height: 8,
              ),
              Text("You'll use it to open the app and approve payments", style: appTextThemeProvider.bodyGrey(context),),
              const SizedBox(
                height: 32,
              ),
              Center(
                child: SizedBox(
                  width: size.width*0.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: theme.greyBorderColor,
                        ),
                        width: 30,
                        height: 30,
                        child: Center(
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  // String nevalue = ("$code$value");
                                  // code = nevalue;
                                });
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                              ),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            )),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: theme.greyBorderColor,
                        ),
                        width: 30,
                        height: 30,
                        child: Center(
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  // String nevalue = ("$code$value");
                                  //
                                  // code = nevalue;
                                });
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                } else {
                                  if (value.isEmpty) {
                                    FocusScope.of(context).previousFocus();
                                  }
                                }
                              },
                              onSaved: (newValue3) {},
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                              ),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            )),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: theme.greyBorderColor,
                        ),
                        width: 30,
                        height: 30,
                        child: Center(
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  // String nevalue = ("$code$value");
                                  //
                                  // code = nevalue;
                                });
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                } else {
                                  if (value.isEmpty) {
                                    FocusScope.of(context).previousFocus();
                                  }
                                }
                              },
                              onSaved: (newValue3) {},
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                              ),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            )),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: theme.greyBorderColor,
                        ),
                        width: 30,
                        height: 30,
                        child: Center(
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  // String nevalue = ("$code$value");
                                  //
                                  // code = nevalue;
                                });
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                } else {
                                  if (value.isEmpty) {
                                    FocusScope.of(context).previousFocus();
                                  }
                                }
                              },
                              onSaved: (newValue3) {},
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                              ),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            )),
                      ),

                    ],
                  ),
                ),
              ),



              const Spacer(),



              AppButton(onPressed: (){},
                  label: 'Continue',
                  buttonColor: theme.primaryColor,
                  textStyle: appTextThemeProvider.bodyWithOffWhiteColor(theme)),

            ]),
      ),
    );
  }
}