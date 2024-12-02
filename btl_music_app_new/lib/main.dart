import 'package:btl_music_app_new/data/repository/repository.dart';
import 'package:btl_music_app_new/ui/user/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:btl_music_app_new/ui/home/home.dart';
import 'package:flutter/material.dart';


// void main() => runApp(const MusicApp());


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hanam88',
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// void main() async{
//   var repository = DefaultRepository();
//   var songs = await repository.loadData();
//   if (songs !=null){
//     for (var song in songs){
//       debugPrint(song.toString());
//     }
//   }
// }