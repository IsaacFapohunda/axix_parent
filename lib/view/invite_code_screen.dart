import 'dart:async';

import 'package:axix_parent_app/core/utils/app_svgs.dart';
import 'package:axix_parent_app/view/widgets/app_button.dart';
import 'package:axix_parent_app/view/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../main.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';


class InviteCodeScreen extends ConsumerStatefulWidget {

  const InviteCodeScreen({super.key});

  @override
  ConsumerState<InviteCodeScreen> createState() =>
      _VerificationScreenConsumerState();
}


class _VerificationScreenConsumerState
    extends ConsumerState<InviteCodeScreen> {

  String phoneNumber = "+2345559555";
  int countdown = 59;
  late Timer timer;
  bool coountDownOver = false;
  @override



  void initState() {
    super.initState();
    startCountdown();

  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        setState(() {
          coountDownOver = true;
        });
        timer.cancel();
      }
    });
  }



  String code ='';
  bool isWrongCode = false;
  bool isLoading = false;
  String accessCode = "1255";




  // void submit(){
  //   code = code.replaceAll('null', '');
  //
  //   int encodedCode = int.parse(code);
  //   // print('VerificationCode = $code');
  //   Text('Your verification code is $code');
  //   }



  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    final appTextThemeProvider = ref.watch(appTextProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldColor,
      appBar: AppBar(
        leading: AppBackButton(textStyle: appTextThemeProvider.appBarBackColor(theme),),
        backgroundColor: theme.appBarWhite,
        centerTitle: true,
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
                "Enter your invite code",
                style:appTextThemeProvider.headingBlack(context),
              ),
              const SizedBox(
                height: 8,
              ),
              Text("Sent by SMS to $phoneNumber", style: appTextThemeProvider.bodyGrey(context),),
              const SizedBox(
                height: 32,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: isWrongCode ? theme.errorRedColor : theme.greyBorderColor,
                    ),
                    width: 14,
                    height: 14,
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
                      color: isWrongCode ? theme.errorRedColor : theme.greyBorderColor,
                    ),
                    width: 14,
                    height: 14,
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
                      color: isWrongCode ? theme.errorRedColor : theme.greyBorderColor,
                    ),
                    width: 14,
                    height: 14,
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
                      color: isWrongCode ? theme.errorRedColor : theme.greyBorderColor,
                    ),
                    width: 14,
                    height: 14,
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
                      color: isWrongCode ? theme.errorRedColor : theme.greyBorderColor,
                    ),
                    width: 14,
                    height: 14,
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
                          onSaved: (newValue4) {},
                          decoration: const InputDecoration(
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
                      color: isWrongCode ? theme.errorRedColor : theme.greyBorderColor,
                    ),
                    width: 14,
                    height: 14,
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
                          onSaved: (newValue5) {},
                          decoration: const InputDecoration(
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
                      color: isWrongCode ? theme.errorRedColor : theme.greyBorderColor,
                    ),
                    width: 14,
                    height: 14,
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
                          onSaved: (newValue6) {},
                          decoration: const InputDecoration(
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

              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                   "Resend code in 0.42",
                    style: appTextThemeProvider.body3ColorText(theme)),
                  isWrongCode ? Text('') : Text("Change number", style: appTextThemeProvider.smallTextWithPrimaryColor(theme),)
                ],
              ),

              const Spacer(),



              AppButton(onPressed: (){},
                  label: 'Verify',
                  buttonColor: theme.primaryColor,
                  textStyle: appTextThemeProvider.bodyWithOffWhiteColor(theme)),
              
            ]),
      ),
    );
  }
}