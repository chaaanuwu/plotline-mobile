import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/features/profile/domain/entity/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<String, ProfileEntity?>> getUserMeProfile();
}
