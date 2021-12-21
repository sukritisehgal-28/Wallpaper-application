import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallpaperapp/widgets/category_tile.dart';
import 'package:wallpaperapp/widgets/searchbar.dart';
import 'package:wallpaperapp/widgets/widget.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaperapp/model/wallpaper_model.dart';
import 'package:wallpaperapp/views/search.dart';
import 'package:wallpaperapp/model/wallpaper_model.dart';
import 'package:wallpaperapp/model/categories_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                        color: Colors.black54,
                        fontFamily: 'Overpass'
                    ),
                  ),
                  Text(
                    'Sukriti Sehgal',
                    style: TextStyle(
                        color: Colors.blue,
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