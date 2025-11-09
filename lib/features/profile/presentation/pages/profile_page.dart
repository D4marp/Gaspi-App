import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/gen/assets.gen.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../home/presentation/widgets/navigation_wrapper.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return NavigationWrapper(
      title: 'My Account',
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            _buildProfileHeader(user),
            const SizedBox(height: 32),

            // Profile Menu Items
            _buildMenuItems(context),
            const SizedBox(height: 80), // Bottom padding for nav
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(dynamic user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF007EFF),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: Text(
                user?.name != null ? user!.name![0].toUpperCase() : 'U',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Column(
            children: [
              Text(
                user?.name ?? 'User',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                user?.email ?? '',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xCC777985),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    final menuItems = [
      {
        'icon': Assets.icons.setting2,
        'label': 'Settings',
        'route': '/settings',
      },
      {
        'icon': Assets.icons.shieldTick,
        'label': 'Security',
        'route': '/security',
      },
      {
        'icon': Assets.icons.documentText,
        'label': 'Help & Support',
        'route': '/help',
      },
    ];

    return Column(
      children: List.generate(
        menuItems.length,
        (index) {
          final item = menuItems[index];
          return Column(
            children: [
              ListTile(
                leading: SvgPicture.asset(
                  item['icon'] as String,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF007EFF),
                    BlendMode.srcIn,
                  ),
                ),
                title: Text(item['label'] as String),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.go(item['route'] as String),
              ),
              if (index < menuItems.length - 1)
                const Divider(height: 1),
            ],
          );
        },
      ),
    );
  }
}
