import 'package:flutter/material.dart';

void main() {
  runApp(const CSUOJTApp());
}

/// ================================
/// APP ROOT
/// ================================
class CSUOJTApp extends StatelessWidget {
  const CSUOJTApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CSU – Navigatu – OJT's",
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

/// ================================
/// SPLASH SCREEN
/// ================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school, size: 80),
            SizedBox(height: 16),
            Text(
              "CSU – Navigatu – OJT's",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("OJT Attendance & Task Monitoring"),
          ],
        ),
      ),
    );
  }
}

/// ================================
/// LOGIN SCREEN
/// ================================
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(labelText: "Student ID"),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text("Login"),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const MainScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ================================
/// MAIN SCREEN WITH NAVIGATION
/// ================================
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final screens = const [
    DashboardScreen(),
    AttendanceScreen(),
    TasksScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() => currentIndex = index);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard), label: "Dashboard"),
          NavigationDestination(icon: Icon(Icons.access_time), label: "Attendance"),
          NavigationDestination(icon: Icon(Icons.task), label: "Tasks"),
          NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

/// ================================
/// DASHBOARD
/// ================================
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            InfoCard(
              title: "Rendered Hours",
              value: "120 / 500",
              icon: Icons.timer,
            ),
            InfoCard(
              title: "Tasks Completed",
              value: "1 / 3",
              icon: Icons.task_alt,
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const InfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}

/// ================================
/// ATTENDANCE
/// ================================
class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  bool timedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Attendance")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              timedIn ? Icons.check_circle : Icons.cancel,
              size: 80,
              color: timedIn ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 12),
            Text(
              timedIn ? "You are Timed In" : "You are Not Timed In",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() => timedIn = !timedIn);
              },
              child: Text(timedIn ? "Time Out" : "Time In"),
            ),
          ],
        ),
      ),
    );
  }
}

/// ================================
/// TASKS
/// ================================
class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = [
      OJTTask("System Documentation", 1.0),
      OJTTask("UI Design", 0.6),
      OJTTask("Database Setup", 0.3),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("OJT Tasks")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: tasks.map((task) => TaskCard(task)).toList(),
      ),
    );
  }
}

class OJTTask {
  final String title;
  final double progress;

  OJTTask(this.title, this.progress);
}

class TaskCard extends StatelessWidget {
  final OJTTask task;

  const TaskCard(this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    String status = task.progress == 1
        ? "Completed"
        : task.progress > 0
            ? "In Progress"
            : "Not Started";

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: task.progress),
            const SizedBox(height: 6),
            Text("Status: $status"),
          ],
        ),
      ),
    );
  }
}

/// ================================
/// PROFILE
/// ================================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
            SizedBox(height: 12),
            Text("Juan Dela Cruz",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("BSIT – OJT Student"),
            Divider(height: 32),
            ListTile(
              leading: Icon(Icons.school),
              title: Text("Company"),
              subtitle: Text("Partner Company Inc."),
            ),
            ListTile(
              leading: Icon(Icons.timer),
              title: Text("Required Hours"),
              subtitle: Text("500"),
            ),
          ],
        ),
      ),
    );
  }
}
