import 'package:bookvies/models/movie_model.dart';
import 'package:bookvies/utils/firebase_constants.dart';

class MovieService {
  Future<Movie> getMovieById({required String movieId}) async {
    try {
      final snapshot = await moviesRef.doc(movieId).get();
      return Movie.fromMap(snapshot.data() as Map<String, dynamic>);
    } catch (error) {
      print("Get movie by id error: $error");
      rethrow;
    }
  }

  Future<void> updateMovie({required Movie movie}) async {
    try {
      await moviesRef.doc(movie.id).update(movie.toMap());
    } catch (error) {
      print("Update movie error: $error");
      rethrow;
    }
  }

  Future<void> deleteMovie({required String movieId}) async {
    try {
      await moviesRef.doc(movieId).delete();
    } catch (error) {
      print("Delete movie error: $error");
      rethrow;
    }
  }
}
