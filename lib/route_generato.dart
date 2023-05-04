import 'package:astronomy_picture/core/pages/about_app.dart';
import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';
import 'package:astronomy_picture/features/apod/presentation/pages/apod_date_page.dart';
import 'package:astronomy_picture/features/apod/presentation/pages/apod_list_page.dart';
import 'package:astronomy_picture/features/apod/presentation/pages/apod_today_page.dart';
import 'package:astronomy_picture/features/apod/presentation/pages/apod_view_page.dart';
import 'package:flutter/material.dart';

class RouteGenerato {
  Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: _mapRouteName(settings.name, settings.arguments));
  }

  Widget Function(BuildContext) _mapRouteName(String? name, Object? args) {
    switch (name) {
      case '/':
        return (_) => const ApodListPage();
      case '/apodView':
        if (args is Apod) {
          return (_) => ApodViewPage(apod: args);
        } else {
          return (_) => _errorPage();
        }
      case '/apodToday':
        return (_) => const ApodTodayPage();
      case '/apodDate':
        return (_) => const ApodDatePage();
      case '/aboutApp':
        return (_) => const AboutAppPage();
      default:
        return (_) => _errorPage();
    }
  }

  Widget _errorPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"),
      ),
      body: const Center(
        child: Text("Error"),
      ),
    );
  }
}
