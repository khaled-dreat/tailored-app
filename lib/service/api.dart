import 'dart:convert';
import 'package:tailored/shared/error/maintenance.dart';
import 'package:tailored/utilities/fun_app/navigator.dart';
import 'package:tailored/providers/provider_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class API {
  String fullurl = 'https://tailored.meshka.space/api/v1/';
  BuildContext context;

  API(this.context);

  get(String url, {isToken = false,Token = false}) async {
    final String full_url = '${fullurl}$url';
    print(full_url);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('token'));
    try {
      http.Response response = await http.get(Uri.parse(full_url),
          headers: isToken
              ? {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                }
              :Token? {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'TOKEN e6ab2a5283ad6bf1edbe15b20aac2ec30d9d4f94',
                } :{
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'TOKEN ${prefs.getString('token')}',
                });
      print(response.statusCode);
      var data={
        'data':response.body.isEmpty?{}:jsonDecode(response.body??"{}"),
        'code': response.statusCode,
      };
      if (response.statusCode == 500) {
        Nav.route(
            context,
            Maintenance(
              erorr: response.body,
            ));
      } else {
        return data;
      }
    } catch (e) {
      print("$e");
      Nav.route(
          context,
          Maintenance(
            erorr: '$e',
          ));
    } finally {}
  }

  post(String url, Map<String, dynamic> body, {bool token=false}) async {
    final String full_url = '${fullurl}$url';

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    print("url =${full_url}");
    print("token =${prefs.getString("token")}");
    print("body =${json.encode(body)}");

    try {
      http.Response response = await http.post(Uri.parse(full_url),
          headers: token?{
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }:{
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Token ${prefs.getString('token')}',
          },
          body: json.encode(body));
      print("response ${response.body}");

      var data={
        'data':response.body.isEmpty?{}:jsonDecode(response.body??"{}"),
        'code': response.statusCode,
      };
      print("response ${data}");
      print("statusCode = ${response.statusCode}");

      if (response.statusCode == 500) {
        Nav.route(
            context,
            Maintenance(
              erorr: "${jsonDecode(response.body)}",
            ));
      } else if (response.statusCode == 404) {
        Nav.route(
            context,
            Maintenance(
              erorr: "${jsonDecode(response.body)}",
            ));
      } else {
        return data;
      }
    } catch (e) {
      print("$e");
      Nav.route(
          context,
          Maintenance(
            erorr: "$e",
          ));
    } finally {}
  }
  patch(String url, Map<String, dynamic> body, {bool token=false}) async {
    final String full_url = '${fullurl}$url';

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    print("url =${full_url}");
    print("token =${prefs.getString("token")}");
    print("body =${json.encode(body)}");

    try {
      http.Response response = await http.patch(Uri.parse(full_url),
          headers: token?{
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }:{
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Token ${prefs.getString('token')}',
          },
          body: json.encode(body));
      var data={
        'data': jsonDecode(response.body),
        'code': response.statusCode,
      };
      print("response ${data}");
      print("statusCode = ${response.statusCode}");

      if (response.statusCode == 500) {
        Nav.route(
            context,
            Maintenance(
              erorr: "${jsonDecode(response.body)}",
            ));
      } else if (response.statusCode == 404) {
        Nav.route(
            context,
            Maintenance(
              erorr: "${jsonDecode(response.body)}",
            ));
      } else {
        return data;
      }
    } catch (e) {
      print("$e");
      Nav.route(
          context,
          Maintenance(
            erorr: "$e",
          ));
    } finally {}
  }

  post_url(String url, Map<String, dynamic> body) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    print("body =${url}");
    print("body =${body}");

    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'version': '7.6',

            // 'Authorization': 'Token ${prefs.getString('token') ?? identifier}',
            // 'locale': Provider.of<Provider_control>(context,listen: false).getlocal(),
          },
          body: json.encode(body));
      print("body =${jsonDecode(response.body)}");

      if (response.statusCode == 500) {
        Nav.route(
            context,
            Maintenance(
              erorr: "${jsonDecode(response.body)}",
            ));
      } else if (response.statusCode == 404) {
        Nav.route(
            context,
            Maintenance(
              erorr: "${jsonDecode(response.body)}",
            ));
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("$e");
      Nav.route(
          context,
          Maintenance(
            erorr: "$e",
          ));
    } finally {}
  }

  Put(String url, Map<String, dynamic> body) async {
    final String full_url = '${fullurl}$url';

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(url);
    try {
      http.Response response = await http.put(Uri.parse(full_url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Token ${prefs.getString('token')}',
            'locale': Provider.of<Provider_control>(context, listen: false)
                .getlocal(),
            'version': '7.6',
          },
          body: json.encode(body));
      print(jsonDecode(response.body));
      if (response.statusCode == 500) {
        Nav.route(
            context,
            Maintenance(
              erorr: jsonDecode(response.body),
            ));
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
    } finally {}
  }

  Delete(String url) async {
    final String full_url = '${fullurl}$url';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      http.Response response = await http.delete(
        Uri.parse(full_url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'version': '7.6',
          'Authorization': 'Token ${prefs.getString('token')}',
          'locale':
              Provider.of<Provider_control>(context, listen: false).getlocal(),
        },
      );
      if (response.statusCode == 500) {
        Nav.route(
            context,
            Maintenance(
              erorr: jsonDecode(response.body),
            ));
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
    } finally {}
  }
}
