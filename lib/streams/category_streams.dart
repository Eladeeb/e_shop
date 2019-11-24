import 'dart:async';

import 'package:e_shopp/contracts/contracts.dart';
import 'package:e_shopp/product/product_category.dart';
import 'package:flutter/material.dart';

class CategoriesStream implements Disposable{
  StreamController<List<ProductCategory>> _CategoriesStram = StreamController<List<ProductCategory>>.broadcast();

  @override
  void dispose() {
    _CategoriesStram.close();
  }

}