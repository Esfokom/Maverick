import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../programs/models/program.dart';
import '../../programs/screens/program_detail_page.dart';
import '../../programs/screens/module_content_screen.dart';
import '../../../core/providers/app_providers.dart';

/// Displays the user's enrolled courses with progress tracking.
class MyCoursesPage extends ConsumerStatefulWidget {
  /// Creates a [MyCoursesPage].
  const MyCoursesPage({super.key});

  @override
  ConsumerState<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends ConsumerState<MyCoursesPage> {
  CourseFilter _currentFilter = CourseFilter.all;

  List<Program> _getFilteredCourses(List<Program> enrolledPrograms) {
    final programProgress = ref.watch(programProgressProvider);

    switch (_currentFilter) {
      case CourseFilter.all:
        return enrolledPrograms;
      case CourseFilter.inProgress:
        return enrolledPrograms.where((p) {
          final progress = programProgress[p.id] ?? 0.0;
          return progress > 0 && progress < 100;
        }).toList();
      case CourseFilter.completed:
        return enrolledPrograms.where((p) {
          final progress = programProgress[p.id] ?? 0.0;
          return progress >= 100;
        }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final enrolledPrograms = ref.watch(enrolledProgramsListProvider);
    final programProgress = ref.watch(programProgressProvider);
    final filteredCourses = _getFilteredCourses(enrolledPrograms);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('My Courses'),
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildHeader(colorScheme, enrolledPrograms, programProgress),
          _buildFilterTabs(colorScheme),
          Expanded(
            child: filteredCourses.isEmpty
                ? _buildEmptyState(colorScheme)
                : _buildCoursesList(filteredCourses),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(
    ColorScheme colorScheme,
    List<Program> enrolledPrograms,
    Map<String, double> programProgress,
  ) {
    final totalCourses = enrolledPrograms.length;
    final inProgressCourses = enrolledPrograms.where((p) {
      final progress = programProgress[p.id] ?? 0.0;
      return progress > 0 && progress < 100;
    }).length;
    final completedCourses = enrolledPrograms.where((p) {
      final progress = programProgress[p.id] ?? 0.0;
      return progress >= 100;
    }).length;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.primaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Learning Journey',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                totalCourses.toString(),
                'Total',
                colorScheme.onPrimary,
              ),
              Container(
                width: 1,
                height: 40,
                color: colorScheme.onPrimary.withValues(alpha: 0.2),
              ),
              _buildStatItem(
                inProgressCourses.toString(),
                'In Progress',
                colorScheme.onPrimary,
              ),
              Container(
                width: 1,
                height: 40,
                color: colorScheme.onPrimary.withValues(alpha: 0.2),
              ),
              _buildStatItem(
                completedCourses.toString(),
                'Completed',
                colorScheme.onPrimary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color textColor) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: textColor.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterTabs(ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildFilterTab(CourseFilter.all, 'All', colorScheme),
          ),
          Expanded(
            child: _buildFilterTab(
              CourseFilter.inProgress,
              'In Progress',
              colorScheme,
            ),
          ),
          Expanded(
            child: _buildFilterTab(
              CourseFilter.completed,
              'Completed',
              colorScheme,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTab(
    CourseFilter filter,
    String label,
    ColorScheme colorScheme,
  ) {
    final isSelected = _currentFilter == filter;

    return GestureDetector(
      onTap: () => setState(() => _currentFilter = filter),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.inverseSurface : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected
                ? colorScheme.onInverseSurface
                : colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(ColorScheme colorScheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.school_outlined,
            size: 64,
            color: colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No courses found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start learning by enrolling in a program',
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoursesList(List<Program> courses) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return _CourseCard(program: courses[index]);
      },
    );
  }
}

/// Filter options for courses.
enum CourseFilter {
  /// Show all courses.
  all,

  /// Show only in-progress courses.
  inProgress,

  /// Show only completed courses.
  completed,
}

class _CourseCard extends ConsumerWidget {
  const _CourseCard({required this.program});

  final Program program;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final programProgress = ref.watch(programProgressProvider);
    final lastModuleIndex = ref.watch(lastModuleIndexProvider);
    final progress = programProgress[program.id] ?? 0.0;
    final lastModule = lastModuleIndex[program.id] ?? 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      color: colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => ProgramDetailPage(program: program),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildThumbnail(colorScheme, progress),
            _buildContent(context, colorScheme, progress, lastModule, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail(ColorScheme colorScheme, double progress) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.asset(
              program.thumbnailPath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: colorScheme.surfaceContainerHighest,
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 48,
                      color: colorScheme.onSurface.withValues(alpha: 0.3),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        if (progress >= 100)
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, size: 16, color: Colors.white),
                  SizedBox(width: 4),
                  Text(
                    'Completed',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildContent(
    BuildContext context,
    ColorScheme colorScheme,
    double progress,
    int lastModule,
    WidgetRef ref,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            program.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.layers,
                size: 16,
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 4),
              Text(
                'Module ${lastModule + 1}/${program.modules.length}',
                style: TextStyle(
                  fontSize: 14,
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Progress',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          '${progress.toInt()}%',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progress / 100,
                        minHeight: 8,
                        backgroundColor: colorScheme.surfaceContainerHighest,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          progress >= 100 ? Colors.green : colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ShadButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => ModuleContentScreen(
                    modules: program.modules,
                    initialModuleIndex: lastModule,
                    programName: program.name,
                    programId: program.id,
                  ),
                ),
              );
            },
            size: ShadButtonSize.sm,
            width: double.infinity,
            child: Text(
              progress >= 100
                  ? 'Review Course'
                  : lastModule > 0
                  ? 'Continue Learning'
                  : 'Start Course',
            ),
          ),
        ],
      ),
    );
  }
}
