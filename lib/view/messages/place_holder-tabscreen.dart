

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_text_styles.dart';

///demo placeholder screens for other bottomo nagivatuin itms
class PlaceholderTabScreen extends ConsumerStatefulWidget {
  final String title;

  const PlaceholderTabScreen({
    super.key,
    required this.title,
  });

  @override
  ConsumerState<PlaceholderTabScreen> createState() => _PlaceholderTabScreenState();
}

class _PlaceholderTabScreenState extends ConsumerState<PlaceholderTabScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appTextThemeProvider = ref.watch(appTextProvider);


    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.construction_outlined,
              size: 48,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 12),
            Text(
              '${widget.title} screen',
              style:  appTextThemeProvider.headingBlack(context),
            ),
            const SizedBox(height: 6),
            Text(
              'This screen will be implemented later.',
              style:  appTextThemeProvider.bodyGrey(context),
            ),
          ],
        ),
      ),
    );
  }
}