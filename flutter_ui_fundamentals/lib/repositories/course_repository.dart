
import '../models/course.dart';
import '../services/course_api_service.dart';

class CourseRepository {
  final CourseApiService apiService;

  CourseRepository(this.apiService);

  // GET: Mengambil daftar course
  Future<List<Course>> getCourses() {
    return apiService.getCourses();
  }

  // POST: Membuat course baru
  Future<Course> createCourse(Course course) {
    return apiService.createCourse(course);
  }

  // PUT: Memperbarui course
  Future<Course> updateCourse(Course course) {
    return apiService.updateCourse(course);
  }

  // DELETE: Menghapus course
  Future<void> deleteCourse(int id) {
    return apiService.deleteCourse(id);
  }
}
