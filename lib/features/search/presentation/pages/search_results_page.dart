import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/features/search/presentation/cubit/search_cubit.dart';
import 'package:plotline_mobile/features/search/presentation/cubit/search_state.dart';
import 'package:plotline_mobile/service_locator.dart'; // Adjust to your actual sl path

class SearchResultsPage extends StatefulWidget {
  final String query;

  const SearchResultsPage({
    super.key,
    required this.query,
  });

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SearchCubit>()
        ..getSearchResults(widget.query),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Results for "${widget.query}"'),
        ),
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (state is SearchLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is SearchError) {
              return Center(
                child: Text(state.message),
              );
            }

            if (state is SearchLoaded) {
              if (state.movies.isEmpty) {
                return const Center(
                  child: Text('No movies found.'),
                );
              }

              return ListView.builder(
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  final movie = state.movies[index];

                  return ListTile(
                    title: Text(movie.title),
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
