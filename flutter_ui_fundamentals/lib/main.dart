
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'providers/course_provider.dart';
import 'repositories/course_repository.dart';
import 'screens/course_explorer_screen.dart';
import 'services/course_supabase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    // Ganti dengan Project URL yang benar dari dashboard Supabase.
    url: 'https://lgugxoccewaehhsmmsnt.supabase.co',
    // Gunakan Publishable key milik proyekmu.
    publishableKey: 'sb_publishable_C7DubL61-sRCDPGSEron2w_MvzO1LjU',
  );

  final courseService = CourseSupabaseService();
  final courseRepository = CourseRepository(courseService);

  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseProvider(courseRepository),
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
      title: 'Course Explorer v2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const CourseExplorerScreen(),
    );
  }
}
