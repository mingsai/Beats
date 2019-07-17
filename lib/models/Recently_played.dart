import 'package:beats/models/RecentsHelper.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/widgets.dart';
import 'package:pref_dessert/pref_dessert.dart';


class Recents extends ChangeNotifier{

  RecentsHelper db;
  List<Song> recently = List<Song>();

  Recents(){
    db = RecentsHelper();
    fetchRecents();
  }

  add(Song song)async {
    if (!alreadyExists(song)){
      if (recently.length > 1) await db.deleteLast();
      await db.add(song);
      fetchRecents();
    }
  }

  alreadyExists(s){
    recently.forEach((item){
      if (s.id==item.id) return true;
    });
    return false;
  }

  fetchRecents() async {
    recently = await db.getRecents();
    notifyListeners();
  }

}