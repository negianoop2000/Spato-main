import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:spato_mobile_app/firebase_services/notification_service.dart';

String? globalShopId;
class ApiService {

  static late final BuildContext context;
  static const String webUrl = "https://spa2.de";

    //static const String baseUrl = "http://192.168.1.17:8000/";

 static const String baseUrl = "https://9kt.7cd.mytemp.website/";


 static const String basesUrl = "https://spa2.de/";
 static const String pdfUrl = "https://spa2.de/storage/";
  static const String imageUrl = "${baseUrl}storage/";
  static const String register = "register";
  static const String login = "login";
  static const String loginForMobileUrl = "loginForMobile";

  static const String forgetPassword = "forgetPassword";
  static const String passwordReset = "password/reset";
  static const String getAllLatestProductsApi = "getAllLatestProductsApi";
  static const String home1 = "home1";
  static const String subscribeNewsLetterApi = "subscribeNewsLetterApi";
  static const String cartAddApi = "cart/addApi";
  static const String updatecartApi = "cart/updateQuanityApi";


  static const String cartGetCartItemsApi = "cart/getCartItemsApi";
  static const String cartUpdateQuantityApi = "cart/updateQuanityApi";
  static const String deleteCartProductsApi = "deleteCartProductsApi/";
  static const String profileViewApi = "profileViewApi";
  static const String showOrderHistoryApi = "showOrderHistoryApi";
  static const String productsByCategoriesApi = "ProductsByCategoriesApi/";
  static const String productDetailPageApi = "ProductdetailPageApi/";
  static const String userLogoutUrl = "logoutApi";
  static const String userDeleteUrl = "delete-account";
  static const String submitQuotesUrl ="submitQuotes";
  static const String saveAddressApi ="saveTempAddressApi";
  static const String offerListingApi ="offerListingApi";
  static const String updateQuantityApi ="updateQuanityApi";
  static const String editProfileApi ="addPermanentProfileApi";
  static const String checkoutApi ="cart/getCartItemsforCheckout";
  static const String applyDisccodeApi ="applyDiscCode";
  static const String deleteCartItemApi ="cart/deleteCartProductsApi/";
  static const String addRevewRattingApi ="addReview_RattingApi/";
  static const String menuSearchApi ="menuBarSearch/";
  static const String addressListApi ="cart/userAddress";
  static const String saveTempAddressUrl ="saveTempAddressApi";
  static const String addOrderApi ="cart/addOrder";
  static const String getOrdersDetailsApi ="getOrdersDetailsApi/";
  static const String getOfferDetailsApi ="getOfferDetailsApi";
  static const String admin_notificationsApi ="admin_notifications";

  static const String notifications ="showNotificationAppApi";
  static const String readnotification ="readNotificationAppApi";
  static const String deletenotification ="deleteNotificationAppApi";





  static const String imageApiUrl ="imageApi";
  static const String getProductsAllCategoryUrl ="getProductsAllCategoryApi";
  static const String getBannnerContentUrl ="getBannnerContent";
  static const String getSupplierListApiUrl ="getSupplierListApi";
  static const String getMainCategory1ApiUrl ="getMainCategory1Api";
  static const String getDynamicNavbarUrl ="getDynamicNavbar";
  static const String getFilterProductsApiUrl ="getFilterProductsApi";




/////////////    b2b ////////////////
  static const String b2b_offerListingurl ="offerListingApi";
  static const String b2b_updateOfferStatusB2BApi ="updateOfferStatusB2BApi";
  static const String b2b_assignmentListingApi ="assignmentListingApi";
  static const String b2b_assignmentChangeForRequestApi ="assignmentChangeForRequestApi";
  static const String b2b_deliveryNotesListingApi ="deliveryNotesListingApi";
  static const String b2b_billsListingApi ="billsListingApi";
  static const String b2b_updateBillStatusApi ="updateBillStatusApi";
  static const String b2b_creditsListingApi ="creditsListingApi";
  static const String b2b_updateCreditStatusApi ="updateCreditStatusApi";
  static const String b2b_dealListingApi ="dealListingApi";
  static const String b2b_getDealDetailsByDealNrApi ="getDealDetailsByDealNrApi";
  static const String b2b_saveContactAddressApi ="saveContactAddressApi";
  static const String b2b_showTempAddressApi ="showTempAddressApi";
  static const String b2b_contactAddressDeleteApi ="contactAddressDeleteApi/";
  static const String b2b_getAssignmentDetailsApi ="getAssignmentDetailsApi";
  static const String b2b_claimsListingApiApi ="claimsListingApi";


  ////////////     spare Parts //////
  static const String getSparepartImageUrl ="getSparepartImage/";
  static const String extractText_sparePartUrl ="extractText-sparePart";
  static const String addSparePartOfferApiUrl ="addSparePartOfferApi";
  static const String showSparePartHistoryApi  = "showSparePartHistoryApi";
  static const String getSparePartDetailsApiUrl ="getSparePartDetailsApi";

  static const String getB2bShopDetails ="b2b_shop_details/";
  static const String getB2bShopList = "get_b2b_shop_list";
  static const String changeSubscribeStatus = "change_status_subscribe_feature";


  Future loginApi(String email, String password, {String? shopId}) async {
    String deviceToken = await NotificationService().getDeviceToken();
    Map<String, String> body = {
      'email': email,
      'password': password,
      'device_type': Platform.isAndroid ? "android" : "ios",
      'device_token':deviceToken,
    };

    if (shopId != "null" && shopId!.isNotEmpty) {
      body['shop_id'] = shopId;
    }

    // Make the POST request
    final response = await http.post(
      Uri.parse(baseUrl + login),
      body: body,
    );

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future verifyOtp(String email, String otp) async {
    final response = await http.post(
        Uri.parse('${"${baseUrl}verify_otp"}?email_login=$email&otp=$otp'),
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future fetchuserid(shopid) async {
    final response = await http.post(
      Uri.parse("${baseUrl}user_id_by_shop_id"),
      body: ({
        'shop_id': shopid,
      }),
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future loginformobile(String email, String password) async {
    final response = await http.post(
        Uri.parse(baseUrl + loginForMobileUrl).replace(queryParameters: {
          'email': email,
          'password': password,
        })
    );


    var convertDataToJson = jsonDecode(response.body);
      return convertDataToJson;
  }

  Future signup(
      String email,
      String password,
      String passwordConform,
      String role,
      String fullName,
      String countryCode,
      String phone,
      String street,
      String pincode,
      String city,
      String number,
      String country,
      bool termCondition,
      bool confirmPrivacy,
      String company,
      String vatId, String referral_id,
      ) async {
    final Map<String, String> body = {
      "email": email,
      "password": password,
      "password_confirmation": passwordConform,
      "Ich_bin": role,
      "Ansprechpartner": fullName,
      "countryCode": countryCode,
      "Phone_Number": phone,
      "Straße": street,
      "Postleitzahl": pincode,
      "Stadt": city,
      "Nr": number,
      "Land": country,
      "Bestätige_AGB": termCondition.toString(),
      "Bestätige_Datenschutz": confirmPrivacy.toString(),
      "company_name": company,
      "vat_id": vatId,
      "shop_id":referral_id,
    };

    final response = await http.post(
      Uri.parse(baseUrl + register),
      body: body,
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future forgetPassApi(email) async {
    // if (!(await _checkConnectivity())) return null;
    final response = await http.post(
      Uri.parse(baseUrl + forgetPassword),
      body: ({
        'email': email,
      }),
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future createPassword(email, password) async {
    final response = await http.post(
      Uri.parse(baseUrl + login),
      body: ({
        'email': email,
        'password': password,
      }),
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future<Map<String, dynamic>> productCategories(String category,String userid) async {
    final response = await http.get(
      Uri.parse("$baseUrl$productsByCategoriesApi$category""/$userid"),
      headers: {

      },
    );
    if (response.statusCode == 200) {
      var convertDataToJson = jsonDecode(response.body);
      return convertDataToJson;
    } else {
      throw Exception('Failed to load category data');
    }
  }

  Future profileUser() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse("$baseUrl$profileViewApi"),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future getAllLatestProductsHomeApi(userid) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse("$baseUrl$getAllLatestProductsApi""/$userid"),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future getSupplierListHomeApi() async {
    final prefs = await SharedPreferences.getInstance();
  //  String baseUrl = getBaseUrl();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse("$baseUrl$getSupplierListApiUrl"),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future profileUserExtraDetail() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse("$baseUrl$home1"),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future orderHistory() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    String? shopId = globalShopId; // Assuming globalShopId might be nullable

    // Build the URL with shopId if it's not null or empty
    String url = "$baseUrl$showOrderHistoryApi";
    if (shopId != null && shopId.isNotEmpty) {
      url += "/$shopId"; // Add shopId to the URL if available
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future showSparePartHistory() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse("$baseUrl$showSparePartHistoryApi"),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future<Map<String, dynamic>> getCartItemsApi() async {
    final prefs = await SharedPreferences.getInstance();
    var guestToken = prefs.getString('guest_token');
    String? shopId = globalShopId;
    String url = "$baseUrl$cartGetCartItemsApi";
    if (shopId != null && shopId.isNotEmpty) {
      url += "/$shopId";
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "guest-token": guestToken ?? '',
        "Content-Type": "application/json",
      },
    );

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future<Map<String, dynamic>> addToCardApi(String productId, int quantity) async {
    final prefs = await SharedPreferences.getInstance();
    String? shopId = globalShopId;

    var guestToken = prefs.getString('guest_token');

    String url = baseUrl + cartAddApi;
    if (shopId != null && shopId.isNotEmpty) {
      url += "/$shopId";
    }

    final response = await http.post(
      Uri.parse(url),
      headers: {
        "guest-token": guestToken ?? '',
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "product_id": productId,
        "quantity": quantity.toString(),
      }),
    );

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future userLogoutApi() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    String url = "$baseUrl$userLogoutUrl";

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future userDeleteApi() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(
      Uri.parse('$baseUrl$userDeleteUrl'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future productDetail(int id, String manufacturer) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    String? shopId = globalShopId;

    String url = "$baseUrl$productDetailPageApi$id/$manufacturer";
    if (shopId != null && shopId.isNotEmpty) {
      url += "/$shopId";
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future submitQuotesApi(String productId,String productcode, String companymobile,String companyemail,
      String firmName, String contactName, String new_email, String mobile, String sparePartName, String quoteNeededBy, String budget, String overview, File file) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');

    String shopid = globalShopId ?? "";

    var request = http.MultipartRequest('POST', Uri.parse(baseUrl + submitQuotesUrl));
    request.headers['Authorization'] = 'Bearer $authToken';

    request.fields['shop_id'] = shopid;

    request.fields['product_id'] = productId;
    request.fields['product_code'] = productcode;

    request.fields['firmEmail'] = companyemail;
    request.fields['firmMobile'] = companymobile;


    request.fields['firmName'] = firmName;
    request.fields['contactName'] = contactName;
    request.fields['new_email'] = new_email;
    request.fields['mobile'] = mobile;
    request.fields['sparePartName'] = sparePartName;
    request.fields['QuoteNeededBy'] = quoteNeededBy;
    request.fields['budget'] = budget;
    request.fields['Overview'] = overview;


      request.files.add(await http.MultipartFile.fromPath('Document', file.path));

    var response = await request.send();
    final responseBody = await response.stream.bytesToString();
    var convertDataToJson = jsonDecode(responseBody);
    return convertDataToJson;
  }

  Future updateQuanityApi(productId, quantity) async {
    final prefs = await SharedPreferences.getInstance();
    var guestToken = prefs.getString('guest_token');
    final response = await http.post(
      Uri.parse(baseUrl + updateQuantityApi),
      headers: {
        "guest-token": guestToken ?? '',
        "Content-Type": "application/json",
      },
      body: ({
        "product_id":productId,
        "quantity":quantity
      }),
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future saveTempAddressApi(String tempAddress, String tempCity, String tempZip, String tempCountry,) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(
      Uri.parse(baseUrl + saveAddressApi),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      body: ({
        "tempAddress":tempAddress,
        "tempCity":tempCity,
        "tempZip":tempZip,
        "tempCountry":tempCountry
      }),
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future editProfile(String city, String zipCode, String country, String userEmail,String vatNumber, String repeatUserName, String permanentAddress, String mobile, File? imageFile) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');

    var uri = Uri.parse(baseUrl + editProfileApi);
    var request = http.MultipartRequest('POST', uri);

    request.headers['Authorization'] = 'Bearer $authToken';

    request.fields['City'] = city;
    request.fields['userEmail'] = userEmail;
    request.fields['zipCode'] = zipCode;
    request.fields['country'] = country;
    request.fields['vat_number'] = vatNumber;
    request.fields['name'] = repeatUserName;
    request.fields['permanentAddress'] = permanentAddress;
    request.fields['mobile'] = mobile;

    if (imageFile != null) {
      var stream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile(
        'imageUpload',
        stream,
        length,
        filename: basename(imageFile.path),
      );
      request.files.add(multipartFile);
    }

    var response = await request.send();

    var responseBody = await response.stream.bytesToString();

    var convertDataToJson = jsonDecode(responseBody);
    return convertDataToJson;
  }

  Future checkOutApi() async {
    final prefs = await SharedPreferences.getInstance();
    var guestToken = prefs.getString('guest_token');
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse(baseUrl + checkoutApi),
      headers: {
        "guest-token": guestToken ?? '',
        'Authorization': 'Bearer $authToken',
        "Content-Type": "application/json",
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future<Map<String, dynamic>?> applyDiscCodeApi(String applyDiscCode, double originalSummaryTotal,{String? shopId}) async {
    final response = await http.get(
      Uri.parse('${baseUrl + applyDisccodeApi}?apply_disc_code=$applyDiscCode&orderSummaryTotal=$originalSummaryTotal&shop_id=$shopId'),

    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  Future deleteCartItem(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    var guestToken = prefs.getString('guest_token');
    final response = await http.delete(
      Uri.parse("$baseUrl$deleteCartItemApi$productId"),
      headers: {
        "guest-token": guestToken ?? '',
        "Content-Type": "application/json",
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future reveiwRatingApi(String rating, String comment,String productId) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');

    String shopid = globalShopId ?? "";

    final response = await http.post(
      Uri.parse("$baseUrl$addRevewRattingApi$productId"),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      body: ({
        "rating": rating,
        "reviewComment": comment,
        "shop_id":shopid,
      }),
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future searchApi(String searchText) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    String? shopId = globalShopId;

    final uri = Uri.parse("$baseUrl$menuSearchApi").replace(queryParameters: {
      "text": searchText,
      if (shopId != null && shopId.isNotEmpty) "shop_id": shopId,
    });


    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future saveTempAddress(String name, String email ,String phone,String tempAddress,String tempCity,String tempZip,String tempCountry) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(
      Uri.parse("$baseUrl$saveTempAddressUrl"),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      body: ({
        "Name_der_Firma" : name,
        "Firmen_E_Mail" : email,
        "Firmentelefon" : phone,
        "tempAddress" : tempAddress,
        "tempCity" : tempCity,
        "tempZip" : tempZip,
        "tempCountry" : tempCountry
      }),
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future<dynamic> OrderApi(
      String delvAddress,
      List<int> productIds,
      List<double> productPrices,
      List<int> productQuantities,
      String applyDiscCode,
      double subTotal,
      double shippingAmt,
      double taxAmt,
      String UserId
      ) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    var guestToken = prefs.getString('guest_token');
    String? shopId = globalShopId;

    var bodyContent = {
      "user": {"id": UserId},
      "product_id": productIds,
      "product_price": productPrices,
      "product_quanty": productQuantities,
      "delv_address": delvAddress,
      "apply_disc_code": applyDiscCode,
      "sub_total": subTotal,
      "shipping_amt": shippingAmt,
      "tax_amt": taxAmt,
      "order_total": subTotal + shippingAmt + taxAmt
    };
    String bodyJson = jsonEncode(bodyContent);

    String url = "$baseUrl$addOrderApi";
    if (shopId != null && shopId.isNotEmpty) {
      url += "/$shopId";
    }

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $authToken',
        "guest-token": guestToken ?? '',
        'Content-Type': 'application/json',
      },
      body: bodyJson,
    );

    // Parse the response and return
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future getAllAddressList() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    String Url = "$baseUrl$addressListApi";
    final response = await http.get(
      Uri.parse(Url),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future b2b_getDealDetailsByDealNr(String deal_Nr,) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse('${baseUrl + b2b_getDealDetailsByDealNrApi}?Deal_Nr=$deal_Nr'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future b2b_offerListingApi() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    String Url = "$baseUrl$b2b_offerListingurl";
    final response = await http.get(
      Uri.parse(Url),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future b2b_updateOfferStatusApi(String offer_code, String status) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse('${baseUrl + b2b_updateOfferStatusB2BApi}?offer_code=$offer_code&status=$status'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future b2b_assignmentListing() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    String Url = "$baseUrl$b2b_assignmentListingApi";
    final response = await http.get(
      Uri.parse(Url),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future b2b_assignmentChangeForRequest(String auftrags_Nr, String request) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse('${baseUrl + b2b_assignmentChangeForRequestApi}?assignment_no=$auftrags_Nr&changeDesc=$request'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future b2b_deliveryNotesListing() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    String Url = "$baseUrl$b2b_deliveryNotesListingApi";
    final response = await http.get(
      Uri.parse(Url),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future b2b_claimsListingApi() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    String Url = "$baseUrl$b2b_claimsListingApiApi";
    final response = await http.get(
      Uri.parse(Url),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future b2b_billsListing() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    String Url = "$baseUrl$b2b_billsListingApi";
    final response = await http.get(
      Uri.parse(Url),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future b2b_updateBillStatus() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    String Url = "$baseUrl$b2b_updateBillStatusApi";
    final response = await http.get(
      Uri.parse(Url),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future b2b_creditsListing() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    String Url = "$baseUrl$b2b_creditsListingApi";
    final response = await http.get(
      Uri.parse(Url),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future b2b_updateCreditStatus() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    String Url = "$baseUrl$b2b_updateCreditStatusApi";
    final response = await http.get(
      Uri.parse(Url),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future b2b_dealListing() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    String Url = "$baseUrl$b2b_dealListingApi";
    final response = await http.get(
      Uri.parse(Url),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future<Map<String, dynamic>?> getOfferDetails(String offer_id) async  {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse('${baseUrl + getOfferDetailsApi}?Angebots_Nr=$offer_id'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future getOrdersDetails(String order_id,) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse('${baseUrl + getOrdersDetailsApi}?Deal_Nr=$order_id'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future B2cgetOrdersDetails(String order_id,) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse('${baseUrl + getOrdersDetailsApi}?order_id=$order_id'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future b2b_saveContactAddress(String name ,String email ,String phone,String userID, String tempAddress,String tempCity,String tempZip,String tempCountry,String SteetNumber) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(
      Uri.parse("$baseUrl$b2b_saveContactAddressApi"),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      body: ({
        "Name_der_Firma" : name,
        "Firmen_E_Mail" : email,
        "Firmentelefon" : phone,
        "userID" : userID,
        "Straße" : tempAddress,
        "Ort" : tempCity,
        "PLZ" : tempZip,
        "Land" : tempCountry,
        "house_no" : SteetNumber,
      }),
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future b2b_showTempAddress() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    String Url = "$baseUrl$b2b_showTempAddressApi";
    final response = await http.get(
      Uri.parse(Url),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future b2b_deleteTempAddress(int addressId) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    String Url = "$baseUrl$b2b_contactAddressDeleteApi$addressId";
    final response = await http.get(
      Uri.parse(Url),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future b2b_getAssignmentDetails(String assignmentNo,) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse('${baseUrl + b2b_getAssignmentDetailsApi}?assignment_no=$assignmentNo'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future adminnotificationsApi() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse("$baseUrl$admin_notificationsApi"),
      headers: {
        'Authorization': 'Bearer $authToken',

        "Content-Type": "application/json",
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future notificationsApi() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse(baseUrl + notifications),
      headers: {
        'Authorization': 'Bearer $authToken',
        "Content-Type": "application/json",
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future read_notification(String id) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(
      Uri.parse('${"$baseUrl$readnotification"}?notification_id=$id'),
      headers: {
        'Authorization': 'Bearer $authToken',
        "Content-Type": "application/json",
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future delete_notification(String id) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(
      Uri.parse('${"$baseUrl$deletenotification"}?notification_id=$id'),
      headers: {
        'Authorization': 'Bearer $authToken',
        "Content-Type": "application/json",
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future get_Image(String image_Bild,) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse('${baseUrl + imageApiUrl}?name=$image_Bild'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future getAllCategoryProduct() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse("$baseUrl$getProductsAllCategoryUrl"),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future getMainCategory({required String userid}) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse("$baseUrl$getMainCategory1ApiUrl""/$userid"),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future getDynamicFilterCategory(String mainCategory, List<int> selectedSupplierIndexes) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');

    String shopId = globalShopId ??"";
    String selectedSuppliersQuery = selectedSupplierIndexes
        .map((index) => 'selectedSuppliers[]=${Uri.encodeQueryComponent(index.toString())}')
        .join('&');

    final response = await http.get(
      Uri.parse('$baseUrl$getDynamicNavbarUrl?Kategorie_1=${Uri.encodeQueryComponent(mainCategory)}&$selectedSuppliersQuery&shop_id=${Uri.encodeQueryComponent(shopId)}'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future<dynamic> getFilterProducts(String mainCategory, List<int> selectedSupplierIndexes) async {
    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('auth_token');
    final String shopId = globalShopId ?? '';

    final String selectedSuppliersQuery = selectedSupplierIndexes
        .map((index) => 'selectedSuppliers[]=${Uri.encodeQueryComponent(index.toString())}')
        .join('&');

    final Uri url = Uri.parse(
      '$baseUrl$getFilterProductsApiUrl?'
          'selectedKategories=${Uri.encodeQueryComponent(mainCategory)}&'
          '$selectedSuppliersQuery&'
          // 'sortOption=${Uri.encodeQueryComponent("sortOption")}&'
          'shop_id=${Uri.encodeQueryComponent(shopId)}',
    );

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'error': 'Failed to load products'};
      }
    } catch (e) {
      return {'error': 'Network error or invalid response'};
    }
  }

  Future getSparepartImage(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse("$baseUrl$getSparepartImageUrl$productId"),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future<Map<String, dynamic>> extractText_sparePartApi(String x, String y , String productId) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final formData = {
      'x': x,
      'y': y,
      'product_id': productId,
    };
    final response = await http.post(
      Uri.parse(baseUrl + extractText_sparePartUrl),
      headers: {
        'Authorization': 'Bearer $authToken',
        "Content-Type": "application/json",
      },
      body: jsonEncode(formData),
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future<Map<String, dynamic>> addSparePartOfferUrl(List<Map<String, dynamic>> inputs,String productId) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');

    final formData = {
      "product_id":productId,
      'inputs': inputs,
    };


    final response = await http.post(
      Uri.parse(baseUrl + addSparePartOfferApiUrl),
      headers: {
        'Authorization': 'Bearer $authToken',
        "Content-Type": "application/json",
      },
      body: jsonEncode(formData),
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future getSparePartDetails(String order_id,) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse('${baseUrl + getSparePartDetailsApiUrl}?order_id=$order_id'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future getb2bshop_details(String encrypted_userId) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse("$baseUrl$getB2bShopDetails$encrypted_userId"),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future getb2bshop_detailsforadmin( String encryptedUserId, String userid) async{
  final prefs = await SharedPreferences.getInstance();
  var authToken = prefs.getString('auth_token');
  final response = await http.get(
  Uri.parse("$baseUrl$getB2bShopDetails$encryptedUserId?id=$userid"),
  headers: {
  'Authorization': 'Bearer $authToken',
  },
  );
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

  Future getb2bshoplist() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse("$baseUrl$getB2bShopList"),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future changeStatusSubscribe(String userid, String feature, String newStatus, String charge) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');

    // Construct the payload data as a Map
    final data = {
      'feature': feature,
      'feature_charge': charge,
      'user_id': userid,
      'status': newStatus,
    };

    final response = await http.post(
      Uri.parse("$baseUrl$changeSubscribeStatus"),
      headers: {
        'Authorization': 'Bearer $authToken',
        "Content-Type": "application/x-www-form-urlencoded", // Form data content type
      },
      body: data, // Send data as form-encoded payload
    );

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future savefeaturecharge(String userid, String feature, String charge) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');

    final data = {
      'feature': feature,
      'user_id': userid,
      'feature_charge': charge,
    };

    final response = await http.post(
      Uri.parse("${baseUrl}save_feature_charge"),
      headers: {
        'Authorization': 'Bearer $authToken',
        "Content-Type": "application/x-www-form-urlencoded", // Form data content type
      },
      body: data,
    );

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future savesubscriptioncharge(String userid, String price) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');

    final data = {
      'user_id': userid,
      'commision_on_sale': price,
    };

    final response = await http.post(
      Uri.parse("${baseUrl}update_commision_on_sale"),
      headers: {
        'Authorization': 'Bearer $authToken',
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: data,
    );

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future savepaymentalertmessage(String userid, String message) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');

    final data = {
      'message':message,
      'user_id': userid,
    };

    final response = await http.post(
      Uri.parse("${baseUrl}save_payment_alert_message"),
      headers: {
        'Authorization': 'Bearer $authToken',
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: data,
    );

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future paymentalertstatus(String userid, String status) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');

    final data = {
      'user_id': userid,
      'old_status': status,
    };

    final response = await http.post(
      Uri.parse("${baseUrl}change_payment_alert_status"),
      headers: {
        'Authorization': 'Bearer $authToken',
        "Content-Type": "application/x-www-form-urlencoded", // Form data content type
      },
      body: data,
    );

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future getprivacypolicies( String pageName, String userId) async{
    final response = await http.get(
      Uri.parse("$baseUrl""fetchStaticDataForMobile?pageName=$pageName&userID=$userId"),
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future<Map<String, dynamic>> updateCartApi(String productId, int quantity) async {
    final prefs = await SharedPreferences.getInstance();
    var guestToken = prefs.getString('guest_token');
    String url = baseUrl + updatecartApi;

    final response = await http.post(
      Uri.parse(url),
      headers: {
        "guest-token": guestToken ?? '',
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "product_id": productId,
        "quantity": quantity.toString(),
      }),
    );

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

}

