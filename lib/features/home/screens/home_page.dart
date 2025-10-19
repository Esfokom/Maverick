import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController newCoursesController = PageController();
    final PageController recommendedController = PageController();

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
          const Text(
            "New Courses",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 250,
            child: PageView(
              controller: newCoursesController,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.redAccent,
                    child: const Center(
                      child: Text("Course 1", style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.greenAccent,
                    child: const Center(
                      child: Text("Course 2", style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.blueAccent,
                    child: const Center(
                      child: Text("Course 3", style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: SmoothPageIndicator(
              controller: newCoursesController,
              count: 3,
              effect: WormEffect(
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
            child: PageView(
              controller: recommendedController,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.redAccent,
                    child: const Center(
                      child: Text(
                        "Recommendation 1",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.greenAccent,
                    child: const Center(
                      child: Text(
                        "Recommendation 2",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.blueAccent,
                    child: const Center(
                      child: Text(
                        "Recommendation 3",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: SmoothPageIndicator(
              controller: recommendedController,
              count: 3,
              effect: WormEffect(
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
}
