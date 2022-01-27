import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/widget/brand_name.dart';
import 'package:wallpaper_app/widget/search_bar.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/widget/wallpaper_list.dart';

class SearchScreen extends StatefulWidget {
  final String searchQuery;

  const SearchScreen({
    this.searchQuery,
  });
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<WallpaperModel> wallpaper = [];
  TextEditingController searchController = new TextEditingController();
  getSearchWallpapers(String query) async{
    var response = await http.get(Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=40"),
        headers: {
          "Authorization" : apiKey
        });
    // print(response.body.toString());
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData['photos'].forEach((element){
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpaper.add(wallpaperModel);
    });
    setState((){});
  }

  @override
  void initState() {
    // TODO: implement initState
    getSearchWallpapers(widget.searchQuery);
    super.initState();
    searchController.text = widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: BrandName(),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SearchBar(
                searchController: searchController,
                onTap: (){
                  getSearchWallpapers(searchController.text);
                },
              ),
              SizedBox(
                height: 25,
              ),
              WallpaperList(
                wallpaper: wallpaper,
              )
            ],
          ),
        ),
      ),
    );
  }
}
