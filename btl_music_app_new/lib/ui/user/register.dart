import 'dart:convert';

import 'package:btl_music_app_new/data/model/common.dart';
import 'package:btl_music_app_new/ui/user/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends  State<SignInScreen> {
  String uri = "${Common.domain}/register";
  final _keys = GlobalKey<FormState>();
  final  _namelController = TextEditingController();
  final  _emailController = TextEditingController();
  final  _passwordController = TextEditingController();
  final _birthdayController = TextEditingController();
  String _labelMode = 'Nữ';
  bool _gender = false;
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Đăng ký',
          style: TextStyle(fontWeight: FontWeight.bold,)
        )
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: SingleChildScrollView(
          child: Form(
            key: _keys,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _namelController,
                  decoration: const InputDecoration(
                    hintText: 'name',
                    labelText: 'Tên',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Hãy nhập tên';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'email',
                    labelText: 'Email đăng nhập',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Hãy nhập email đăng nhập';
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
                TextFormField(
                  controller: _birthdayController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.blueGrey, width: 2.0)),
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'yyyy-MM-dd',
                    labelText: 'Ngày sinh',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Hãy nhập Ngày sinh yyyy-MM-dd';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Giới tính '),
                    Switch(
                        value: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                            _labelMode = _gender ? 'Nam' : 'Nữ';
                          });
                        }),
                    Text(_labelMode),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    String name = _namelController.text;
                    String email = _emailController.text;
                    String password = _passwordController.text;
                    String birthday = _birthdayController.text;

                    Map<String, Object?> user = {
                      "name": name,
                      "email": email,
                      "password": password,
                      "birthday":birthday,
                      "gender":_gender,
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

                          debugPrint(data.toString());
                        if (data['status'] == true) {
                          // Show dialog
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Thông báo'),
                                  content: Text(
                                      'Đăng ký thành công'),
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
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Thông báo lỗi'),
                                  content: Text(data['result']),
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
                        }
                      });
                    }
                  },
                  child: Text('Đăng ký'),
                ),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Back Login',
                          style: TextStyle(color: Colors.grey)),
                    ),
                  ),
                ],
              ),
            ),

        ),
      ),
    );
  }
}