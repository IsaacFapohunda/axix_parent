
import 'package:axix_parent_app/view/more_screens/payment_method_screen.dart';
import 'package:axix_parent_app/view/more_screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../messages_screen/messages_widget/parent_holder.dart';
import '../messages_screen/messages_widget/screen_title.dart';
import 'edit_profile_screen.dart';



class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({
    super.key,
    this.onOpenSettings,
  });

  final VoidCallback? onOpenSettings;

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  String firstName = 'Ngozi';
  String lastName = 'Nwosu';
  String email = 'ngozi.nwosu@gmail.com';
  String address = '14 Ajose Street, Surulere';

  Future<void> _editProfile() async {
    final result = await showModalBottomSheet<Map<String, String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => EditProfileBottomSheet(
        firstName: firstName,
        lastName: lastName,
        email: email,
        address: address,
      ),
    );

    if (result != null && mounted) {
      setState(() {
        firstName = result['firstName']!;
        lastName = result['lastName']!;
        email = result['email']!;
        address = result['address']!;
      });
    }
  }

  Future<void> _logout() async {
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const LogoutBottomSheet(),
    );

    if (confirmed == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Connect your existing logout method here.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    final textTheme = ref.watch(appTextProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldColor,
      appBar: AppBar(
        primary: false,
        toolbarHeight: 168,
        titleSpacing: 0,
        backgroundColor: theme.appBarWhite,
        title: Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 39.5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              parentHeader(context, ref),
              const SizedBox(height: 24),
              screenTitle(
                context,
                'Profile',
                'Parent account',
                ref,
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFECEFF2),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundColor: Color(0xFFB42318),
                      child: Text(
                        'NN',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$firstName $lastName',
                            style: textTheme.bodyBlack(
                              context,
                              fontSize: 14.0,
                              fontweight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Mother · Primary guardian',
                            style: textTheme.body2ColorText(theme),
                          ),
                          Text(
                            email,
                            style: textTheme.body2ColorText(theme),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 36,
                  child: OutlinedButton(
                    onPressed: _editProfile,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF1A7A4A),
                      side: const BorderSide(
                        color: Color(0xFF1A7A4A),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text('Edit profile'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          _profileSectionTitle(
            'My children',
            '2',
            textTheme,
            context,
          ),
          const SizedBox(height: 8),

          _profileChild(
            'AN',
            'Adaeze Nwosu',
            'SS1B',
            const Color(0xFF2C93FF),
          ),
          _profileChild(
            'CN',
            'Chidi Nwosu',
            'JSS2A',
            const Color(0xFF625BEB),
          ),

          const SizedBox(height: 18),
          Text(
            'Account',
            style: textTheme.bodyBlack(
              context,
              fontSize: 14.0,
              fontweight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),

          _profileMenuItem(
            icon: Icons.credit_card_outlined,
            title: 'Payment methods',
            subtitle: null,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PaymentMethodsScreen(),
                ),
              );
            },
          ),

          _profileMenuItem(
            icon: Icons.settings_outlined,
            title: 'Settings',
            subtitle: 'Notifications, language, security',
            onTap: () {
              if (widget.onOpenSettings != null) {
                widget.onOpenSettings!();
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ParentSettingsScreen(),
                  ),
                );
              }
            },
          ),

          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: OutlinedButton.icon(
              onPressed: _logout,
              icon: const Icon(Icons.logout, size: 16),
              label: const Text('Log out'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFE55353),
                side: const BorderSide(
                  color: Color(0xFFF4C7C7),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileSectionTitle(
      String title,
      String count,
      AppTextStyles textTheme,
      BuildContext context,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textTheme.bodyBlack(
            context,
            fontSize: 14.0,
            fontweight: FontWeight.w700,
          ),
        ),
        Text(
          count,
          style: const TextStyle(
            color: Color(0xFF1A7A4A),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _profileChild(
      String initials,
      String name,
      String className,
      Color color,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: const Color(0xFFECEFF2),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 17,
            backgroundColor: color,
            child: Text(
              initials,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                Text(
                  className,
                  style: const TextStyle(
                    color: Color(0xFF89919D),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: Color(0xFF89919D),
          ),
        ],
      ),
    );
  }

  Widget _profileMenuItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 13,
        ),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFFECEFF2),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 19,
              color: const Color(0xFF89919D),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF89919D),
                      ),
                    ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Color(0xFF89919D),
            ),
          ],
        ),
      ),
    );
  }
}