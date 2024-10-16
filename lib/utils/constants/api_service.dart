import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class ApiService {
  static late final BuildContext context;
  static const String webUrl = "https://spa2.de";
  static const String baseUrl = "https://spa2.de/";
  static const String pdfUrl = "https://spa2.de/storage/";
  static const String imageUrl = "https://spa2.de/storage/";
  static const String register = "register";
  static const String login = "login";
  static const String forgetPassword = "forgetPassword";
  static const String passwordReset = "password/reset";
  static const String getAllLatestProductsApi = "getAllLatestProductsApi";
  static const String home1 = "home1";
  static const String subscribeNewsLetterApi = "subscribeNewsLetterApi";
  static const String cartAddApi = "cart/addApi";
  static const String cartGetCartItemsApi = "cart/getCartItemsApi";
  static const String cartUpdateQuantityApi = "cart/updateQuanityApi";
  static const String deleteCartProductsApi = "deleteCartProductsApi/";
  static const String cartCheckoutItemsApiAuthentic = "cart/checkoutItemsApiAuthentic";
  static const String profileViewApi = "profileViewApi";
  static const String showOrderHistoryApi = "showOrderHistoryApi";
  static const String productsByCategoriesApi = "ProductsByCategoriesApi/";
  static const String productdetailPageApi = "ProductdetailPageApi/";
  static const String userLogoutUrl = "logoutApi";
  static const String userDeleteUrl = "delete-account";
  static const String submitQuotesUrl ="submitQuotes";
  static const String saveAddressApi ="saveTempAddressApi";
  static const String offerListingApi ="offerListingApi";
  static const String updateQuantityApi ="updateQuanityApi";
  static const String editProfileApi ="addPermanentProfileApi";
  static const String checkoutApi ="cart/checkoutItemsApiAuthentic";
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




  Future loginApi(email, password) async {
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
      String vatId,
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

  Future<Map<String, dynamic>> productCategories(String category) async {
    final response = await http.get(
      Uri.parse("$baseUrl$productsByCategoriesApi$category"),
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
      Uri.parse("${baseUrl}${profileViewApi}"),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }
  Future getAllLatestProductsHomeApi() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse("${baseUrl}${getAllLatestProductsApi}"),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }
  Future getSupplierListHomeApi() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse("${baseUrl}${getSupplierListApiUrl}"),
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
      Uri.parse("${baseUrl}${home1}"),
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
    final response = await http.get(
      Uri.parse("${baseUrl}${showOrderHistoryApi}"),
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
      Uri.parse("${baseUrl}${showSparePartHistoryApi}"),
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
    final response = await http.get(
      Uri.parse("${baseUrl}${cartGetCartItemsApi}"),
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
    var guestToken = prefs.getString('guest_token');
    final response = await http.post(
      Uri.parse(baseUrl + cartAddApi),
      headers: {
        "guest-token": guestToken ?? '',
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "product_id": productId,
        "quantity": quantity.toString()
      }),
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }


  Future userLogoutApi() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(
      Uri.parse('$baseUrl$userLogoutUrl'),
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

  Future productDetail(int id , String Manufacturer) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse("${baseUrl}${productdetailPageApi}$id/$Manufacturer"),//3843/Technik
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }


  Future submitQuotesApi(String productId, String firmName, String contactName, String new_email, String mobile, String sparePartName, String quoteNeededBy, String budget, String overview, File file) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
  //  if (!(await _checkConnectivity())) return null;
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl + submitQuotesUrl));
    request.headers['Authorization'] = 'Bearer $authToken';

    request.fields['product_id'] = productId;
    request.fields['firmName'] = firmName;
    request.fields['contactName'] = contactName;
    request.fields['new_email'] = new_email;
    request.fields['mobile'] = mobile;
    request.fields['sparePartName'] = sparePartName;
    request.fields['QuoteNeededBy'] = quoteNeededBy;
    request.fields['budget'] = budget;
    request.fields['Overview'] = overview;

    if (file != null) {
      request.files.add(await http.MultipartFile.fromPath('Document', file.path));
    }

    var response = await request.send();
    final responseBody = await response.stream.bytesToString();
    var convertDataToJson = jsonDecode(responseBody);
    return convertDataToJson;
  }

  Future getofferListingApi() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse("${baseUrl}${offerListingApi}"),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
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

  Future<Map<String, dynamic>?> applyDiscCodeApi(String applyDiscCode, double originalSummaryTotal) async {
    final prefs = await SharedPreferences.getInstance();
    var guestToken = prefs.getString('guest_token');
    final response = await http.get(
      Uri.parse('${baseUrl + applyDisccodeApi}?apply_disc_code=$applyDiscCode&orderSummaryTotal=$originalSummaryTotal'),
      headers: {
        "guest-token": guestToken ?? '',
        "Content-Type": "application/json",
      },
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
      Uri.parse("${baseUrl}${deleteCartItemApi}$productId"),
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
    final response = await http.post(
      Uri.parse("${baseUrl}${addRevewRattingApi}$productId"),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      body: ({
        "rating": rating,
        "reviewComment": comment,
      }),
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }


  Future searchApi(String searchText) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    String Url = "$baseUrl${menuSearchApi}?text=$searchText";
    final response = await http.get(
      Uri.parse(Url),
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
      Uri.parse("${baseUrl}${saveTempAddressUrl}"),
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
    final response = await http.post(
      Uri.parse("${baseUrl}${addOrderApi}"),
      headers: {
        'Authorization': 'Bearer $authToken',
        "guest-token": guestToken ?? '',
        'Content-Type': 'application/json',
      },
      body: bodyJson,
    );
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
      Uri.parse("${baseUrl}${b2b_saveContactAddressApi}"),
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
  Future b2b_deleteTempAddress(int Address_id) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    String Url = "$baseUrl$b2b_contactAddressDeleteApi$Address_id";
    final response = await http.get(
      Uri.parse(Url),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future b2b_getAssignmentDetails(String assignment_no,) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse('${baseUrl + b2b_getAssignmentDetailsApi}?assignment_no=$assignment_no'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }


  Future notificationsApi() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse('${"http://192.168.1.13:8000/" + notifications}'),
      headers: {
        'Authorization': 'Bearer 139|nfaR6RVohfurM1GIwELLh6Og93jg2fS1Zr8Dpxysc3b57167',        "Content-Type": "application/json",
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future read_notification(String id) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(
      Uri.parse('${"http://192.168.1.13:8000/$readnotification"}?notification_id=$id'),
      headers: {
        'Authorization': 'Bearer 139|nfaR6RVohfurM1GIwELLh6Og93jg2fS1Zr8Dpxysc3b57167',
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
      Uri.parse('${"http://192.168.1.13:8000/$deletenotification"}?notification_id=$id'),
      headers: {
        'Authorization': 'Bearer 139|nfaR6RVohfurM1GIwELLh6Og93jg2fS1Zr8Dpxysc3b57167',
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
      Uri.parse("${baseUrl}${getProductsAllCategoryUrl}"),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future BannnerContent() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse("${baseUrl}${getBannnerContentUrl}"),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future getMainCategory() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse("${baseUrl}${getMainCategory1ApiUrl}"),
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

    String selectedSuppliersQuery = selectedSupplierIndexes
        .map((index) => 'selectedSuppliers[]=${Uri.encodeQueryComponent(index.toString())}')
        .join('&');
    final response = await http.get(
      Uri.parse('$baseUrl$getDynamicNavbarUrl?Kategorie_1=${Uri.encodeQueryComponent(mainCategory)}&$selectedSuppliersQuery'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future getFilterProducts(String mainCategory, List<int> selectedSupplierIndexes) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');

    String selectedSuppliersQuery = selectedSupplierIndexes
        .map((index) => 'selectedSuppliers[]=${Uri.encodeQueryComponent(index.toString())}')
        .join('&');
    final response = await http.get(
      Uri.parse('$baseUrl$getFilterProductsApiUrl?selectedKategories=${Uri.encodeQueryComponent(mainCategory)}&$selectedSuppliersQuery'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }



  Future getSparepartImage(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse("${baseUrl}${getSparepartImageUrl}$productId"),
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

}

