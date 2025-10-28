/// Storage keys for shared preferences.
class StorageKeys {
  StorageKeys._();

  /// Key for checking if it's the first time the app is opened.
  static const String isFirstTime = 'is_first_time';

  /// Key for storing enrolled program IDs.
  static const String enrolledPrograms = 'enrolled_programs';

  /// Key for storing program progress (JSON map).
  static const String programProgress = 'program_progress';

  /// Key for storing module progress (JSON map).
  static const String moduleProgress = 'module_progress';

  /// Key for storing total learning hours.
  static const String totalLearningHours = 'total_learning_hours';

  /// Key for storing total courses completed.
  static const String totalCoursesCompleted = 'total_courses_completed';

  /// Key for storing current streak.
  static const String currentStreak = 'current_streak';

  /// Key for storing last active date.
  static const String lastActiveDate = 'last_active_date';

  /// Key for storing user name.
  static const String userName = 'user_name';

  /// Key for storing total achievements.
  static const String totalAchievements = 'total_achievements';

  /// Key for storing current program ID.
  static const String currentProgramId = 'current_program_id';

  /// Key for storing last module index for each program.
  static const String lastModuleIndex = 'last_module_index';
}
