import 'package:astronomy_picture/container_injection.dart';
import 'package:astronomy_picture/core/util/date_convert.dart';
import 'package:astronomy_picture/features/apod/presentation/bloc/apod_bloc.dart';
import 'package:astronomy_picture/features/apod/presentation/widgets/apod_tile.dart';
import 'package:astronomy_picture/features/apod/presentation/widgets/error_apod_widget.dart';
import 'package:astronomy_picture/theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ApodSeachPage extends SearchDelegate {
  PickerDateRange choosedDate = PickerDateRange(DateTime.now(), DateTime.now());
  late ApodBloc _apodBloc;

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
                        buildResults(context);
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
    _apodBloc = getIt<ApodBloc>();
    _apodBloc.input.add(GetByDateRangeApodEvent(query: query));
    return Container(
      color: PersonalTheme.spaceBlue,
      child: StreamBuilder(
        stream: _apodBloc.stream,
        builder: (context, snapshot) {
          ApodState? state = snapshot.data;

          if (state is LoadingApodState) {
            return Center(
              child: CircularProgressIndicator(
                color: PersonalTheme.white,
              ),
            );
          }

          if (state is ErrorApodState) {
            return Center(
              child: ErrorApodWidget(
                msg: state.msg,
                onRetry: () {
                  _apodBloc.input.add(GetByDateRangeApodEvent(query: query));
                },
              ),
            );
          }

          if (state is SuccessListApodState) {
            final list = state.list;
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ApodTile(
                    apod: list[index],
                    onTap: () {
                      Navigator.pushNamed(context, '/apodView',
                          arguments: list[index]);
                    }),
              ),
            );
          }

          return Container();
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  border:
                      Border.all(color: PersonalTheme.white.withOpacity(.7))),
              child: Container(
                  padding: const EdgeInsets.all(10.0),
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "single day: YYYY-MM-DD\nrange of days: YYYY-MM-DD/YYYY-MM-DD\nOr tap the calendar icon! Is much better",
                      style: TextStyle(color: PersonalTheme.white),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
