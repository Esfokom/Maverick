import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // ✅ Added for dots indicators

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const MainNavigation(),
        '/signup': (context) => const SignUpPage(),
        '/forgot-password': (context) => const ForgotPasswordPage(),
        '/notifications': (context) => const NotificationsPage(notifications: []),
      },
      initialRoute: '/',
    );
  }
}

// ---------------- LOGIN SCREEN ----------------
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email) || password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid credentials ❌"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Image(image: AssetImage('images/Maverick-logo.png'),
                  height: 120,
                ),
                const SizedBox(height: 32),
                const Text("Welcome", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 32),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email address",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/forgot-password'),
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: _isLoading ? null : _login,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Sign In", style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: const [
                    Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text("OR", style: TextStyle(color: Colors.grey)),
                    ),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    icon: Image(
                      image: AssetImage('images/Google_Icon.png'),
                      height: 20,
                    ),
                    label: const Text("Sign in with Google"),
                    onPressed: () {
                      // Google Sign In logic here
                    },
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/signup'),
                  child: const Text("Don't have an account? Sign Up", style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------- SIGN UP PAGE ----------------
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedCountry;
  String? selectedCountryCode;
  String? selectedCountryFlag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text("Create Account", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: _inputDecoration("First Name"),
                    validator: (value) => value!.isEmpty ? "Required" : null,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: _inputDecoration("Last Name"),
                    validator: (value) => value!.isEmpty ? "Required" : null,
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode: true,
                        onSelect: (Country country) {
                          setState(() {
                            selectedCountry = country.name;
                            selectedCountryCode = "+${country.phoneCode}";
                            selectedCountryFlag = country.flagEmoji;
                          });
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(selectedCountryFlag ?? "🌍", style: const TextStyle(fontSize: 20)),
                              const SizedBox(width: 8),
                              Text(selectedCountry ?? "Select Country", style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          readOnly: true,
                          decoration: _inputDecoration(selectedCountryCode ?? "Code"),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 4,
                        child: TextFormField(
                          decoration: _inputDecoration("Mobile Number"),
                          keyboardType: TextInputType.phone,
                          validator: (value) => value!.isEmpty ? "Required" : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: _inputDecoration("Email address"),
                    validator: (value) {
                      if (value!.isEmpty) return "Required";
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return "Invalid email";
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    obscureText: true,
                    decoration: _inputDecoration("Create Password"),
                    validator: (value) => value!.length < 6 ? "Min 6 chars" : null,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    obscureText: true,
                    decoration: _inputDecoration("Confirm Password"),
                    validator: (value) => value!.isEmpty ? "Required" : null,
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushReplacementNamed(context, '/home');
                        }
                      },
                      child: const Text("Sign Up", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(context, '/'),
                    child: const Text("Already have an account?Sign In", style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}

// ---------------- MAIN NAVIGATION ----------------
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const ProgramsPage(),
    const MyCoursesPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "Programs"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "My Courses"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

// ---------------- HOME PAGE ----------------
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
            const Image(image: AssetImage('images/Maverick-logo.png'),
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
          const Text("New Courses", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SizedBox(
            height: 250,
            child: PageView(
              controller: newCoursesController,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10), // ✅ Added radius
                  child: Container(color: Colors.redAccent, child: const Center(child: Text("Course 1" , style: TextStyle(fontSize: 20),))),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(color: Colors.greenAccent, child: const Center(child: Text("Course 2" , style: TextStyle(fontSize: 20),))),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(color: Colors.blueAccent, child: const Center(child: Text("Course 3" , style: TextStyle(fontSize: 20),))),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: SmoothPageIndicator(
              controller: newCoursesController,
              count: 3,
              effect: WormEffect(dotHeight: 8, dotWidth: 8, activeDotColor: Colors.blue),
            ),
          ),
          const SizedBox(height: 20),
          const Text("Recommended for You", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SizedBox(
            height: 250,
            child: PageView(
              controller: recommendedController,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10), // ✅ Added radius
                  child: Container(color: Colors.redAccent, child: const Center(child: Text("Recommendation 1" , style: TextStyle(fontSize: 20),))),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(color: Colors.greenAccent, child: const Center(child: Text("Recommendation 2" , style: TextStyle(fontSize: 20),))),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(color: Colors.blueAccent, child: const Center(child: Text("Recommendation 3" , style: TextStyle(fontSize: 20),))),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: SmoothPageIndicator(
              controller: recommendedController,
              count: 3,
              effect: WormEffect(dotHeight: 8, dotWidth: 8, activeDotColor: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- NOTIFICATIONS PAGE ----------------
class NotificationsPage extends StatelessWidget {
  final List<String> notifications;
  const NotificationsPage({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: notifications.isEmpty
          ? const Center(child: Text("No new notifications"))
          : ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) => ListTile(
          leading: const Icon(Icons.notifications),
          title: Text(notifications[index]),
        ),
      ),
    );
  }
}

// ---------------- OTHER PAGES ----------------
class ProgramsPage extends StatelessWidget {
  const ProgramsPage({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text("Programs Page")));
}

class MyCoursesPage extends StatelessWidget {
  const MyCoursesPage({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text("My Courses Page")));
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text("Profile Page")));
}

// ---------------- FORGOT PASSWORD ----------------
class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text("Forgot Password")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text("Enter your email to reset password"),
            const SizedBox(height: 15),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Password reset link sent ✅")),
                );
              },
              child: const Text("Send Reset Link"),
            ),
          ],
        ),
      ),
    );
  }
}
