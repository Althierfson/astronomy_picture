import 'dart:async';

import 'package:astronomy_picture/container_injection.dart';
import 'package:astronomy_picture/presentation/bloc/search/search_bloc.dart';
import 'package:astronomy_picture/core/date_convert.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/presentation/widgets/apod_tile.dart';
import 'package:astronomy_picture/presentation/widgets/error_apod_widget.dart';
import 'package:astronomy_picture/theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SeachPage extends SearchDelegate {
  PickerDateRange choosedDate = PickerDateRange(DateTime.now(), DateTime.now());
  late SearchBloc _searchBloc;
  late SearchBloc _searchBlocHistory;
  String _cacheQuery = "";
  List<Apod> _cacheList = [];
  List<String> _searcHistory = [];
  final StreamController<SearchState> _stream = StreamController.broadcast();

  SeachPage() {
    _searchBloc = getIt<SearchBloc>();
    _searchBlocHistory = getIt<SearchBloc>();
    _searchBlocHistory.input.add(GetHistorySearchEvent());
    _searchBlocHistory.stream.listen((event) {
      if (event is SuccessHistorySearchState) {
        _searcHistory = event.list;
      }
    });
    _searchBloc.stream.listen((event) {
      _stream.add(event);
    });
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      textTheme: TextTheme(titleLarge: TextStyle(color: PersonalTheme.white)),
      appBarTheme: AppBarTheme(backgroundColor: PersonalTheme.black),
      inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: PersonalTheme.white)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: PersonalTheme.vermilion)),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return SfDateRangePicker(
                    showActionButtons: true,
                    maxDate: DateTime.now(),
                    initialSelectedRange: choosedDate,
                    selectionMode: DateRangePickerSelectionMode.range,
                    backgroundColor: PersonalTheme.black,
                    todayHighlightColor: PersonalTheme.blue,
                    headerHeight: 100,
                    headerStyle: DateRangePickerHeaderStyle(
                        textStyle: TextStyle(color: PersonalTheme.white)),
                    monthViewSettings: DateRangePickerMonthViewSettings(
                      viewHeaderStyle: DateRangePickerViewHeaderStyle(
                          textStyle: TextStyle(color: PersonalTheme.white)),
                    ),
                    monthCellStyle: DateRangePickerMonthCellStyle(
                        textStyle: TextStyle(color: PersonalTheme.white)),
                    onSubmit: (dateRange) {
                      if (dateRange is PickerDateRange) {
                        choosedDate = dateRange;
                        if (dateRange.endDate != null) {
                          query =
                              "${DateConvert.dateToString(dateRange.startDate ?? DateTime(2023))}/${DateConvert.dateToString(dateRange.endDate ?? DateTime(2023))}";
                        } else {
                          query = DateConvert.dateToString(
                              dateRange.startDate ?? DateTime(2023));
                        }
                      }
                      Navigator.pop(context);
                    },
                    onCancel: () {
                      Navigator.pop(context);
                    },
                  );
                });
          },
          icon: const Icon(Icons.calendar_month)),
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = "";
            }
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query != _cacheQuery && query.isNotEmpty) {
      _searchBloc.input.add(GetByDateRangeSearchEvent(query: query));
      _cacheQuery = query;
    }

    return Container(
      color: PersonalTheme.spaceBlue,
      child: StreamBuilder(
        stream: _stream.stream,
        builder: (context, snapshot) {
          SearchState? state = snapshot.data;

          if (state is LoadingSearchState) {
            return Center(
              child: CircularProgressIndicator(
                color: PersonalTheme.white,
              ),
            );
          }

          if (state is ErrorSearchState) {
            return Center(
              child: ErrorApodWidget(
                msg: state.msg,
                onRetry: () {
                  _searchBloc.input
                      .add(GetByDateRangeSearchEvent(query: query));
                },
              ),
            );
          }

          if (state is SuccessListSearchState) {
            if (query.isNotEmpty) {
              _searcHistory.add(query);
              _searchBlocHistory.input
                  .add(UpdateHistorySearchEvent(list: _searcHistory));
            }

            _cacheList = state.list;
          }

          if (_cacheList.isEmpty) {
            return Center(
              child: ErrorApodWidget(
                msg: "Sorry! We not find any content for this search.",
                onRetry: () {
                  _searchBloc.input
                      .add(GetByDateRangeSearchEvent(query: query));
                },
              ),
            );
          }

          return ListView.builder(
            itemCount: _cacheList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ApodTile(
                    apod: _cacheList[index],
                    onTap: () {
                      Navigator.pushNamed(context, '/apodView',
                          arguments: _cacheList[index]);
                    }),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: PersonalTheme.spaceBlue,
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: PersonalTheme.white.withOpacity(.7))),
                  child: Container(
                      padding: const EdgeInsets.all(10.0),
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Single day: YYYY-MM-DD\nRange of days: YYYY-MM-DD/YYYY-MM-DD\nOr tap the calendar icon! Is much better",
                          style: TextStyle(color: PersonalTheme.white),
                        ),
                      )),
                ),
              )
            ],
          ),
          StreamBuilder(
            stream: _stream.stream,
            builder: (context, snapshot) {
              SearchState? state = snapshot.data;

              if (state is LoadingSearchState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is ErrorSearchState) {
                return Center(
                  child: ErrorApodWidget(
                    msg: state.msg,
                  ),
                );
              }

              if (state is SuccessHistorySearchState) {
                _searcHistory = state.list;
              }

              return Expanded(
                  child: ListView.builder(
                itemCount: _searcHistory.length,
                itemBuilder: (context, index) => ListTile(
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: PersonalTheme.white,
                    ),
                    onPressed: () {
                      _searcHistory.removeAt(index);
                      _searchBloc.input
                          .add(UpdateHistorySearchEvent(list: _searcHistory));
                    },
                  ),
                  title: Text(
                    _searcHistory[index],
                    style: TextStyle(color: PersonalTheme.white),
                  ),
                  onTap: () => query = _searcHistory[index],
                ),
              ));
            },
          )
        ],
      ),
    );
  }
}
