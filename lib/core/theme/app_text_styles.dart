import 'package:flutter/cupertino.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const String fontFamilySyne = 'Syne';
  static const String fontFamilyDMSans = 'DMSans';

  // Syne fallback to SF Pro with heavy weight
  static const TextStyle headline = TextStyle(
    fontFamily: fontFamilySyne,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle subheadline = TextStyle(
    fontFamily: fontFamilyDMSans,
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamilyDMSans,
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.1,
    color: AppColors.textMuted,
  );

  static const TextStyle body = TextStyle(
    fontFamily: fontFamilyDMSans,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static const TextStyle audiowide = TextStyle(
    fontFamily: 'Audiowide',
    fontSize: 20,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamilySyne,
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamilyDMSans,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
}
