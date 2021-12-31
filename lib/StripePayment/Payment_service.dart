import 'package:flutter/cupertino.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({required this.message, required this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';

  static String secret =
      'sk_test_51JzIYCK5aYKNbwmScwYULiJ4cBA8MCrH6hiJ07uPyB6JevBoQUXh7RKO3DJPGHZQsEBa71pNA0ZQXCpm53yi5RD800I3XZ7iQ7';
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51JzIYCK5aYKNbwmS8Xtv47DybKLSikxmMKBqiUCSJaKF9ODGB5sWT9gD6VUhs18L9Stp4FaarJtZ4kJfvzYDT6r600A5CNlhT9",
        merchantId: "Test",
        androidPayMode: 'test'));
  }

  // static Future<StripeTransactionResponse> payViaExistingCard(
  //     {String amount, String currency, CreditCard card}) async {
  //   try {
  //     var paymentMethod = await StripePayment.createPaymentMethod(
  //         PaymentMethodRequest(card: card));
  //     var paymentIntent =
  //         await StripeService.createPaymentIntent(amount, currency);
  //     var a = paymentIntent['client_secret'].toString().split("_");
  //     print("my new client id is:${a[0] + '_' + a[1]}");
  //     var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
  //         clientSecret: paymentIntent['client_secret'],
  //         paymentMethodId: paymentMethod.id));
  //     print(paymentIntent['client_secret']);

  //     if (response.status == 'succeeded') {
  //       return new StripeTransactionResponse(
  //           message: 'Transaction successful', success: true);
  //     } else {
  //       return new StripeTransactionResponse(
  //           message: 'Transaction failed', success: false);
  //     }
  //   } on PlatformException catch (err) {
  //     return StripeService.getPlatformExceptionErrorResult(err);
  //   } catch (err) {
  //     return new StripeTransactionResponse(
  //         message: 'Transaction failed: ${err.toString()}', success: false);
  //   }
  // }

  static Future<StripeTransactionResponse> payViaExistingCard(
      {String? amount, String? currency, CreditCard? card}) async {
    try {
      var paymentMethod = await StripePayment.createPaymentMethod(
          PaymentMethodRequest(card: card));
      var paymentIntent =
          await StripeService.createPaymentIntent(amount!, currency!);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent!['client_secret'],
          paymentMethodId: paymentMethod.id));
      if (response.status == 'succeeded') {
        return new StripeTransactionResponse(
            message: 'Transaction successful', success: true);
      } else {
        return new StripeTransactionResponse(
            message: 'Transaction failed', success: false);
      }
    } on PlatformException catch (err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return new StripeTransactionResponse(
          message: 'Transaction failed: ${err.toString()}', success: false);
    }
  }

  static Future<StripeTransactionResponse> payWithNewCard(
      {required String amount, required String currency}) async {
    print(amount);
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      var paymentIntent =
          await StripeService.createPaymentIntent(amount, currency);

      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent!['client_secret'],
          paymentMethodId: paymentMethod.id));
      if (response.status == 'succeeded') {
        return StripeTransactionResponse(
            message: 'Transaction successful', success: true);
      } else {
        return StripeTransactionResponse(
            message: 'Transaction failed', success: false);
      }
    } on PlatformException catch (err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return StripeTransactionResponse(
          message: 'Transaction failed: ${err.toString()}', success: false);
    }
  }

  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }

    return  StripeTransactionResponse(message: message, success: false);
  }

  static Future<Map<String, dynamic>?> createPaymentIntent(
      String? amount, String? currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(Uri.parse(StripeService.paymentApiUrl),
          body: body, headers: StripeService.headers);
      return jsonDecode(response.body);
    } catch (err) {
      print(err);
      print('err charging user: ${err.toString()}');
    }
    return null;
  }
}
