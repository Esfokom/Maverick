import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

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
                  const Text(
                    "Create Account",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                selectedCountryFlag ?? "🌍",
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                selectedCountry ?? "Select Country",
                                style: const TextStyle(fontSize: 16),
                              ),
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
                          decoration: _inputDecoration(
                            selectedCountryCode ?? "Code",
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 4,
                        child: TextFormField(
                          decoration: _inputDecoration("Mobile Number"),
                          keyboardType: TextInputType.phone,
                          validator: (value) =>
                              value!.isEmpty ? "Required" : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: _inputDecoration("Email address"),
                    validator: (value) {
                      if (value!.isEmpty) return "Required";
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))
                        return "Invalid email";
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    obscureText: true,
                    decoration: _inputDecoration("Create Password"),
                    validator: (value) =>
                        value!.length < 6 ? "Min 6 chars" : null,
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushReplacementNamed(context, '/home');
                        }
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(context, '/'),
                    child: const Text(
                      "Already have an account?Sign In",
                      style: TextStyle(color: Colors.blue),
                    ),
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
