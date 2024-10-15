import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/database/cache/cache_helper.dart';
import '../../../../core/services/service_locator.dart';
import 'theme_states.dart'; // Update with correct path

// ThemeCubit to manage theme
class ThemeCubit extends Cubit<ThemeState> {
  bool isDark = false;

  ThemeCubit() : super(GetThemeState());

  // Fetch the saved theme from local storage
  void getTheme() async {
    isDark = await sl<CacheHelper>().getData(key: 'isDark') ?? false;
    emit(GetThemeState());
  }

  // Toggle theme and save the preference
  void changeTheme() {
    isDark = !isDark;
    sl<CacheHelper>().saveData(key: 'isDark', value: isDark);
    emit(ChangeThemeState());
  }
}
