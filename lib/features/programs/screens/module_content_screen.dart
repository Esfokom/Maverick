import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:markdown/markdown.dart' as md;
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Markdown(
      data: module.content!,
      builders: {'code': CodeElementBuilder(isDarkMode: isDarkMode)},
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
          backgroundColor: isDarkMode
              ? const Color(0xFF1F2937)
              : const Color(0xFFF6F8FA),
          color: isDarkMode ? const Color(0xFFE5E7EB) : const Color(0xFF24292F),
          fontFamily: 'monospace',
          fontSize: 14,
        ),
        codeblockDecoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF0D1117) : const Color(0xFFF6F8FA),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDarkMode
                ? const Color(0xFF30363D)
                : const Color(0xFFD0D7DE),
            width: 1,
          ),
        ),
        codeblockPadding: const EdgeInsets.all(16),
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

/// A custom markdown element builder for code blocks with syntax highlighting.
class CodeElementBuilder extends MarkdownElementBuilder {
  /// Creates a [CodeElementBuilder].
  CodeElementBuilder({required this.isDarkMode});

  /// Whether the app is in dark mode.
  final bool isDarkMode;

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    var language = '';

    if (element.attributes['class'] != null) {
      final classes = element.attributes['class']!.split(' ');
      // Look for language-* class
      for (final className in classes) {
        if (className.startsWith('language-')) {
          language = className.substring(9);
          break;
        }
      }
    }

    // Auto-detect language if not specified
    if (language.isEmpty) {
      final code = element.textContent;
      language = _detectLanguage(code);
    }

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF0D1117) : const Color(0xFFF6F8FA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDarkMode ? const Color(0xFF30363D) : const Color(0xFFD0D7DE),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Language label
          if (language.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isDarkMode
                        ? const Color(0xFF30363D)
                        : const Color(0xFFD0D7DE),
                    width: 1,
                  ),
                ),
              ),
              child: Text(
                language,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode
                      ? const Color(0xFF8B949E)
                      : const Color(0xFF57606A),
                ),
              ),
            ),
          // Code content with syntax highlighting
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: HighlightView(
              element.textContent,
              language: language,
              theme: isDarkMode ? _githubDarkTheme : githubTheme,
              padding: const EdgeInsets.all(16),
              textStyle: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Attempts to detect the programming language from code content.
  String _detectLanguage(String code) {
    // Simple heuristics for Python
    if (code.contains('def ') ||
        code.contains('import ') ||
        code.contains('from ') ||
        code.contains('class ') && code.contains('self') ||
        code.contains('print(')) {
      return 'python';
    }

    // Simple heuristics for JavaScript
    if (code.contains('const ') ||
        code.contains('let ') ||
        code.contains('var ') ||
        code.contains('function ') ||
        code.contains('=>') ||
        code.contains('console.log')) {
      return 'javascript';
    }

    // Simple heuristics for Dart
    if (code.contains('void ') ||
        code.contains('class ') && code.contains('extends') ||
        code.contains('Widget')) {
      return 'dart';
    }

    return 'plaintext';
  }

  /// GitHub dark theme colors for syntax highlighting.
  static final Map<String, TextStyle> _githubDarkTheme = {
    'root': const TextStyle(
      backgroundColor: Color(0xFF0D1117),
      color: Color(0xFFE6EDF3),
    ),
    'comment': const TextStyle(color: Color(0xFF8B949E)),
    'quote': const TextStyle(color: Color(0xFF8B949E)),
    'keyword': const TextStyle(color: Color(0xFFFF7B72)),
    'selector-tag': const TextStyle(color: Color(0xFF7EE787)),
    'literal': const TextStyle(color: Color(0xFF79C0FF)),
    'section': const TextStyle(color: Color(0xFF1F6FEB)),
    'link': const TextStyle(color: Color(0xFF58A6FF)),
    'subst': const TextStyle(color: Color(0xFFE6EDF3)),
    'string': const TextStyle(color: Color(0xFFA5D6FF)),
    'title': const TextStyle(color: Color(0xFFD2A8FF)),
    'name': const TextStyle(color: Color(0xFFFFA657)),
    'type': const TextStyle(color: Color(0xFFFFA657)),
    'attribute': const TextStyle(color: Color(0xFF79C0FF)),
    'symbol': const TextStyle(color: Color(0xFF79C0FF)),
    'bullet': const TextStyle(color: Color(0xFF79C0FF)),
    'built_in': const TextStyle(color: Color(0xFFFFA657)),
    'addition': const TextStyle(color: Color(0xFF7EE787)),
    'variable': const TextStyle(color: Color(0xFFFFA657)),
    'template-tag': const TextStyle(color: Color(0xFF7EE787)),
    'template-variable': const TextStyle(color: Color(0xFF7EE787)),
    'meta': const TextStyle(color: Color(0xFF8B949E)),
    'meta-keyword': const TextStyle(color: Color(0xFF8B949E)),
    'meta-string': const TextStyle(color: Color(0xFFA5D6FF)),
    'number': const TextStyle(color: Color(0xFF79C0FF)),
    'doctag': const TextStyle(color: Color(0xFF8B949E)),
    'params': const TextStyle(color: Color(0xFFE6EDF3)),
    'function': const TextStyle(color: Color(0xFFD2A8FF)),
    'class': const TextStyle(color: Color(0xFFFFA657)),
    'tag': const TextStyle(color: Color(0xFF7EE787)),
    'attr': const TextStyle(color: Color(0xFF79C0FF)),
    'regexp': const TextStyle(color: Color(0xFF7EE787)),
    'emphasis': const TextStyle(fontStyle: FontStyle.italic),
    'strong': const TextStyle(fontWeight: FontWeight.bold),
  };
}
