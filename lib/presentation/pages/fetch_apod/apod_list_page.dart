import 'package:astronomy_picture/container_injection.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/presentation/bloc/fetch_apod/fetch_apod_bloc.dart';
import 'package:astronomy_picture/presentation/pages/search/apod_seach_page.dart';
import 'package:astronomy_picture/presentation/widgets/apod_drawer.dart';
import 'package:astronomy_picture/presentation/widgets/apod_tile.dart';
import 'package:astronomy_picture/presentation/widgets/error_apod_widget.dart';
import 'package:flutter/material.dart';

class FetchApodPage extends StatefulWidget {
  const FetchApodPage({super.key});

  @override
  State<FetchApodPage> createState() => _FetchApodPageState();
}

class _FetchApodPageState extends State<FetchApodPage> {
  final ScrollController _controller = ScrollController();
  late FetchApodBloc _apodBloc;
  List<Apod> apodList = [];

  @override
  void initState() {
    _apodBloc = getIt<FetchApodBloc>();
    _apodBloc.input.add(MakeFetchApodEvent());
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        _apodBloc.input.add(MakeFetchApodEvent());
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
        FetchApodState? state = snapshot.data;
        Widget child = const CircularProgressIndicator();

        if (state is SuccessListFetchApod) {
          apodList.addAll(state.list);
        }

        if (state is ErrorFetchApodState) {
          child = ErrorApodWidget(
            msg: state.msg,
            onRetry: () {
              apodList.clear();
              _apodBloc.input.add(MakeFetchApodEvent());
            },
          );
        }

        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: SeachPage());
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          drawer: const ApodDrawer(),
          body: RefreshIndicator(
            onRefresh: () async {
              apodList.clear();
              _apodBloc.input.add(MakeFetchApodEvent());
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
                      },
                    ),
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
            currentIndex: 1,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark), label: 'Bookmark'),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.today), label: 'Picture of the day'),
            ],
            onTap: (value) {
              if (value == 0) {
                Navigator.pushNamed(context, '/apodSave');
              }

              if (value == 2) {
                Navigator.pushNamed(context, '/apodToday');
              }
            },
          ),
        );
      },
    );
  }
}
