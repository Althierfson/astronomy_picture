import 'package:flutter/material.dart';

class ApodDrawer extends StatelessWidget {
  const ApodDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(child: Image.asset("assets/icon.png")),
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/aboutApp');
            },
            label: const Text("About APP"),
            icon: const Icon(Icons.info_outline),
          )
        ],
      ),
    );
  }
}
