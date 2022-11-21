import 'dart:convert';

class CategoryDto {
  CategoryDto({
    required this.categoryId,
    required this.category,
  });

  int categoryId;
  String category;

  factory CategoryDto.fromJson(String str) => CategoryDto.fromMap(json.decode(str));

  factory CategoryDto.fromMap(Map<String, dynamic> json) => CategoryDto(
        categoryId: json["categoryId"],
        category: json["category"],
      );
}
