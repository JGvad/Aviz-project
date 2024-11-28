class MapHandler {
  static List<T> mapForJsonToModelList<T>(
      List<dynamic> data, Function fromJson) {
    return data.map<T>((jsonObject) => fromJson(jsonObject)).toList();
  }

  static T mapSingleObjectFromJson<T>(List<dynamic> data, Function fromJson) {
    return fromJson(data.first);
  }
}
