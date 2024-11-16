//message_util.dart
// ignore_for_file: constant_identifier_names, depend_on_referenced_packages

import 'dart:core';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:logger/logger.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FinPlanInboxManager {

  static bool debug = bool.parse(dotenv.env['debug'] ?? 'false');
  static bool detaildebug = bool.parse(dotenv.env['detaildebug'] ?? 'false');
  static int maximumMessageCount = int.parse(dotenv.env['maximumMessageCount'] ?? '5');

  static Logger log = Logger();
  
  ///////////////////////////////Get SMS Messages//////////////////////////////////////
  static Future<List<SmsMessage>> getInboxMessages({
    List<SmsQueryKind> kinds = const[SmsQueryKind.inbox], // SmsQueryKind.inbox, SmsQueryKind.sent, SmsMessageKind.draft
    String? sender, 
    int count = 10}) 
  async {
    
    List<SmsMessage> messages = [];

    var permission = await Permission.sms.status;

    if (permission.isGranted) {
      messages = await SmsQuery().querySms(
        kinds: kinds,         // SmsQueryKind.inbox, SmsQueryKind.sent, SmsMessageKind.draft
        address: sender,      // +1234567890
        count: count,  // 10
      );
    }
    else {
      await Permission.sms.request();
    }
    log.d('Inbox all message count : ${messages.length}');

    return messages;
  }

  // Get transactional messages
  static Future<List<SmsMessage>> getTransactionalMessages() async{
    
    bool isOTP = false;
    bool isPersonal = false;
    bool isTransactional = false;
    List<SmsMessage> transactionalMessages = [];
    
    List<SmsMessage> msgList = await getInboxMessages();
    
    for(int i = 0; i < msgList.length; i++){

      String msgUppercase = (msgList[i].body ?? '').toUpperCase();
      
      isOTP = msgUppercase.contains('OTP') || msgUppercase.contains('VERIFICATION CODE');
      isPersonal = msgList[i].sender!.toUpperCase().startsWith('+');
      isTransactional = msgUppercase.contains('RS ') 
                        || msgUppercase.contains('RS. ') 
                        || msgUppercase.contains('RS.')
                        || msgUppercase.contains('INR ');
      
      // Add to the message list if 
      // - Its NOT an OTP OR personal message
      // - but a transactional message
      if(!isOTP && !isPersonal && isTransactional){
        transactionalMessages.add(msgList[i]);
      }
    }

    // Clip the required number of messages from the list if the list contains sufficient items
    List<SmsMessage> listToReturn = (transactionalMessages.length <= maximumMessageCount) 
                                        ? transactionalMessages 
                                        : transactionalMessages.sublist(0, maximumMessageCount);
    return listToReturn;
  }

  // Method to convert the SMS Messages to a format that will be used for insert method later
  static Future<List<Map<String, dynamic>>> convertMessagesToMap(List<SmsMessage> messages) async{
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    String deviceName = androidInfo.model;

    List<Map<String, dynamic>> convertedMessages = [];
    for (SmsMessage sms in messages) {
      Map<String, dynamic> record = {
        "FinPlan__Content__c": "${sms.body != null && sms.body!.length > 255 ? sms.body?.substring(0, 255) : sms.body}",
        "FinPlan__Sender__c": "${sms.sender}",
        "FinPlan__Received_At__c": sms.date.toString(),
        "FinPlan__Device__c": deviceName,
        "FinPlan__Created_From__c" : "Sync" // Explicitly set as 'Sync' so it does not fire up the trigger on SMS Object
      };
      convertedMessages.add(record);
    }
    return convertedMessages;
  }

}