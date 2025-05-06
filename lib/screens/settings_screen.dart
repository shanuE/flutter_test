import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          const _SettingsNavigationBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _SettingsItem(
                    title: 'Notifications',
                    icon: CupertinoIcons.bell,
                    onTap: () {},
                  ),
                  _SettingsItem(
                    title: 'Appearance',
                    icon: CupertinoIcons.paintbrush,
                    onTap: () {},
                  ),
                  _SettingsItem(
                    title: 'Privacy',
                    icon: CupertinoIcons.lock,
                    onTap: () {},
                  ),
                  _SettingsItem(
                    title: 'View Terms & Conditions',
                    icon: CupertinoIcons.doc_text,
                    onTap: () => _showTermsSheet(context),
                  ),
                  const SizedBox(height: 32),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Material(
                      child: Text(
                        'Profile Card',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const ProfileCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void _showTermsSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Terms & Conditions'),
          leading: SizedBox(),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Text(
                '''
These are the Terms and Conditions:

1. Use the app responsibly.
2. We respect your privacy.
3. This is placeholder text for demo purposes.

Thank you for using our app.
''',
                style: CupertinoTheme.of(context).textTheme.textStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsNavigationBar extends StatelessWidget {
  const _SettingsNavigationBar();

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      largeTitle: const Text('Settings'),
      stretch: true,
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      trailing: const Icon(CupertinoIcons.gear),
      border: null,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: CupertinoSearchTextField(
            placeholder: 'Search settings',
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          ),
        ),
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: CupertinoColors.separator,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: CupertinoColors.activeBlue),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            const Icon(
              CupertinoIcons.chevron_right,
              color: CupertinoColors.systemGrey,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade300, Colors.purple.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(
                sigmaX: 2.0,
                sigmaY: 2.0,
              ),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                ),
                child: const Text(
                  'Profile Card',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}