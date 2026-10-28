import 'package:flutter/foundation.dart';

import '../models/course.dart';
import '../repositories/course_repository.dart';

class CourseProvider extends ChangeNotifier {
  final CourseRepository repository;

  CourseProvider(this.repository);

  List<Course> _courses = [];
  bool _isLoading = false;
  bool _isSaving = false;
  String? _error;

  final Set<String> _favoriteCodes = {};

  // Getter
  List<Course> get courses => _courses;
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  String? get error => _error;

  List<Course> get favoriteCourses =>
      _courses.where((c) => _favoriteCodes.contains(c.code)).toList();

  int get favoriteCount => _favoriteCodes.length;

  // Memeriksa apakah course merupakan favorit
  bool isFavorite(String code) => _favoriteCodes.contains(code);

  // Menambah atau menghapus favorit
  void toggleFavorite(String code) {
    if (_favoriteCodes.contains(code)) {
      _favoriteCodes.remove(code);
    } else {
      _favoriteCodes.add(code);
    }

    notifyListeners();
  }

  // GET: Mengambil daftar course
  Future<void> loadCourses() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _courses = await repository.getCourses();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // POST: Membuat course baru
  Future<Course> createCourse(Course course) async {
    _isSaving = true;
    notifyListeners();

    try {
      final createdCourse = await repository.createCourse(course);

      await loadCourses();

      return createdCourse;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  // PUT: Memperbarui course yang sudah ada
  Future<void> updateCourse(Course course) async {
    if (course.id == null) {
      throw Exception('ID course tidak boleh kosong saat mengedit');
    }

    _isSaving = true;
    notifyListeners();

    try {
      await repository.updateCourse(course.id!, course);

      await loadCourses();
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  // DELETE: Menghapus course
  Future<void> deleteCourse(int id, String code) async {
    _isSaving = true;
    notifyListeners();

    try {
      await repository.deleteCourse(id);

      // Menghapus course dari daftar lokal
      _courses.removeWhere((course) => course.id == id);

      // Menghapus favorit jika course yang dihapus merupakan favorit
      _favoriteCodes.remove(code);

      notifyListeners();
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }
}