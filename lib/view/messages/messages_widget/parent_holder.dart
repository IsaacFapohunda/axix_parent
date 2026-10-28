

import 'package:axix_parent_app/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_text_styles.dart';

Widget parentHeader(BuildContext context, WidgetRef ref) {
  final appThemeColor = ref.watch(appThemeProvider);
  final appTextThemeProvider = ref.watch(appTextProvider);

  return Padding(
    padding: const EdgeInsets.only(top: 39.5, left: 24, right: 24),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.all(3),
          height: 36,
          width: 157,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              width: 1,
              color: appThemeColor.greyBorderColor,
            )

          ),
          child: Row(

            children: [

              CircleAvatar(
                radius: 17,
                backgroundColor: AppThemeController.getAvatarColor('AN'),
                child: Text('AN', style: appTextThemeProvider.whiteText(context)),
              ),
              Flexible(
                child: Text(
                  'Adaeze',
                  overflow: TextOverflow.ellipsis,
                  style: appTextThemeProvider.bodyBlack(context, fontweight: FontWeight.w700)
                ),
              ),
              SizedBox(width: 5),
              Text(
                'SS1B',
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
              Icon(Icons.keyboard_arrow_down, size: 15, color: Colors.grey),
            ],
          ),
        ),

        Row(
          children: [
            SizedBox(width: 41, height: 37,child: const Icon(Icons.notifications_none, )),
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 24,
              backgroundColor: Color(0xFFB42318),
              child: Text(
                'NN',
                style: appTextThemeProvider.whiteText(context, fontSize: 14),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}