
import 'package:axix_parent_app/view/widgets/app_button.dart';
import 'package:axix_parent_app/view/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/app_svgs.dart';



class ParentPinScreen extends ConsumerStatefulWidget {
  final String childName;

  const ParentPinScreen({
    super.key,
    required this.childName,
  });

  @override
  ConsumerState<ParentPinScreen> createState() =>
      _ParentPinScreenState();
}

class _ParentPinScreenState extends ConsumerState<ParentPinScreen> {
  final TextEditingController pinController = TextEditingController();
  final FocusNode pinFocusNode = FocusNode();

  @override
  void dispose() {
    pinController.dispose();
    pinFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = ref.watch(appThemeProvider);
    final textTheme = ref.watch(appTextProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldColor,
      appBar: AppBar(
        toolbarHeight: 83,
        backgroundColor: theme.appBarWhite,
        title: AppBackButton(
          textStyle: textTheme.appBarBackColor(theme),
        ),
      ),
      body: SafeArea(


        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 48, 32, 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 21,
                width: 99,
                padding: EdgeInsets.only(top: 2, left: 4, right: 4, bottom: 2),
                decoration: BoxDecoration(
                  color: theme.primary2Color,
                  border: Border.all(
                    color: theme.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(AppSvgs.avatar, height: 12, width: 12,),
                    SizedBox(width: 4,),
                    Text(
                        'Parent portal',
                        style: textTheme.smallerTextWithPrimaryColor(theme)
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              Text(
                'Log in with your 4-digit pin',
                style: textTheme.headingBlack(context, fontSize: 24, fontweight: FontWeight.w700),
              ),

              const SizedBox(height: 8),

              Text(
                'Use the pin you created',
                style: textTheme.bodyGrey(context),
              ),

              const SizedBox(height: 34),


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

              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                },
                child: Text(
                  'Forgot passcode?',
                  style: textTheme.smallTextWithPrimaryColor(theme, fontSize: 14)
                ),
              ),

              const SizedBox(height: 40),

              Spacer(),

              AppButton(
                onPressed: () {

                },
                label: 'Send code',
                buttonColor: theme.primaryColor,
                textStyle:
                textTheme.bodyWithOffWhiteColor(theme),
              ),
            ],
          ),
        ),


      ),
    );
  }
}