import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/commons/commons.dart';
import '../../../../../core/database/cache/cache_helper.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_button.dart';
import '../../../../task/presentation/screens/home_screen/home_screen.dart';
import '../../../data/model/on_boarding_model.dart';

class OnBoaringScreens extends StatelessWidget {
  OnBoaringScreens({super.key});

  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    // Define breakpoints
    double screenWidth = MediaQuery.of(context).size.width;

    // Small screens (e.g. phones)
    bool isSmallScreen = screenWidth < 600;

    // Large screens (e.g. tablets)
    bool isLargeScreen = screenWidth >= 600;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24), // Fixed padding or scaled
          child: PageView.builder(
            controller: controller,
            itemCount: OnBoardingModel.onBoardingScreens.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  // Skip text (aligns to the left only on smaller screens)
                  index != 2
                      ? Align(
                          alignment: isSmallScreen
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: CustomTextButton(
                            text: AppStrings.skip,
                            onPressed: () {
                              controller.jumpToPage(2);
                            },
                          ),
                        )
                      : SizedBox(
                          height: 50.h, // Fixed height for spacing
                        ),
                  SizedBox(
                    height: 16.h, // Fixed spacing
                  ),

                  // Image (adjust size based on screen size)
                  Image.asset(
                    OnBoardingModel.onBoardingScreens[index].imgPath,
                    height: isLargeScreen
                        ? 400.h
                        : 300.h, // Larger image for tablets
                    width: isLargeScreen
                        ? 400.h
                        : 300.w, // Larger image for tablets
                  ),
                  SizedBox(
                    height: 16.h, // Fixed spacing
                  ),

                  // SmoothPageIndicator (universal for all screen sizes)
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: AppColors.primary,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 8,
                    ),
                  ),
                  SizedBox(
                    height: 52.h, // Fixed spacing
                  ),

                  // Title (adjust font size based on screen size)
                  Text(
                    OnBoardingModel.onBoardingScreens[index].title,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: isLargeScreen
                              ? 32
                              : 24, // Larger font for tablets
                        ),
                  ),

                  // Subtitle (adjust font size based on screen size)
                  Text(
                    OnBoardingModel.onBoardingScreens[index].subTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: isLargeScreen
                              ? 22
                              : 18, // Larger font for tablets
                        ),
                  ),
                  const Spacer(),

                  // Buttons
                  Row(
                    children: [
                      // Back button (visible only if not on the first page)
                      index != 0
                          ? CustomTextButton(
                              text: AppStrings.back,
                              onPressed: () {
                                controller.previousPage(
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                );
                              },
                            )
                          : Container(),
                      const Spacer(),

                      // Next or Get Started button
                      index != 2
                          ? CustomButton(
                              text: AppStrings.next,
                              onPressed: () {
                                controller.nextPage(
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                );
                              },
                            )
                          : CustomButton(
                              text: AppStrings.getStarted,
                              onPressed: () async {
                                // Save onboarding status and navigate to home
                                await sl<CacheHelper>()
                                    .saveData(
                                        key: AppStrings.onBoardingKey,
                                        value: true)
                                    .then((value) {
                                  print('onBoarding is Visited');
                                  navigate(
                                      context: context,
                                      screen: const HomeScreen());
                                }).catchError((e) {
                                  print(e.toString());
                                });
                              },
                            ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
