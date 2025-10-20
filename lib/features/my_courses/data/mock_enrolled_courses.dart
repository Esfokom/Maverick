import '../../programs/data/mock_programs.dart';
import '../models/enrolled_course.dart';

/// Mock data for user's enrolled courses.
final List<EnrolledCourse> mockEnrolledCourses = [
  EnrolledCourse(
    program: mockPrograms[0], // AI Engineer Pathway
    enrolledDate: DateTime.now().subtract(const Duration(days: 45)),
    progress: 45.0,
    completedModules: 2,
    totalModules: 5,
    lastAccessedDate: DateTime.now().subtract(const Duration(hours: 3)),
    hoursSpent: 28,
    certificateEarned: false,
  ),
  EnrolledCourse(
    program: mockPrograms[3], // Data Driver
    enrolledDate: DateTime.now().subtract(const Duration(days: 30)),
    progress: 65.0,
    completedModules: 3,
    totalModules: 5,
    lastAccessedDate: DateTime.now().subtract(const Duration(days: 1)),
    hoursSpent: 22,
    certificateEarned: false,
  ),
  EnrolledCourse(
    program: mockPrograms[5], // Full-Stack Accelerator
    enrolledDate: DateTime.now().subtract(const Duration(days: 90)),
    progress: 100.0,
    completedModules: 5,
    totalModules: 5,
    lastAccessedDate: DateTime.now().subtract(const Duration(days: 5)),
    hoursSpent: 48,
    certificateEarned: true,
  ),
  EnrolledCourse(
    program: mockPrograms[4], // DevOps Pipeline
    enrolledDate: DateTime.now().subtract(const Duration(days: 15)),
    progress: 20.0,
    completedModules: 1,
    totalModules: 5,
    lastAccessedDate: DateTime.now().subtract(const Duration(days: 2)),
    hoursSpent: 8,
    certificateEarned: false,
  ),
];
