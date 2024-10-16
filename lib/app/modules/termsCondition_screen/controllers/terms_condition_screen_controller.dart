import 'package:get/get.dart';

class TermsConditionScreenController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  final RxString termsConditionsText = """
General terms and conditions of SPATO GmbH represented by the managing director Mr. Oliver Laug
Schellberger Weg 34, 42659 Solingen
Email: info@spato.de
VAT ID: DE346441844
Commercial register of the Wuppertal district court Commercial register number HRB 32131. hereinafter referred to as SPATO.

§ 1 General, definitions
• SPATO offers entrepreneurs within the meaning of Paragraph 2 of these General Terms and Conditions in particular swimming pools and pools along with accessories. The general terms and conditions apply in their respective version.
• Customers within the meaning of these General Terms and Conditions are exclusively entrepreneurs and these General Terms and Conditions only apply if the customer is an entrepreneur (§ 14 BGB). SPATO sells and delivers goods exclusively to entrepreneurs (§ 14 BGB).
• Individual contractual agreements take precedence over these General Terms and Conditions. Differing, conflicting or supplementary terms and conditions will not become part of the contract unless their validity is expressly agreed to. These terms and conditions also apply if SPATO carries out the delivery to the customer without reservation despite being aware of the customer's conditions that conflict with or deviate from these terms and conditions.

§ 2 Registration
• For orders, prior registration as a customer is required. This can only be done via the SPATO website at www.spato.de, by email or on site at SPATO.
• Only entrepreneurs are entitled to register. Proof must be provided by submitting a business registration.

§ 3 Conclusion of contract
• SPATO's offers are always subject to change and non-binding, unless the offer states otherwise. Due to the technical display options, the ordered goods may differ slightly, within reason, from the goods shown on the Internet, catalogs or other product descriptions; in particular, there may be color differences.
• The customer can order via the SPATO website, by email, by telephone or on site in the SPATO store. The customer's order represents a binding offer to conclude a purchase contract for the ordered goods.
• Unless Section 4 of these General Terms and Conditions applies or something else has been agreed between the parties, the ordering process is as follows:
• Online booking
  To order goods, the customer must put the desired items in the shopping cart. The customer will see the item(s) they selected in the shopping cart. In this shopping cart overview, the customer can change the desired quantity of the respective item in the “Quantity” field or delete it by pressing the “x” field. The customer can continue their ordering process by clicking the “Continue to checkout” button. The customer must now enter their address details and an email address. He can then select the desired payment method. The customer can also view the general terms and conditions here. By ticking the relevant input field, the customer confirms that he has read the right of cancellation, the model cancellation form and the data protection declaration and that he accepts the general terms and conditions. An overview of the order then follows. The order can then be completed by clicking the “Order for a fee” button.
  Input errors: Entries during the ordering process can be corrected at any time by the customer using the “Back” button marked with a green arrow pointing to the left in their browser and then making the appropriate change. You can also edit the data entered during the ordering process using the “Back” function in your Internet browser. You can cancel the entire ordering process at any time by closing your internet browser.
  The purchase contract is concluded
    • by sending a separate email with an order confirmation or
    • with the delivery of the goods or
    • if the customer is asked to pay by SPATO after placing his order, whereby if several alternatives arise, the earlier one is decisive for the conclusion of the contract.
  SPATO will immediately confirm receipt of the booking/order to the customer by email.
• Order by email or telephone
  Upon request from the customer, SPATO will make a corresponding offer to the customer. This does not constitute an offer in the legal sense, but rather merely an invitation to the customer to make an offer in the legal sense.
  The order by the customer represents a binding offer to conclude a corresponding contract. SPATO can accept this within a period of 5 days.
• Ordering in store
  The customer can also place an order directly on site at the SPATO store.
  In this case, the contract for the purchase of the ordered goods is concluded directly when the order is placed.
• The contract is concluded with the reservation that it will not be performed in the event of incorrect delivery. This only applies in the event that SPATO is not responsible for the non-delivery and has concluded a specific cover transaction with the supplier with due care. SPATO will make all reasonable efforts to procure the goods. Otherwise, the consideration will be refunded immediately. If the goods are not available, the customer will be informed immediately.
• If the customer orders the goods electronically, the contract text will be saved by the seller and sent to the customer, together with the legally valid terms and conditions, by email after the contract has been concluded.
• Return conditions for entrepreneurs (B2B)
  Are you an entrepreneur and not a consumer within the meaning of §13 BGB? It is then possible for us to take back goods as a gesture of goodwill under the following conditions. Please ask us about the return beforehand.
  Merchandise return/restocking fee
    • If we voluntarily take back goods from the customer, the following applies: Only goods in a proper, salable condition that are not custom-made or ordered can be taken back. If the goods are returned, the customer will receive a refund in the amount of the value of the goods, less a restocking fee. The refund will not be paid out in cash, but will only be offset against future purchases or orders. We are entitled to set off any refund amounts without restriction.
    • The restocking fee is a flat rate of 17.5% of the value of the goods taken back per item, unless a different value is agreed upon when the goods are taken back.
    • Termination of current orders/order confirmations/contracts
      If current orders/order confirmations/contracts are terminated by the buyer, SPATO is entitled to charge the buyer an expense allowance. The expense allowance will be charged to the buyer at least 20% of the order volume. If costs are higher, they will be charged to the buyer in full.
      If the buyer has made a down payment, SPATO is entitled to offset this against the expense allowance and, if necessary, to recalculate it.

§ 4 Conclusion of contract for custom-made products
• Upon request from the customer, SPATO will send the customer a binding offer for custom-made products. The customer can accept this within 5 working days by sending a corresponding signed order confirmation.
• Cost estimates are always non-binding.
• The offer calculations are based on the values of the inquiry or the information provided by the customer.
  The customer is obliged to provide the measurements and other data relevant to the custom-made product. SPATO will include this in its offer. By signing the order confirmation, the customer confirms that this data is correct.
• SPATO reserves ownership of the goods until all claims from an ongoing business relationship have been settled in full.
• If the customer behaves in breach of contract, in particular if payment is delayed, if the customer provides false information about his creditworthiness or if an application is made to open insolvency proceedings, SPATO is entitled - if necessary after setting a deadline - to withdraw from the contract and demand the return of the goods , provided that the customer has not yet provided the consideration or has not provided it in full.
• The customer is entitled to resell the goods in the ordinary course of business. He now agrees to SPATO all claims in accordance with. H.d. the invoice amount that accrues to him through the resale to a third party. SPATO accepts the assignment. After the assignment, the customer is authorized to collect the claim. SPATO reserves the right to collect the claim itself as soon as the customer does not properly meet his payment obligations and defaults on payment.
• SPATO undertakes to release the securities to which it is entitled at the customer's request to the extent that the realizable value of the securities exceeds the claim to be secured by more than 10%. SPATO is responsible for selecting the securities to be released.

§ 5 Retention of title
(3) The customer only has the right to offset if his counterclaims have been legally established, recognized or not disputed by SPATO. The customer's right to offset contractual and other claims arising from the initiation or implementation of this contractual relationship remains unaffected. The customer can only exercise a right of retention if his counterclaim is based on the same contractual relationship.

§ 7 Payment options and Payment terms
(1) The payment options available to the customer are shown to the customer in the respective offer
• Further information about the payment methods can be found in the data protection declaration on the SPATO website.
• If the goods have not been paid for within the agreed payment terms, the customer is in default without the need for a reminder. In this case, he has to pay default interest of 10% above the applicable base interest rate (§§ 288 Para. 2 BGB). Any reminder costs incurred are borne by the customer. If it can be proven that there is higher damage caused by the delay, this can also be claimed.
• Payment terms
  The buyer is only entitled to withhold payment or to set off any counterclaims if these counterclaims are undisputed or have been legally established. In the event of defects in the delivery, the customer's rights, in particular in accordance with Section 437 No. 3 BGB, remain unaffected.

§ 8 Shipping and costs
• Unless otherwise agreed, delivery is made from the warehouse to the delivery address specified by the customer.
• If the customer's desired delivery method differs from SPATO's standard shipping method, the additional costs will be charged to the customer.
• If the customer is in default of acceptance or culpably violates other obligations to cooperate, SPATO is entitled to demand compensation for the damage incurred, including any additional expenses. Further claims remain unaffected. The customer bears the risk of accidental loss or accidental deterioration of the purchased item at the point in time at which he defaults on acceptance or payment.

§ 9 Notices of defects and warranty rights
(1) The customer's warranty rights require that the customer has properly fulfilled his obligations to inspect and give notice of defects in accordance with Section 377 HGB. Notices of defects must be sent in writing (email is sufficient) to SPATO immediately, but at the latest within 2 days of delivery of the goods.
• SPATO must be given the opportunity to check the goods complained about. Upon request, the goods complained about must be returned to SPATO for inspection at SPATO's expense. In the event of a justified complaint, SPATO will reimburse the cost of the most favorable shipping route; this does not apply if the costs increase because the purchased item is at a location other than the location of the intended use.
• The customer is entitled to supplementary performance in the event of a defect.
• If the customer chooses supplementary performance, SPATO is entitled to refuse the supplementary performance chosen by the customer if this is only possible with disproportionate costs and the other type of supplementary performance remains without significant disadvantages for the customer. In this case, the customer's right is limited to the other type of supplementary performance. SPATO can refuse supplementary performance altogether if it is only possible with disproportionate costs.
• If the supplementary performance has failed, the customer can request a reduction or withdraw from the contract.

§ 10 Data protection
• The parties are obliged to observe the statutory provisions on data protection, in particular the provisions of the General Data Protection Regulation (GDPR) and the Federal Data Protection Act (BDSG).
• Both parties are aware that personal data is used for the purpose of the contract and its implementation, in particular for mutual correspondence, for contract management and for the purposes of the resulting obligations.
• Personal data is also stored by both parties and used for the purpose of the contract. This data will only be used for the implementation and processing of the contractual relationship. Further information about the handling of personal data can be found in the data protection declaration on the SPATO website.
• The parties undertake to ensure that personal data is protected against unauthorized access, misuse and loss. Furthermore, both parties will ensure that the legal requirements for data protection are met. To this end, they will take the necessary technical and organizational measures and ensure that these are implemented accordingly.
• Both parties are also obliged to ensure that personal data is only stored for as long as it is necessary to fulfill the contract and to process any claims arising from the contract. If the parties store personal data beyond the period of the contract, they must ensure that it is deleted or anonymized accordingly as soon as the storage is no longer necessary.

§ 11 Limitation of liability
(1) SPATO is liable for damage caused by intent or gross negligence, for culpable injury to life, limb or health, for defects that SPATO has fraudulently concealed, for damage resulting from the lack of a quality guaranteed by SPATO and for damage that is subject to mandatory liability under the Product Liability Act, in accordance with the statutory provisions.
• In the event of a slightly negligent breach of an obligation that is essential for achieving the purpose of the contract (cardinal obligation), SPATO's liability is limited to the amount of damage that is foreseeable and typical for the contract at the time the contract was concluded. SPATO is not liable for slightly negligent breaches of contractual obligations that are not cardinal obligations.

§ 12 Final provisions
(1) If the customer is a merchant, a legal entity under public law or a special fund under public law, the exclusive place of jurisdiction for all disputes arising from this contract is SPATO's place of business. The same applies if the customer has no general place of jurisdiction in Germany or if their place of residence or habitual abode is not known at the time the action is filed. SPATO is also entitled to sue the customer at his general place of jurisdiction.
• The law of the Federal Republic of Germany applies to the exclusion of the UN Sales Convention.
• Should individual provisions of this contract be or become ineffective or contain a loophole, the remaining provisions remain unaffected. The parties undertake to replace the ineffective provision with an effective provision that comes as close as possible to the economic meaning and purpose of the ineffective provision. In the event of a loophole, the parties undertake to fill the gap with a provision that corresponds to what would have been agreed according to the meaning and purpose of the contract if the matter had been considered from the outset.

Solingen, August 2023

""".obs;

  @override
  void onInit() {
  super.onInit();
  fetchTermsConditions();
  }

  void fetchTermsConditions() async {
  isLoading.value = true;

  // Simulate loading of terms and conditions
  await Future.delayed(Duration(seconds: 2));

  // This is where you'd usually load the terms and conditions from an API or file.
  // For now, we're using the hardcoded string in termsConditionsText.

  isLoading.value = false;
  }
  }