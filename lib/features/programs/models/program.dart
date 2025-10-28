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
    this.isComingSoon = false,
  });

  /// Creates a [Program] from a JSON map.
  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id'] as String,
      name: json['name'] as String,
      shortDescription: json['shortDescription'] as String,
      fullDescription: json['fullDescription'] as String,
      duration: json['duration'] as String,
      difficulty: ProgramDifficulty.values.firstWhere(
        (e) => e.name == json['difficulty'],
      ),
      thumbnailPath: json['thumbnailPath'] as String,
      modules: (json['modules'] as List<dynamic>)
          .map((m) => ProgramModule.fromJson(m as Map<String, dynamic>))
          .toList(),
      author: json['author'] as String,
      authorBio: json['authorBio'] as String,
      isComingSoon: json['isComingSoon'] as bool? ?? false,
    );
  }

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

  /// Whether this program is coming soon.
  final bool isComingSoon;

  /// Converts this [Program] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'shortDescription': shortDescription,
      'fullDescription': fullDescription,
      'duration': duration,
      'difficulty': difficulty.name,
      'thumbnailPath': thumbnailPath,
      'modules': modules.map((m) => m.toJson()).toList(),
      'author': author,
      'authorBio': authorBio,
      'isComingSoon': isComingSoon,
    };
  }
}

/// Represents a module within a program.
class ProgramModule {
  /// Creates a new [ProgramModule] instance.
  const ProgramModule({
    required this.title,
    required this.description,
    required this.duration,
    this.content,
    this.order = 0,
  });

  /// Creates a [ProgramModule] from a JSON map.
  factory ProgramModule.fromJson(Map<String, dynamic> json) {
    return ProgramModule(
      title: json['title'] as String,
      description: json['description'] as String,
      duration: json['duration'] as String,
      content: json['content'] as String?,
      order: json['order'] as int? ?? 0,
    );
  }

  /// The title of the module.
  final String title;

  /// Description of what the module covers.
  final String description;

  /// Duration of the module.
  final String duration;

  /// Markdown content of the module.
  final String? content;

  /// Order of the module in the program.
  final int order;

  /// Converts this [ProgramModule] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'duration': duration,
      'content': content,
      'order': order,
    };
  }
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
