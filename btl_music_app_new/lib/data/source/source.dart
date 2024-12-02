import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:btl_music_app_new/data/model/common.dart';
import '../model/song.dart';

abstract interface class DataSource {
  Future<List<Song>?> loadData();
}

class RemoteDataSource implements DataSource {
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };
  @override
  Future<List<Song>?> loadData() async {
    String url = '${Common.domain}/songs';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final bobyContent = utf8.decode(response.bodyBytes);
    var songWrapper = jsonDecode(bobyContent) as Map;
    var songList = songWrapper['songs'] as List;

    List<Song> songs = songList.map((song) => Song.fromJson(song)).toList();
    for (var song in songs) {
      if (!song.image.contains("https://thantrieu.com/")) {
        song.image = "${Common.domain2}/${song.image}";
        song.source = "${Common.domain2}/${song.source}";
      }
    }
    // debugPrint(songList.toString());
    // debugPrint("response.toString()");
    // debugPrint(songs.toString());
    return songs;
  }
}

class LocalDataSource implements DataSource {
  @override
  Future<List<Song>?> loadData() async {
    final String response =
        await rootBundle.loadString('${Common.domain}/songs2');
    final jsonBody = jsonDecode(response) as Map;
    final songList = jsonBody['songs'] as List;
    List<Song> songs = songList.map((song) => Song.fromJson(song)).toList();
    for (var song in songs) {
      if (!song.image.contains("https://thantrieu.com/")) {
        song.image = "${Common.domain2}/${song.image}";
        song.source = "${Common.domain2}/${song.source}";

      }
    }
    return songs;
  }
}
