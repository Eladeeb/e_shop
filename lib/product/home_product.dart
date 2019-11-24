import 'dart:async';
import 'dart:async' as prefix0;
import 'package:e_shopp/contracts/contracts.dart';
import 'package:e_shopp/product/product.dart';
import 'package:e_shopp/api/products_api.dart';
class HomeProductsBloc implements Disposable{
  List<Product> products ;
  ProductsAPI productsAPI ;
  int currentDot ;
  final StreamController<List<Product>> _productsController =StreamController<List<Product>>.broadcast();
  Stream<List<Product>> get productStream => _productsController.stream ;
  final StreamController<int> _categoryController =StreamController<int>.broadcast();
  Stream<int> get category =>_categoryController.stream ;
  StreamSink<int> get fetchProducts => _categoryController.sink;


  int categoryID ;

  HomeProductsBloc(){
    productsAPI =ProductsAPI();
    products=[];
    _indexChange( currentDot);
    _productsController.add(this.products);
    _categoryController.add(this.categoryID);
    _categoryController.stream.listen(_fetchCategoryFromApi);
  }

  Future<void> _fetchCategoryFromApi(int category)async{
    this.products = await productsAPI.fetchProductsByCategory(category,1);
    _productsController.add(products);
  }

   void _indexChange(int newIndex){
    currentDot = newIndex ;
  }


  @override
  void dispose() {
    _productsController.close();
    _categoryController.close();
  }

}