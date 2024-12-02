import 'dart:convert';
import 'dart:ffi';

import 'package:btl_music_app_new/data/model/account.dart';
import 'package:btl_music_app_new/data/model/common.dart';
import 'package:btl_music_app_new/ui/home/home.dart';
import 'package:btl_music_app_new/ui/user/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// class AccountTab extends StatelessWidget {
//   const AccountTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text('Account Tab'),
//       ),
//     );
//   }
// }
class AccountTab extends StatefulWidget {
  Account? emp;
  AccountTab({super.key, this.emp});
  @override
  State<AccountTab> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountTab> {
  int? _id;
  String? _name;
  bool _obscureText = true;
  bool _obscureText2 = true;
  String uri = "${Common.domain}/account";
  final _keys = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _birthdayController = TextEditingController();
  String _labelMode = 'Nữ';
  bool _gender = false;
  List<Account> account = [];

  void initState() {
    super.initState();
    _loadAccount();
  }

  Future<void> _loadAccount() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      _name = pref.getString("name");
      _id = pref.getInt("id");
    });
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    http.get(Uri.parse('$uri/$_id'), headers: headers).then((value) {
      var data = jsonDecode(const Utf8Decoder().convert(value.bodyBytes));
      var acc = Account.fromJson(data['account']);

      _idController.text = acc.id.toString();
      _nameController.text = acc.name;
      _emailController.text = acc.email;
      _passwordController.text = acc.password;
      _birthdayController.text = acc.birthday.toString();
      _gender = acc.gender;
      _labelMode = _gender ? "Nam" : "Nữ";
      setState(() {
        account = data.map((e) => Account.fromJson(e)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Tài khoản của $_name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ))),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: SingleChildScrollView(
          child: Form(
            key: _keys,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
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
                    labelText: 'Email',
                  ),
                  enabled: false,
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: 'password',
                    labelText: 'Mật khẩu mới',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                    // controller: _newPasswordController,
                    obscureText: _obscureText2,
                    decoration: InputDecoration(
                      hintText: 'Xác nhận mật khẩu',
                      labelText: 'Mật khẩu cũ',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText2
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText2 = !_obscureText2;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Hãy xác nhận mật khẩu cũ để lưu thông tin tài khoảng mới';
                      }
                      if (value != _passwordController.text) {
                        return 'Mật khẩu Không đúng';
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
                    String name = _nameController.text;
                    String email = _emailController.text;

                    String password = _newPasswordController.text;
                    if (_newPasswordController.text == null ||
                        _newPasswordController.text == "") {
                      password = _passwordController.text;
                    }
                    String birthday = _birthdayController.text;
                    Map<String, Object?> user = {
                      "name": name,
                      "password": password,
                      "birthday": birthday,
                      "gender": _gender,
                    };
                    Map<String, String> headers = <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    };
                    if (_keys.currentState!.validate()) {
                      http
                          .put(Uri.parse('$uri/$_id'),
                              headers: headers, body: jsonEncode(user))
                          .then((value) async {
                        var data = jsonDecode(
                            const Utf8Decoder().convert(value.bodyBytes));

                        if (data['account'] != false) {
                          // Show dialog
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Thông báo'),
                                  content: Text(
                                      'Cập nhật thành công'),
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
                                  content: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MusicApp()));
                      });
                    }
                  },
                  child: Text('Lưu Thông tin'),
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: const Text('Đăng xuất',
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
