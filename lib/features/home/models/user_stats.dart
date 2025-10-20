/// Represents user statistics and progress information.
class UserStats {
  /// Creates a [UserStats] instance.
  const UserStats({
    required this.userName,
    required this.currentProgramName,
    required this.currentProgramProgress,
    required this.totalCoursesCompleted,
    required this.totalLearningHours,
    required this.currentStreak,
  });

  /// The user's name.
  final String userName;

  /// Name of the program the user is currently enrolled in.
  final String currentProgramName;

  /// Progress percentage of the current program (0-100).
  final double currentProgramProgress;

  /// Total number of courses completed by the user.
  final int totalCoursesCompleted;

  /// Total hours spent learning.
  final int totalLearningHours;

  /// Current learning streak in days.
  final int currentStreak;
}
