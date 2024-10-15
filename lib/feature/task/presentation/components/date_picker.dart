import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../cubit/task_cubit.dart';

Widget buildDatePicker(BuildContext context) {
  return DatePicker(
    DateTime.now(),
    initialSelectedDate: DateTime.now(),
    selectionColor: AppColors.primary,
    selectedTextColor: AppColors.white,
    dateTextStyle: Theme.of(context).textTheme.displayMedium!,
    dayTextStyle: Theme.of(context).textTheme.displayMedium!,
    monthTextStyle: Theme.of(context).textTheme.displayMedium!,
    onDateChange: (date) {
      BlocProvider.of<TaskCubit>(context).getSelectedDate(date);
    },
  );
}
