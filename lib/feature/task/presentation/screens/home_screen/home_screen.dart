import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/commons/commons.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../components/date_picker.dart';
import '../../components/header.dart';
import '../../components/search_field.dart';
import '../../components/task_list.dart';
import '../../cubit/task_cubit.dart';
import '../../cubit/task_state.dart';
import '../add_task_screen/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            // Define breakpoints for mobile, tablet, and desktop
            if (constraints.maxWidth < 600) {
              // Mobile layout
              return _buildMobileLayout(context);
            } else if (constraints.maxWidth >= 600 &&
                constraints.maxWidth < 1024) {
              // Tablet layout
              return _buildTabletLayout(context);
            } else {
              // Desktop layout
              return _buildDesktopLayout(context);
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigate(context: context, screen: const AddTaskScreen());
          },
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  // Mobile layout
  Widget _buildMobileLayout(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.sp), // Scaled padding for mobile
      child: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(context),
              SizedBox(height: 12.h),
              buildSearchField(context),
              SizedBox(height: 12.h),
              buildDatePicker(context),
              SizedBox(height: 16.h),
              buildTaskList(context),
            ],
          );
        },
      ),
    );
  }

  // Tablet layout
  Widget _buildTabletLayout(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 10.sp), // Adjust padding for tablet
      child: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(context),
              SizedBox(height: 20.h),
              buildSearchField(context),
              SizedBox(height: 20.h),
              buildDatePicker(context),
              SizedBox(height: 24.h),
              buildTaskList(context),
            ],
          );
        },
      ),
    );
  }

  // Desktop layout
  Widget _buildDesktopLayout(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.sp), // Larger padding for desktop
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader(context),
                SizedBox(height: 20.h),
                buildSearchField(context),
                SizedBox(height: 20.h),
                Expanded(child: buildDatePicker(context)),
              ],
            ),
          ),
          SizedBox(width: 48.w), // Space between columns
          Expanded(
            child: buildTaskList(context),
          ),
        ],
      ),
    );
  }
}
