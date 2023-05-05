import 'package:astronomy_picture/container_injection.dart';
import 'package:astronomy_picture/features/apod/presentation/bloc/apod_bloc.dart';
import 'package:astronomy_picture/features/apod/presentation/pages/apod_view_page.dart';
import 'package:astronomy_picture/features/apod/presentation/widgets/error_apod_widget.dart';
import 'package:astronomy_picture/features/apod/presentation/widgets/show_apod.dart';
import 'package:flutter/material.dart';

class ApodTodayPage extends StatefulWidget {
  const ApodTodayPage({super.key});

  @override
  State<ApodTodayPage> createState() => _ApodTodayPageState();
}

class _ApodTodayPageState extends State<ApodTodayPage> {
  late ApodBloc _bloc;

  @override
  void initState() {
    _bloc = getIt<ApodBloc>();
    _bloc.input.add(GetTodayApodEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApodState>(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        ApodState? state = snapshot.data;
        Widget body = Container();
        if (state is SuccessApodState) {
          return ApodViewPage(apod: state.apod);
        }

        if (state is LoadingApodState) {
          body = const Center(child: CircularProgressIndicator());
        }

        if (state is ErrorApodState) {
          body = ErrorApodWidget(
            msg: state.msg,
          );
        }

        return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: body,
            ));
      },
    );
  }
}
