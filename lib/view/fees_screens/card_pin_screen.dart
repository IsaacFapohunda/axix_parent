
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../model/fees/fees_data.dart';
import '../messages_screen/messages_widget/green_button.dart';
import 'otp_verfication_screen.dart';

class CardPinScreen extends ConsumerStatefulWidget {
  final FeeInvoice? invoice;
  final bool payAll;

  const CardPinScreen({
    super.key,
    this.invoice,
    this.payAll = false,
  });

  @override
  ConsumerState<CardPinScreen> createState() => _CardPinScreenState();
}

class _CardPinScreenState extends ConsumerState<CardPinScreen> {
  final pinController = TextEditingController();

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final theme = ref.watch(appThemeProvider);
    final textTheme = ref.watch(appTextProvider);


    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(
          18,
          18,
          18,
          MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(18),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Enter your card PIN',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Text(
                'Enter your 4-digit demonstration PIN',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF98A2B3),
                ),
              ),
              const SizedBox(height: 25),


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

              // TextField(
              //   controller: pinController,
              //   obscureText: true,
              //   textAlign: TextAlign.center,
              //   keyboardType: TextInputType.number,
              //   inputFormatters: [
              //     FilteringTextInputFormatter.digitsOnly,
              //     LengthLimitingTextInputFormatter(4),
              //   ],
              //   decoration: const InputDecoration(
              //     hintText: '••••',
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F4F7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.lock_outline, size: 16),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'This is a demonstration screen. Do not enter a real bank PIN.',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              greenButton(
                label: 'Continue',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OtpVerificationScreen(
                        invoice: widget.invoice,
                        payAll: widget.payAll,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}