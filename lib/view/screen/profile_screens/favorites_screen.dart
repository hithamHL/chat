import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medicen_app/logic/controllers/product_controller.dart';
import 'package:medicen_app/utils/theme.dart';
import 'package:medicen_app/view/widget/custom_card.dart';
import 'package:medicen_app/view/widget/favorites_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xffFFFAEB),
    ));
    //FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);
    super.initState();
  }

  final controller=Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor2,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.black,
            size: 20,
          ), onPressed: () {
            Get.back();
          },),
          title: Text("Favorites Screen",style: TextStyle(color: Colors.black,fontSize: 16),),
        ),
        body:  Obx((){
          if(controller.favouritsList.isEmpty){
            return  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100,
                    width: 100,
                    child: Image.asset("images/heart.png"),
                  ),
                  SizedBox(height: 10,),
                  Text("Please, Add your favorites products.".tr,style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color:mainColor,
                  ),
                  ),
                ],
              ),
            );
          }
          else{
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                  itemBuilder: (context,index){
                    return CustomCard(
                        title: controller.favouritsList[index].title,
                        description: controller.favouritsList[index].description,
                        price: controller.favouritsList[index].price,
                        id: controller.favouritsList[index].id,
                        image: controller.favouritsList[index].images,
                        rating: controller.favouritsList[index].rate,
                        count: controller.favouritsList[index].count,
                        removeFromFavorites: (){

                          controller.addFavourites(controller.favouritsList[index].id);

                        });

                  },
                  separatorBuilder: (context,index){
                    return Container();
                  },
                  itemCount: controller.favouritsList.length),
            );
          }


        }),
      ),
    );
  }
}
