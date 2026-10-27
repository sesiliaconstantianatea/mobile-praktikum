
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_ui_fundamentals/services/course_service.dart';
import 'package:flutter_ui_fundamentals/repositories/course_repository.dart';
import 'package:flutter_ui_fundamentals/providers/course_provider.dart';
import 'package:flutter_ui_fundamentals/screens/course_explorer_screen.dart';

void main() {
  testWidgets('Course Explorer menampilkan halaman utama', (
    WidgetTester tester,
  ) async {
    final courseService = CourseService();
    final courseRepository = CourseRepository(courseService);

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => CourseProvider(courseRepository),
        child: const MaterialApp(
          home: CourseExplorerScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Course Explorer v2'), findsOneWidget);
    expect(find.text('Daftar Course'), findsOneWidget);
    expect(find.text('2415051112 • Sesilia Constantiana Tea'), findsOneWidget);
  });
}
