import '../models/course.dart';
import '../services/course_data_source.dart';

class CourseRepository {
  final CourseDataSource dataSource;

  CourseRepository(this.dataSource);

  // GET: Mengambil daftar course
  Future<List<Course>> getCourses() {
    return dataSource.getCourses();
  }

  // POST: Membuat course baru
  Future<Course> createCourse(Course course) {
    return dataSource.createCourse(course);
  }

  // PUT: Memperbarui course berdasarkan ID
  Future<void> updateCourse(int id, Course course) {
    return dataSource.updateCourse(id, course);
  }

  // DELETE: Menghapus course
  Future<void> deleteCourse(int id) {
    return dataSource.deleteCourse(id);
  }
}