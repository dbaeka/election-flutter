import 'dart:async';
import 'dart:convert';

//import 'package:flutter_auth/modals.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyFunctions {
  //test
  // static const api_root = "https://electiongh.herokuapp.com/api/v1";
  //new
  static const api_root = "https://ghelectionmonitoring.com/api/v1";

  // static const api_root = "https://server.test/api/v1";
  static Future<String> loggIn(Map body) async {
    try {
      //toast("I am here");

      Map<String, String> header = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      return http
          .post(api_root + "/authenticate",
              body: jsonEncode(body), headers: header)
          .then((http.Response response) {
        final int statusCode = response.statusCode;

        //toast(response.toString());

        if (statusCode < 200 || statusCode > 400 || json == null) {
          throw new Exception("Data failed to load");
        }

        String returnVal = (response.body == null) ? "" : response.body;

        //print(statusCode.toString() + " / " + returnVal);

        return returnVal;
      }).catchError((error) =>
              print("Server not reached: Error Msg=>" + error.toString()));
    } catch (error) {
      print(error);
      return '{"data":null}';
    }
  }

  static Future<String> postWithToken(Map body) async {
    try {
      //final SharedPreferences prefs = await SharedPreferences.getInstance();
      //String login = prefs.getString("login");

      String token = await getToken();
      // jsonDecode(login)["token"].trim();

      //print(token);

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer " + token
      };
      return http
          .post(api_root + "/results", body: jsonEncode(body), headers: headers)
          .then((http.Response response) {
        final int statusCode = response.statusCode;
        //print(statusCode);

        return statusCode.toString();
      }).catchError((error) =>
              print("Server not reached: Error Msg:" + error.toString()));
    } catch (_) {
      return '{"data":null}';
    }
  }

  static Future<String> savePmResults(Map body) async {
    try {
      String token = await getToken();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer " + token
      };
      return http
          .post(api_root + "/pm_results", body: jsonEncode(body), headers: headers)
          .then((http.Response response) {
        final int statusCode = response.statusCode;
        //print(statusCode);

        return statusCode.toString();
      }).catchError((error) =>
              print("Server not reached: Error Msg:" + error.toString()));
    } catch (_) {
      return '{"data":null}';
    }
  }

  static Future<String> saveImage(Map body) async {
    try {
      String token = await getToken();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer " + token
      };
      return http
          .post(api_root + "/images/base64",
              body: jsonEncode(body), headers: headers)
          .then((http.Response response) {
        final int statusCode = response.statusCode;

        String returnVal = (response.body == null) ? "" : response.body;

        print("image2" + returnVal);

        return statusCode.toString();
      }).catchError((error) =>
              print("Server not reached: Error Msg:" + error.toString()));
    } catch (_) {
      return '{"data":null}';
    }
  }

   static Future<String> savePmImage(Map body) async {
    try {
      String token = await getToken();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer " + token
      };
      return http
          .post(api_root + "/pm_images",
              body: jsonEncode(body), headers: headers)
          .then((http.Response response) {
        final int statusCode = response.statusCode;

        String returnVal = (response.body == null) ? "" : response.body;

        print("image2" + returnVal);

        return statusCode.toString();
      }).catchError((error) =>
              print("Server not reached: Error Msg:" + error.toString()));
    } catch (_) {
      return '{"data":null}';
    }
  }

  static Future<String> getUploadHistory() async {
    try {
      String token = await getToken();

      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer " + token
      };
      return http
          .get(api_root + "/upload_history", headers: headers)
          .then((http.Response response) {
        //final int statusCode = response.statusCode;

        String returnVal = (response.body == null) ? "" : response.body;

        //print(returnVal);

        return returnVal;
      }).catchError((error) =>
              print("Server not reached: Error Msg:" + error.toString()));
    } catch (_) {
      return '{"data":null}';
    }
  }

   static Future<String> getUploadHistoryPm() async {
    try {
      String token = await getToken();

      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer " + token
      };
      return http
          .get(api_root + "/pm_upload_history", headers: headers)
          .then((http.Response response) {
        //final int statusCode = response.statusCode;

        String returnVal = (response.body == null) ? "" : response.body;

        //print(returnVal);

        return returnVal;
      }).catchError((error) =>
              print("Server not reached: Error Msg:" + error.toString()));
    } catch (_) {
      return '{"data":null}';
    }
  }

  static Future<String> saveEditedResults(Map body) async {
    try {
      String token = await getToken();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer " + token
      };
      return http
          .patch(api_root + "/results",
              body: jsonEncode(body), headers: headers)
          .then((http.Response response) {
        final int statusCode = response.statusCode;

        //String returnVal = (response.body == null) ? "" : response.body;

        //print(returnVal);

        print(statusCode);

        return statusCode.toString();
      }).catchError((error) =>
              print("Server not reached: Error Msg:" + error.toString()));
    } catch (_) {
      return '{"data":null}';
    }
  }

  static loggedInDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String loggedInDetails = prefs.getString("login");

    return loggedInDetails;
  }

  static getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = jsonDecode(prefs.getString("login"))["token"];
    //print(token);
    return token;
  }

static getLoggedInData(String field) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String info = jsonDecode(prefs.getString("login"))[field];
    //print(token);
    return info;
  }
  static Future<String> getAllResults() async {
    try {
      String token = await getToken();

      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer " + token
      };
      return http
          .get(api_root + "/results", headers: headers)
          .then((http.Response response) {
        //final int statusCode = response.statusCode;

        String returnVal = (response.body == null) ? "" : response.body;

        //print(returnVal);

        return returnVal;
      }).catchError((error) =>
              print("Server not reached: Error Msg:" + error.toString()));
    } catch (_) {
      return '{"data":null}';
    }
  }

  static Future<String> getAllStations() async {
    try {
      String token = await getToken();

      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer " + token
      };
      return http
          //.get(api_root + "/stations", headers: headers)
          .get(api_root + "/stations?page[size]=30&sort=-updated_at",
              headers: headers)
          .then((http.Response response) {
        //final int statusCode = response.statusCode;

        String returnVal = (response.body == null) ? "" : response.body;

        //print(returnVal);

        return returnVal;
      }).catchError((error) =>
              print("Server not reached: Error Msg:" + error.toString()));
    } catch (_) {
      return '{"data":null}';
    }
  }

  static Future<String> getAllNew() async {
    try {
      String token = await getToken();

      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer " + token
      };
      return http
          .get(api_root + "/stations/new?page[size]=30", headers: headers)
          .then((http.Response response) {
        //final int statusCode = response.statusCode;

        String returnVal = (response.body == null) ? "" : response.body;

        //print(returnVal);

        return returnVal;
      }).catchError((error) =>
              print("Server not reached: Error Msg:" + error.toString()));
    } catch (_) {
      return '{"data":null}';
    }
  }

  static Future<String> getAllApproved() async {
    try {
      String token = await getToken();

      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer " + token
      };
      return http
          .get(api_root + "/stations/old?page[size]=30", headers: headers)
          .then((http.Response response) {
        //final int statusCode = response.statusCode;

        String returnVal = (response.body == null) ? "" : response.body;

        //print(returnVal);

        return returnVal;
      }).catchError((error) =>
              print("Server not reached: Error Msg:" + error.toString()));
    } catch (_) {
      return '{"data":null}';
    }
  }

  static Future<String> getPendings() async {
    try {
      String token = await getToken();

      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer " + token
      };
      return http
          .get(api_root + "/stations/pending?page[size]=30", headers: headers)
          .then((http.Response response) {
        //final int statusCode = response.statusCode;

        String returnVal = (response.body == null) ? "" : response.body;

        //print(returnVal);

        return returnVal;
      }).catchError((error) =>
              print("Server not reached: Error Msg:" + error.toString()));
    } catch (_) {
      return '{"data":null}';
    }
  }

  static Future<String> getSingleResult(String id) async {
    try {
      String token = await getToken();

      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer " + token
      };
      return http
          .get(api_root + "/results/" + id, headers: headers)
          .then((http.Response response) {
        //final int statusCode = response.statusCode;

        String returnVal = (response.body == null) ? "" : response.body;

        //print(returnVal);

        return returnVal;
      }).catchError((error) =>
              print("Server not reached: Error Msg:" + error.toString()));
    } catch (_) {
      return '{"data":null}';
    }
  }

  //acceptReject

  static Future<String> acceptReject(Map body) async {
    try {
      String token = await getToken();
      print(body);
      print(token);
      print(api_root + "/results");

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer " + token
      };
      return http
          .patch(api_root + "/results",
              body: jsonEncode(body), headers: headers)
          .then((http.Response response) {
        final int statusCode = response.statusCode;

        print(statusCode);

        String returnVal = (response.body == null) ? "" : response.body;

        print(returnVal);

        return statusCode.toString();
      }).catchError((error) =>
              print("Server not reached: Error Msg:" + error.toString()));
    } catch (_) {
      return '{"data":null}';
    }
  }

  static Future<String> getElectionResult() async {
    try {
      String token = await getToken();

      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer " + token
      };
      return http
          .get(api_root + "/display_results", headers: headers)
          .then((http.Response response) {
        String returnVal = (response.body == null) ? "" : response.body;
        return returnVal;
      }).catchError((error) =>
              print("Server not reached: Error Msg:" + error.toString()));
    } catch (_) {
      return '{"data":null}';
    }
  }

  static Future<String> parliamentaryCandidates() async {
    try {
      String token = await getToken();

      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer " + token
      };
      return http
          .get(api_root + "/pm_candidates", headers: headers)
          .then((http.Response response) {

        String returnVal = (response.body == null) ? "" : response.body;

        return returnVal;
      }).catchError((error) =>
              print("Server not reached: Error Msg:" + error.toString()));
    } catch (_) {
      return '{"data":null}';
    }
  }
}
