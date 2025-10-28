import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/programs/models/program.dart';
import '../../features/programs/data/mock_programs.dart';
import '../services/storage_service.dart';

/// Provider for the storage service.
final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService.instance;
});

/// Provider for checking if it's the first time opening the app.
final isFirstTimeProvider = NotifierProvider<IsFirstTimeNotifier, bool>(
  IsFirstTimeNotifier.new,
);

/// Notifier for managing first-time user state.
class IsFirstTimeNotifier extends Notifier<bool> {
  @override
  bool build() {
    // Use instance directly since it's already initialized in main()
    return StorageService.instance.isFirstTime;
  }

  Future<void> setFirstTimeComplete() async {
    await StorageService.instance.setFirstTimeComplete();
    state = false;
  }
}

/// Provider for enrolled program IDs.
final enrolledProgramsProvider =
    NotifierProvider<EnrolledProgramsNotifier, List<String>>(
      EnrolledProgramsNotifier.new,
    );

/// Notifier for managing enrolled programs.
class EnrolledProgramsNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    return StorageService.instance.getEnrolledPrograms();
  }

  Future<void> enrollProgram(String programId) async {
    await StorageService.instance.enrollProgram(programId);
    state = StorageService.instance.getEnrolledPrograms();
  }

  Future<void> unenrollProgram(String programId) async {
    await StorageService.instance.unenrollProgram(programId);
    state = StorageService.instance.getEnrolledPrograms();
  }

  bool isProgramEnrolled(String programId) {
    return state.contains(programId);
  }
}

/// Provider for program progress.
final programProgressProvider =
    NotifierProvider<ProgramProgressNotifier, Map<String, double>>(
      ProgramProgressNotifier.new,
    );

/// Notifier for managing program progress.
class ProgramProgressNotifier extends Notifier<Map<String, double>> {
  @override
  Map<String, double> build() {
    return StorageService.instance.getProgramProgress();
  }

  Future<void> updateProgress(String programId, double progress) async {
    await StorageService.instance.updateProgramProgress(programId, progress);
    state = StorageService.instance.getProgramProgress();
  }

  double getProgress(String programId) {
    return state[programId] ?? 0.0;
  }
}

/// Provider for module progress.
final moduleProgressProvider =
    NotifierProvider<ModuleProgressNotifier, Map<String, Map<String, bool>>>(
      ModuleProgressNotifier.new,
    );

/// Notifier for managing module progress.
class ModuleProgressNotifier extends Notifier<Map<String, Map<String, bool>>> {
  @override
  Map<String, Map<String, bool>> build() {
    return StorageService.instance.getModuleProgress();
  }

  Future<void> updateModuleProgress({
    required String programId,
    required int moduleIndex,
    required bool completed,
  }) async {
    await StorageService.instance.updateModuleProgress(
      programId: programId,
      moduleIndex: moduleIndex,
      completed: completed,
    );
    state = StorageService.instance.getModuleProgress();
  }

  bool isModuleCompleted(String programId, int moduleIndex) {
    return state[programId]?[moduleIndex.toString()] ?? false;
  }

  Map<String, bool> getModuleProgressByProgram(String programId) {
    return state[programId] ?? {};
  }
}

/// Provider for last module index.
final lastModuleIndexProvider =
    NotifierProvider<LastModuleIndexNotifier, Map<String, int>>(
      LastModuleIndexNotifier.new,
    );

/// Notifier for managing last module index.
class LastModuleIndexNotifier extends Notifier<Map<String, int>> {
  @override
  Map<String, int> build() {
    return StorageService.instance.getLastModuleIndexMap();
  }

  Future<void> updateLastModuleIndex(String programId, int moduleIndex) async {
    await StorageService.instance.updateLastModuleIndex(programId, moduleIndex);
    state = StorageService.instance.getLastModuleIndexMap();
  }

  int getLastModuleIndex(String programId) {
    return state[programId] ?? 0;
  }
}

/// Provider for user stats.
final userStatsProvider = NotifierProvider<UserStatsNotifier, UserStatsData>(
  UserStatsNotifier.new,
);

/// User statistics data class.
class UserStatsData {
  const UserStatsData({
    required this.userName,
    required this.totalLearningHours,
    required this.totalCoursesCompleted,
    required this.currentStreak,
    required this.totalAchievements,
    this.currentProgramId,
  });

  final String userName;
  final int totalLearningHours;
  final int totalCoursesCompleted;
  final int currentStreak;
  final int totalAchievements;
  final String? currentProgramId;

  UserStatsData copyWith({
    String? userName,
    int? totalLearningHours,
    int? totalCoursesCompleted,
    int? currentStreak,
    int? totalAchievements,
    String? currentProgramId,
  }) {
    return UserStatsData(
      userName: userName ?? this.userName,
      totalLearningHours: totalLearningHours ?? this.totalLearningHours,
      totalCoursesCompleted:
          totalCoursesCompleted ?? this.totalCoursesCompleted,
      currentStreak: currentStreak ?? this.currentStreak,
      totalAchievements: totalAchievements ?? this.totalAchievements,
      currentProgramId: currentProgramId ?? this.currentProgramId,
    );
  }
}

/// Notifier for managing user stats.
class UserStatsNotifier extends Notifier<UserStatsData> {
  @override
  UserStatsData build() {
    final storage = StorageService.instance;
    return UserStatsData(
      userName: storage.userName,
      totalLearningHours: storage.totalLearningHours,
      totalCoursesCompleted: storage.totalCoursesCompleted,
      currentStreak: storage.currentStreak,
      totalAchievements: storage.totalAchievements,
      currentProgramId: storage.currentProgramId,
    );
  }

  Future<void> updateUserName(String name) async {
    await StorageService.instance.setUserName(name);
    state = state.copyWith(userName: name);
  }

  Future<void> updateLearningHours(int hours) async {
    await StorageService.instance.setTotalLearningHours(hours);
    state = state.copyWith(totalLearningHours: hours);
  }

  Future<void> updateCoursesCompleted(int count) async {
    await StorageService.instance.setTotalCoursesCompleted(count);
    state = state.copyWith(totalCoursesCompleted: count);
  }

  Future<void> updateStreak() async {
    await StorageService.instance.updateStreak();
    final storage = StorageService.instance;
    state = state.copyWith(currentStreak: storage.currentStreak);
  }

  Future<void> updateAchievements(int count) async {
    await StorageService.instance.setTotalAchievements(count);
    state = state.copyWith(totalAchievements: count);
  }

  Future<void> setCurrentProgram(String? programId) async {
    if (programId != null) {
      await StorageService.instance.setCurrentProgram(programId);
    }
    state = state.copyWith(currentProgramId: programId);
  }
}

/// Provider for all available programs.
final programsProvider = FutureProvider<List<Program>>((ref) async {
  return await loadPrograms();
});

/// Provider for current program.
final currentProgramProvider = Provider<Program?>((ref) {
  final stats = ref.watch(userStatsProvider);
  final programsAsync = ref.watch(programsProvider);

  return programsAsync.whenData((programs) {
    if (stats.currentProgramId == null) return null;
    try {
      return programs.firstWhere((p) => p.id == stats.currentProgramId);
    } catch (e) {
      return null;
    }
  }).value;
});

/// Provider for enrolled programs list.
final enrolledProgramsListProvider = Provider<List<Program>>((ref) {
  final enrolledIds = ref.watch(enrolledProgramsProvider);
  final programsAsync = ref.watch(programsProvider);

  return programsAsync.whenData((programs) {
        return programs.where((p) => enrolledIds.contains(p.id)).toList();
      }).value ??
      [];
});
