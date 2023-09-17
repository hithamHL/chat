import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:medicen_app/routes/routes.dart';
import 'package:medicen_app/utils/theme.dart';
import 'package:medicen_app/view/screen/nav_screen/home_screen.dart';
import 'package:medicen_app/view/screen/nav_screen/message_screen.dart';
import 'package:medicen_app/view/screen/nav_screen/more_screen.dart';
import 'package:medicen_app/view/screen/nav_screen/new_home_screen.dart';
import 'package:medicen_app/view/screen/nav_screen/userprofile_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PersistentTabController? _controller;

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home".tr),
        activeColorSecondary: Colors.white,
        activeColorPrimary: mainColor,

        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.paperplane),
        title: ("Message".tr),
        activeColorPrimary: mainColor,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),

      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("Profile".tr),
        activeColorPrimary: mainColor,
        activeColorSecondary: Colors.white,


        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),

      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.ellipsis),
        title: ("More".tr),
        activeColorPrimary: mainColor,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),



    ];
  }

  int _selectedIndex = 0;

  List<Widget> _buildScreens() {
    return [
      NewHomeScreen(),
      MessageScreen(),
      UserProfileScreen(),
      MoreScreen()
      // ShowCaseWidget(builder: (Builder(builder: (context)=> ListStu(),)),),
    ];
  }

  final _pageOptions = [
    NewHomeScreen(),
    MessageScreen(),
    UserProfileScreen(),
    MoreScreen()
  ];
  final PageStorageBucket bucket = PageStorageBucket();

  Widget currentScreen = HomeScreen();

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xffFFFAEB),
    ));
    //FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: _pageOptions[_selectedIndex],
          bottomNavigationBar: PersistentTabView(
            context,
          //  navBarHeight: 65,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            backgroundColor: mainColor2,
            // Default is Colors.white.
            handleAndroidBackButtonPress: true,
            // Default is true.
            resizeToAvoidBottomInset: true,
            // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
            stateManagement: true,
            // Default is true.
            hideNavigationBarWhenKeyboardShows: true,
            // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(10),
                  topLeft: Radius.circular(10)),
              colorBehindNavBar: mainColor2
            ),
            // popAllScreensOnTapOfSelectedTab: true,
            // popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle
                .style10, // Choose the nav bar style with this property.
          )
      ),
    );
  }
}


//     return SafeArea(
//       child:
//
//       AnnotatedRegion<SystemUiOverlayStyle>(
//     value:SystemUiOverlayStyle.dark,
//         child: Scaffold(
//           floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//           // floatingActionButton: Container(
//           //   margin: EdgeInsets.only(bottom: 10.0),
//           //   child: FloatingActionButton(
//           //     backgroundColor: mainColor,
//           //     shape: RoundedRectangleBorder(
//           //       borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
//           //     ),
//           //     child: Icon(Icons.shopping_cart_outlined),
//           //     onPressed: () {
//           //       // Your onPressed logic here
//           //       Get.toNamed(Routes.cartScreen);
//           //     },
//           //   ),
//           // ),
//           bottomNavigationBar: BottomAppBar(
//             color: Color(0xffFFFAEB),
//             shape: CircularNotchedRectangle(),
//             notchMargin: 10,
//             child: Container(
//               height: 60,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//
//                       MaterialButton(
//                           minWidth: 40,
//                           onPressed: (){
//                        setState(() {
//                          currentScreen=HomeScreen();
//                          _selectedIndex=0;
//                        });
//                       },
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.home,  color:_selectedIndex==0?mainColor:Colors.grey,),
//                           Text("Home",style: TextStyle(color: _selectedIndex==0?mainColor:Colors.grey),)
//                         ],
//                       ),
//                       ),
//                       SizedBox(width: 10,),
//                       MaterialButton(
//                         minWidth: 40,
//                         onPressed: (){
//                           setState(() {
//                             currentScreen=MessageScreen();
//                             _selectedIndex=1;
//                           });
//                         },
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.near_me_outlined,  color:_selectedIndex==1?mainColor:Colors.grey,),
//                             Text("Message",style: TextStyle(color: _selectedIndex==1?mainColor:Colors.grey),)
//                           ],
//                         ),
//                       ),
//                       SizedBox(width: 10,),
//
//                       MaterialButton(
//                         minWidth: 40,
//                         onPressed: (){
//                           setState(() {
//                             currentScreen=UserProfileScreen();
//                             _selectedIndex=2;
//                           });
//                         },
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.person_outline,  color:_selectedIndex==2?mainColor:Colors.grey,),
//                             Text("Profile",style: TextStyle(color: _selectedIndex==2?mainColor:Colors.grey),)
//                           ],
//                         ),
//                       ),
//                       SizedBox(width: 10,),
//
//                       MaterialButton(
//                         minWidth: 40,
//                         onPressed: (){
//                           setState(() {
//                             currentScreen=MoreScreen();
//                             _selectedIndex=3;
//                           });
//                         },
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.more_horiz,  color:_selectedIndex==3?mainColor:Colors.grey,),
//                             Text("More",style: TextStyle(color: _selectedIndex==3?mainColor:Colors.grey),)
//                           ],
//                         ),
//                       ),
//
//                     ],
//                   ),
//                   // Row(
//                   //   crossAxisAlignment: CrossAxisAlignment.start,
//                   //   children: [
//                   //
//                   //     MaterialButton(
//                   //       minWidth: 40,
//                   //       onPressed: (){
//                   //         setState(() {
//                   //           currentScreen=UserProfileScreen();
//                   //           _selectedIndex=2;
//                   //         });
//                   //       },
//                   //       child: Column(
//                   //         mainAxisAlignment: MainAxisAlignment.center,
//                   //         children: [
//                   //           Icon(Icons.person_outline,  color:_selectedIndex==2?mainColor:Colors.grey,),
//                   //           Text("Profile",style: TextStyle(color: _selectedIndex==2?mainColor:Colors.grey),)
//                   //         ],
//                   //       ),
//                   //     ),
//                   //     MaterialButton(
//                   //       minWidth: 40,
//                   //       onPressed: (){
//                   //         setState(() {
//                   //           currentScreen=MoreScreen();
//                   //           _selectedIndex=3;
//                   //         });
//                   //       },
//                   //       child: Column(
//                   //         mainAxisAlignment: MainAxisAlignment.center,
//                   //         children: [
//                   //           Icon(Icons.more_horiz,  color:_selectedIndex==3?mainColor:Colors.grey,),
//                   //           Text("More",style: TextStyle(color: _selectedIndex==3?mainColor:Colors.grey),)
//                   //         ],
//                   //       ),
//                   //     ),
//                   //
//                   //   ],
//                   // ),
//                 ],
//               ),
//             ),
//           ),
//           body: PageStorage(
//             bucket: bucket,
//             child: currentScreen,
//           ),
//         ),
//       ),
//     );
//   }
// }
