import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../data/model/task_model.dart';
import '../cubit/task_cubit.dart';

class TaskComponent extends StatelessWidget {
  const TaskComponent({
    super.key,
    required this.taskModel,
  });

  final TaskModel taskModel;

  Color getColor(index) {
    switch (index) {
      case 0:
        return AppColors.red;
      case 1:
        return AppColors.green;
      case 2:
        return AppColors.blueGrey;
      case 3:
        return AppColors.blue;
      case 4:
        return AppColors.orange;
      case 5:
        return AppColors.purple;
      default:
        return AppColors.grey;
    }
  }

  void shareTask(BuildContext context, TaskModel taskModel) {
    final taskDetails = '''
Task: ${taskModel.title}
Note: ${taskModel.note}
Time: ${taskModel.startTime} - ${taskModel.endTime}
Date: ${taskModel.date}
''';
    Share.share(taskDetails, subject: 'Check out this task!');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(24),
              height: 240.h,
              color: AppColors.deepGrey,
              child: Column(
                children: [
                  taskModel.isCompleted == 1
                      ? Container()
                      : SizedBox(
                          height: 32.h,
                          width: double.infinity,
                          child: CustomButton(
                            text: AppStrings.taskCompleted,
                            onPressed: () {
                              BlocProvider.of<TaskCubit>(context)
                                  .updateTask(taskModel.id);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    height: 32.h,
                    width: double.infinity,
                    child: CustomButton(
                      text: 'Share Task',
                      backgroundColor: AppColors.blue,
                      onPressed: () {
                        shareTask(context, taskModel);
                      },
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    height: 32.h,
                    width: double.infinity,
                    child: CustomButton(
                      text: AppStrings.deleteTask,
                      backgroundColor: AppColors.red,
                      onPressed: () {
                        BlocProvider.of<TaskCubit>(context)
                            .deleteTask(taskModel.id);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    height: 32.h,
                    width: double.infinity,
                    child: CustomButton(
                      text: AppStrings.cancel,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        height: 132.h,
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
          color: getColor(taskModel.color),
          borderRadius: BorderRadius.circular(16),
        ),
        margin: EdgeInsets.only(bottom: 16.sp),
        child: Row(
          children: [
            // Task details (wrapped with Flexible to prevent overflow)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title with Flexible widget
                  Flexible(
                    child: Text(
                      taskModel.title,
                      style: Theme.of(context).textTheme.displayMedium,
                      overflow: TextOverflow.ellipsis, // Prevents overflow
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // Row for time
                  Row(
                    children: [
                      const Icon(
                        Icons.timer,
                        color: AppColors.white,
                      ),
                      SizedBox(width: 8.w),
                      Flexible(
                        child: Text(
                          '${taskModel.startTime} - ${taskModel.endTime}',
                          style: Theme.of(context).textTheme.displayMedium,
                          overflow: TextOverflow.ellipsis, // Prevents overflow
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),

                  // Note
                  Flexible(
                    child: Text(
                      taskModel.note,
                      style: Theme.of(context).textTheme.displayMedium,
                      overflow: TextOverflow.ellipsis, // Prevents overflow
                    ),
                  ),
                ],
              ),
            ),

            // Divider line
            Container(
              height: 75.h,
              width: 1,
              color: Colors.white,
              margin: const EdgeInsets.only(right: 10),
            ),

            // Rotated status text
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                taskModel.isCompleted == 1
                    ? AppStrings.completed.toUpperCase()
                    : AppStrings.toDo,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: AppColors.white, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
