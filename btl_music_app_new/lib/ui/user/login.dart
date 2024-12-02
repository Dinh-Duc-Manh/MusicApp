import 'dart:convert';

import 'package:btl_music_app_new/data/model/account.dart';
import 'package:btl_music_app_new/data/model/common.dart';
import 'package:btl_music_app_new/ui/home/home.dart';
import 'package:btl_music_app_new/ui/user/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  String uri = "${Common.domain}/login";
  final _keys = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: SingleChildScrollView(
          child: Form(
            key: _keys,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                    'assets/login.jpg',
                    width: 200),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'email',
                    labelText: 'Tên đăng nhập',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Hãy nhập tên đăng nhập';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'password',
                      labelText: 'Mật khẩu',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Hãy nhập mật khẩu';
                      }
                      return null;
                    }),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    String email = _emailController.text;
                    String password = _passwordController.text;
                    Map<String, String> user = {
                      "email": email,
                      "password": password
                    };
                    Map<String, String> headers = <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    };
                    if (_keys.currentState!.validate()) {
                      http
                          .post(Uri.parse(uri),
                              headers: headers, body: jsonEncode(user))
                          .then((value) async {
                        var data = jsonDecode(
                            const Utf8Decoder().convert(value.bodyBytes));

                        if (data['result'] == null) {
                          // Show dialog
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Thông báo lỗi'),
                                  content: Text(
                                      'Thông tin đăng nhập không chính xác'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Đóng'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        } else {
                          // debugPrint(data.toString());
                          var acc = Account.fromJson(data['result']);
                          var prefs = await SharedPreferences.getInstance();
                          // prefs.setString("avatar", acc.avatar);
                          prefs.setString("name", acc.name);
                          // prefs.setString("birthday", DateTime.parse(acc.birthday));
                          prefs.setInt("id", acc.id);
                          // prefs.setString("accesstoken", acc.accesstoken);
                          if (!context.mounted) return;
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MusicApp()));
                        }
                      });
                    }
                  },
                  child: Text('Đăng nhập'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Bạn không có tài khoản",
                        style: TextStyle(color: Colors.grey)),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()));
                      },
                      child: const Text(
                        "Đăng Ký?",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
