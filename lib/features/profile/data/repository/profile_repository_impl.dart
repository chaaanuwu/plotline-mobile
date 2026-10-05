import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/features/profile/data/sources/profile_remote_data_source.dart';
import 'package:plotline_mobile/features/profile/domain/entity/profile_entity.dart';
import 'package:plotline_mobile/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, ProfileEntity?>> getUserMeProfile() async {
    final result = await remoteDataSource.getMe();

    return result.fold(
      (error) async => Left<String, ProfileEntity?>(error),
      (profileModel) async => Right<String, ProfileEntity?>(profileModel),
    );
  }
}
