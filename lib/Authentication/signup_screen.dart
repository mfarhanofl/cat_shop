import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:zomo/Authentication/db_helper.dart';
import 'package:zomo/Authentication/login.dart';

class Signup_Screen extends StatefulWidget {
  const Signup_Screen({super.key});

  @override
  State<Signup_Screen> createState() => _Signup_ScreenState();
}

class _Signup_ScreenState extends State<Signup_Screen> {
  final _formKey = GlobalKey<FormState>();
  final DBHelper _dbHelper = DBHelper();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPassController = TextEditingController();

  bool hidePassword = true;
  bool hideConfirm = true;

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isConfirmValid = false;
  bool isFormValid = false;

  bool isValidEmail(String email) {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);
  }

  void validateForm() {
    setState(() {
      isFormValid = isEmailValid && isPasswordValid && isConfirmValid;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _cPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Hero(
                    tag: 'logo',
                    child: CircleAvatar(
                      radius: 90,
                      backgroundImage: AssetImage("images/logo.png"),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    "Sign Up!",
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 30),

                  /// EMAIL
                  TextFormField(
                    controller: _emailController,
                    cursorColor: Colors.black,
                    onChanged: (value) {
                      isEmailValid = isValidEmail(value);
                      validateForm();
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      labelText: "Email",
                      suffixIcon: _emailController.text.isEmpty
                          ? null
                          : Icon(
                              isEmailValid ? Icons.check_circle : Icons.cancel,
                              color: isEmailValid ? Colors.green : Colors.red,
                            ),
                      border: const OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// PASSWORD
                  TextFormField(
                    controller: _passwordController,
                    obscureText: hidePassword,
                    cursorColor: Colors.black,
                    onChanged: (value) {
                      isPasswordValid = value.length >= 6;
                      validateForm();
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      labelText: "Password",
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isPasswordValid ? Icons.check_circle : Icons.cancel,
                            color: isPasswordValid ? Colors.green : Colors.red,
                          ),
                          IconButton(
                            icon: Icon(
                              hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                          ),
                        ],
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// CONFIRM PASSWORD
                  TextFormField(
                    controller: _cPassController,
                    obscureText: hideConfirm,
                    cursorColor: Colors.black,
                    onChanged: (value) {
                      isConfirmValid =
                          value == _passwordController.text && value.isNotEmpty;
                      validateForm();
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      labelText: "Confirm Password",
                      suffixIcon: Icon(
                        isConfirmValid ? Icons.check_circle : Icons.cancel,
                        color: isConfirmValid ? Colors.green : Colors.red,
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// SIGNUP BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: isFormValid
                            ? Colors.lightBlueAccent
                            : Colors.grey,
                      ),
                      onPressed: isFormValid
                          ? () async {
                              final email = _emailController.text.trim();
                              final password = _passwordController.text.trim();

                              try {
                                bool exists = await _dbHelper.checkEmailExists(
                                  email,
                                );

                                if (exists) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Email already registered"),
                                    ),
                                  );
                                  return; // stay on signup
                                }

                                await _dbHelper.signup(email, password);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Signup Successful"),
                                  ),
                                );

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const Login(),
                                  ),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Signup failed"),
                                  ),
                                );
                              }
                            }
                          : null,
                      child: const Text(
                        "Sign Up!",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: "Login!",
                              style: const TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const Login(),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
