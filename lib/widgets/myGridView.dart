import 'package:ikigai/routers/routersName.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

double radius = 15;

String _setHeroTag(bool isFavorite, data) {
  if (isFavorite) {
    return data.title + data.imageUrl + data.title;
  } else {
    return data.title + data.imageUrl;
  }
}

Widget myGridView(animes, int option, bool isFavorite) {
  return GridView.builder(
    itemCount: animes.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
    ),
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () async {
          var _option = isFavorite ? animes[index].option : option;
          Navigator.of(context).pushNamed(
            RoutersName.descriptionRoute,
            arguments: DescriptionArguments(animes[index], _option),
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
                  tag: _setHeroTag(isFavorite, animes[index]),
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
