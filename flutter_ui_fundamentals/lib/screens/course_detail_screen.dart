
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_provider.dart';
import 'edit_course_screen.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({
    super.key,
    required this.course,
  });

  Future<void> _deleteCourse(BuildContext context) async {
    // Pastikan course memiliki ID sebelum menghapus.
    if (course.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Course tidak memiliki ID dan tidak bisa dihapus.'),
        ),
      );
      return;
    }

    // Menampilkan dialog konfirmasi.
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hapus Course?'),
          content: Text(
            'Apakah kamu yakin ingin menghapus "${course.title}"?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    // Periksa apakah halaman masih aktif setelah dialog ditutup.
    if (!context.mounted) return;

    // Batalkan proses jika pengguna memilih Batal.
    if (confirmed != true) return;

    try {
      // Memanggil HTTP DELETE melalui Provider.
      await context.read<CourseProvider>().deleteCourse(
            course.id!,
            course.code,
          );

      // Wajib memeriksa context setelah proses async selesai.
      if (!context.mounted) return;

      // Kembali ke halaman sebelumnya.
      Navigator.pop(context);

      // Menampilkan notifikasi penghapusan.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${course.title} berhasil dihapus.'),
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
    final isFav = provider.isFavorite(course.code);

    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
        actions: [
          IconButton(
            tooltip: 'Edit Course',
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditCourseScreen(
                    course: course,
                  ),
                ),
              );
            },
          ),
          IconButton(
            tooltip: 'Favorit',
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : null,
            ),
            onPressed: () {
              context
                  .read<CourseProvider>()
                  .toggleFavorite(course.code);
            },
          ),
          IconButton(
            tooltip: 'Hapus Course',
            icon: const Icon(Icons.delete),
            onPressed: provider.isSaving
                ? null
                : () => _deleteCourse(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Kode Mata Kuliah: ${course.code}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Jumlah SKS: ${course.credits}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Status: ${course.status}',
              style: const TextStyle(fontSize: 16),
            ),
            const Divider(height: 32),
            Row(
              children: [
                const Text(
                  'Status Favorit: ',
                  style: TextStyle(fontSize: 16),
                ),
                Chip(
                  avatar: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.red : Colors.grey,
                  ),
                  label: Text(
                    isFav ? 'Favorit Saya' : 'Bukan Favorit',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: provider.isSaving
                    ? null
                    : () => _deleteCourse(context),
                icon: const Icon(Icons.delete),
                label: const Text('Hapus Course'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
