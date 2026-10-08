import 'package:flutter/material.dart';

const String studentName = 'SESILIA CONSTANTIANA TEA';
const String studentId = '2415051112';

void main() {
  runApp(const MyApp());
}

// ===============================
// CHANGE NOTIFIER
// ===============================

class CourseState extends ChangeNotifier {
  final Set<String> favorites = {};

  void toggleFavorite(String courseCode) {
    if (favorites.contains(courseCode)) {
      favorites.remove(courseCode);
    } else {
      favorites.add(courseCode);
    }

    notifyListeners();
  }

  bool isFavorite(String courseCode) {
    return favorites.contains(courseCode);
  }
}

// ===============================
// APP
// ===============================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChangeNotifier Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const ChangeNotifierDemoPage(),
    );
  }
}

// ===============================
// SCREEN
// ===============================

class ChangeNotifierDemoPage extends StatefulWidget {
  const ChangeNotifierDemoPage({super.key});

  @override
  State<ChangeNotifierDemoPage> createState() =>
      _ChangeNotifierDemoPageState();
}

class _ChangeNotifierDemoPageState
    extends State<ChangeNotifierDemoPage> {
  final CourseState courseState = CourseState();

  @override
  void initState() {
    super.initState();

    courseState.addListener(_updateUI);
  }

  void _updateUI() {
    setState(() {});
  }

  @override
  void dispose() {
    courseState.removeListener(_updateUI);
    courseState.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChangeNotifier Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              studentName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text('NIM: $studentId'),

            const SizedBox(height: 30),

            const Text(
              'State Management',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Jumlah Favorite: '
              '${courseState.favorites.length}',
            ),

            const SizedBox(height: 20),

            _buildCourse(
              'IF101',
              'Pemrograman Dasar',
            ),

            _buildCourse(
              'IF102',
              'Pemrograman Mobile',
            ),

            _buildCourse(
              'IF103',
              'Basis Data',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourse(
    String code,
    String name,
  ) {
    final favorite = courseState.isFavorite(code);

    return Card(
      child: ListTile(
        title: Text('$code - $name'),
        trailing: IconButton(
          icon: Icon(
            favorite
                ? Icons.favorite
                : Icons.favorite_border,
          ),
          onPressed: () {
            courseState.toggleFavorite(code);
          },
        ),
      ),
    );
  }
}