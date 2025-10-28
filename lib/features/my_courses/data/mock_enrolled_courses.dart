import '../../programs/data/mock_programs.dart';
import '../models/enrolled_course.dart';

/// Loads mock enrolled courses for the user.
Future<List<EnrolledCourse>> loadEnrolledCourses() async {
  final programs = await loadPrograms();

  // Find specific programs by ID
  final aiProgram = programs.firstWhere((p) => p.id == '1');
  final dataProgram = programs.firstWhere((p) => p.id == '4');
  final fullStackProgram = programs.firstWhere((p) => p.id == '6');
  final devOpsProgram = programs.firstWhere((p) => p.id == '5');

  return [
    EnrolledCourse(
      program: aiProgram, // AI Engineer Pathway
      enrolledDate: DateTime.now().subtract(const Duration(days: 45)),
      progress: 45.0,
      completedModules: 2,
      totalModules: aiProgram.modules.length,
      lastAccessedDate: DateTime.now().subtract(const Duration(hours: 3)),
      hoursSpent: 28,
      certificateEarned: false,
    ),
    EnrolledCourse(
      program: dataProgram, // Data Driver
      enrolledDate: DateTime.now().subtract(const Duration(days: 30)),
      progress: 65.0,
      completedModules: 3,
      totalModules: dataProgram.modules.length,
      lastAccessedDate: DateTime.now().subtract(const Duration(days: 1)),
      hoursSpent: 22,
      certificateEarned: false,
    ),
    EnrolledCourse(
      program: fullStackProgram, // Full-Stack Accelerator
      enrolledDate: DateTime.now().subtract(const Duration(days: 90)),
      progress: 100.0,
      completedModules: 5,
      totalModules: fullStackProgram.modules.length,
      lastAccessedDate: DateTime.now().subtract(const Duration(days: 5)),
      hoursSpent: 48,
      certificateEarned: true,
    ),
    EnrolledCourse(
      program: devOpsProgram, // DevOps Pipeline
      enrolledDate: DateTime.now().subtract(const Duration(days: 15)),
      progress: 20.0,
      completedModules: 1,
      totalModules: devOpsProgram.modules.length,
      lastAccessedDate: DateTime.now().subtract(const Duration(days: 2)),
      hoursSpent: 8,
      certificateEarned: false,
    ),
  ];
}

/// Mock data for user's enrolled courses - deprecated.
@Deprecated('Use loadEnrolledCourses() instead')
final List<EnrolledCourse> mockEnrolledCourses = [];
