import 'package:flutter/material.dart';
import '../data/mock_programs.dart';
import '../models/program.dart';
import 'program_detail_page.dart';

/// Displays a list of available programs with search functionality.
class ProgramsPage extends StatefulWidget {
  const ProgramsPage({super.key});

  @override
  State<ProgramsPage> createState() => _ProgramsPageState();
}

class _ProgramsPageState extends State<ProgramsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Program> _allPrograms = [];
  List<Program> _filteredPrograms = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPrograms();
  }

  Future<void> _loadPrograms() async {
    try {
      final programs = await loadPrograms();
      setState(() {
        _allPrograms = programs;
        _filteredPrograms = programs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error loading programs: $e')));
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterPrograms(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredPrograms = _allPrograms;
      } else {
        _filteredPrograms = _allPrograms.where((program) {
          final nameLower = program.name.toLowerCase();
          final descLower = program.shortDescription.toLowerCase();
          final searchLower = query.toLowerCase();
          return nameLower.contains(searchLower) ||
              descLower.contains(searchLower);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Programs'), elevation: 0),
      body: Column(
        children: [
          _buildSearchBar(colorScheme),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredPrograms.isEmpty
                ? _buildEmptyState(colorScheme)
                : _buildProgramsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        onChanged: _filterPrograms,
        decoration: InputDecoration(
          hintText: 'Search programs...',
          prefixIcon: Icon(Icons.search, color: colorScheme.onSurfaceVariant),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _filterPrograms('');
                  },
                )
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: colorScheme.surfaceContainerHighest,
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
            Icons.search_off,
            size: 64,
            color: colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No programs found',
            style: TextStyle(fontSize: 18, color: colorScheme.onSurface),
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching with different keywords',
            style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildProgramsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _filteredPrograms.length,
      itemBuilder: (context, index) {
        final program = _filteredPrograms[index];
        return _ProgramCard(program: program);
      },
    );
  }
}

class _ProgramCard extends StatelessWidget {
  const _ProgramCard({required this.program});

  final Program program;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
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
          children: [_buildThumbnail(), _buildContent()],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: Hero(
        tag: 'program_${program.id}',
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.asset(
            program.thumbnailPath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              final colorScheme = Theme.of(context).colorScheme;
              return Container(
                color: colorScheme.surfaceContainerHighest,
                child: Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 48,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Builder(
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                program.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                program.shortDescription,
                style: TextStyle(
                  fontSize: 14,
                  color: colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
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
          ),
        );
      },
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
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
}
