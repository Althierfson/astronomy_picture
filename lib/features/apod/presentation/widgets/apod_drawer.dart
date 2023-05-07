import 'package:astronomy_picture/theme.dart';
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
          DrawerHeader(
              child: Center(
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: PersonalTheme.white))),
                      child: Image.asset("assets/icon.png")))),
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/aboutApp');
            },
            label: Text(
              "About APP",
              style: TextStyle(color: PersonalTheme.white),
            ),
            icon: Icon(
              Icons.info_outline,
              color: PersonalTheme.white,
            ),
          )
        ],
      ),
    );
  }
}
