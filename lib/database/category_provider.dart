import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app_flutter/const/const.dart';
import 'package:sqflite/sqflite.dart';

class Category {
  late int id;
  late String name, image;

  Category();

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnMainCategoryId: id,
      columnCategoryName: name,
      columnCategoryImage: image,
    };

    return map;
  }

  Category.fromMap(Map<String, dynamic> map) {
    id = map[columnMainCategoryId];
    name = map[columnCategoryName];
    image = map[columnCategoryImage];
  }
}

class CategoryProvider {
  Future<Category?> getCategoryById(Database db, int id) async {
    var maps = await db.query(tableCategoryName,
        columns: [
          columnMainCategoryId,
          columnCategoryName,
          columnCategoryImage
        ],
        where: '$columnMainCategoryId=?',
        whereArgs: [id]);
    if (maps.length > 0) return Category.fromMap(maps.first);
    return null;
  }

  Future<List<Category>?> getCategories(Database db) async {
    var maps = await db.query(tableCategoryName, columns: [
      columnMainCategoryId,
      columnCategoryName,
      columnCategoryImage
    ]);
    if (maps.length > 0)
      return maps.map((category) => Category.fromMap(category)).toList();
    return null;
  }
}

class CategoryList extends StateNotifier<List<Category>> {
  CategoryList(List<Category> state) : super(state ?? []);

  void addAll(List<Category> categories) {
    state.addAll(categories);
  }

  void add(Category category) {
    state = [
      ...state,
      category,
    ];
  }
}
