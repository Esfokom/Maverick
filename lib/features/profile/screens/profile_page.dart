import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../home/data/mock_user_stats.dart';
import '../../programs/data/mock_programs.dart';

/// Displays the user's profile with statistics and settings.
class ProfilePage extends StatelessWidget {
  /// Creates a [ProfilePage].
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, colorScheme),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatsSection(colorScheme),
                  const SizedBox(height: 24),
                  _buildEnrolledProgramsSection(colorScheme),
                  const SizedBox(height: 24),
                  _buildAchievementsSection(colorScheme),
                  const SizedBox(height: 24),
                  _buildSettingsSection(context, colorScheme),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, ColorScheme colorScheme) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: colorScheme.inverseSurface,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(color: colorScheme.inverseSurface),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              CircleAvatar(
                backgroundColor: colorScheme.onInverseSurface,
                radius: 30,
                child: Center(
                  child: Text(
                    mockUserStats.userName[0].toUpperCase(),
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.inverseSurface,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                mockUserStats.userName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onInverseSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Learning Enthusiast',
                style: TextStyle(
                  fontSize: 16,
                  color: colorScheme.onInverseSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection(ColorScheme colorScheme) {
    return ShadCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Learning Statistics',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  Icons.book_outlined,
                  '${mockUserStats.totalCoursesCompleted}',
                  'Courses',
                  colorScheme,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatItem(
                  Icons.access_time,
                  '${mockUserStats.totalLearningHours}h',
                  'Hours',
                  colorScheme,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  Icons.local_fire_department,
                  '${mockUserStats.currentStreak}',
                  'Day Streak',
                  colorScheme,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatItem(
                  Icons.emoji_events,
                  '12',
                  'Achievements',
                  colorScheme,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    IconData icon,
    String value,
    String label,
    ColorScheme colorScheme,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: colorScheme.onSurface, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEnrolledProgramsSection(ColorScheme colorScheme) {
    return ShadCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Program',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          _buildProgramItem(
            mockPrograms[0].name,
            '${mockUserStats.currentProgramProgress.toInt()}% Complete',
            mockUserStats.currentProgramProgress / 100,
            colorScheme,
          ),
        ],
      ),
    );
  }

  Widget _buildProgramItem(
    String name,
    String progress,
    double progressValue,
    ColorScheme colorScheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            ShadBadge(child: Text(progress)),
          ],
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progressValue,
            minHeight: 8,
            backgroundColor: colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementsSection(ColorScheme colorScheme) {
    return ShadCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Achievements',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildAchievementBadge(
                Icons.emoji_events,
                'First Course',
                colorScheme,
              ),
              _buildAchievementBadge(
                Icons.local_fire_department,
                '7 Day Streak',
                colorScheme,
              ),
              _buildAchievementBadge(Icons.star, 'Fast Learner', colorScheme),
              _buildAchievementBadge(Icons.school, 'Scholar', colorScheme),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementBadge(
    IconData icon,
    String label,
    ColorScheme colorScheme,
  ) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: colorScheme.onPrimaryContainer, size: 28),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 70,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsSection(BuildContext context, ColorScheme colorScheme) {
    return ShadCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _buildSettingsTile(
            Icons.person_outline,
            'Edit Profile',
            () {},
            colorScheme,
          ),
          _buildDivider(colorScheme),
          _buildSettingsTile(
            Icons.notifications_outlined,
            'Notifications',
            () {},
            colorScheme,
          ),
          _buildDivider(colorScheme),
          _buildSettingsTile(
            Icons.lock_outline,
            'Privacy & Security',
            () {},
            colorScheme,
          ),
          _buildDivider(colorScheme),
          _buildSettingsTile(
            Icons.help_outline,
            'Help & Support',
            () {},
            colorScheme,
          ),
          _buildDivider(colorScheme),
          _buildSettingsTile(Icons.info_outline, 'About', () {}, colorScheme),
          _buildDivider(colorScheme),
          _buildSettingsTile(
            Icons.logout,
            'Logout',
            () {
              _showLogoutDialog(context, colorScheme);
            },
            colorScheme,
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    IconData icon,
    String title,
    VoidCallback onTap,
    ColorScheme colorScheme, {
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive
            ? colorScheme.error
            : colorScheme.onSurface.withValues(alpha: 0.7),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? colorScheme.error : colorScheme.onSurface,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: colorScheme.onSurface.withValues(alpha: 0.4),
      ),
      onTap: onTap,
    );
  }

  Widget _buildDivider(ColorScheme colorScheme) {
    return Divider(
      height: 1,
      thickness: 1,
      color: colorScheme.surfaceContainerHighest,
      indent: 16,
      endIndent: 16,
    );
  }

  void _showLogoutDialog(BuildContext context, ColorScheme colorScheme) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: colorScheme.surface,
          title: Text('Logout', style: TextStyle(color: colorScheme.onSurface)),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(color: colorScheme.onSurface),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                'Cancel',
                style: TextStyle(color: colorScheme.onSurface),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                // Add logout logic here
              },
              child: Text('Logout', style: TextStyle(color: colorScheme.error)),
            ),
          ],
        );
      },
    );
  }
}
