import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final imageUrl = 'https://image.tmdb.org/t/p/w500/';
  TextEditingController searchController = TextEditingController();
  List? movieList;

  @override
  void initState() {
    super.initState();
    getList();
  }

  getList() async {
    var url = 'http://api.themoviedb.org/3/discover/movie?api_key=0beac818ea6ac287319bb56a3a64f06e';
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    movieList = jsonData['results'];
  }

  getSearchedList(var query) async {
    var url = 'http://api.themoviedb.org/3/search/movie?api_key=0beac818ea6ac287319bb56a3a64f06e&query=$query';
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    movieList = jsonData['results'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x00ffbf00),
      appBar: AppBar(
        title: const Text("Movies 🎥", style: TextStyle(
          color: Colors.black,
          fontSize: 26,
          fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.only(left:10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2.0, style: BorderStyle.solid,color: Colors.amberAccent),
              color: Colors.white12
            ),
            child: TextFormField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search Movie',
                hintStyle: TextStyle(
                    color: Colors.white70
                ),
                suffixIcon: Icon(Icons.search,color: Colors.white70),
                border: InputBorder.none
              ),
              onChanged: (value){
                if(value.isNotEmpty){
                  getSearchedList(value);
                } else{
                  getList();
                }
                setState(() {
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount:  movieList==null?0:movieList!.length,
                itemBuilder: (context,i){
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => DetailScreen(movieObj: movieList![i],),
                  ));
                },
                child: movieList!=null &&movieList![i]['poster_path']==null?Container():Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2.0, style: BorderStyle.solid,color: Colors.amberAccent)
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                image: NetworkImage(
                                    imageUrl + movieList![i]['poster_path'],
                                ),
                                fit: BoxFit.cover
                              ),
                            ),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:10.0),
                                  child: Text(movieList![i]['title'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: const TextStyle(color: Colors.white,fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:10.0,top: 8.0),
                                  child: Text((movieList![i]['release_date']).toString().split('-').first,style: const TextStyle(color: Colors.white,fontSize: 18),),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
