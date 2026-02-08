import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' hide context;

// =======================================================
// 1. DATABASE HELPER
// =======================================================
class DatabaseHelper {
  static const String _dbName = 'auth.db';
  static const int _version = 1;

  static Future<Database> _openDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return openDatabase(
      path,
      version: _version,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT UNIQUE,
            password TEXT
          )
        ''');
      },
    );
  }

  static Future<bool> hasUser() async {
    try {
      final db = await _openDB();
      final result = await db.query('users', limit: 1);
      return result.isNotEmpty;
    } catch (e) {
      debugPrint('DB Error: $e');
      return false;
    }
  }
}

// =======================================================
// 2. SPLASH SCREEN
// =======================================================
class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..repeat();

    _startApp();
  }

  Future<void> _startApp() async {
    final results = await Future.wait([
      Future.delayed(const Duration(seconds: 3)),
      DatabaseHelper.hasUser(),
    ]);

    final bool userExists = results[1] as bool;

    if (!mounted) return;

    if (userExists) {
      Navigator.pushReplacementNamed(context, '/bottombar');
    } else {
      Navigator.pushReplacementNamed(context, '/signup');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDot(int index) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final double value = (_controller.value + index * 0.2) % 1.0;
        final double scale = 0.6 + (value < 0.5 ? value : 1 - value);

        return Transform.scale(scale: scale, child: child);
      },
      child: const Dot(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: SizedBox(
                  width: 160,
                  height: 160,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: const AssetImage('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_buildDot(0), _buildDot(1), _buildDot(2)],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =======================================================
// 3. DOT WIDGET (FACEBOOK STYLE)
// =======================================================
class Dot extends StatelessWidget {
  const Dot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
    );
  }
}
