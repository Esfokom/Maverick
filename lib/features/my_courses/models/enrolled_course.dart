import '../../programs/models/program.dart';

/// Represents a user's enrollment in a program with progress tracking.
class EnrolledCourse {
  /// Creates an [EnrolledCourse] instance.
  const EnrolledCourse({
    required this.program,
    required this.enrolledDate,
    required this.progress,
    required this.completedModules,
    required this.totalModules,
    required this.lastAccessedDate,
    required this.hoursSpent,
    this.certificateEarned = false,
  });

  /// The program the user is enrolled in.
  final Program program;

  /// Date when the user enrolled in this course.
  final DateTime enrolledDate;

  /// Progress percentage (0-100).
  final double progress;

  /// Number of modules completed.
  final int completedModules;

  /// Total number of modules in the course.
  final int totalModules;

  /// Last date the user accessed this course.
  final DateTime lastAccessedDate;

  /// Total hours spent on this course.
  final int hoursSpent;

  /// Whether the user has earned a certificate.
  final bool certificateEarned;

  /// Returns whether the course is completed.
  bool get isCompleted => progress >= 100;

  /// Returns a user-friendly status message.
  String get statusMessage {
    if (isCompleted) return 'Completed';
    if (progress > 0) return 'In Progress';
    return 'Not Started';
  }
}
