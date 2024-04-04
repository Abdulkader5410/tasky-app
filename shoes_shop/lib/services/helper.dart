import 'package:flutter/services.dart';
import 'package:shose_shop/models/sneakers_model.dart';

class Helper {
  Future<List<Sneakers>> getMenSneakers() async {
    final data = await rootBundle.loadString('json/men_json.json');
    final menList = sneakersFromJson(data);
    return menList;
  }

  Future<List<Sneakers>> getWomenSneakers() async {
    final data = await rootBundle.loadString("json/women_json.json");
    final womenList = sneakersFromJson(data);
    return womenList;
  }

  Future<List<Sneakers>> getKidsSneakers() async {
    final data = await rootBundle.loadString("json/kids_json.json");
    final kidsList = sneakersFromJson(data);
    return kidsList;
  }

  Future<Sneakers> getMenSneakersById(String id) async {
    final data = await rootBundle.loadString("json/men_json.json");
    final menList = sneakersFromJson(data);
    final menSneaker = menList.firstWhere((sneaker) => sneaker.id == id);
    return menSneaker;
  }

  Future<Sneakers> getWomenSneakersById(String id) async {
    final data = await rootBundle.loadString("json/women_json.json");
    final womenList = sneakersFromJson(data);
    final womenSneaker = womenList.firstWhere((sneaker) => sneaker.id == id);

    return womenSneaker;
  }

  Future<Sneakers> getKidsSneakersById(String id) async {
    final data = await rootBundle.loadString("json/kids_json.json");
    final kidsList = sneakersFromJson(data);
    final kidsSneaker = kidsList.firstWhere((sneaker) => sneaker.id == id);

    return kidsSneaker;
  }
}
