
import 'package:freezed_annotation/freezed_annotation.dart';
part 'product_model.g.dart';
part 'product_model.freezed.dart';

@freezed
class ProductModel with _$ProductModel{
  const factory ProductModel({
    required int id,
    required String title,
    required int price,
    required String description,
    required Category category,
    required List<String> images,

  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, Object?> json) => _$ProductModelFromJson(json);
}

@freezed
class Category with _$Category{
  const factory Category({
    required int id,
    required String name,
    required String image,

  }) = _Category;

  factory Category.fromJson(Map<String, Object?> json) => _$CategoryFromJson(json);
}
