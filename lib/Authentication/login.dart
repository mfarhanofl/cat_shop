import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool hidePassword = true;

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isFormValid = false;

  Database? _database;

  // ---------------- DATABASE ----------------

  Future<void> initDb() async {
    if (_database != null) return;

    String path = join(await getDatabasesPath(), 'auth.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT UNIQUE,
            password TEXT
          )
        ''');
      },
    );
  }

  Future<bool> loginUser(String email, String password) async {
    await initDb();

    var result = await _database!.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    return result.isNotEmpty;
  }

  // ---------------- VALIDATION ----------------

  bool isValidEmail(String email) {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);
  }

  void validateForm() {
    setState(() {
      isFormValid = isEmailValid && isPasswordValid;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _database?.close();
    super.dispose();
  }

  // ---------------- UI ----------------

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
                    "Login!",
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

                  const SizedBox(height: 30),

                  /// LOGIN BUTTON
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

                              bool success = await loginUser(email, password);

                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Login Successful"),
                                  ),
                                );

                                Navigator.pushReplacementNamed(
                                  context,
                                  '/bottombar',
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Invalid email or password"),
                                  ),
                                );
                              }
                            }
                          : null,
                      child: const Text(
                        "Login!",
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
                          text: "Don't have account ",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign up!",
                              style: const TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/signup',
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
