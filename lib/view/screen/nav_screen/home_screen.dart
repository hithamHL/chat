import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medicen_app/routes/routes.dart';
import 'package:medicen_app/services/json_file/all_categries.dart';
import 'package:medicen_app/utils/theme.dart';
import 'package:medicen_app/view/widget/custom_text.dart';

import '../../../logic/controllers/product_controller.dart';
import '../../../services/json_file/all_producte.dart';
import '../../widget/producte_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController=TextEditingController();
  final controller=Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(width: double.infinity,
          color: mainColor2,
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.place_outlined,color: Color(0xffCCCCCC)),
                     SizedBox(width: 5,),
                    Text('Palestine',style: TextStyle(color: Color(0xffCCCCCC)),),
                  ],
                ),
                SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap:(){
                          // to do search for list view
                        },
                        child: Container(
                          width: 50,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.0), // Adjust the radius as needed
                              bottomLeft: Radius.circular(12.0), // Adjust the radius as needed
                            ),
                            color: mainColor,
                          ),

                            child: Icon(
                              Icons.search,
                              color: Colors.white, // Change the icon color here
                            ),
                          ),
                      ),
                      SizedBox(width: 0,),



                      Expanded(
                        child: TextFormField(

                          controller: searchController,


                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            hintText: "Search ....",
                            hintStyle: TextStyle(color: Color(0xffcacaca)),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: mainColor, // Set the border color here
                                width: 2.0, // Set the border width here
                              ),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  bottomRight: Radius.circular(12)
                              ),  ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: mainColor, // Set the border color here
                                width: 2.0, // Set the border width here
                              ),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  bottomRight: Radius.circular(12)
                              ),     ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: mainColor, // Set the border color here
                                width: 2.0, // Set the border width here
                              ),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  bottomRight: Radius.circular(12)
                              ),
                            ),

                          ),

                        )

                      ),
                      InkWell(
                        onTap: (){
                          //get.toNamed for Filter Screen

                        },
                        child: Container(
                            padding: EdgeInsets.all(8),
                            child: SvgPicture.asset("images/filtter.svg")),
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(

                  width: double.infinity,
                  height: 150,

                  decoration: BoxDecoration(

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black, // Shadow color
                        offset: Offset(0, 2), // Offset of the shadow
                        blurRadius: 6.0, // Blur radius
                        spreadRadius: 0, // Spread radius
                      ),
                    ],
                    borderRadius: BorderRadius.all(
                    Radius.circular(20)
                    ),
                    color: mainColor2,
                  ),

                  child: Stack(
                    children: [
                     Center(child: SvgPicture.asset("images/bg_for_depost.svg")),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: CustomTextWidget(
                              text: "Discount 35%",
                              textColor: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5,),
                        CustomTextWidget(
                            text: "on vitamins and minerals",
                            textColor: Color(0xffcacaca),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        SizedBox(height: 5,),

                        Container(
                          width: 150,

                          child: ElevatedButton(
                            onPressed: () async {
                              //  getConnectivity();
                              Get.toNamed(Routes.discountsScreen);



                            },
                            child: Text(
                                "Discover more",
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30), // Set the radius here
                              ),

                              primary: mainColor, // Set the button color to your desired color
                              padding: EdgeInsets.all(16), // Adjust the padding as needed
                              // Set minimum width to 200
                            ),
                          ),
                        ),
                      ],
                    ),


                    ],
                  )
                ),

            SizedBox(height: 16,),

            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular Categories",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      // Add other text styles as needed
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle the "View All" action here
                      Get.toNamed(Routes.categoryList);
                    },
                    child: Text(
                      "View All",
                      style: TextStyle(
                        color: mainColor, // Add your desired color
                        fontWeight: FontWeight.bold,
                        // Add other text styles as needed
                      ),
                    ),
                  ),
                ],
              ),
            ),
                SizedBox(height: 8,),

               Container(
                 height: 100,
                 width: MediaQuery.of(context).size.width,

                 child: SizedBox(
                   height: 80,
                   child: ListView.builder(
                     padding: EdgeInsets.only(left: 10),
                     itemCount: Categories().menuCategory.length,
                     scrollDirection: Axis.horizontal,
                     itemBuilder: (BuildContext context, int index) {
                       var items = Categories().menuCategory[index];
                       return SizedBox(
                         width: 80, // Set the desired width for each item
                         child: InkWell(
                           onTap: (){

                             if(index==0){
                               Get.toNamed(Routes.medicineList);
                             }else if(index==1){
                               Get.toNamed(Routes.babyCareList);
                             }else if(index==2){
                               Get.toNamed(Routes.skinCareList);
                             }else if(index==3){
                               Get.toNamed(Routes.mouthAndTeethList);
                             }else if(index==4){
                               Get.toNamed(Routes.nutritionalSupplementsList);
                             }else if(index==5){
                               Get.toNamed(Routes.severeToxinsList);
                             }else if(index==6){
                               Get.toNamed(Routes.mildToxinsList);
                             }

                           },
                           child: Container(
                             child: Column(
                               children: [
                                 CircleAvatar(
                                   radius: 25,
                                   backgroundColor: mainColor2,
                                   child: Image.asset(
                                     items["image"],
                                     width: 30,
                                     height: 30,
                                     fit: BoxFit.fitWidth,
                                   ),
                                 ),
                                 SizedBox(height: 6.74),
                                 Text(
                                   items["text"] + "  ",
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                     fontSize: 13,
                                   ),
                                 )
                               ],
                             ),
                           ),
                         ),
                       );
                     },
                   ),
                 ),
               ),

                SizedBox(height: 8,),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Best Saller",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          // Add other text styles as needed
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle the "View All" action here
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            color: mainColor, // Add your desired color
                            fontWeight: FontWeight.bold,
                            // Add other text styles as needed
                          ),
                        ),
                      ),
                    ],
                  ),
                ),



            Container(
              height: 350,
              width: MediaQuery.of(context).size.width,

              child: ListView.builder(
                itemCount: products.length,
                scrollDirection: Axis.horizontal,

                itemBuilder: (context, index) {

                  return ProductCard(
                    title: products[index].title,
                    description: products[index].description,
                    price: products[index].price,
                    rating: products[index].rate,
                    id: products[index].id,
                    count: products[index].count,
                    image: products[index].images,
                    addToFavorites: () {
                      // Implement favorite functionality here
                      controller.addFavourites(products[index].id);
                       },
                    addToCart: () {
                      // Implement add to cart functionality here
                    },
                  );
                },
              ),
            ),







              ],
            ),
          )
        ],
      ),
    );
  }
}
