import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_bottom_app_bar.dart';

class AboutDeveloperView extends StatelessWidget {
  const AboutDeveloperView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Column(),
        centerTitle: true,
        title: const Text('About the Developer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/images/about_developer.jpeg'),
            ),
            const SizedBox(height: 24),
            Text(
              'Malek',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber[900],
                  fontFamily: "Roboto"),
            ),
            const SizedBox(height: 8),
            Text(
              'Programmer & UX/UI Designer',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'I\'m Malek from Egypt. I\'m a programmer and UX/UI designer. I love combining code and colors. This is my first app (Eye of Ra).',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, color: Colors.amber[800]),
                const SizedBox(width: 8),
                Text(
                  'Egypt',
                  style: TextStyle(
                    color: Colors.amber[800],
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomAppBar(
        currentTab: BottomBarEnum.Profile,
        onChanged: (type) {
          try {
            String route = getCurrentRoute(type);
            Get.toNamed(route, arguments: {});
          } catch (e) {
            print('Navigation error: $e');
          }
        },
      ),
    );
  }

  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homePage;
      case BottomBarEnum.Profile:
        return AppRoutes.aboutDeveloperView;
      default:
        return "/"; // Default route for debugging
    }
  }
}
