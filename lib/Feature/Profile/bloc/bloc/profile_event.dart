part of 'profile_bloc.dart';

sealed class ProfileEvent {}

final class ProfileFetchData extends ProfileEvent {
  final String? userId;
  ProfileFetchData({this.userId});
}

final class ProfileEditeUserInfo extends ProfileEvent {
  final String userId;
  final String name;
  final String phone;
  final File thumbnail;
  ProfileEditeUserInfo({
    required this.userId,
    required this.name,
    required this.phone,
    required this.thumbnail,
  });
}
