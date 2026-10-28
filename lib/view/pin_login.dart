
import 'package:axix_parent_app/view/widgets/app_button.dart';
import 'package:axix_parent_app/view/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

// Use the same project imports as your existing screens for:
// appThemeProvider, appTextProvider, AppBackButton, and AppButton.

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
    final theme = ref.watch(appThemeProvider);
    final textTheme = ref.watch(appTextProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldColor,
      appBar: AppBar(
        backgroundColor: theme.appBarWhite,
        elevation: 0,
        leading: AppBackButton(
          textStyle: textTheme.appBarBackColor(theme),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(32, 24, 32, 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 48,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Parent portal',
                        style: TextStyle(
                          fontSize: 10,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    Text(
                      'Log in with your 4-digit pin',
                      style: textTheme.headingBlack(context),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Use the pin you created',
                      style: textTheme.bodyGrey(context),
                    ),

                    const SizedBox(height: 34),

                    // Four PIN indicators with a hidden input field.
                    GestureDetector(
                      onTap: () => pinFocusNode.requestFocus(),
                      child: SizedBox(
                        height: 48,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(4, (index) {
                                final entered =
                                    pinController.text.length > index;

                                return Container(
                                  width: 9,
                                  height: 9,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    color: entered
                                        ? theme.primaryColor
                                        : const Color(0xFFE4E7EC),
                                    shape: BoxShape.circle,
                                  ),
                                );
                              }),
                            ),

                            Opacity(
                              opacity: 0,
                              child: TextField(
                                controller: pinController,
                                focusNode: pinFocusNode,
                                autofocus: true,
                                keyboardType: TextInputType.number,
                                obscureText: true,
                                maxLength: 4,
                                onChanged: (_) => setState(() {}),
                                decoration: const InputDecoration(
                                  counterText: '',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    GestureDetector(
                      onTap: () {
                        // Add your forgot-PIN flow here.
                      },
                      child: Text(
                        'Forgot passcode?',
                        style: TextStyle(
                          fontSize: 11,
                          color: theme.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    AppButton(
                      onPressed: () {
                        // Connect your send-code or verification flow here.
                      },
                      label: 'Send code',
                      buttonColor: theme.primaryColor,
                      textStyle:
                      textTheme.bodyWithOffWhiteColor(theme),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}