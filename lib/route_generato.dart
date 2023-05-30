import 'package:astronomy_picture/presentation/pages/core/about_app.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/presentation/pages/fetch_apod/apod_list_page.dart';
import 'package:astronomy_picture/presentation/pages/bookmark_apod/bookmark_apod_page.dart';
import 'package:astronomy_picture/presentation/pages/today_apod/apod_today_page.dart';
import 'package:astronomy_picture/presentation/pages/core/apod_view_page.dart';
import 'package:flutter/material.dart';

class RouteGenerato {
  Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: _mapRouteName(settings.name, settings.arguments));
  }

  Widget Function(BuildContext) _mapRouteName(String? name, Object? args) {
    switch (name) {
      case '/':
        return (_) => const FetchApodPage();
      case '/apodView':
        if (args is Apod) {
          return (_) => ApodViewPage(apod: args);
        } else {
          return (_) => _errorPage();
        }
      case '/apodToday':
        return (_) => const ApodTodayPage();
      case '/aboutApp':
        return (_) => const AboutAppPage();
      case '/apodSave':
        return (_) => const BookmarkApodPage();
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
