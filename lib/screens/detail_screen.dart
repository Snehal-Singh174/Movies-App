import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Map? movieObj;
  const DetailScreen({Key? key,this.movieObj}) : super(key: key);

  final imageUrl = 'https://image.tmdb.org/t/p/w500/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0x00ffbf00),
        body:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 450,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                        imageUrl + movieObj!['poster_path'],
                      ),
                      fit: BoxFit.cover,
                    )
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('Overview:',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: Text('${movieObj!['vote_average']}/10',style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.amberAccent)),
                      ))
                ],
              ),
              Container(
                  margin: const EdgeInsets.all(10),
                  child: Text("Release: " + (movieObj!['release_date']).toString().split('-').first,style: const TextStyle(color: Colors.white,fontSize: 18))
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Text(movieObj!['overview'],style: const TextStyle(color: Colors.white,fontSize: 18),),
              )
            ],
          ),
        )
    );
  }


}

