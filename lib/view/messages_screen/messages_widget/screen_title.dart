
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

Widget screenTitle(
    BuildContext context,
    String title,
    String subtitle,
    WidgetRef ref
    ) {

  final appThemeColor = ref.watch(appThemeProvider);
  final appTextThemeProvider = ref.watch(appTextProvider);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: appTextThemeProvider.headingBlack(context)),
      const SizedBox(height: 4),
      Text(subtitle, style: appTextThemeProvider.bodyGrey(context)),
    ],
  );
}