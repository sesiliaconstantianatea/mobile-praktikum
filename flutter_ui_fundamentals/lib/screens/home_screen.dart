
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/course_provider.dart';
import '../widgets/error_view.dart';
import '../widgets/course_card.dart';
import 'add_course_screen.dart';
import 'course_detail_screen.dart';
import 'favorites_screen.dart';

const String studentName = 'Sesilia Constantiana Tea';
const String studentId = '2415051112';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        context.read<CourseProvider>().loadCourses();
      }
    });
  }

  Future<void> _confirmDelete(
    BuildContext context,
    int id,
    String code,
    String title,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: Text(
          'Yakin ingin menghapus mata kuliah "$title" ($code)?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext, false);
            },
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext, true);
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    try {
      await context.read<CourseProvider>().deleteCourse(id, code);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Course "$title" berhasil dihapus'),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menghapus course: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Explorer v2'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Tambah Course',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddCourseScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'Favorit',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FavoritesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Icon(Icons.person, color: Colors.blue),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '$studentId • $studentName',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Total Course: ${provider.courses.length}',
                      ),
                      Text(
                        'Total Favorit: ${provider.favoriteCount}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                if (provider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (provider.error != null) {
                  return ErrorView(
                    message: provider.error!,
                    onRetry: () {
                      context.read<CourseProvider>().loadCourses();
                    },
                  );
                }

                if (provider.courses.isEmpty) {
                  return const Center(
                    child: Text(
                      'Data course belum tersedia',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: provider.courses.length,
                  itemBuilder: (context, index) {
                    final course = provider.courses[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: CourseCard(
                              course: course,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        CourseDetailScreen(
                                      course: course,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                            tooltip: 'Hapus Course',
                            onPressed: provider.isSaving
                                ? null
                                : () {
                                    final id = course.id;

                                    if (id == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'ID course tidak ditemukan',
                                          ),
                                        ),
                                      );
                                      return;
                                    }

                                    _confirmDelete(
                                      context,
                                      id,
                                      course.code,
                                      course.title,
                                    );
                                  },
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
