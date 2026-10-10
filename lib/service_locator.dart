import 'package:get_it/get_it.dart';
import 'package:plotline_mobile/core/network/api_client.dart';
import 'package:plotline_mobile/features/auth/data/repository/auth_repository_impl.dart';
import 'package:plotline_mobile/features/auth/data/sources/auth_local_data_source.dart';
import 'package:plotline_mobile/features/auth/data/sources/auth_remote_data_source.dart';
import 'package:plotline_mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:plotline_mobile/features/auth/domain/usecases/get_saved_auth.dart';
import 'package:plotline_mobile/features/auth/domain/usecases/signin_usecase.dart';
import 'package:plotline_mobile/features/auth/domain/usecases/signup_usecase.dart';
import 'package:plotline_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:plotline_mobile/features/profile/data/repository/profile_repository_impl.dart';
import 'package:plotline_mobile/features/profile/data/sources/profile_remote_data_source.dart';
import 'package:plotline_mobile/features/profile/domain/repository/profile_repository.dart';
import 'package:plotline_mobile/features/profile/domain/usecase/get_me_use_case.dart';
import 'package:plotline_mobile/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:plotline_mobile/features/reviews/data/repository/review_repository_impl.dart';
import 'package:plotline_mobile/features/reviews/data/sources/review_remote_data_source.dart';
import 'package:plotline_mobile/features/reviews/domain/repository/review_repository.dart';
import 'package:plotline_mobile/features/reviews/domain/usecase/get_feed_reviews_usecase.dart';
import 'package:plotline_mobile/features/reviews/domain/usecase/get_my_reviews_usecase.dart';
import 'package:plotline_mobile/features/reviews/presentation/cubit/review_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

// GetIt service locator
final sl = GetIt.instance;

// Initialize all application dependencies
Future<void> initializeDependencies() async {
  final prefs = await SharedPreferences.getInstance();

  // CORE
  // API client used for making HTTP requests
  sl.registerSingleton<SharedPreferences>(prefs);
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(prefs: sl<SharedPreferences>()),
  );

  // AUTH

  // AUTH - DATA SOURCES
  // Remote data source
  // Handles authentication API requests
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<ApiClient>()),
  );
  // Local data source
  // Handles locally stored authentication data
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );

  // AUTH - REPOSITORY
  // Repository implementation
  // Connects the domain layer with the remote and local data sources
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      localDataSource: sl<AuthLocalDataSource>(),
    ),
  );

  // AUTH - USE CASES
  // Sign in
  sl.registerLazySingleton<SigninUsecase>(
    () => SigninUsecase(sl<AuthRepository>()),
  );

  // Sign up
  sl.registerLazySingleton<SignupUsecase>(
    () => SignupUsecase(sl<AuthRepository>()),
  );

  // Get currently saved authentication data
  sl.registerLazySingleton<GetSavedAuth>(
    () => GetSavedAuth(sl<AuthRepository>()),
  );

  // AUTH - PRESENTATION
  // AuthBloc manages login and signup authentication states
  // Factory is used because a new AuthBloc should be created
  // whenever a new AuthBloc provider is created.
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      signinUsecase: sl<SigninUsecase>(),
      signupUsecase: sl<SignupUsecase>(),
    ),
  );

  // PROFILE

  // PROFILE - DATA SOURCES
  // Remote data source
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );

  // PROFILE - REPOSITORY
  sl.registerLazySingleton<ProfileRepository>(
    () =>
        ProfileRepositoryImpl(remoteDataSource: sl<ProfileRemoteDataSource>()),
  );

  // PROFILE - USE CASES
  sl.registerLazySingleton<GetMeUseCase>(
    () => GetMeUseCase(repository: sl<ProfileRepository>()),
  );

  // PROFILE - PRESENTATION
  // ProfileCubit manages the state of the profile screen
  // Factory is used because a new ProfileCubit should be created
  // whenever a new ProfileCubit provider is created.
  sl.registerFactory<ProfileCubit>(
    () => ProfileCubit(getMeUseCase: sl<GetMeUseCase>()),
  );

  // REVIEWS

  // REVIEW DATASOURCE
  sl.registerLazySingleton<ReviewRemoteDataSource>(
    () => ReviewRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );

  // REVIEW - REPOSITORY
  sl.registerLazySingleton<ReviewRepository>(
    () => ReviewRepositoryImpl(remoteDataSource: sl<ReviewRemoteDataSource>()),
  );

  // REVIEW - USE CASES
  sl.registerLazySingleton<GetMyReviewsUsecase>(
    () => GetMyReviewsUsecase(repository: sl<ReviewRepository>()),
  );

  // REVIEW - USE CASES
  sl.registerLazySingleton<GetFeedReviewsUsecase>(
    () => GetFeedReviewsUsecase(repository: sl<ReviewRepository>()),
  );

  // REVIEW - PRESENTATION(WIDGET)
  sl.registerFactory<ReviewCubit>(
    () => ReviewCubit(
      getMyReviewsUsecase: sl<GetMyReviewsUsecase>(),
      getFeedReviewsUsecase: sl<GetFeedReviewsUsecase>(),
    ),
  );
}
