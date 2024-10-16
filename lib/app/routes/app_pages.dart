import 'package:get/get.dart';

import '../B2B_Modules/address_book/bindings/addressbook.dart';
import '../B2B_Modules/address_book/views/addressbook.dart';
import '../B2B_Modules/bills/bindings/bills.dart';
import '../B2B_Modules/bills/views/bills.dart';
import '../B2B_Modules/credit_notes/bindings/creditNotes.dart';
import '../B2B_Modules/credit_notes/views/creditNotes.dart';
import '../B2B_Modules/dashbord/bindings/dashbord.dart';
import '../B2B_Modules/dashbord/views/dashbord.dart';
import '../B2B_Modules/dealmaker/bindings/dealmaker.dart';
import '../B2B_Modules/dealmaker/views/dealmaker.dart';
import '../B2B_Modules/need_help_manager/bindings/needHelp.dart';
import '../B2B_Modules/need_help_manager/views/needHelp.dart';
import '../B2B_Modules/offer/bindings/offer.dart';
import '../B2B_Modules/offer/views/offer.dart';
import '../B2B_Modules/order/bindings/order.dart';
import '../B2B_Modules/order/controllers/order.dart';
import '../B2B_Modules/order/views/order.dart';
import '../modules/BottomTap/bottom_binding.dart';
import '../modules/BottomTap/bottom_view.dart';
import '../modules/Offer_Role_screen/bindings/offer_Role_screen_binding.dart';
import '../modules/Offer_Role_screen/views/offer_Role_screen_view.dart';
import '../modules/accountInformation_screen/bindings/account_information_screen_binding.dart';
import '../modules/accountInformation_screen/views/account_information_screen_view.dart';
import '../modules/addNewAddress_screen/bindings/add_new_address_screen_binding.dart';
import '../modules/addNewAddress_screen/views/add_new_address_screen_view.dart';
import '../modules/addressBook_screen/bindings/address_book_screen_binding.dart';
import '../modules/addressBook_screen/controllers/address_book_screen_controller.dart';
import '../modules/addressBook_screen/views/address_book_screen_view.dart';
import '../modules/allProduct/bindings/all_product_binding.dart';
import '../modules/allProduct/views/all_product_view.dart';
import '../modules/allReview/bindings/all_review_binding.dart';
import '../modules/allReview/views/all_review_view.dart';
import '../modules/all_Category_product/bindings/all_category_binding.dart';
import '../modules/all_Category_product/views/all_category_view.dart';
import '../modules/checkout_Congratulation/bindings/checkout_congratulation_binding.dart';
import '../modules/checkout_Congratulation/views/checkout_congratulation_view.dart';
import '../modules/checkout_information/bindings/checkout_information_binding.dart';
import '../modules/checkout_information/views/checkout_information_view.dart';
import '../modules/checkout_payment/bindings/checkout_payment_binding.dart';
import '../modules/checkout_payment/views/checkout_payment_view.dart';
import '../modules/checkout_shipping/bindings/checkout_shipping_binding.dart';
import '../modules/checkout_shipping/views/checkout_shipping_view.dart';
import '../modules/contactus_screen/bindings/contactus_screen_binding.dart';
import '../modules/contactus_screen/views/contactus_screen_view.dart';
import '../modules/createPassword/bindings/create_password_binding.dart';
import '../modules/createPassword/views/create_password_view.dart';
import '../modules/delivery_condition/bindings/delivery_condition_binding.dart';
import '../modules/delivery_condition/views/delivery_condition_view.dart';
import '../modules/detail_screen/bindings/detail_screen_binding.dart';
import '../modules/detail_screen/views/detail_screen_view.dart';
import '../modules/editProfile/bindings/editProfile_binding.dart';
import '../modules/editProfile/views/editProfile_view.dart';
import '../modules/forgetPassword/bindings/forget_password_binding.dart';
import '../modules/forgetPassword/views/forget_password_view.dart';
import '../modules/forgetPassword_Otp_screen/bindings/forget_password_otp_screen_binding.dart';
import '../modules/forgetPassword_Otp_screen/views/forget_password_otp_screen_view.dart';
import '../modules/general_setting/bindings/general_setting_binding.dart';
import '../modules/general_setting/views/general_setting_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/introVC/bindings/intro_v_c_binding.dart';
import '../modules/introVC/views/intro_v_c_view.dart';
import '../modules/legal_screen/legal_binding.dart';
import '../modules/legal_screen/legal_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/myCart/bindings/my_cart_binding.dart';
import '../modules/myCart/views/my_cart_view.dart';
import '../modules/myOrder_screen/bindings/my_order_screen_binding.dart';
import '../modules/myOrder_screen/views/my_order_screen_view.dart';
import '../modules/notification_List_screen/bindings/notification_list_screen_binding.dart';
import '../modules/notification_List_screen/views/notification_list_screen_view.dart';
import '../modules/notification_screen/bindings/notification_screen_binding.dart';
import '../modules/notification_screen/views/notification_screen_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/policy_condition/bindings/policy_condition_binding.dart';
import '../modules/policy_condition/views/policy_condition_view.dart';
import '../modules/policy_screen/bindings/policy_screen_binding.dart';
import '../modules/policy_screen/views/policy_screen_view.dart';
import '../modules/profile_screen/bindings/profile_screen_binding.dart';
import '../modules/profile_screen/views/profile_screen_view.dart';
import '../modules/request_quote_screen/bindings/request_quote_screen_binding.dart';
import '../modules/request_quote_screen/views/request_quote_screen_view.dart';
import '../modules/see_categories/bindings/see_categories_screen_binding.dart';
import '../modules/see_categories/views/see_categories_screen_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/signUp/bindings/sign_up_binding.dart';
import '../modules/signUp/views/sign_up_view.dart';
import '../modules/signUpInfo/bindings/sign_up_info_binding.dart';
import '../modules/signUpInfo/views/sign_up_info_view.dart';
import '../modules/sparePartScreen/bindings/spare_part_screen_binding.dart';
import '../modules/sparePartScreen/views/spare_part_screen_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/termsCondition_screen/bindings/terms_condition_screen_binding.dart';
import '../modules/termsCondition_screen/views/terms_condition_screen_view.dart';
import '../supplier_modules/dashbord_supplier/bindings/dashbord.dart';
import '../supplier_modules/dashbord_supplier/views/dashbord.dart';
import '../supplier_modules/delivery_notes_supplier/bindings/delivery_notes.dart';
import '../supplier_modules/delivery_notes_supplier/views/delivery_notes.dart';
import '../supplier_modules/need_help_manager/bindings/needHelp_supplier.dart';
import '../supplier_modules/need_help_manager/views/needHelp_supplier.dart';
import '../supplier_modules/orders_supplier/bindings/orders.dart';
import '../supplier_modules/orders_supplier/views/orders.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INTRO_V_C,
      page: () => IntroVCView(),
      binding: IntroVCBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_PASSWORD,
      page: () => CreatePasswordView(),
      binding: CreatePasswordBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD,
      page: () => ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => editProfileView(),
      binding: editProfileBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP_INFO,
      page: () => SignUpInfoView(),
      binding: SignUpInfoBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT_SHIPPING,
      page: () => CheckoutShippingView(),
      binding: CheckoutShippingBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT_CONGRATULATION,
      page: () => const CheckoutCongratulationView(),
      binding: CheckoutCongratulationBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT_INFORMATION,
      page: () => CheckoutInformationView(),
      binding: CheckoutInformationBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT_PAYMENT,
      page: () => CheckoutPaymentView(),
      binding: CheckoutPaymentBinding(),
    ),
    GetPage(
      name: _Paths.MY_CART,
      page: () => MyCartView(),
      binding: MyCartBinding(),
    ),
    GetPage(
      name: _Paths.ALL_PRODUCT,
      page: () => AllProductView(),
      binding: AllProductBinding(),
    ),
    GetPage(
      name: _Paths.ALL_REVIEW,
      page: () => AllReviewView(),
      binding: AllReviewBinding(),
    ),
    GetPage(
      name: _Paths.SEE_CATEGORIES,
      page: () => SeeCategoriesView(),
      binding: SeeCategoriesBinding(),
    ),
    GetPage(
      name: _Paths.OFFER_ROLE_SCREEN,
      page: () => offer_RoleScreenView(),
      binding: offer_RoleScreenBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_SCREEN,
      page: () => DetailScreenView(),
      binding: DetailScreenBinding(),
    ),
    GetPage(
      name: _Paths.REQUEST_QUOTE_SCREEN,
      page: () => RequestQuoteScreenView(),
      binding: RequestQuoteScreenBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_INFORMATION_SCREEN,
      page: () => AccountInformationScreenView(),
      binding: AccountInformationScreenBinding(),
    ),
    GetPage(
      name: _Paths.ADD_NEW_ADDRESS_SCREEN,
      page: () => AddNewAddressScreenView(),
      binding: AddNewAddressScreenBinding(),
    ),
    GetPage(
      name: _Paths.ADDRESS_BOOK_SCREEN,
      page: () => AddressBookScreenView(),
      binding: AddressBookScreenBinding(),
    ),
    GetPage(
      name: _Paths.CONTACTUS_SCREEN,
      page: () => ContactusScreenView(),
      binding: ContactusScreenBinding(),
    ),
    GetPage(
      name: _Paths.GENERAL_SETTING,
      page: () => GeneralSettingView(),
      binding: GeneralSettingBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.MY_ORDER_SCREEN,
      page: () => MyOrderScreenView(),
      binding: MyOrderScreenBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_SCREEN,
      page: () => NotificationScreenView(),
      binding: NotificationScreenBinding(),
    ),
    GetPage(
      name: _Paths.POLICY_SCREEN,
      page: () => PolicyScreenView(),
      binding: PolicyScreenBinding(),
    ),
    GetPage(
      name: _Paths.POLICY_CONDITION,
      page: () => PolicyConditionView(),
      binding: PolicyConditionBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_SCREEN,
      page: () => ProfileScreenView(),
      binding: ProfileScreenBinding(),
    ),
    GetPage(
      name: _Paths.TERMS_CONDITION_SCREEN,
      page: () => TermsConditionScreenView(),
      binding: TermsConditionScreenBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD_OTP_SCREEN,
      page: () => ForgetPasswordOtpScreenView(),
      binding: ForgetPasswordOtpScreenBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_LIST_SCREEN,
      page: () => NotificationListScreenView(),
      binding: NotificationListScreenBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_TAP,
      page: () => BottomNavigationTap(),
      binding: BottomNavigationBinding(),
    ),
    GetPage(
      name: _Paths.DASHBORD_S,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_S,
      page: () => OrderView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.DELIVERY_S,
      page: () => DeliveryNotesView(),
      binding: DeliveryNotesBinding(),
    ),
    GetPage(
      name: _Paths.ADDRESSBOOK_SCREEN,
      page: () => AddressbookB2BView(),
      binding: AddressbookB2BBinding(),
    ),
    GetPage(
      name: _Paths.BILLS_SCREEN,
      page: () => billsB2BView(),
      binding: billsB2BBinding(),
    ),
    GetPage(
      name: _Paths.CREDIT_NOTES_SCREEN,
      page: () => creditNotesB2BView(),
      binding: creditNotesB2BBinding(),
    ),
    GetPage(
      name: _Paths.DEALMAKER_SCREEN,
      page: () => dealmakerB2BView(),
      binding: dealmakerB2BBinding(),
    ),
    GetPage(
      name: _Paths.NEEDHELP_SCREEN,
      page: () => needHelpB2BView(),
      binding: needHelpB2BBinding(),
    ),
    GetPage(
      name: _Paths.DASHBORD_B2B,
      page: () => DashboardB2BView(),
      binding: DashboardB2BBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_B2B_SCREEN,
      page: () => orderB2BView(),
      binding: orderB2BBinding(),
    ),
    GetPage(
      name: _Paths.OFFER_B2B_SCREEN,
      page: () => offerB2BView(),
      binding: offerB2BBinding(),
    ),
    GetPage(
      name: _Paths.NEEDHELP_S,
      page: () => needHelpView(),
      binding: needHelpBinding(),
    ),
    GetPage(
      name: _Paths.LEGAL,
      page: () => WordDocView(),
      binding: WordDocBinding(),
    ),
    GetPage(
      name: _Paths.DELIVERY_CONDITION,
      page: () => DeliveryConditionView(),
      binding: DeliveryConditionBinding(),
    ),
    GetPage(
      name: _Paths.ALL_CATEGORY,
      page: () => AllcategoryView(),
      binding: AllcategoryBinding(),
    ),
    GetPage(
      name: _Paths.SPARE_PART_SCREEN,
      page: () => SparePartScreenView(),
      binding: SparePartScreenBinding(),
    ),
  ];
}
