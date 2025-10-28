import 'dart:convert';
import 'dart:developer' as developer;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/storage_keys.dart';

/// Service for managing persistent storage using SharedPreferences.
class StorageService {
  StorageService._();

  static StorageService? _instance;
  static SharedPreferences? _preferences;

  /// Gets the singleton instance of [StorageService].
  static StorageService get instance {
    _instance ??= StorageService._();
    return _instance!;
  }

  /// Initializes the storage service. Must be called before using the service.
  static Future<void> initialize() async {
    try {
      _preferences = await SharedPreferences.getInstance();
      developer.log(
        'StorageService initialized successfully',
        name: 'maverick.storage',
      );
    } catch (e, s) {
      developer.log(
        'Failed to initialize StorageService',
        name: 'maverick.storage',
        level: 1000,
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }

  /// Gets the SharedPreferences instance.
  SharedPreferences get prefs {
    if (_preferences == null) {
      throw StateError(
        'StorageService not initialized. Call StorageService.initialize() first.',
      );
    }
    return _preferences!;
  }

  // String operations
  Future<bool> setString(String key, String value) =>
      prefs.setString(key, value);
  String? getString(String key) => prefs.getString(key);

  // Integer operations
  Future<bool> setInt(String key, int value) => prefs.setInt(key, value);
  int? getInt(String key) => prefs.getInt(key);

  // Double operations
  Future<bool> setDouble(String key, double value) =>
      prefs.setDouble(key, value);
  double? getDouble(String key) => prefs.getDouble(key);

  // Boolean operations
  Future<bool> setBool(String key, bool value) => prefs.setBool(key, value);
  bool? getBool(String key) => prefs.getBool(key);

  // String list operations
  Future<bool> setStringList(String key, List<String> value) =>
      prefs.setStringList(key, value);
  List<String>? getStringList(String key) => prefs.getStringList(key);

  // JSON operations
  Future<bool> setJson(String key, Map<String, dynamic> value) =>
      setString(key, jsonEncode(value));

  Map<String, dynamic>? getJson(String key) {
    final jsonString = getString(key);
    if (jsonString == null) return null;
    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      developer.log(
        'Failed to decode JSON for key: $key',
        name: 'maverick.storage',
        level: 900,
        error: e,
      );
      return null;
    }
  }

  // Remove operations
  Future<bool> remove(String key) => prefs.remove(key);
  Future<bool> clear() => prefs.clear();

  // Check if key exists
  bool containsKey(String key) => prefs.containsKey(key);

  // First-time user check
  bool get isFirstTime => getBool(StorageKeys.isFirstTime) ?? true;

  Future<void> setFirstTimeComplete() =>
      setBool(StorageKeys.isFirstTime, false);

  // Enrolled programs
  List<String> getEnrolledPrograms() =>
      getStringList(StorageKeys.enrolledPrograms) ?? [];

  Future<void> enrollProgram(String programId) async {
    final enrolled = getEnrolledPrograms();
    if (!enrolled.contains(programId)) {
      enrolled.add(programId);
      await setStringList(StorageKeys.enrolledPrograms, enrolled);
    }
  }

  Future<void> unenrollProgram(String programId) async {
    final enrolled = getEnrolledPrograms();
    enrolled.remove(programId);
    await setStringList(StorageKeys.enrolledPrograms, enrolled);
  }

  bool isProgramEnrolled(String programId) =>
      getEnrolledPrograms().contains(programId);

  // Program progress
  Map<String, double> getProgramProgress() {
    final json = getJson(StorageKeys.programProgress);
    if (json == null) return {};
    return json.map((key, value) => MapEntry(key, (value as num).toDouble()));
  }

  Future<void> updateProgramProgress(String programId, double progress) async {
    final progressMap = getProgramProgress();
    progressMap[programId] = progress;
    await setJson(
      StorageKeys.programProgress,
      progressMap.map((key, value) => MapEntry(key, value)),
    );
  }

  double getProgramProgressById(String programId) =>
      getProgramProgress()[programId] ?? 0.0;

  // Module progress
  Map<String, Map<String, bool>> getModuleProgress() {
    final json = getJson(StorageKeys.moduleProgress);
    if (json == null) return {};
    return json.map(
      (key, value) => MapEntry(
        key,
        (value as Map<String, dynamic>).map((k, v) => MapEntry(k, v as bool)),
      ),
    );
  }

  Future<void> updateModuleProgress({
    required String programId,
    required int moduleIndex,
    required bool completed,
  }) async {
    final progressMap = getModuleProgress();
    progressMap[programId] ??= {};
    progressMap[programId]![moduleIndex.toString()] = completed;

    await setJson(
      StorageKeys.moduleProgress,
      progressMap.map(
        (key, value) => MapEntry(key, value.map((k, v) => MapEntry(k, v))),
      ),
    );
  }

  Map<String, bool> getModuleProgressByProgram(String programId) =>
      getModuleProgress()[programId] ?? {};

  bool isModuleCompleted(String programId, int moduleIndex) =>
      getModuleProgressByProgram(programId)[moduleIndex.toString()] ?? false;

  // Last module index
  Map<String, int> getLastModuleIndexMap() {
    final json = getJson(StorageKeys.lastModuleIndex);
    if (json == null) return {};
    return json.map((key, value) => MapEntry(key, value as int));
  }

  Future<void> updateLastModuleIndex(String programId, int moduleIndex) async {
    final indexMap = getLastModuleIndexMap();
    indexMap[programId] = moduleIndex;
    await setJson(StorageKeys.lastModuleIndex, indexMap);
  }

  int getLastModuleIndex(String programId) =>
      getLastModuleIndexMap()[programId] ?? 0;

  // Current program
  String? get currentProgramId => getString(StorageKeys.currentProgramId);

  Future<void> setCurrentProgram(String programId) =>
      setString(StorageKeys.currentProgramId, programId);

  // User stats
  int get totalLearningHours => getInt(StorageKeys.totalLearningHours) ?? 0;

  Future<void> setTotalLearningHours(int hours) =>
      setInt(StorageKeys.totalLearningHours, hours);

  int get totalCoursesCompleted =>
      getInt(StorageKeys.totalCoursesCompleted) ?? 0;

  Future<void> setTotalCoursesCompleted(int count) =>
      setInt(StorageKeys.totalCoursesCompleted, count);

  int get currentStreak => getInt(StorageKeys.currentStreak) ?? 0;

  Future<void> setCurrentStreak(int streak) =>
      setInt(StorageKeys.currentStreak, streak);

  int get totalAchievements => getInt(StorageKeys.totalAchievements) ?? 0;

  Future<void> setTotalAchievements(int count) =>
      setInt(StorageKeys.totalAchievements, count);

  String get userName => getString(StorageKeys.userName) ?? 'User';

  Future<void> setUserName(String name) =>
      setString(StorageKeys.userName, name);

  // Streak management
  Future<void> updateStreak() async {
    final lastActive = getString(StorageKeys.lastActiveDate);
    final today = DateTime.now();
    final todayStr = '${today.year}-${today.month}-${today.day}';

    if (lastActive == null) {
      await setCurrentStreak(1);
      await setString(StorageKeys.lastActiveDate, todayStr);
      return;
    }

    final parts = lastActive.split('-');
    final lastDate = DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );

    final difference = today.difference(lastDate).inDays;

    if (difference == 1) {
      // Consecutive day
      await setCurrentStreak(currentStreak + 1);
    } else if (difference > 1) {
      // Streak broken
      await setCurrentStreak(1);
    }
    // Same day - no change

    await setString(StorageKeys.lastActiveDate, todayStr);
  }
}
