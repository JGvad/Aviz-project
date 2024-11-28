import 'dart:io';

import 'package:aviz/Core/data/models/promotion_hive_model.dart';
import 'package:aviz/Core/data/models/promotion_model.dart';
import 'package:aviz/Core/data/repository/promotion_repository.dart';
import 'package:aviz/Feature/Profile/data/model/user_model.dart';
import 'package:aviz/Feature/Profile/data/repository/profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final IProfileRepository _profileRepository;
  final IPromotionRepository _promotionRepository;
  ProfileBloc(
    this._profileRepository,
    this._promotionRepository,
  ) : super(ProfileInitial()) {
    on<ProfileFetchData>(
      (event, emit) async {
        emit(ProfileLoding());

        final response = await Future.wait(
          [
            _profileRepository.getUserInfo(event.userId!),
            _promotionRepository.getUserPromotions(ownerId: event.userId!),
            _promotionRepository.getSavedPromotions(ownerId: event.userId!),
          ],
        );

        emit(
          ProfileFetchDataResponse(
            response[0] as Either<String, UserModel>,
            response[1] as Either<String, List<PromotionModel>>,
            response[2] as Either<String, List<SavedPromotion>>,
          ),
        );
      },
    );
    on<ProfileEditeUserInfo>(
      (event, emit) async {
        await _profileRepository.editUserInfo(
          userId: event.userId,
          name: event.name,
          phone: event.phone,
          thumbnail: event.thumbnail,
        );
      },
    );
  }
}
