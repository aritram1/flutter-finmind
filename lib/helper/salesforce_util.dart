// ignore: depend_on_referenced_packages
// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, constant_identifier_names, 

import 'dart:core';
import 'package:finmind/helper/app_constants.dart';
import 'package:logger/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SalesforceUtil{

  // const static String VERSION = '59.0'

  // Declare required variables
  static String clientId = '';
  static String clientSecret = '';
  static String userName = '';
  static String pwdWithToken = '';
  static String tokenEndpoint = '';
  static String tokenGrantType = '';
  static String compositeUrlForInsert = '';
  static String compositeUrlForUpdate = '';
  static String compositeUrlForDelete = '';
  static String queryUrl = '';
  static bool debug = false; 
  static bool detaildebug = false;

  static String accessToken = '';
  static String instanceUrl = '';
  static String refreshToken = '';
  static String expiryTime = '';
  
  static Logger log = Logger();

  static bool initialized = false;

  static init() async {
    // Load environment variables from the .env file and assign to class variables
    await dotenv.load(fileName: ".env");
    clientId              = dotenv.env['clientId'] ?? '';
    clientSecret          = dotenv.env['clientSecret'] ?? '';
    userName              = dotenv.env['userName'] ?? '';
    pwdWithToken          = dotenv.env['pwdWithToken'] ?? '';
    tokenEndpoint         = dotenv.env['tokenEndpoint'] ?? '';
    tokenGrantType        = dotenv.env['tokenGrantType'] ?? '';

    compositeUrlForInsert = dotenv.env['compositeUrlForInsert'] ?? ''; // Standard Insert API from Salesforce - '/services/data/v59.0/composite/tree/'
    compositeUrlForUpdate = dotenv.env['compositeUrlForUpdate'] ?? ''; // Standard Update API from Salesforce - '/services/data/v59.0/composite/sobjects/'
    compositeUrlForDelete = dotenv.env['compositeUrlForDelete'] ?? ''; // Standard Delete API from Salesforce - '/services/data/v59.0/composite/sobjects?ids='
    queryUrl              = dotenv.env['queryUrl'] ?? '';              // Standard Query API from Salesforce  - '/services/data/v59.0/query?q='

    debug                 = bool.parse(dotenv.env['debug'] ?? 'false');
    detaildebug           = bool.parse(dotenv.env['detaildebug'] ?? 'false');

    initialized = true;

  }

  // Method to generate request header for logged in requests
  static Map<String, String> generateLoggedInRequestHeader(){
    Map<String, String> header = {
      'Content-Type' : 'application/json',
      'Authorization' : 'Bearer $accessToken'
    };
    return header;
  }

  // Generic method to generate the endpoint URL for the type of operation
  static String generateEndpointUrl({ required String opType, String objAPIName = '', 
                                      List<String> recordIds = const [], 
                                      int batchCount = 0, bool hardDelete = false}){
    String endpointUrl = '';
    if(opType == AppConstants.LOGIN){ // testing completed
      endpointUrl = tokenEndpoint
                      + '?' 
                      + 'client_id=$clientId'
                      + '&client_secret=$clientSecret'
                      + '&username=$userName'
                      + '&password=$pwdWithToken'
                      + '&grant_type=$tokenGrantType';
    }
    if(opType == AppConstants.INSERT){ // testing completed
      endpointUrl = '$instanceUrl$compositeUrlForInsert$objAPIName';
    }
    else if(opType == AppConstants.UPDATE){ // testing completed 
      endpointUrl = '$instanceUrl$compositeUrlForUpdate';
    }
    else if(opType == AppConstants.DELETE){
      if(recordIds.isNotEmpty){
        String ids = recordIds.join(',');
        endpointUrl = '$instanceUrl$compositeUrlForDelete$ids';
      }
    }
    if(detaildebug) log.d('Generated endpoint : $endpointUrl');
    return endpointUrl;
  }

  // Generic method to generate the body from the type of operation
  static Map<String, dynamic> generateBody({required String opType, String objAPIName = '', List<Map<String, dynamic>> fieldNameValuePairs = const [], List<String> recordIds = const [], int batchCount = 0}){
    
    Map<String, dynamic> body = {};
    
    if(opType == AppConstants.DELETE){}                    // no body element is required for delete
    else if(opType == AppConstants.SYNC){}                 // this is a custom API, as of now it does not require `body`
    else if(opType == AppConstants.DELETE_MESSAGES){}      // this is a custom API, as of now it does not require `body`
    else if(opType == AppConstants.APPROVE_MESSAGES){      // Approve MEssages
      Map<String, dynamic> dataMap = {};
      dataMap['data'] = recordIds;
      body['input'] = dataMap;
    }
    else if(opType == AppConstants.INSERT || opType == AppConstants.UPDATE){ // Insert or Update operation
      var allRecords = [];
      // int count = batchCount * MAXM_BATCH_SIZE;
      for(Map<String, dynamic> eachRecord in fieldNameValuePairs){
        Map<String, dynamic> each = {};
        each['attributes'] = {
          'type': objAPIName,
          'referenceId': eachRecord['ref'] //value is like 'ref1', 'ref2', 'ref3'
        };
        for(String fieldAPIName in eachRecord.keys){
          if(fieldAPIName != 'ref'){
            each[fieldAPIName] = eachRecord[fieldAPIName];
          }
        }
        allRecords.add(each);
        // count++;
      }
      body['records'] = allRecords;
      if(opType == AppConstants.UPDATE){
        body['allOrNone'] = 'false';
      }// if(detaildebug) log.d('body=>' + body.toString());
    }
    
    else if(opType == AppConstants.DELETE_TRANSACTIONS){}  // do nothing
    
    return body;
  }

  // Method specific to generate endpoint url for a query operation 
  static String generateQueryEndpointUrl(String objAPIName, List<String> fieldList, String whereClauseString, String orderByClauseString, int? count){
    String fields = fieldList.isNotEmpty ? fieldList.join(',') : 'count()';
    String whereClause = whereClauseString != '' ? 'WHERE $whereClauseString' : '' ;
    String orderByClause =  orderByClauseString != '' ? 'ORDER BY $orderByClauseString' : '';
    String limitCount = (count != null && count > 0) ? 'LIMIT $count' : '';

    String query = 'SELECT $fields FROM $objAPIName $whereClause $orderByClause $limitCount';
    if(debug) log.d('Generated Query : $query');

    query = query.replaceAll(' ', '+');
        
    final String endpointUrl = '$instanceUrl$queryUrl$query';
    if(detaildebug) log.d('endpointUrl inside generateQueryEndpointUrl: $endpointUrl');

    return endpointUrl;
  }

  // A simple method to return a template response map which can be re-used
  static Map<String, dynamic> getGenericResponseTemplate(){
    return {'data' : [], 'errors' : []};
  }
  
}
