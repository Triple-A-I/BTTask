import '../cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/app_colors.dart';
import '../cubit/task_cubit.dart';

Widget buildHeader(BuildContext context) {
  return Row(
    children: [
      Text(
        DateFormat.yMMMMd().format(DateTime.now()),
        style: Theme.of(context).textTheme.displayLarge,
      ),
      const Spacer(),
      IconButton(
        onPressed: () {
          BlocProvider.of<ThemeCubit>(context).changeTheme();
        },
        icon: Icon(
          Icons.mode_night,
          color: BlocProvider.of<ThemeCubit>(context).isDark
              ? AppColors.white
              : AppColors.background,
        ),
      ),
    ],
  );
}
