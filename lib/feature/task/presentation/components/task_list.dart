import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/task_model.dart';
import '../cubit/task_cubit.dart';
import '../cubit/task_state.dart';
import 'no_task.dart';
import 'task_component.dart';

Widget buildTaskList(BuildContext context) {
  return BlocBuilder<TaskCubit, TaskState>(
    builder: (context, state) {
      if (state is SearchTasksLoadingState || state is GetDateLoadingState) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is SearchTasksEmptyState) {
        return const Center(child: Text("No tasks found for this query."));
      } else if (state is SearchTasksSuccessState) {
        return _buildTaskListView(context, state.filteredTasks);
      } else if (state is GetDateSucessState || state is TaskInitial) {
        return BlocProvider.of<TaskCubit>(context).tasksList.isEmpty
            ? noTasksWidget(context)
            : _buildTaskListView(
                context, BlocProvider.of<TaskCubit>(context).tasksList);
      } else {
        return const Center(child: Text("Something went wrong."));
      }
    },
  );
}

Widget _buildTaskListView(BuildContext context, List<TaskModel> tasks) {
  return Expanded(
    child: ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskComponent(
          taskModel: tasks[index],
        );
      },
    ),
  );
}
