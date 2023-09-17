import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicen_app/utils/global.dart';
import 'package:medicen_app/utils/theme.dart';

import '../../../routes/routes.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Map<String, String>> onboardingData = [
    {
      'image': 'images/onboard1.png',
      'text': '''
      Welcome to the PharmaCare App!
We are glad you joined our healthy family
      ''',
    },
    {
      'image': 'images/onboard2.png',
      'text': '''
     Our app aims to make your medical life easier by providing easy and efficient management of your pharmacy.''',
    },
    {
      'image': 'images/onboard3.png',
      'text': '''Discover a range of our unique features and start experiencing premium pharmaceutical care.''',
    },
  ];

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   backgroundColor: screenColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextButton(
                onPressed: () {

                  _pageController.animateToPage(
                    onboardingData.length - 1,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,

                  );
                  sharedPreferences!.setBool("End_Boarding", true);
                  Get.toNamed(Routes.typeLoginScreen);


                },
                child: Text(
                  'Skip',

                  style: TextStyle(color: mainColor,fontSize: 16),

                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [


                      Image.asset(
                        onboardingData[index]['image']!,
                        width: 300,
                        height: 350,
                      ),
                      SizedBox(height: 20),
                      Text(
                        onboardingData[index]['text']!,

                        style: TextStyle(fontSize: 18),

                      textAlign: TextAlign.center,),

                    ],
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_currentPage == onboardingData.length - 1) {
                    // Handle "Get Started" button press
                    print("Get Started pressed");
                    sharedPreferences!.setBool("End_Boarding", true);

                    Get.toNamed(Routes.typeLoginScreen);
                  } else {
                    // Handle "Next" button press
                    _nextPage();
                  }
                },
                child: Text(
                  _currentPage == onboardingData.length - 1 ? 'Get Started' : 'Next',
                ),
                style: ElevatedButton.styleFrom(

                  primary: mainColor, // Set the button color to your desired color
                  padding: EdgeInsets.all(16), // Adjust the padding as needed
                  // Set minimum width to 200
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                    (index) => buildIndicator(index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator(int index) {
    double indicatorSize = index == _currentPage ? 30 : 8.0;
    Color indicatorColor = index == _currentPage ? mainColor : Colors.grey;

    return Container(
      width: indicatorSize,
      height: 8,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),

        color: indicatorColor,
      ),
    );
  }
}