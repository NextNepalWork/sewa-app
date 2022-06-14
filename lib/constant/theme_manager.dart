import 'package:flutter/material.dart';
import 'package:sewa_digital/constant/constants.dart';

enum SewaAppTheme {
  lightAppTheme,
  darkAppTheme,
}

final sewaThemeData = {
  SewaAppTheme.darkAppTheme: ThemeData(
      brightness: Brightness.dark,
      backgroundColor: ColorManager.grey.withOpacity(.3),
      textTheme: TextTheme(
        headline1: getSemiBoldStyle(
            color: ColorManager.white, fontSize: SewaFontSize.s16),
        headline2: getSemiBoldStyle(
            color: ColorManager.white, fontSize: SewaFontSize.s14),
        subtitle1: getMediumStyle(
            color: ColorManager.white, fontSize: SewaFontSize.s14),
        subtitle2: getMediumStyle(
            color: ColorManager.white, fontSize: SewaFontSize.s12),
        caption: getRegularStyle(color: ColorManager.grey1),
        bodyText1: getRegularStyle(color: ColorManager.grey),
      ),
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.black,
          iconTheme: IconThemeData(color: ColorManager.white),
          elevation: 0,
          shadowColor: ColorManager.primaryOpacity70,
          titleTextStyle: getRegularStyle(
            color: ColorManager.white,
            fontSize: SewaFontSize.s16,
          ).copyWith(fontWeight: FontWeight.w600)),
      cardTheme: CardTheme(
          color: ColorManager.black,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s4),
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(AppPadding.p8),
          hintStyle: getRegularStyle(color: ColorManager.grey1),
          labelStyle: getMediumStyle(color: ColorManager.white),
          errorStyle: getRegularStyle(color: ColorManager.error),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorManager.grey.withOpacity(.5),
                  width: AppSize.s1_5),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s8))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorManager.primaryBlue, width: AppSize.s1_5),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s8))),
          errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.error, width: AppSize.s1_5),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s8))),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorManager.primaryBlue, width: AppSize.s1_5),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s8))))),
  SewaAppTheme.lightAppTheme: ThemeData(
      //main colors of the app
      backgroundColor: Colors.white,
      primaryColor: ColorManager.primaryBlue,
      primaryColorLight: ColorManager.primaryOpacity70,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,
      splashColor: ColorManager.primaryOpacity70,
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: ColorManager.grey),
      //card view theme
      cardTheme: CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s4),
      appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.grey.shade100,
          iconTheme: IconThemeData(color: ColorManager.black),
          elevation: 0,
          shadowColor: ColorManager.primaryOpacity70,
          titleTextStyle: getRegularStyle(
            color: ColorManager.black,
            fontSize: SewaFontSize.s16,
          ).copyWith(fontWeight: FontWeight.w600)),
      //Button theme
      buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          disabledColor: ColorManager.grey1,
          buttonColor: ColorManager.primaryBlue,
          splashColor: ColorManager.primaryOpacity70),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getRegularStyle(color: ColorManager.white),
              primary: ColorManager.primaryBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12)))),
      //Text theme
      textTheme: TextTheme(
          headline1: getSemiBoldStyle(
              color: ColorManager.black, fontSize: SewaFontSize.s16),
          headline2: getSemiBoldStyle(
              color: ColorManager.black, fontSize: SewaFontSize.s14),
          subtitle1: getMediumStyle(
              color: ColorManager.black, fontSize: SewaFontSize.s14),
          subtitle2: getMediumStyle(
              color: ColorManager.black, fontSize: SewaFontSize.s12),
          caption: getRegularStyle(color: ColorManager.grey1),
          bodyText1: getRegularStyle(color: ColorManager.grey)),
      //input decoration theme
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(AppPadding.p8),
          hintStyle: getRegularStyle(color: ColorManager.white),
          labelStyle: getMediumStyle(color: ColorManager.darkGrey),
          errorStyle: getRegularStyle(
            color: ColorManager.error,
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.grey, width: 1),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s8))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorManager.primaryBlue, width: AppSize.s1_5),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s8))),
          errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.error, width: AppSize.s1_5),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s8))),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorManager.primaryBlue, width: AppSize.s1_5),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s8)))))
};
