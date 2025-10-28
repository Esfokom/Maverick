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
    'assets/programs/data/data_driver.json',
    'assets/programs/data/devops_pipeline.json',
    'assets/programs/data/fullstack_accelerator.json',
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

  return programs;
}

/// Mock data for programs - deprecated, use loadPrograms() instead.
@Deprecated('Use loadPrograms() to load programs from JSON files')
final List<Program> mockPrograms = [];
