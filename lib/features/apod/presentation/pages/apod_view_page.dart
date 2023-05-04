import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';
import 'package:astronomy_picture/features/apod/presentation/widgets/show_apod.dart';
import 'package:flutter/material.dart';

class ApodViewPage extends StatelessWidget {
  final Apod apod;
  const ApodViewPage({super.key, required this.apod});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(child: ShowApod(apod: apod)));
  }
}
