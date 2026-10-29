
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'providers/course_provider.dart';
import 'repositories/course_repository.dart';
import 'screens/course_explorer_screen.dart';
import 'services/course_data_source.dart';
import 'services/course_supabase_service.dart';
// Untuk menggunakan REST, import CourseApiService dan ubah
// deklarasi dataSource di bawah.

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://lgugxoccewaehhsmmsnt.supabase.co',
    publishableKey: 'sb_publishable_C7DubL61-sRCDPGSEron2w_MvzO1LjU',
  );

  // Data source aktif: Supabase.
  final CourseDataSource dataSource = CourseSupabaseService();
  final courseRepository = CourseRepository(dataSource);

  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseProvider(courseRepository)..loadCourses(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Data Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CourseExplorerScreen(),
    );
  }
}
