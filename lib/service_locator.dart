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
import 'package:plotline_mobile/features/profile/presentation/bloc/profile_cubit.dart';

// GetIt service locator
final sl = GetIt.instance;

// Initialize all application dependencies
Future<void> initializeDependencies() async {
  // CORE
  // API client used for making HTTP requests
  sl.registerLazySingleton<ApiClient>(() => ApiClient());

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

  // PROFILE - PRESENTATION

  // ProfileCubit manages the profile screen state
  // It uses GetSavedAuth to retrieve the currently authenticated user data
  // Factory is used because a new ProfileCubit should be created
  sl.registerFactory<ProfileCubit>(
    () => ProfileCubit(getSavedAuth: sl<GetSavedAuth>()),
  );
}
