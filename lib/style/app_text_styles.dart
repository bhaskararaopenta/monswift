import 'package:flutter/material.dart';
import '../colors/AppColors.dart';
import 'package:flutter/cupertino.dart';

class AppTextStyles {
  static TextStyle loginTxt = TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark);

  static TextStyle signupText = TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textWhite);

  static TextStyle disableContinueBtnTxt = TextStyle(
      color: AppColors.greyColor,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter-SemiBold',
      fontSize: 18);
  static TextStyle enableContinueBtnTxt = TextStyle(
      color: AppColors.textWhite,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter-SemiBold',
      fontSize: 18);

  static TextStyle navText = TextStyle(
      fontSize: 12, fontWeight: FontWeight.normal, color: AppColors.textWhite);

  static TextStyle searchHintText = TextStyle(
      fontSize: 18, fontWeight: FontWeight.normal, color: AppColors.textDark);

  static TextStyle outlineText = TextStyle(
      color: AppColors.textDark,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter-Medium',
      fontSize: 14);
  static TextStyle closeAccountText = TextStyle(
      color: AppColors.textDark,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter-Medium',
      fontSize: 16);
  static TextStyle tabText = TextStyle(
      color: AppColors.textDark,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
      fontSize: 16);
  static TextStyle semiBoldTitleText = TextStyle(
      color: AppColors.textDark,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter-SemiBold',
      fontSize: 24);

  static TextStyle boldBottomTitleText = TextStyle(
      color: AppColors.textDark,
      fontWeight: FontWeight.w700,
      fontFamily: 'Inter-Bold',
      fontSize: 24);
  static TextStyle gbpText = TextStyle(
      color: AppColors.textDark,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter-SemiBold',
      fontSize: 14);
  static TextStyle oneGbpText = TextStyle(
      color: AppColors.edittextTitle,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter-Medium',
      fontSize: 14);
  static TextStyle subTitle = TextStyle(
      color: AppColors.edittextTitle,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter-Medium',
      fontSize: 14);
  static TextStyle subtitleText = TextStyle(
      color: AppColors.greyColor,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter-Regular',
      fontSize: 16);
  static TextStyle choiceChip = TextStyle(
      color: AppColors.textDark,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter-Medium',
      fontSize: 14);
  static TextStyle boldTitleText = TextStyle(
      color: AppColors.textDark,
      fontWeight: FontWeight.w700,
      fontFamily: 'Inter-Bold',
      fontSize: 32);
  static TextStyle thirtyTwoMedium = TextStyle(
      color: AppColors.textDark,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter-Medium',
      fontSize: 32);

  static TextStyle greenText = TextStyle(
      color: AppColors.greenColor,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter-Regular',
      fontSize: 14);
  static TextStyle instructions = TextStyle(
      color: AppColors.greyColor,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter-Regular',
      fontSize: 14);
  static TextStyle cameraInstructions = TextStyle(
      color: AppColors.textWhite,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter-Regular',
      fontSize: 12);
static TextStyle twelveMedium = TextStyle(
      color: AppColors.textDark,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter-Medium',
      fontSize: 12);

  static TextStyle retake = TextStyle(
      shadows: [Shadow(color: AppColors.signUpBtnColor, offset: Offset(0, -5))],
      color: Colors.transparent,
      decoration: TextDecoration.underline,
      decorationColor: AppColors.signUpBtnColor,
      decorationThickness: 1,
      fontSize: 16,
      fontFamily: 'Inter-Regular',
      fontWeight: FontWeight.w600);

  static TextStyle passwordMismatchError = TextStyle(
      color: AppColors.redColor,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter-SemiBold',
      fontSize: 14);
  static TextStyle semiBoldSixteen = TextStyle(
      color: AppColors.textDark,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter-SemiBold',
      fontSize: 16);
  static TextStyle twelveSemiBold = TextStyle(
      color: AppColors.textDark,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter-SemiBold',
      fontSize: 12);

  static TextStyle createPinTitle = TextStyle(
      color: AppColors.textDark,
      fontWeight: FontWeight.w700,
      fontFamily: 'Inter-Bold',
      fontSize: 32);
  static TextStyle screenTitle = TextStyle(
      color: AppColors.textDark,
      fontWeight: FontWeight.w700,
      fontFamily: 'Inter-Bold',
      fontSize: 32);
  static TextStyle currencyOnSendMoney = TextStyle(
      color: AppColors.edittextTitle,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
      fontSize: 20);
  static TextStyle buttonText = TextStyle(
      color: AppColors.textWhite, fontWeight: FontWeight.w600, fontSize: 18);
  static TextStyle subButtonText = TextStyle(
      color: AppColors.textDark, fontWeight: FontWeight.w600, fontSize: 16);

  static TextStyle sixteenRegular = TextStyle(
      color: AppColors.greyColor,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter-Regular',
      fontSize: 16);
  static TextStyle sixteenRegularWhite = TextStyle(
      color: AppColors.textWhite,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter-Regular',
      fontSize: 16);

  static TextStyle sixteenRegularDark = TextStyle(
      color: AppColors.textDark,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter-Regular',
      fontSize: 16);

  static TextStyle twelveRegular = TextStyle(
      color: AppColors.greyColor,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter-Regular',
      fontSize: 12);
  static TextStyle twentyBold = TextStyle(
      color: AppColors.textWhite,
      fontWeight: FontWeight.w700,
      fontFamily: 'Inter-Bold',
      fontSize: 20);
  static TextStyle twentyRegular = TextStyle(
      color: AppColors.greyColor,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter-Regular',
      fontSize: 14);
  static TextStyle twentySemiBold =  TextStyle(
      fontSize: 20,
      fontFamily: 'Inter-SemiBold',
      fontWeight: FontWeight.w600);
  static TextStyle letterTitle = TextStyle(
      color: AppColors.textWhite,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter-SemiBold',
      fontSize: 20);
  static TextStyle fourteenMediumGrey = TextStyle(
      color: AppColors.greyColor,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter-Medium',
      fontSize: 14);
  static TextStyle eighteenMedium = TextStyle(
      color: AppColors.textDark,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter-Medium',
      fontSize: 18);
  static TextStyle fourteenBold = TextStyle(
      color: AppColors.textDark,
      fontWeight: FontWeight.w700,
      fontFamily: 'Inter-Regular',
      fontSize: 14);
  static TextStyle fourteenRegular = TextStyle(
      color: AppColors.textDark,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter-Regular',
      fontSize: 14);
  static TextStyle fourteenRegularNavDisableColor = TextStyle(
      color: AppColors.navDisableColor,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter-Regular',
      fontSize: 14);
  static TextStyle sendMoneyInfoLeftText =  TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.sendMoneyInfo,
      fontFamily: 'Inter');

  static TextStyle sendMoneyInfoRightText =  TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.edittextTitle,
      fontFamily: 'Inter');

  static TextStyle fourteenMediumWhite = TextStyle(
      color: AppColors.textWhite,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
      fontSize: 14);
  static TextStyle fourteenMediumBlue = TextStyle(
      color: AppColors.signUpBtnColor,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
      fontSize: 14);
}
