import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/model/categories_model.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/view/search_view.dart';
import 'package:wallpaper_app/widget/brand_name.dart';
import 'package:wallpaper_app/widget/category_tile.dart';
import 'package:wallpaper_app/widget/search_bar.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/widget/wallpaper_list.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoriesModel> categories = [];
  List<WallpaperModel> wallpaper = [];
  TextEditingController searchController = new TextEditingController();
  getTrendingWallpapers() async{
    var response = await http.get(Uri.parse("https://api.pexels.com/v1/curated?page=2&per_page=40"),
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

    getTrendingWallpapers();
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: BrandName(),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchBar(
              searchController: searchController,
              onTap: (){
                if(searchController.text != "") {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) =>
                      SearchScreen(
                        searchQuery: searchController.text,
                      )));
                }
              },
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                shrinkWrap: true,
                itemBuilder: (context, index){
                  return CategoriesTile(
                    imgUrl: categories[index].imgUrl,
                    title: categories[index].categoriesName,
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Made By ',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Overpass'
                  ),
                ),
                Text(
                  'Sukriti',
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontFamily: 'Overpass'
                  ),
                ),
              ],
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
    );
  }
}
