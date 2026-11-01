import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/usecase/get_search_movie_results_usecase.dart';
import 'package:plotline_mobile/features/search/presentation/cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final GetSearchMovieResultsUsecase getSearchMovieResultsUsecase;

  SearchCubit({required this.getSearchMovieResultsUsecase})
    : super(SearchInitial());

  Future<void> getSearchResults(String query) async {
    final searchQuery = query.trim();

    if (searchQuery.isEmpty) return;

    emit(SearchLoading());

    final result = await getSearchMovieResultsUsecase(searchQuery);

    result.fold(
      (error) {
        emit(SearchError(error));
      },
      (movies) {
        emit(SearchLoaded(query: searchQuery, movies: movies));
      },
    );
  }
}
