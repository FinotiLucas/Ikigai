import 'package:allnihon/screens/description/mainDescription.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

double radius = 15;

Widget myGridView(animes, option) {
  return GridView.builder(
    itemCount: animes.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
    ),
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () async {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (BuildContext context) => new MainDescriptionPage(
                anime: animes[index],
                option: option,
              ),
            ),
          );
        },
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 150,
                child: Hero(
                  tag: animes[index].title + animes[index].imageUrl,
                  child: CachedNetworkImage(
                    imageUrl: animes[index].imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: new BorderRadius.only(
                            topLeft: Radius.circular(radius),
                            topRight: Radius.circular(radius)),
                      ),
                    ),
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  animes[index].title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: false,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
