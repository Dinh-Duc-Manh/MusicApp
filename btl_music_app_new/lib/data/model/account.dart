import 'dart:convert';

class Account {
  int id;
  String name;
  String email;
  String password;
  DateTime birthday;
  bool gender;
  String role;

  Account(this.id, this.name, this.email, this.password, this.birthday,
      this.gender, this.role);

  factory Account.fromJson(Map<String, Object?> data) {
    return Account(
        int.parse(data['id'].toString()),
        data['name'].toString(),
        data['email'].toString(),
        data['password'].toString(),
        DateTime.parse(data['birthday'].toString()),
        int.parse(data['gender'].toString())== 1 ? true : false,
        data['role'].toString()
        // DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecond+int.parse(data['expiryminisecond'].toString()))
        );
  }

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "password": password,
      "birthday": birthday,
      "gender": gender,
      "role": role
    };
  }

}
