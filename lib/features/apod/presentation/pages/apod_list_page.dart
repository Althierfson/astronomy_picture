import 'package:astronomy_picture/container_injection.dart';
import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';
import 'package:astronomy_picture/features/apod/presentation/bloc/apod_bloc.dart';
import 'package:astronomy_picture/features/apod/presentation/pages/apod_seach_page.dart';
import 'package:astronomy_picture/features/apod/presentation/widgets/apod_drawer.dart';
import 'package:astronomy_picture/features/apod/presentation/widgets/apod_tile.dart';
import 'package:flutter/material.dart';

class ApodListPage extends StatefulWidget {
  const ApodListPage({super.key});

  @override
  State<ApodListPage> createState() => _ApodListPageState();
}

class _ApodListPageState extends State<ApodListPage> {
  final ScrollController _controller = ScrollController();
  late ApodBloc _apodBloc;
  List<Apod> apodList = [];

  @override
  void initState() {
    _apodBloc = getIt<ApodBloc>();
    _apodBloc.input.add(FetchApodEvent());
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        _apodBloc.input.add(FetchApodEvent());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _apodBloc.input.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _apodBloc.stream,
      builder: (context, snapshot) {
        ApodState? state = snapshot.data;
        Widget child = const CircularProgressIndicator();

        if (state is SuccessListApodState) {
          apodList.addAll(state.list);
        }

        if (state is ErrorApodState) {
          child = Text(state.msg);
        }

        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: ApodSeachPage());
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          drawer: const ApodDrawer(),
          body: RefreshIndicator(
            onRefresh: () async {
              apodList.clear();
              _apodBloc.input.add(FetchApodEvent());
            },
            child: ListView.builder(
              controller: _controller,
              itemCount: apodList.length + 1,
              itemBuilder: (context, index) {
                if (index < apodList.length) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ApodTile(
                        apod: apodList[index],
                        onTap: () {
                          Navigator.pushNamed(context, '/apodView',
                              arguments: apodList[index]);
                        }),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Center(
                      child: child,
                    ),
                  );
                }
              },
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.today), label: 'Picture of the day'),
            ],
            onTap: (value) {
              if (value == 1) {
                Navigator.pushNamed(context, '/apodToday');
              }

              if (value == 2) {
                Navigator.pushNamed(context, '/apodDate');
              }
            },
          ),
        );
      },
    );
  }
}
