import 'package:get_it/get_it.dart';
import 'package:plotline_mobile/core/network/api_client.dart';
import 'package:plotline_mobile/features/auth/data/repository/auth_repository_impl.dart';
import 'package:plotline_mobile/features/auth/data/sources/auth_local_data_source.dart';
import 'package:plotline_mobile/features/auth/data/sources/auth_remote_data_source.dart';
import 'package:plotline_mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:plotline_mobile/features/auth/domain/usecases/signin_usecase.dart';
import 'package:plotline_mobile/features/auth/domain/usecases/signup_usecase.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<ApiClient>(ApiClient());

  // AUTH
  sl.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImpl(sl()));
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerLazySingleton<SigninUsecase>(() => SigninUsecase());
  sl.registerLazySingleton<SignupUsecase>(() => SignupUsecase());

  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource());
}
