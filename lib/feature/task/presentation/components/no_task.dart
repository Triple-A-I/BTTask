import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_strings.dart';

Widget noTasksWidget(BuildContext context) {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        children: [
          // Display the no tasks image
          Image.asset(
            AppAssets.noTasks,
            height: 250.h, // Adjust the height if needed to fit your layout
          ),
          SizedBox(height: 16.h), // Add some spacing

          // Display the "No Tasks" title
          Text(
            AppStrings.noTaskTitle,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 12.sp,
                ),
            textAlign: TextAlign.center, // Center the text
          ),

          SizedBox(height: 8.h), // Add some spacing

          // Display the "No Tasks" subtitle
          Text(
            AppStrings.noTaskSubTitle,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 10.sp,
                ),
            textAlign: TextAlign.center, // Center the text
          ),
        ],
      ),
    ),
  );
}
