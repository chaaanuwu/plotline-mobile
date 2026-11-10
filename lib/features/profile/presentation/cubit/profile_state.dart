import 'package:plotline_mobile/features/profile/domain/entity/profile_entity.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileEntity profile;

  ProfileLoaded({required this.profile});
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError({required this.message});
}
