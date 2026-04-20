import 'package:flutter/cupertino.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static CupertinoThemeData get darkTheme {
    return const CupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      barBackgroundColor: AppColors.background,
      textTheme: CupertinoTextThemeData(
        navTitleTextStyle: AppTextStyles.headlineMedium,
        textStyle: AppTextStyles.bodyLarge,
      ),
    );
  }

  static CupertinoThemeData get lightTheme {
    return CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      barBackgroundColor: AppColors.background,
      textTheme: CupertinoTextThemeData(
        navTitleTextStyle: TextStyle(
          fontFamily: AppTextStyles.fontFamilySyne,
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: CupertinoColors.white,
        ),
        textStyle: TextStyle(
          fontFamily: AppTextStyles.fontFamilyDMSans,
          fontSize: 16,
          color: CupertinoColors.white,
        ),
      ),
    );
  }
}
