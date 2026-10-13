import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/core/configs/api/api_endpoints.dart';
import 'package:plotline_mobile/core/network/api_client.dart';
import 'package:plotline_mobile/features/movie_catalog/data/models/movie_model.dart';

abstract class MovieCatalogRemoteDataSource {
  Future<Either<String, List<MovieModel>>> getTmdbTrendingMovies();
}

class MovieCatalogRemoteDataSourceImpl implements MovieCatalogRemoteDataSource {
  final ApiClient apiClient;

  MovieCatalogRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<Either<String, List<MovieModel>>> getTmdbTrendingMovies() async {
    try {
      final response = await apiClient.dio.get(ApiEndpoints.trendingMovies);

      if (response.statusCode == 200) {
        final trendingMovies = response.data as List<dynamic>;

        return Right(
          trendingMovies
              .map(
                (movie) => MovieModel.fromJson(
                  Map<String, dynamic>.from(movie as Map),
                ),
              )
              .toList(),
        );
      }

      return Left("Failed to fetch trending movies.");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
