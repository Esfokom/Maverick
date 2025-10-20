/// Represents a learning program with its details.
class Program {
  /// Creates a new [Program] instance.
  const Program({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.fullDescription,
    required this.duration,
    required this.difficulty,
    required this.thumbnailPath,
    required this.modules,
    required this.author,
    required this.authorBio,
  });

  /// Unique identifier for the program.
  final String id;

  /// The name of the program.
  final String name;

  /// A brief description of the program.
  final String shortDescription;

  /// A detailed description of the program.
  final String fullDescription;

  /// Duration of the program (e.g., "8 weeks", "3 months").
  final String duration;

  /// Difficulty level of the program.
  final ProgramDifficulty difficulty;

  /// Path to the program's thumbnail image.
  final String thumbnailPath;

  /// List of modules included in the program.
  final List<ProgramModule> modules;

  /// Name of the program author/instructor.
  final String author;

  /// Biography of the program author.
  final String authorBio;
}

/// Represents a module within a program.
class ProgramModule {
  /// Creates a new [ProgramModule] instance.
  const ProgramModule({
    required this.title,
    required this.description,
    required this.duration,
  });

  /// The title of the module.
  final String title;

  /// Description of what the module covers.
  final String description;

  /// Duration of the module.
  final String duration;
}

/// Difficulty levels for programs.
enum ProgramDifficulty {
  /// Beginner level program.
  beginner,

  /// Intermediate level program.
  intermediate,

  /// Advanced level program.
  advanced;

  /// Returns a display-friendly string for the difficulty level.
  String get displayName {
    switch (this) {
      case ProgramDifficulty.beginner:
        return 'Beginner';
      case ProgramDifficulty.intermediate:
        return 'Intermediate';
      case ProgramDifficulty.advanced:
        return 'Advanced';
    }
  }
}
