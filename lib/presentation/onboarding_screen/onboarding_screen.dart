import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hierosecret/core/app_export.dart';

import 'controller/onboarding_controller.dart';

// ... (imports and class definition)

class OnboardingScreen extends GetWidget<OnboardingController> {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if the RegisterController is not null before using it

    return SafeArea(
      child: Scaffold(
        // ... (other scaffold properties)
        body: GestureDetector(
          onTap: () async {
            // Check if the user is logged in
            final User? user = FirebaseAuth.instance.currentUser;

            if (user != null) {
              // User is logged in, fetch their Firestore document
              final String userID = user.uid;

              try {
                final userDoc = await FirebaseFirestore.instance
                    .collection('users')
                    .doc(userID)
                    .get();

                if (userDoc.exists) {
                  // Navigate to the Onboarding Home Screen with the user data
                  final String fullName = userDoc.data()?['fullName'] ?? '';

                  Get.toNamed(
                    AppRoutes.homeOnboardingScreen,
                    arguments: {
                      'fullName': fullName,
                      'userID': userID,
                    },
                  );
                } else {
                  // If the user's document does not exist, navigate to Register Screen
                  Get.toNamed(AppRoutes.registerScreen);
                }
              } catch (e) {
                // Handle errors
                print("Error fetching user data: $e");
                Get.toNamed(AppRoutes.registerScreen);
              }
            } else {
              // User is not logged in, navigate to Register Screen
              Get.toNamed(AppRoutes.registerScreen);
            }
          },
          child: Container(
            width: SizeUtils.width,
            height: SizeUtils.height,
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary,
              image: DecorationImage(
                image: AssetImage(
                  ImageConstant.imgOnboarding,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 22.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    ImageConstant.imgNounEgypt22733,
                    height: 225.v,
                    width: 200.h,
                  ),
                  SizedBox(height: 26.v),
                  Text(
                    "Eye Of Ra".toUpperCase().tr,
                    style: theme.textTheme.displayMedium,
                  ),
                  SizedBox(height: 5.v),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
