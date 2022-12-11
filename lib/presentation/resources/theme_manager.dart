import 'package:flutter/material.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'color_manager.dart';
import 'values_manager.dart';

ThemeData getAppTheme() {
  return ThemeData(
    //main color
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.primary, //ripple effect color

    //cardView theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.size4,
    ),

    //appBar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.size4,
      shadowColor: ColorManager.lightPrimary,
      titleTextStyle: getRegularStyle(
        color: ColorManager.white,
        fontSize: FontSize.size16,
      ),
    ),
    //button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary,
    ),

    //elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
          color: ColorManager.white,
          fontSize: AppSize.size17,
        ),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.size16),
        ),
      ),
    ),

    //text theme
    textTheme: TextTheme(
      displayLarge: getSemiBoldStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.size16,
      ),
      headlineLarge: getSemiBoldStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.size16,
      ),
      headlineMedium: getRegularStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.size14,
      ),
      titleMedium: getMediumStyle(
        color: ColorManager.primary,
        fontSize: FontSize.size14,
      ),
      titleSmall: getRegularStyle(
        color: ColorManager.white,
        fontSize: FontSize.size16,
      ),
      bodyLarge: getRegularStyle(
        color: ColorManager.grey1,
      ),
      bodySmall: getRegularStyle(
        color: ColorManager.grey,
      ),
      bodyMedium: getRegularStyle(
        color: ColorManager.grey2,
        fontSize: FontSize.size12,
      ),
      labelSmall: getBoldStyle(
        color: ColorManager.primary,
        fontSize: FontSize.size12,
      ),
    ),

    //inputDecoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      //content padding
      contentPadding: const EdgeInsets.all(AppPadding.padding8),
      //hint style
      hintStyle: getRegularStyle(
        color: ColorManager.grey,
        fontSize: FontSize.size14,
      ),
      //label style
      labelStyle: getMediumStyle(
        color: ColorManager.grey,
        fontSize: FontSize.size14,
      ),
      //error style
      errorStyle: getRegularStyle(
        color: ColorManager.error,
      ),
      //enabled border style
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.grey,
          width: AppSize.size1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.size8),
        ),
      ),
      //focus border style
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.size1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.size8),
        ),
      ),
      //error border style
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.error,
          width: AppSize.size1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.size8),
        ),
      ),
      //focus error border style
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.size1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.size8),
        ),
      ),
    ),
  );
}
