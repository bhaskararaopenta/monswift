import 'package:flutter/material.dart';
import 'package:nationremit/more/rate/rate_alert_page.dart';
import 'package:nationremit/more/schedule_transaction/schedule_transaction.dart';
import 'package:nationremit/onboarding/onboarding.dart';
import 'package:nationremit/profile/edit_profile_page.dart';
import 'package:nationremit/profile/reset_pin.dart';
import 'package:nationremit/wallet/add_new_card.dart';
import 'package:nationremit/login/dashboard.dart';
import 'package:nationremit/login/login_page.dart';
import 'package:nationremit/login/login_page_after_signup.dart';
import 'package:nationremit/login/payment_detail_page.dart';
import 'package:nationremit/login/payment_type_page.dart';
import 'package:nationremit/login/profile_page.dart';
import 'package:nationremit/recipient/recipient_details_page.dart';
import 'package:nationremit/recipient/recipient_nav_page.dart';
import 'package:nationremit/login/rest_password_page.dart';
import 'package:nationremit/login/select_country_page.dart';
import 'package:nationremit/login/select_payment_mode_page.dart';
import 'package:nationremit/login/send_money_page.dart';
import 'package:nationremit/transactions/transaction_details_page.dart';
import 'package:nationremit/login/transactions_page.dart';
import 'package:nationremit/login/transfer_details_page.dart';
import 'package:nationremit/login/webview_pay_page.dart';
import 'package:nationremit/more/help/help_faq_page.dart';
import 'package:nationremit/more/more_nav_page.dart';
import 'package:nationremit/more/settings/currency_page.dart';
import 'package:nationremit/more/settings/language_page.dart';
import 'package:nationremit/more/settings/notification_setting_page.dart';
import 'package:nationremit/payment/select_recipient_sending_money_page.dart';
import 'package:nationremit/payment/success_details_page.dart';
import 'package:nationremit/profile/add_user_profile.dart';
import 'package:nationremit/profile/take_picture.dart';
import 'package:nationremit/profile/user_profile_details_page.dart';
import 'package:nationremit/profile/user_profile_page.dart';
import 'package:nationremit/recipient/add_new_recipient.dart';
import 'package:nationremit/recipient/edit_new_recipient.dart';
import 'package:nationremit/recipient/relatios_ship_with_recipient.dart';
import 'package:nationremit/router/router.dart';
import 'package:nationremit/signup/create_pin.dart';
import 'package:nationremit/signup/signup_page.dart';
import 'package:nationremit/signup/verification_email_page.dart';
import 'package:nationremit/wallet/saved_card_page.dart';

import '../contact/contact_support_page.dart';
import '../contact/success_support_page.dart';
import '../login/login_with_pin.dart';
import '../login/notification_page.dart';
import '../more/privacy/privacy_policy_page.dart';
import '../more/schedule_transaction/set_schedule_page.dart';
import '../more/settings/connected_devices_page.dart';
import '../more/settings/settings_page.dart';
import '../more/settings/two_step_verification_page.dart';
import '../payment/review_payment_page.dart';
import '../profile/add_user_address.dart';
import '../profile/add_user_address_manually.dart';
import '../profile/success_profile_update_page.dart';
import '../profile/success_reset_password_page.dart';
import '../profile/success_reset_pin_page.dart';
import '../profile/take_picture_for_passport.dart';
import '../profile/upload_identity_page.dart';
import '../recipient/select_recipient_country_page.dart';
import '../signup/confirm_pin.dart';
import '../transactions/transaction_history_status_page.dart';
import '../wallet/accountInformation/account_information_page.dart';
import '../wallet/add_money_to_wallet_page.dart';
import '../wallet/open_card_for_cvv.dart';
import '../wallet/saved_card_payment_page.dart';
import '../wallet/wallet_more_page.dart';

class MainRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget body;
    switch (settings.name) {
      case RouterConstants.onBoardRoute:
        body = const OnBoardScreen();
        //  body =  OnBoardScreen();
        break;
      case RouterConstants.loginWithPinRoute:
        body = const LoginWithPinPage();
        //  body =  OnBoardScreen();
        break;
      case RouterConstants.loginRoute:
        body = const LoginPage();
        //  body =  OnBoardScreen();
        break;
      case RouterConstants.loginRouteAfterSignUP:
        body = const LoginPageAfterSignup();
        //  body =  OnBoardScreen();
        break;
      case RouterConstants.signupRoute:
        body = const SignupPage();
        break;
      case RouterConstants.dashboardRoute:
        body = const DashboardPage();
        break;
      /*  case RouterConstants.otpRoute:
        body = const OTPPage();
        break;*/
      case RouterConstants.createPinRoute:
        body = const CreatePinPage();
        break;
      case RouterConstants.confirmPinRoute:
        body = const ConfirmPinPage();
        break;
      case RouterConstants.resetPinRoute:
        body = const ResetPinPage();
        break;
      case RouterConstants.addNewRecipientRoute:
        body = const AddNewRecipientPage();
        break;
      case RouterConstants.helpFAQRoute:
        body = const HelpFAQPage();
        break;
      case RouterConstants.notificationPageRoute:
        body = const NotificationSettingPage();
        break;
      case RouterConstants.accountInformationPageRoute:
        body = const AccountInformationPage();
        break;
      case RouterConstants.privacyPolicyRoute:
        body = const PrivacyPolicyPage();
        break;
      case RouterConstants.settingsPageRoute:
        body = const SettingsPage();
        break;
      case RouterConstants.connectedDevicesRoute:
        body = const ConnectedDevicesPage();
        break;
      case RouterConstants.rateAlertPageRoute:
        body = const RateAlertPage();
        break;
      case RouterConstants.currencyRoute:
        body = const CurrencyPage();
        break;
      case RouterConstants.languageRoute:
        body = const LanguagePage();
        break;
      case RouterConstants.notificationBellRoute:
        body = const NotificationPage();
        break;
      case RouterConstants.twoStepVerificationRoute:
        body = const TwoStepVerificationPage();
        break;
      case RouterConstants.relationShipWithRecipient:
        body = const RelationShipWithRecipient();
        break;
      case RouterConstants.selectCountryForRecipientRoute:
        body = const SelectRecipientCountryPage();
        break;
      case RouterConstants.recipientDetailsRoute:
        body = const RecipientDetailsPage();
        break;
      case RouterConstants.successPage:
        body = const SuccessDetailsPage();
        break;
      case RouterConstants.successPagePassword:
        body = const ResetPasswordSuccessPage();
        break;
      case RouterConstants.successPageProfileDetailsUpdated:
        body = const ProfileDetailsSuccessPage();
        break;
      case RouterConstants.supportEmailSuccessRoute:
        body = const SupportEmailSuccessPage();
        break;
      case RouterConstants.paymentTypeRoute:
        body = const PaymentTypePage();
        break;
      case RouterConstants.selectCountryRoute:
        body = const SelectCountryPage();
        break;
      case RouterConstants.selectRecipientToSendMoneyRoute:
        body = const SelectRecipientToSendMoneyPage();
        break;
      case RouterConstants.walletMorePageRoute:
        body = const WalletMorePage();
        break;
      case RouterConstants.recipientNavRoute:
        body = const RecipientNavPage();
        break;
      case RouterConstants.addNewCardsRoute:
        body = const AddNewCard();
        break;
      case RouterConstants.editProfilePage:
        body = const EditProfilePage();
        break;
      case RouterConstants.savedCardPaymentPage:
        body = const SavedCardPaymentPage();
        break;
      case RouterConstants.openCardsRouteToEnterCVV:
        body = const OpenCardToEnterCVVPage();
        break;
      case RouterConstants.addMoneyToWallet:
        body = const AddMoneyPage();
        break;
      case RouterConstants.savedCardRoute:
        body = const SavedCardPage();
        break;
      case RouterConstants.moreRoute:
        body = const MoreNavPage();
        break;
      case RouterConstants.transitionRoute:
        body = const TransactionsPage();
        break;
      case RouterConstants.scheduleTransactionRoute:
        body = const ScheduleTransactionTabBarPage();
        break;
      /*case RouterConstants.forgotPasswordRoute:
        body = const ForgotPasswordPage();
        break;*/
      case RouterConstants.restPasswordRoute:
        body = const RestPasswordPage();
        break;
      case RouterConstants.paymentModeRoute:
        body = const SelectPaymentModePage();
        break;
      case RouterConstants.profileRoute:
        body = const UserProfilePage();
        break;
      case RouterConstants.userProfileDetailsRoute:
        body = const UserProfileDetailsPage();
        break;
      case RouterConstants.personalProfileRoute:
        body = const ProfilePage();
        break;
      case RouterConstants.addProfileRoute:
        body = const AddUserProfilePage();
        break;
      case RouterConstants.addProfileAddressRoute:
        body = const AddUserAddressPage();
        break;
      case RouterConstants.addProfileAddressManuallyRoute:
        body = const AddUserAddressManuallyPage();
        break;
      case RouterConstants.contactSupportPageRoute:
        body = const ContactSupportPage();
        break;
      case RouterConstants.uploadProfileIdentity:
        body = const UploadIdentityPage();
        break;
      case RouterConstants.takePicture:
        body = const TakePictureScreen();
        break;
        case RouterConstants.takePictureScreenForPassport:
        body = const TakePictureScreenForPassport();
        break;
      case RouterConstants.transferDetailRoute:
        body = const TransferDetailsPage();
        break;
      case RouterConstants.setScheduleRoute:
        body = const SetSchedulePage();
        break;
      case RouterConstants.paymentDetailRoute:
        body = const PaymentDetailPage();
        break;
      case RouterConstants.paymentHTMLRoute:
        body = const PaymentHTMLPage();
        break;
      case RouterConstants.transactionDetailsRoute:
        body = const TransactionDetailsPage();
        break;
      case RouterConstants.editRecipientDetailsRoute:
        body = const EditdNewRecipientPage();
        break;
      case RouterConstants.sendMoneyPageRoute:
        body = const SendMoneyPage();
        break;
      case RouterConstants.reviewPaymentRoute:
        body = const ReviewPaymentPage();
        break;
      case RouterConstants.verifyMailRoute:
        body = const VerificationMailPage();
        break;
      case RouterConstants.successResetPinFromProfile:
        body = const SuccessResetPinPage();
        break;
        case RouterConstants.transferStatusScreen:
        body = TransferStatusScreen();
        break;
      default:
        body = Container();
    }

    return MaterialPageRoute(builder: (context) => body, settings: settings);
  }
}
