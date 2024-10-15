import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/task_cubit.dart';

Widget buildSearchField(BuildContext context) {
  return TextField(
    decoration: InputDecoration(
      hintText: 'Search tasks...',
      prefixIcon: const Icon(Icons.search),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    onChanged: (query) {
      if (query.isNotEmpty) {
        BlocProvider.of<TaskCubit>(context).searchTasks(query);
      } else {
        BlocProvider.of<TaskCubit>(context)
            .getTasks(); // Show all tasks if search is cleared
      }
    },
  );
}
