import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentService {
  static const String serverKey = 'SB-Mid-server-BXZqRYO9KQUw7BkoO8CJK_H-';
  static const String apiUrl =
      'https://app.sandbox.midtrans.com/snap/v1/transactions';

  Future<String> createTransaction(
      double amount, String orderId, String customerEmail) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Basic ' + base64Encode(utf8.encode(serverKey)),
      },
      body: jsonEncode({
        "transaction_details": {
          "order_id": orderId,
          "gross_amount": amount.toInt(),
        },
        "credit_card": {
          "secure": true,
        },
        "customer_details": {
          "email": customerEmail,
        },
      }),
    );

    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      return responseData['redirect_url'];
    } else {
      print('response ${response.body}');
      throw Exception('Failed to create transaction');
    }
  }
}
