// ignore_for_file: avoid_print
import 'package:http/http.dart' as http;
import 'dart:convert';

class SMSService {
  final String accountSid;
  final String authToken;
  final String senderId;

  SMSService({
    required this.accountSid,
    required this.authToken,
    required this.senderId,
  });

  Future<bool> sendStatusUpdate({
    required String toNumber,
    required String complaintId,
    required String status,
    required String title,
    required DateTime date,
  }) async {
    try {
      print("-------------------------------------------Starting SMS Service-------------------------------");
      print("Account SID: $accountSid");
      print("Sender ID: $senderId");
      print("To Number: $toNumber");
      
      final url = Uri.parse('https://api.twilio.com/2010-04-01/Accounts/$accountSid/Messages.json');
      print("URL: $url");
      
      final message = 'Your complaint #$complaintId "$title" has been $status at $date';
      print("Message: $message");
      
      print("-------------------------------------------Preparing Request-------------------------------");
      final auth = base64Encode(utf8.encode('$accountSid:$authToken'));
      print("Auth header prepared $auth");
      
      final body = {
        'From': senderId,
        'To': toNumber,
        'Body': message,
        // 'MessagingServiceSid': accountSid,
      };
      print("Request body prepared: $body");
      
      print("-------------------------------------------Sending Request-------------------------------");
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Basic $auth',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      
      print("-------------------------------------------Response Received-------------------------------");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      
      if (response.statusCode == 201) {
        print("--------------------------------------Success: Message sent successfully-------------------------------");
        return true;
      } else {
        print("--------------------------------------Error: Failed to send message-------------------------------");
        print("Error Response: ${response.body}");
        if (response.statusCode == 400) {
          print("Attempting fallback to phone number...");
          final fallbackBody = {
            'From': '+19705917736',
            'To': toNumber,
            'Body': message,
          };
          
          final fallbackResponse = await http.post(
            url,
            headers: {
              'Authorization': 'Basic $auth',
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: fallbackBody,
          );
          
          if (fallbackResponse.statusCode == 201) {
            print("Fallback successful: Message sent with phone number");
            return true;
          }
        }
        return false;
      }
    } catch (e, stackTrace) {
      print("--------------------------------------Exception Caught-------------------------------");
      print("Error: $e");
      print("Stack Trace: $stackTrace");
      return false;
    }
  }
} 