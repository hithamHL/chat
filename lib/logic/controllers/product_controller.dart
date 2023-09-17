import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medicen_app/services/json_file/all_producte.dart';

class ProductController extends GetxController{

  var favouritsList=<Product>[].obs;
  var productList=<Product>[].obs;
  var stoarge=GetStorage();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    List? storedShoppings = stoarge.read<List>('isFavouritesList');

    if (storedShoppings != null) {
      favouritsList =
          storedShoppings.map((e) => Product.fromJson(e)).toList().obs;
    }
    getProducts();

  }

  void getProducts()async{

        productList.addAll(products);

  }

  void addFavourites(int productId) async{
    var existingIndex=favouritsList.indexWhere((element) => element.id==productId);
    if(existingIndex>=0){
      favouritsList.removeAt(existingIndex);
      await stoarge.remove('isFavouritesList');
    }else {
      favouritsList.add(
          productList.firstWhere((element) => element.id == productId));

      List<Map<String, dynamic>> productMaps = favouritsList.map((product) => product.toJson()).toList();
      await stoarge.write("isFavouritesList", productMaps);

    }
  }

   isFavourites(int productId){
    return favouritsList.any((element) => element.id==productId);
  }
}