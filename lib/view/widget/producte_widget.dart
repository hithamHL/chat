import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicen_app/logic/controllers/product_controller.dart';
import 'package:medicen_app/utils/theme.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final int id;
  final String description;
  final double price;
  final String image;
  final double rating;
  final int count;
  final VoidCallback addToFavorites;
  final VoidCallback addToCart;

  ProductCard({
    required this.title,
    required this.description,
    required this.price,
    required this.id,
    required this.image,
    required this.rating,
    required this.count,
    required this.addToFavorites,
    required this.addToCart,
  });
  final controller=Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {

    return Container(
      width: 200,

      child: Card(
        elevation: 3,
        //color: mainColor2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(

                  child: Image.network(
                    image,
                    height: 170,
                    fit: BoxFit.cover,

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Obx(()=>
                            Column(
                              children: [

                                InkWell(
                                    onTap: (){
                                      onPressed: addToFavorites();
                                      //   controller.addFavourites(id);

                                    },
                                    child:controller.isFavourites(id)? Icon(
                                      Icons.favorite,color: scandreColor,)
                                        :Icon(
                                      Icons.favorite_border,color: scandreColor,)
                                ),
                                SizedBox(height: 10,),

                                InkWell(
                                  onTap: (){
                                    onPressed: addToCart();

                                  },
                                  child: Icon(
                                    Icons.add_circle,color: scandreColor,),
                                ),
                              ],
                            ),)
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      maxLines: 1, // تحديد الحد الأقصى لعدد الأسطر
                      overflow: TextOverflow.ellipsis, // عرض نقاط الإلباء إذا تجاوز النص الحد الأقصى للعرض
                    ),
                    SizedBox(height: 8.0),

                    Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '\$$price',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 5,),

                            Icon(Icons.star,color: scandreColor,),
                              //  SizedBox(width: 4,),

                            Text(
                              '$rating($count)',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),


                          ],
                        ),

                      ],
                    ),


                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}