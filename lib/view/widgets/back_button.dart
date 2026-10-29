import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';



class AppBackButton extends ConsumerWidget {
  final String label;
  final bool showLabel;
  final VoidCallback? onPressed;
  final TextStyle textStyle;

  const AppBackButton({super.key,
    this.label = "Back",
  this.showLabel = true,
  this.onPressed,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: theme.greyBorderColor,
              ),
              shape: BoxShape.circle,
            ),
            child:  Center(
              child: Icon(
                Icons.arrow_back,
                color: theme.bodyColor,
              ),
            ),
          ),

          if (showLabel) ...[
            const SizedBox(width: 8,),
            Text(label, style: textStyle,)
          ]
        ],
      ),
    );
  }
}