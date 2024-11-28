import 'dart:async';

import 'package:aviz/Core/data/datasource/promotion_datasource.dart';
import 'package:aviz/Core/data/models/promotion_hive_model.dart';
import 'package:aviz/Core/data/repository/promotion_repository.dart';
import 'package:aviz/Feature/AddPromotion/bloc/bloc/add_promotion_bloc.dart';
import 'package:aviz/Feature/AddPromotion/data/datasource/add_promotion_datasource.dart';
import 'package:aviz/Feature/AddPromotion/data/datasource/category_datasource.dart';
import 'package:aviz/Feature/AddPromotion/data/datasource/sub_category_datasource.dart';
import 'package:aviz/Feature/AddPromotion/data/repository/add_promotion_repository.dart';
import 'package:aviz/Feature/AddPromotion/data/repository/category_repository.dart';
import 'package:aviz/Feature/AddPromotion/data/repository/sub_category_repository.dart';
import 'package:aviz/Feature/Authentication/bloc/bloc/auth_bloc.dart';
import 'package:aviz/Feature/Authentication/data/datasource/auth_datasource.dart';
import 'package:aviz/Feature/Authentication/data/repository/auth_repository.dart';
import 'package:aviz/Feature/DetialPromotion/bloc/bloc/detial_promotion_bloc.dart';
import 'package:aviz/Feature/Home/bloc/bloc/home_bloc.dart';
import 'package:aviz/Feature/ListPromotion/bloc/bloc/list_promotion_bloc.dart';
import 'package:aviz/Feature/Profile/bloc/bloc/profile_bloc.dart';
import 'package:aviz/Feature/Profile/data/datasource/profile_datasource.dart';
import 'package:aviz/Feature/Profile/data/repository/profile_repository.dart';
import 'package:aviz/Feature/Search/bloc/bloc/search_bloc.dart';
import 'package:aviz/UtilNetwork/dio_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

GetIt locator = GetIt.instance;

Future<void> serviceLocator() async {
  await _initUtil();
  _initDatasource();
  _initRepository();
  _initBloc();
}

Future<void> _initUtil() async {
  locator.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage());
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  locator.registerSingleton<Dio>(await DioProvider.creatDio());
  locator.registerSingleton<Box<SavedPromotion>>(
    Hive.box<SavedPromotion>('SavedBox'),
  );
  locator.registerSingleton<GoogleTranslator>(
    GoogleTranslator(),
  );
}

void _initDatasource() {
  locator.registerSingleton<ICategoryDatasource>(
    CategoryRemote(
      locator.get<Dio>(),
    ),
  );
  locator.registerSingleton<ISubCategoryDatasource>(
    SubCategoryRemote(
      locator.get<Dio>(),
    ),
  );
  locator.registerSingleton<IPromotionDatasource>(
    PromotionRemote(locator.get<Dio>(), locator.get<Box<SavedPromotion>>()),
  );
  locator.registerSingleton<IAddPromotionDatasource>(
    AddPromotionRemote(
      locator.get<Dio>(),
    ),
  );
  locator.registerSingleton<IProfileDatasource>(
    ProfileDataRemote(
      locator.get<Dio>(),
    ),
  );
  locator.registerSingleton<IAuthDatasource>(AuthDatasource());
}

void _initRepository() {
  locator.registerSingleton<ICategoryRepository>(
    CategoryRepository(
      locator.get<ICategoryDatasource>(),
    ),
  );
  locator.registerSingleton<ISubCategoryRepository>(
    SubCategoryRepository(
      locator.get<ISubCategoryDatasource>(),
    ),
  );
  locator.registerSingleton<IPromotionRepository>(
    PromotionRepository(
      locator.get<IPromotionDatasource>(),
    ),
  );
  locator.registerSingleton<IAddPromotionRepository>(
    AddPromotionRepository(
      locator.get<IAddPromotionDatasource>(),
    ),
  );
  locator.registerSingleton<IProfileRepository>(
    ProfileRepository(
      locator.get<IProfileDatasource>(),
    ),
  );
  locator.registerSingleton<IAuthRepository>(
    AuthRepository(
      locator.get<IAuthDatasource>(),
    ),
  );
}

void _initBloc() {
  locator.registerFactory<AddPromotionBloc>(
    () => AddPromotionBloc(
        locator.get<ICategoryRepository>(),
        locator.get<ISubCategoryRepository>(),
        locator.get<IAddPromotionRepository>()),
  );

  locator.registerSingleton<ProfileBloc>(
    ProfileBloc(
      locator.get<IProfileRepository>(),
      locator.get<IPromotionRepository>(),
    ),
  );
  locator.registerFactory<DetialPromotionBloc>(
    () => DetialPromotionBloc(
      locator.get<IPromotionRepository>(),
    ),
  );
  locator.registerFactory<ListPromotionBloc>(
    () => ListPromotionBloc(
      locator.get<IPromotionRepository>(),
    ),
  );
  locator.registerFactory<SearchBloc>(
    () => SearchBloc(
      locator.get<IPromotionRepository>(),
    ),
  );
  locator.registerSingleton<HomeBloc>(
    HomeBloc(
      locator.get<IPromotionRepository>(),
    ),
  );
  locator.registerFactory<AuthBloc>(
    () => AuthBloc(
      locator.get<IAuthRepository>(),
    ),
  );
}
