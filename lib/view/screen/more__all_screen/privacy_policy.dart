import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medicen_app/utils/theme.dart';

import '../../../routes/routes.dart';
import '../../../services/json_file/all_categries.dart';

class PrivacyAndPolicyScreen extends StatefulWidget {
  const PrivacyAndPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyAndPolicyScreen> createState() => _PrivacyAndPolicyScreenState();
}

class _PrivacyAndPolicyScreenState extends State<PrivacyAndPolicyScreen> {
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
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: mainColor2,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.black,
                size: 20,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text(
              "Privacy Policy",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Privacy Policy",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "This Privacy Policy governs the manner in which [Your App/Company Name] collects, uses, maintains, and discloses information collected from users (each, a \"User\") of the [Your App] mobile application (\"App\"). This privacy policy applies to the App and all products and services offered by [Your App/Company Name].",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Personal Identification Information",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  "We may collect personal identification information from Users in various ways, including, but not limited to, when Users visit our App, register on the App, place an order, fill out a form, and in connection with other activities, services, features, or resources we make available on our App. Users may be asked for, as appropriate, name, email address, mailing address, phone number. Users may, however, visit our App anonymously. We will collect personal identification information from Users only if they voluntarily submit such information to us. Users can always refuse to supply personally identification information, except that it may prevent them from engaging in certain App-related activities.",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Non-Personal Identification Information",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  "We may collect non-personal identification information about Users whenever they interact with our App. Non-personal identification information may include the browser name, the type of computer, and technical information about Users' means of connection to our App, such as the operating system and the Internet service providers utilized and other similar information.",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "How We Use Collected Information",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  "We may collect and use Users' personal information for the following purposes:\n\n"
                  "• To improve customer service: Information you provide helps us respond to your customer service requests and support needs more efficiently.\n"
                  "• To personalize user experience: We may use information in the aggregate to understand how our Users as a group use the services and resources provided on our App.\n"
                  "• To improve our App: We may use feedback you provide to improve our products and services.\n"
                  "• To process payments: We may use the information Users provide about themselves when placing an order only to provide service to that order. We do not share this information with outside parties except to the extent necessary to provide the service.\n"
                  "• To send periodic emails: We may use the email address to send User information and updates pertaining to their order. It may also be used to respond to their inquiries, questions, and/or other requests. If User decides to opt-in to our mailing list, they will receive emails that may include company news, updates, related product or service information, etc. If at any time the User would like to unsubscribe from receiving future emails, we include detailed unsubscribe instructions at the bottom of each email.",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                // Add more sections of your privacy policy as needed.
              ],
            ),
          ),
        ),
      ),
    );
  }
}
