import 'package:get/get.dart';
import 'package:medicen_app/view/screen/auth/forget_pass/change_pass.dart';
import 'package:medicen_app/view/screen/auth/forget_pass/forgetpassword_screen.dart';
import 'package:medicen_app/view/screen/auth/forget_pass/successful_reset_pass.dart';
import 'package:medicen_app/view/screen/auth/forget_pass/verification_screen.dart';
import 'package:medicen_app/view/screen/auth/login_screen.dart';
import 'package:medicen_app/view/screen/auth/new_login_screen.dart';
import 'package:medicen_app/view/screen/auth/new_signup_screen.dart';
import 'package:medicen_app/view/screen/auth/signup_screen.dart';
import 'package:medicen_app/view/screen/auth/type_login_screen.dart';
import 'package:medicen_app/view/screen/categore_lists/baby_cate_list.dart';
import 'package:medicen_app/view/screen/categore_lists/medicine_list.dart';
import 'package:medicen_app/view/screen/categore_lists/mild_toxins_list.dart';
import 'package:medicen_app/view/screen/categore_lists/nutritional_supplements.dart';
import 'package:medicen_app/view/screen/categore_lists/severe_toxins_list.dart';
import 'package:medicen_app/view/screen/categore_lists/skin_car_list.dart';
import 'package:medicen_app/view/screen/categore_lists/view_all_category.dart';
import 'package:medicen_app/view/screen/main_screen.dart';
import 'package:medicen_app/view/screen/more__all_screen/about_us_screen.dart';
import 'package:medicen_app/view/screen/more__all_screen/discounts_screen.dart';
import 'package:medicen_app/view/screen/more__all_screen/privacy_policy.dart';
import 'package:medicen_app/view/screen/nav_screen/cart_screen.dart';
import 'package:medicen_app/view/screen/nav_screen/home_screen.dart';
import 'package:medicen_app/view/screen/nav_screen/message_screen.dart';
import 'package:medicen_app/view/screen/nav_screen/more_screen.dart';
import 'package:medicen_app/view/screen/nav_screen/new_home_screen.dart';
import 'package:medicen_app/view/screen/notification_screen.dart';
import 'package:medicen_app/view/screen/on_borde/onbording_screen.dart';
import 'package:medicen_app/view/screen/profile_screens/favorites_screen.dart';
import 'package:medicen_app/view/screen/splash_screen.dart';
import 'package:medicen_app/view/screen/user_profile_screens/account_information.dart';
import 'package:medicen_app/view/screen/user_profile_screens/orders_screen.dart';
import 'package:medicen_app/view/screen/user_profile_screens/setting_screen.dart';
import 'package:medicen_app/view/screen/user_profile_screens/setting_screens/add_accounr.dart';
import 'package:medicen_app/view/screen/user_profile_screens/setting_screens/add_address_screen.dart';
import 'package:medicen_app/view/screen/user_profile_screens/address_screen.dart';
import 'package:medicen_app/view/screen/user_profile_screens/setting_screens/change_password.dart';
import 'package:medicen_app/view/screen/user_profile_screens/setting_screens/deleat_account_screen.dart';

import '../logic/bindings/product_binding.dart';
import '../view/screen/categore_lists/mouth_and_teeth_list.dart';
import '../view/screen/more__all_screen/usage_policy_screen.dart';
import '../view/screen/nav_screen/userprofile_screen.dart';

class AppRoutes{


  // initilroute
static const splashScreen=Routes.splashScreen;
  //getpage

  static final routes=[
    GetPage(
        name: Routes.splashScreen,
        page: ()=>SplashScreen()),

    GetPage(
        name: Routes.loginScreen,
        page: ()=>LoginScreen()),

    GetPage(
        name: Routes.signUpScreen,
        page: ()=>SignUpScreen()),

    GetPage(
        name: Routes.onBoardingScreen,
        page: ()=>OnBoardingScreen()),

    GetPage(
        name: Routes.forgetPassword,
        page: ()=>ForgetPasswordScreen()),

    GetPage(
        name: Routes.verificationScreen,
        page: ()=>VerificationScreen()),

    GetPage(
        name: Routes.successfulResetPassword,
        page: ()=>SuccessfulResetPassword()),

    GetPage(
        name: Routes.changePassword,
        page: ()=>ChangePassword()),

    GetPage(
        name: Routes.mainScreen,
        page: ()=>MainScreen(),
    bindings: [
      ProductBinding(),
    ]
    ),

    GetPage(
        name: Routes.homeScreen,
        page: ()=>HomeScreen()),

    GetPage(
        name: Routes.cartScreen,
        page: ()=>CartScreen()),

    GetPage(
        name: Routes.messageScreen,
        page: ()=>MessageScreen()),

    GetPage(
        name: Routes.moreScreen,
        page: ()=>MoreScreen()),

    GetPage(
        name: Routes.userProfileScreen,
        page: ()=>UserProfileScreen()),

    GetPage(
        name: Routes.categoryList,
        page: ()=>CategoryList()),

    GetPage(
        name: Routes.medicineList,
        page: ()=>MedicineList()),

    GetPage(
        name: Routes.babyCareList,
        page: ()=>BabyCareList()),

    GetPage(
        name: Routes.mildToxinsList,
        page: ()=>MildToxinsList()),


    GetPage(
        name: Routes.mouthAndTeethList,
        page: ()=>MouthAndTeethList()),


    GetPage(
        name: Routes.nutritionalSupplementsList,
        page: ()=>NutritionalSupplementsList()),


    GetPage(
        name: Routes.severeToxinsList,
        page: ()=>SevereToxinsList()),

    GetPage(
        name: Routes.skinCareList,
        page: ()=>SkinCareList()),

    GetPage(
        name: Routes.favoritesScreen,
        page: ()=>FavoritesScreen()),


    GetPage(
        name: Routes.aboutAusScreen,
        page: ()=>AboutAusScreen()),

    GetPage(
        name: Routes.privacyAndPolicyScreen,
        page: ()=>PrivacyAndPolicyScreen()),

    GetPage(
        name: Routes.usagePolicyScreen,
        page: ()=>UsagePolicyScreen()),

    GetPage(
        name: Routes.discountsScreen,
        page: ()=>DiscountsScreen()),

    GetPage(
        name: Routes.newLoginScreen,
        page: ()=>NewLoginScreen()),

    GetPage(
        name: Routes.newSignUpScreen,
        page: ()=>NewSignUpScreen()),

    GetPage(
        name: Routes.typeLoginScreen,
        page: ()=>TypeLoginScreen()),

    GetPage(
        name: Routes.newHomeScreen,
        page: ()=>NewHomeScreen()),

    GetPage(
        name: Routes.settingScreen,
        page: ()=>SettingScreen()),

    GetPage(
        name: Routes.addAccountScreen,
        page: ()=>AddAccountScreen()),

    GetPage(
        name: Routes.changePasswordFromSetting,
        page: ()=>ChangePasswordFromSetting()),


    GetPage(
        name: Routes.deleteAccountScreen,
        page: ()=>DeleteAccountScreen()),

    GetPage(
        name: Routes.addressScreen,
        page: ()=>AddressScreen()),

    GetPage(
        name: Routes.addAddressScreen,
        page: ()=>AddAddressScreen()),

    GetPage(
        name: Routes.ordersScreen,
        page: ()=>OrdersScreen()),

    GetPage(
        name: Routes.accountInfoScreen,
        page: ()=>AccountInfoScreen()),

    GetPage(
        name: Routes.notificationScreen,
        page: ()=>NotificationScreen()),

  ];
}

class Routes{
  static const splashScreen='/splashScreen';
  static const loginScreen='/loginScreen';
  static const signUpScreen='/signUpScreen';
  static const onBoardingScreen='/onBoardingScreen';
  static const forgetPassword='/forgetPassword';
  static const verificationScreen='/verificationScreen';
  static const successfulResetPassword='/successfulResetPassword';
  static const changePassword='/changePassword';
  static const mainScreen='/mainScreen';
  static const homeScreen='/homeScreen';
  static const cartScreen='/cartScreen';
  static const messageScreen='/messageScreen';
  static const userProfileScreen='/userProfileScreen';
  static const moreScreen='/moreScreen';
  static const categoryList='/categoryList';
  static const medicineList='/medicineList';
  static const babyCareList='/babyCareList';
  static const mildToxinsList='/mildToxinsList';
  static const mouthAndTeethList='/mouthAndTeethList';
  static const nutritionalSupplementsList='/nutritionalSupplementsList';
  static const severeToxinsList='/severeToxinsList';
  static const skinCareList='/skinCareList';
  static const favoritesScreen='/favoritesScreen';
  static const aboutAusScreen='/aboutAusScreen';
  static const privacyAndPolicyScreen='/privacyAndPolicyScreen';
  static const usagePolicyScreen='/usagePolicyScreen';
  static const discountsScreen='/discountsScreen';
  static const newLoginScreen='/newLoginScreen';
  static const newSignUpScreen='/newSignUpScreen';
  static const typeLoginScreen='/typeLoginScreen';
  static const newHomeScreen='/newHomeScreen';
  static const settingScreen='/settingScreen';
  static const addAccountScreen='/addAccountScreen';
  static const changePasswordFromSetting='/changePasswordFromSetting';
  static const deleteAccountScreen='/deleteAccountScreen';
  static const addressScreen='/addressScreen';
  static const addAddressScreen='/addAddressScreen';
  static const ordersScreen='/ordersScreen';
  static const accountInfoScreen='/accountInfoScreen';
  static const notificationScreen='/notificationScreen';
}