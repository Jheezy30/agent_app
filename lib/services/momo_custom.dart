

import 'package:agent_app/model/momo.dart';
import 'package:flutter/material.dart';

class MomoCustom extends ChangeNotifier{
  List<Momo> momos = [];
  

  void addMomo(String number , String network){
    final Momo momo = Momo(number: number, network: network);
    momos.add(momo);

    notifyListeners();  
  }

  void deleteMomo(int index){
    if(index >= 0 && index < momos.length){
      momos.removeAt(index);
      notifyListeners();
    }
  }

  void clearMomos(){
    momos.clear();
    notifyListeners();
  }






}
