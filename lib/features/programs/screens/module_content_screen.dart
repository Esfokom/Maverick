import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../models/program.dart';

/// A screen that displays the content of a program module in markdown format.
class ModuleContentScreen extends StatefulWidget {
  /// Creates a [ModuleContentScreen].
  const ModuleContentScreen({
    required this.modules,
    required this.initialModuleIndex,
    required this.programName,
    super.key,
  });

  /// The list of modules in the program.
  final List<ProgramModule> modules;

  /// The index of the module to display initially.
  final int initialModuleIndex;

  /// The name of the program.
  final String programName;

  @override
  State<ModuleContentScreen> createState() => _ModuleContentScreenState();
}

class _ModuleContentScreenState extends State<ModuleContentScreen> {
  late int _currentModuleIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentModuleIndex = widget.initialModuleIndex;
    _pageController = PageController(initialPage: _currentModuleIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextModule() {
    if (_currentModuleIndex < widget.modules.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousModule() {
    if (_currentModuleIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.programName,
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            Text(
              widget.modules[_currentModuleIndex].title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                'Module ${_currentModuleIndex + 1}/${widget.modules.length}',
                style: TextStyle(
                  fontSize: 14,
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress indicator
          LinearProgressIndicator(
            value: (_currentModuleIndex + 1) / widget.modules.length,
            backgroundColor: colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
          ),

          // Module content
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentModuleIndex = index;
                });
              },
              itemCount: widget.modules.length,
              itemBuilder: (context, index) {
                final module = widget.modules[index];
                final hasContent =
                    module.content != null && module.content!.isNotEmpty;

                if (!hasContent) {
                  return _buildComingSoonView(module);
                }

                return _buildModuleContent(module);
              },
            ),
          ),

          // Navigation buttons
          _buildNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildModuleContent(ProgramModule module) {
    final colorScheme = Theme.of(context).colorScheme;

    return Markdown(
      data: module.content!,
      styleSheet: MarkdownStyleSheet(
        h1: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
        h2: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
          height: 1.5,
        ),
        h3: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        h4: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        p: TextStyle(fontSize: 16, color: colorScheme.onSurface, height: 1.6),
        code: TextStyle(
          backgroundColor: colorScheme.surfaceContainerHighest,
          color: colorScheme.primary,
          fontFamily: 'monospace',
        ),
        codeblockDecoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        blockquote: TextStyle(
          color: colorScheme.onSurface.withValues(alpha: 0.7),
          fontStyle: FontStyle.italic,
        ),
        blockquoteDecoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(4),
          border: Border(
            left: BorderSide(color: colorScheme.primary, width: 4),
          ),
        ),
        listBullet: TextStyle(color: colorScheme.primary),
      ),
      padding: const EdgeInsets.all(16),
    );
  }

  Widget _buildComingSoonView(ProgramModule module) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_outline,
              size: 64,
              color: colorScheme.onSurface.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'Content Coming Soon',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This module content is currently being developed.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 24),
            ShadCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    module.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    module.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Duration: ${module.duration}',
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationBar() {
    final colorScheme = Theme.of(context).colorScheme;
    final canGoPrevious = _currentModuleIndex > 0;
    final canGoNext = _currentModuleIndex < widget.modules.length - 1;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(color: colorScheme.outlineVariant, width: 1),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Previous button
          Expanded(
            child: ShadButton(
              onPressed: canGoPrevious ? _goToPreviousModule : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back,
                    size: 18,
                    color: canGoPrevious
                        ? colorScheme.onPrimary
                        : colorScheme.onSurface.withValues(alpha: 0.3),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Previous',
                    style: TextStyle(
                      color: canGoPrevious
                          ? colorScheme.onPrimary
                          : colorScheme.onSurface.withValues(alpha: 0.3),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Next button
          Expanded(
            child: ShadButton(
              onPressed: canGoNext ? _goToNextModule : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    canGoNext ? 'Next' : 'Complete',
                    style: TextStyle(
                      color: canGoNext
                          ? colorScheme.onPrimary
                          : colorScheme.onSurface.withValues(alpha: 0.3),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    canGoNext ? Icons.arrow_forward : Icons.check,
                    size: 18,
                    color: canGoNext
                        ? colorScheme.onPrimary
                        : colorScheme.onSurface.withValues(alpha: 0.3),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
