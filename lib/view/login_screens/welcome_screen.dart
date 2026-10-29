
import 'package:axix_parent_app/core/utils/app_svgs.dart';
import 'package:axix_parent_app/view/login_screens/pin_login.dart';
import 'package:axix_parent_app/view/widgets/app_button.dart';
import 'package:axix_parent_app/view/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';


class ParentChildSelectionScreen extends ConsumerStatefulWidget {
  const ParentChildSelectionScreen({super.key});

  @override
  ConsumerState<ParentChildSelectionScreen> createState() =>
      _ParentChildSelectionScreenState();
}

class _ParentChildSelectionScreenState
    extends ConsumerState<ParentChildSelectionScreen> {
  int selectedChild = 0;

  final List<Map<String, String>> children = [
    {
      'name': 'Adaeze Nwosu',
      'class': 'SS1B · KHS/2024/101',
      'initials': 'AN',
    },
    {
      'name': 'Chidi Nwosu',
      'class': 'JSS2A · KHS/2025/062',
      'initials': 'CN',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    final textTheme = ref.watch(appTextProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldColor,
      appBar: AppBar(
        toolbarHeight: 83,
        backgroundColor: theme.scaffoldColor,
        title: AppBackButton(textStyle: textTheme.appBarBackColor(theme)),
      ),

      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 48, 32, 48),
          child: Column(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
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

                        const SizedBox(height: 20),

                        Text(
                          'Welcome, Ngozi',
                          style: textTheme.headingBlack(context),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          'Kings Heritage Secondary School has linked '
                              '2 children to your account.',
                          style: textTheme.bodyGrey(context),
                          softWrap: true,
                        ),

                        const SizedBox(height: 32),

                        ...List.generate(children.length, (index) {
                          final child = children[index];
                          final selected = selectedChild == index;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(14),
                              onTap: () {
                                setState(() {
                                  selectedChild = index;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: selected
                                        ? theme.primaryColor
                                        : theme.greyBorderColor,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundColor: AppThemeController.getAvatarColor('name'),
                                      child: Text(
                                        child['initials']!,
                                        style: textTheme.whiteText(context, fontSize: 14, fontweight: FontWeight.w700)
                                      ),
                                    ),


                                    const SizedBox(width: 10),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            child['name']!,
                                            style: textTheme.headingBlack(context, fontSize: 15, fontweight: FontWeight.w600),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            child['class']!,
                                            style: textTheme.bodyGrey(context, fontweight: FontWeight.w500, fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),

                               SvgPicture.asset(
                                       AppSvgs.circleMark),


                                  ],
                                ),
                              ),
                            ),
                          );
                        }),

                        const SizedBox(height: 6),

                        Wrap(
                          children: [
                            Text(
                              'Not your child, or one is missing? ',
                              style: textTheme.body3ColorText(theme),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Add your school contact action here.
                              },
                              child: Text(
                                'Tell the school',
                                style: textTheme.smallTextWithPrimaryColor(theme),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),


              Spacer(),
              AppButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ParentPinScreen(
                        childName: children[selectedChild]['name']!,
                      ),
                    ),
                  );
                },
                label: 'Continue',
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