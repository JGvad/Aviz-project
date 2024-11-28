import 'package:persian_number_utility/persian_number_utility.dart';

extension PriceSeparation on num? {
  String numberSeprated() {
    if (this == null) {
      throw Exception('Invalid inpute : Null ');
    }
    String numberSeprated = '$this'.seRagham();
    return numberSeprated;
  }
}
