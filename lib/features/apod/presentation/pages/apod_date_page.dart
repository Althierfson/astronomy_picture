import 'package:astronomy_picture/container_injection.dart';
import 'package:astronomy_picture/features/apod/presentation/bloc/apod_bloc.dart';
import 'package:astronomy_picture/features/apod/presentation/widgets/error_apod_widget.dart';
import 'package:astronomy_picture/features/apod/presentation/widgets/show_apod.dart';
import 'package:flutter/material.dart';

class ApodDatePage extends StatefulWidget {
  const ApodDatePage({super.key});

  @override
  State<ApodDatePage> createState() => _ApodDatePageState();
}

class _ApodDatePageState extends State<ApodDatePage> {
  late ApodBloc _bloc;
  DateTime choosedDate = DateTime.now();

  @override
  void initState() {
    _bloc = getIt<ApodBloc>();
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
          body = ShowApod(
            apod: state.apod,
          );
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
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: double.infinity,
                  height: 70,
                  child: ElevatedButton(
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: choosedDate,
                                firstDate: DateTime.now()
                                    .subtract(const Duration(days: 3650)),
                                lastDate: DateTime.now())
                            .then((value) {
                          if (value != null) {
                            choosedDate = value;
                            _bloc.input.add(GetApodFromDateEvent(date: value));
                          }
                        });
                      },
                      child: const Text("Choose a date")),
                ),
                body
              ],
            ),
          ),
        );
      },
    );
  }
}
