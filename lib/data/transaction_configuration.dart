// Khalti configuration
import 'package:khalti_flutter/khalti_flutter.dart';

class TransactionConfiguration {
  static PaymentConfig config({
    required int amount,
  }) {
    return PaymentConfig(
      amount: amount, // Amount should be in paisa
      productIdentity: 'dell-g5-g5510-2021',
      productName: 'Dell G5 G5510 2021',
      productUrl: 'https://www.khalti.com/#/bazaar',
      additionalData: {
        // Not mandatory; can be used for reporting purpose
        'vendor': 'Khalti Bazaar',
      },
      mobile:
          '9840355789', // Not mandatory; can be used to fill mobile number field
      mobileReadOnly:
          false, // Not mandatory; makes the mobile field not editable
    );
  }
}
