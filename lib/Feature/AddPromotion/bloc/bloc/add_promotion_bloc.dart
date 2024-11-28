import 'dart:io';

import 'package:aviz/Feature/AddPromotion/data/model/category_model.dart';
import 'package:aviz/Feature/AddPromotion/data/model/sub_category_model.dart';
import 'package:aviz/Feature/AddPromotion/data/repository/add_promotion_repository.dart';
import 'package:aviz/Feature/AddPromotion/data/repository/category_repository.dart';
import 'package:aviz/Feature/AddPromotion/data/repository/sub_category_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'add_promotion_event.dart';
part 'add_promotion_state.dart';

class AddPromotionBloc extends Bloc<AddPromotionEvent, AddPromotionState> {
  final ICategoryRepository _categoryRepository;
  final ISubCategoryRepository _subCategoryRepository;
  final IAddPromotionRepository _addPromotionRepository;
  AddPromotionBloc(this._categoryRepository, this._subCategoryRepository,
      this._addPromotionRepository)
      : super(AddPromotionInitial()) {
    on<AddPromotionCategoryRequest>(
      (event, emit) async {
        emit(AddPromotionLoding());
        final categoryResult = await _categoryRepository.getCategories();

        emit(
          AddPromotionCategoryResponse(
            categoryList: categoryResult,
          ),
        );
      },
    );
    on<AddPromotionSubCategoryRequest>(
      (event, emit) async {
        emit(AddPromotionLoding());
        final subCategoryResult =
            await _subCategoryRepository.subCategories(event.categoryId);
        emit(
          AddPromotionSubCategoryResponse(subcategoryList: subCategoryResult),
        );
      },
    );
    on<AddPromotionRequest>(
      (event, emit) async {
        emit(AddPromotionLoding());
        final response = await _addPromotionRepository.addPromotion(
          title: event.title,
          description: event.description,
          thumbnail: event.thumbnail,
          price: event.price,
          meterage: event.meterage,
          roomCount: event.roomCount,
          floor: event.floor,
          yearBuilt: event.yearBuilt,
          location: event.location,
          subCategoryId: event.subCategoryId,
          phoneNumber: event.phoneNumber,
          hasElevator: event.hasElevator,
          hasParking: event.hasParking,
          hasStorage: event.hasStorage,
          showExactLocation: event.showExactLocation,
          callEnabled: event.callEnabled,
          chatEnabled: event.chatEnabled,
          isHot: event.isHot,
          hasPool: event.hasPool,
          userOwner: event.userOwner,
        );
        emit(
          AddPromotionResponse(response: response),
        );
      },
    );
  }
}
