import 'package:wedevs_testproject/constants/strings.dart';

class ProductFilterModel {
  String title;
  bool isChecked;

  ProductFilterModel({
    required this.title,
    required this.isChecked,
  });

  static List<ProductFilterModel> fetchAll() => [
        ProductFilterModel(title: newest, isChecked: false),
        ProductFilterModel(title: oldest, isChecked: false),
        ProductFilterModel(title: priceLowHigh, isChecked: false),
        ProductFilterModel(title: priceHighLow, isChecked: false),
        ProductFilterModel(title: bestSelling, isChecked: false),
      ];
}
