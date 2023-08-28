import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../routes.dart' as route;

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.primary.withOpacity(.2),
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.black,
                    )),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('John Doe',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left),
                ),
              ],
            ),
          ),
          ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () => Navigator.of(context).pushNamed(route.landingScreen,
                  arguments: {"page": "Airtime", "title": "Buy airtime"})),
          ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Statistics'),
              onTap: () {
                Navigator.pushNamed(context, route.landingScreen);
              }),
          ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Rate Us'),
              onTap: () {}),
          ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, route.landingScreen);
              }),
          ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log out'),
              onTap: () {
                // logOutDialog(context);
              }),
        ],
      ),
    );
  }
}
