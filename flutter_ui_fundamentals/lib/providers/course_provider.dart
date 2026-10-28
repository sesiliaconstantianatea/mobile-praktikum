
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
      final createdCourse =
          await repository.createCourse(course);

      await loadCourses();

      return createdCourse;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  // PUT: Memperbarui course yang sudah ada
  Future<Course> updateCourse(Course course) async {
    _isSaving = true;
    notifyListeners();

    try {
      final updatedCourse =
          await repository.updateCourse(course);

      await loadCourses();

      return updatedCourse;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }
}
