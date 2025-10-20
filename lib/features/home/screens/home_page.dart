import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../programs/data/mock_programs.dart';
import '../../programs/models/program.dart';
import '../../programs/screens/program_detail_page.dart';
import '../data/mock_user_stats.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController newCoursesController = PageController();
    final PageController recommendedController = PageController();

    // Get the first 3 programs for new courses
    final newPrograms = mockPrograms.take(3).toList();
    // Get the last 3 programs for recommendations
    final recommendedPrograms = mockPrograms.skip(3).take(3).toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Image(
              image: AssetImage('images/Maverick-logo.png'),
              height: 25,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search for courses",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.black),
              onPressed: () => Navigator.pushNamed(context, '/notifications'),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildGreetingSection(),
          const SizedBox(height: 20),
          _buildCurrentCourseProgress(),
          const SizedBox(height: 20),
          _buildStatsCards(),
          const SizedBox(height: 24),
          const Text(
            "New Programs",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 250,
            child: PageView.builder(
              controller: newCoursesController,
              itemCount: newPrograms.length,
              itemBuilder: (context, index) {
                return _buildProgramCard(context, newPrograms[index]);
              },
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: SmoothPageIndicator(
              controller: newCoursesController,
              count: newPrograms.length,
              effect: const WormEffect(
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Recommended for You",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 250,
            child: PageView.builder(
              controller: recommendedController,
              itemCount: recommendedPrograms.length,
              itemBuilder: (context, index) {
                return _buildProgramCard(context, recommendedPrograms[index]);
              },
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: SmoothPageIndicator(
              controller: recommendedController,
              count: recommendedPrograms.length,
              effect: const WormEffect(
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGreetingSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[700]!, Colors.blue[500]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, ${mockUserStats.userName}! 👋',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'What do you want to learn today?',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentCourseProgress() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Current Program',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '${mockUserStats.currentProgramProgress.toInt()}%',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            mockUserStats.currentProgramName,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: mockUserStats.currentProgramProgress / 100,
              minHeight: 8,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[700]!),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            Icons.book_outlined,
            '${mockUserStats.totalCoursesCompleted}',
            'Completed',
            Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            Icons.access_time,
            '${mockUserStats.totalLearningHours}h',
            'Learning Time',
            Colors.orange,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            Icons.local_fire_department,
            '${mockUserStats.currentStreak}',
            'Day Streak',
            Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 28, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProgramCard(BuildContext context, Program program) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => ProgramDetailPage(program: program),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                program.thumbnailPath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.image_not_supported, size: 48),
                    ),
                  );
                },
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.7),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      program.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      program.shortDescription,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildProgramBadge(Icons.schedule, program.duration),
                        const SizedBox(width: 8),
                        _buildProgramBadge(
                          Icons.signal_cellular_alt,
                          program.difficulty.displayName,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgramBadge(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
