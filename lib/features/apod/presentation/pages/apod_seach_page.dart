import 'package:astronomy_picture/container_injection.dart';
import 'package:astronomy_picture/features/apod/presentation/bloc/apod_bloc.dart';
import 'package:astronomy_picture/features/apod/presentation/widgets/apod_tile.dart';
import 'package:astronomy_picture/theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ApodSeachPage extends SearchDelegate {
  PickerDateRange choosedDate = PickerDateRange(DateTime.now(), DateTime.now());
  late ApodBloc _apodBloc;

  ApodSeachPage() {
    _apodBloc = getIt<ApodBloc>();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        textTheme: TextTheme(titleLarge: TextStyle(color: PersonalTheme.white)),
        appBarTheme: AppBarTheme(backgroundColor: PersonalTheme.spaceBlue));
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
                              "${dateRange.startDate.toString().substring(0, 10)}/${dateRange.endDate.toString().substring(0, 10)}";
                        } else {
                          query =
                              dateRange.startDate.toString().substring(0, 10);
                        }
                      }
                      Navigator.pop(context);
                      buildResults(context);
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
    _apodBloc.input.add(FetchApodEvent());
    return Container(
      color: PersonalTheme.black,
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

          if (state is SuccessListApodState) {
            final list = state.list;
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) =>
                  ApodTile(apod: list[index], onTap: () {}),
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
      color: PersonalTheme.black,
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
