import 'package:astronomy_picture/container_injection.dart';
import 'package:astronomy_picture/features/apod/presentation/bloc/apod_bloc.dart';
import 'package:astronomy_picture/features/apod/presentation/widgets/apod_button.dart';
import 'package:astronomy_picture/features/apod/presentation/widgets/error_apod_widget.dart';
import 'package:astronomy_picture/features/apod/presentation/widgets/show_apod.dart';
import 'package:flutter/material.dart';

class ApodPage extends StatefulWidget {
  const ApodPage({super.key});

  @override
  State<ApodPage> createState() => _ApodPageState();
}

class _ApodPageState extends State<ApodPage> {
  late ApodBloc _bloc;

  @override
  void initState() {
    _bloc = getIt<ApodBloc>();
    _bloc.input.add(GetTodayApodEvent());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.input.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ApodButton(
                      text: "Today",
                      onPressed: () {
                        _bloc.input.add(GetTodayApodEvent());
                      }),
                  ApodButton(
                      text: "Choose a day",
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now()
                                    .subtract(const Duration(days: 3650)),
                                lastDate: DateTime.now())
                            .then((value) => value == null
                                ? () {}
                                : _bloc.input
                                    .add(GetApodFromDateEvent(date: value)));
                        // DateTime(2022, 12, 4)
                      }),
                  ApodButton(
                      text: "Random",
                      onPressed: () {
                        _bloc.input.add(GetRandomApodEvent());
                      }),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              StreamBuilder<ApodState>(
                stream: _bloc.stream,
                builder: (context, snapshot) {
                  ApodState? state = snapshot.data;
                  if (state is SuccessApodState) {
                    return ShowApod(
                      apod: state.apod,
                    );
                  }

                  if (state is LoadingApodState) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ErrorApodState) {
                    return ErrorApodWidget(
                      msg: state.msg,
                    );
                  }

                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
