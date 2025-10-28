import 'package:flutter/material.dart';
import '../models/program.dart';
import 'module_content_screen.dart';

/// Displays detailed information about a specific program.
class ProgramDetailPage extends StatelessWidget {
  /// Creates a [ProgramDetailPage].
  const ProgramDetailPage({required this.program, super.key});

  /// The program to display details for.
  final Program program;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProgramHeader(),
                  const SizedBox(height: 24),
                  _buildFullDescription(),
                  const SizedBox(height: 32),
                  _buildAuthorSection(),
                  const SizedBox(height: 32),
                  _buildModulesSection(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'program_${program.id}',
          child: Image.asset(program.thumbnailPath, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildProgramHeader() {
    return Builder(
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              program.name,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _buildInfoChip(Icons.schedule, program.duration, Colors.blue),
                _buildInfoChip(
                  Icons.signal_cellular_alt,
                  program.difficulty.displayName,
                  _getDifficultyColor(),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Chip(
      avatar: Icon(icon, size: 18, color: color),
      label: Text(label),
      backgroundColor: color.withValues(alpha: 0.1),
      side: BorderSide(color: color.withValues(alpha: 0.3)),
    );
  }

  Color _getDifficultyColor() {
    switch (program.difficulty) {
      case ProgramDifficulty.beginner:
        return Colors.green;
      case ProgramDifficulty.intermediate:
        return Colors.orange;
      case ProgramDifficulty.advanced:
        return Colors.red;
    }
  }

  Widget _buildFullDescription() {
    return Builder(
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About this Program',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              program.fullDescription,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAuthorSection() {
    return Builder(
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Instructor',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: colorScheme.primary,
                    child: Text(
                      program.author[0],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          program.author,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          program.authorBio,
                          style: TextStyle(
                            fontSize: 14,
                            color: colorScheme.onSurfaceVariant,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildModulesSection() {
    return Builder(
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Program Modules',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: program.modules.length,
              itemBuilder: (context, index) {
                final module = program.modules[index];
                return _ModuleCard(
                  module: module,
                  index: index + 1,
                  program: program,
                  moduleIndex: index,
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _ModuleCard extends StatelessWidget {
  const _ModuleCard({
    required this.module,
    required this.index,
    required this.program,
    required this.moduleIndex,
  });

  final ProgramModule module;
  final int index;
  final Program program;
  final int moduleIndex;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasContent = module.content != null && module.content!.isNotEmpty;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: InkWell(
        onTap: program.isComingSoon
            ? null
            : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ModuleContentScreen(
                      modules: program.modules,
                      initialModuleIndex: moduleIndex,
                      programName: program.name,
                    ),
                  ),
                );
              },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: hasContent
                          ? colorScheme.primary
                          : colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: hasContent
                          ? Text(
                              '$index',
                              style: TextStyle(
                                color: colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Icon(
                              Icons.lock_outline,
                              size: 16,
                              color: colorScheme.onSurfaceVariant,
                            ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      module.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      module.duration,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  if (!program.isComingSoon && hasContent) ...[
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 44),
                child: Text(
                  module.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
