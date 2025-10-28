import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/program.dart';

/// Loads all programs from JSON files.
Future<List<Program>> loadPrograms() async {
  final programs = <Program>[];

  // Load full programs with content
  final fullProgramPaths = [
    'assets/programs/data/ai_engineer_pathway.json',
    'assets/programs/data/cloud_architect_program.json',
    'assets/programs/data/cyber_sentinel.json',
  ];

  for (final path in fullProgramPaths) {
    try {
      final jsonString = await rootBundle.loadString(path);
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;
      programs.add(Program.fromJson(jsonData));
    } catch (e) {
      print('Error loading program from $path: $e');
    }
  }

  // Load coming soon programs
  try {
    final comingSoonJson = await rootBundle.loadString(
      'assets/programs/data/coming_soon.json',
    );
    final comingSoonList = json.decode(comingSoonJson) as List<dynamic>;

    for (final programData in comingSoonList) {
      programs.add(Program.fromJson(programData as Map<String, dynamic>));
    }
  } catch (e) {
    print('Error loading coming soon programs: $e');
  }

  return programs;
}

/// Mock data for programs - deprecated, use loadPrograms() instead.
@Deprecated('Use loadPrograms() to load programs from JSON files')
final List<Program> mockPrograms = [];
