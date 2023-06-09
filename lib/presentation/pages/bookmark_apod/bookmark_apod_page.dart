import 'package:astronomy_picture/container_injection.dart';
import 'package:astronomy_picture/presentation/bloc/bookmark_apod/bookmark_apod_bloc.dart';
import 'package:astronomy_picture/core/date_convert.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/presentation/pages/search/apod_seach_page.dart';
import 'package:astronomy_picture/presentation/widgets/apod_tile.dart';
import 'package:astronomy_picture/presentation/widgets/error_apod_widget.dart';
import 'package:astronomy_picture/theme.dart';
import 'package:flutter/material.dart';

class BookmarkApodPage extends StatefulWidget {
  const BookmarkApodPage({super.key});

  @override
  State<BookmarkApodPage> createState() => _BookmarkApodPageState();
}

class _BookmarkApodPageState extends State<BookmarkApodPage> {
  late BookmarkApodBloc _apodBloc;
  List<Apod> _list = [];
  Apod? _cacheApod;

  @override
  void initState() {
    _apodBloc = getIt<BookmarkApodBloc>();
    _apodBloc.input.add(GetAllSaveBookmarkApodEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: StreamBuilder(
          stream: _apodBloc.stream,
          builder: (context, snapshot) {
            var state = snapshot.data;

            if (state is LoadingBookmarkApodState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ErrorBookmarkApodState) {
              return Center(
                child: ErrorApodWidget(msg: state.msg),
              );
            }

            if (state is SuccessListBookmarkApodState) {
              _list = state.list;
            }

            if (_list.isEmpty) {
              return Center(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info,
                        color: PersonalTheme.white,
                        size: 100,
                      ),
                      Text(
                        "You not save any content yet",
                        style: TextStyle(color: PersonalTheme.white),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: _list.length,
                itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Dismissible(
                        key: Key(_list[index].date.toString()),
                        onDismissed: (direction) {
                          _cacheApod = _list.removeAt(index);
                          setState(() {
                            showSnackBar("Content removed", index);
                          });
                        },
                        child: ApodTile(
                          apod: _list[index],
                          onTap: () {
                            Navigator.pushNamed(context, '/apodView',
                                    arguments: _list[index])
                                .then((_) {
                              _apodBloc.input
                                  .add(GetAllSaveBookmarkApodEvent());
                            });
                          },
                        ))),
              );
            }
          }),
    );
  }

  void showSnackBar(String msg, int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: PersonalTheme.black,
        content: Text(msg),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _list.insert(index, _cacheApod!);
              });
            }),
        duration: const Duration(seconds: 6),
        onVisible: () {
          Future.delayed(const Duration(seconds: 7), () {
            if (!_list.contains(_cacheApod)) {
              _apodBloc.input.add(RemoveSaveBookmarkApodEvent(
                  date: DateConvert.dateToString(_cacheApod!.date)));
            }
          });
        },
      ));
    });
  }
}
