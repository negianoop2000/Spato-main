import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spato_mobile_app/app/routes/app_pages.dart';
import 'package:spato_mobile_app/common/setting_widget.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';
import 'package:spato_mobile_app/utils/constants/image_strings.dart';
import 'package:spato_mobile_app/utils/constants/loader.dart';
import 'package:spato_mobile_app/utils/constants/text_strings.dart';

import '../controllers/policy_condition_controller.dart';

class PolicyConditionView extends GetView<PolicyConditionController> {
  const PolicyConditionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color colorsecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color background = Theme.of(context).brightness == Brightness.light
        ? TColors.containerFillDark
        : TColors.black;
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;
    Color textColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colordarkgrey
        : TColors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          TTexts.txtPrivacyPolicy,
          style: AppTextStyles.black20
              .copyWith(fontWeight: FontWeight.w600, color: colorsecondary),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: background,
                border: Border.all(
                  color: borderColor,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: colorsecondary,
                  size: 15,
                ),
              ),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Privacy Policy for Using Our Website and APP\n\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text:
                    "1. Controller of Data Processing (hereinafter referred to as \"we\")\n\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text:
                    "SPATO GmbH Schellberger Weg 34 42659 Solingen Germany\n\nEmail: info@spato.de\n\nFor further details about us, please refer to our Legal Notice.\n\n",
                    style: TextStyle(color: textColor),
                  ),
                  TextSpan(
                    text:
                    "2. Personal Data, Purposes of Processing, and Legal Basis\n\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text:
                    "The use of our website is generally possible without providing personal data. Providing personal data is voluntary.\n\nPersonal data includes any information relating to an identified or identifiable natural person (hereinafter referred to as \"data subject\"). An identifiable natural person is one who can be identified, directly or indirectly, in particular by reference to an identifier such as a name, an identification number, location data, an online identifier, or one or more factors specific to the physical, physiological, genetic, mental, economic, cultural, or social identity of that natural person.\n\nThe purpose of data processing is to operate this website with information about our services, including contact options and online application opportunities.\n\nPersonal data is collected on our website only if it is:\n\n- Necessary for the use of the website (Legal basis: Article 6(1)(a) and/or Article 6(1)(b) of the General Data Protection Regulation (GDPR)),\n\n- To protect our interest in improving the user experience and maintaining the security of use (Legal basis: Article 6(1)(f) GDPR),\n\n- For the use of the services offered on the website and for pre-contractual measures, especially for form inputs (Legal basis: Article 6(1)(a) and/or Article 6(1)(b) GDPR), or\n\n- For contract conclusion and contract execution (Legal basis: Article 6(1)(a) and Article 6(1)(b) GDPR).\n\nFurther details on data processing can be found below under the respective headings:\n\n",
                    style: TextStyle(color: textColor),
                  ),
                  TextSpan(
                    text: "3. Access Data/Server Log Files\n\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text:
                    "When you visit our website, the servers automatically store information that your browser sends, known as server log files. This information includes:\n\n- Name of the accessed website,\n\n- File,\n\n- Date and time of access,\n\n- Message about successful retrieval,\n\n- Browser type and version,\n\n- User's operating system,\n\n- Referrer URL,\n\n- IP address (anonymized),\n\n- Provider.\n\nThis data is not merged with other data sources. The information is used exclusively for the analysis and maintenance of the technical operation of the servers and the network in accordance with Article 6(1)(f) GDPR.\n\n",
                    style: TextStyle(color: textColor),
                  ),
                  TextSpan(
                    text: "4. Cookies\n\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text:
                    "Our website stores cookies. Cookies are small files that enable specific, device-related information to be stored on the user's access device (PC, smartphone, etc.). They serve the usability of websites and thus the users (e.g., storage of login data). They also serve to collect statistical data on website usage and analyze it for the purpose of improving the offer. Further information can be found in the following sections of our privacy policy. If you consent to non-essential cookies, the legal basis is Section 25(1) TDDDG, Article 6(1)(a) GDPR (consent). Further information on the cookies or services used can be found in our consent management tool, and consents can be freely withdrawn at any time with effect for the future without disadvantage.\n\nUsers can influence the use of cookies. Most browsers have an option to limit or prevent the storage of cookies. However, it is pointed out that the use and, in particular, the user convenience without cookies may be limited.\n\n",
                    style: TextStyle(color: textColor),
                  ),
                  TextSpan(
                    text: "5. Contact via Email\n\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text:
                    "If you send us inquiries via email, your details from the email, including the contact data you provided there, will be stored with us for the purpose of processing the inquiry and for any follow-up questions in accordance with Article 6(1)(b) GDPR. We store and use the personal data voluntarily provided by you to the extent necessary for further correspondence with you.\n\nIf you, as a consumer or B2B customer, send an inquiry via email through our website, we forward your inquiry to the appropriate supplier in your area or the specifically requested supplier. The legal basis for the forwarding is your consent according to Article 6(1)(a) GDPR and the processing of your inquiry according to Article 6(1)(b) GDPR.\n\n",
                    style: TextStyle(color: textColor),
                  ),
                  TextSpan(
                    text: "6. Contact Form\n\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text:
                    "If you send us inquiries via the contact form, your details from the inquiry form, including the contact data you provided there, will be stored with us for the purpose of processing the inquiry and for any follow-up questions in accordance with Article 6(1)(b) GDPR.\n\nIf you, as a consumer or B2B customer, send an inquiry via the contact form through our website, we forward your inquiry to the appropriate supplier in your area or the specifically requested supplier. The legal basis for the forwarding is your consent according to Article 6(1)(a) GDPR and the processing of your inquiry according to Article 6(1)(b) GDPR.\n\n",
                    style: TextStyle(color: textColor),
                  ),
                  TextSpan(
                    text: "7. Customer Account\n\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text:
                    "To make direct purchases as an entrepreneur or to forward your inquiries about specific products to the respective suppliers, you need to create a customer account on our website. The required information (mandatory fields) will be displayed during the registration process. Providing this data is necessary for us to set up the customer account for you. Data processing is based on the necessity of pre-contractual measures or contract execution in accordance with Article 6(1)(b) GDPR.\n\n",
                    style: TextStyle(color: textColor),
                  ),
                  TextSpan(
                    text: "8. PayPal\n\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text:
                    "If you choose to make a purchase via PayPal, we transmit the payment details to PayPal (Europe) S.à r.l. et Cie, S.C.A., 22-24 Boulevard Royal, L-2449 Luxembourg (\"PayPal\"). PayPal is used in the context of processing contracts (Article 6(1)(b) GDPR). PayPal may conduct a credit check. For this, PayPal uses the results of previous payments from the user's PayPal account and credit data from credit reporting agencies.\n\n",
                    style: TextStyle(color: textColor),
                  ),
                  TextSpan(
                    text: "9. SSL Encryption\n\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text:
                    "To protect the transmission of confidential content, such as the inquiries you send to us as the site operator, this site uses SSL encryption. You can recognize an encrypted connection by the browser's address line changing from \"http://\" to \"https://\" and the lock symbol in your browser line.\n\n",
                    style: TextStyle(color: textColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

