part of 'profile_bloc.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoding extends ProfileState {}

final class ProfileFetchDataResponse extends ProfileState {
  final Either<String, UserModel> user;
  final Either<String, List<PromotionModel>> userPromotion;
  final Either<String, List<SavedPromotion>> savedPromotion;
  ProfileFetchDataResponse(this.user, this.userPromotion, this.savedPromotion);
}
