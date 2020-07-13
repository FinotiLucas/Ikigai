import 'package:ikigai/classes/descriptionRouter.dart';
import 'package:ikigai/routers/routersName.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

double radius = 15;

class MyGridView extends StatefulWidget {
  MyGridView({
    Key key,
    this.animes,
    this.option,
    this.isFavorite,
  }) : super(key: key);

  final animes;
  final int option;
  final bool isFavorite;

  @override
  _MyGridViewState createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {
  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  String _setHeroTag(data) {
    if (widget.isFavorite) {
      return data.title + data.imageUrl + data.title;
    } else {
      return data.title + data.imageUrl;
    }
  }

  Widget myGridView() {
    return GridView.builder(
      controller: _controller,
      itemCount: widget.animes.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            var _option =
                widget.isFavorite ? widget.animes[index].option : widget.option;
            Navigator.of(context).pushNamed(
              RoutersName.descriptionRoute,
              arguments: DescriptionArguments(widget.animes[index], _option),
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
                  height: 140,
                  child: Hero(
                    tag: _setHeroTag(widget.animes[index]),
                    child: CachedNetworkImage(
                      imageUrl: widget.animes[index].imageUrl,
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
                    widget.animes[index].title,
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

  Widget build(BuildContext context) {
    return Container(
      child: myGridView(),
    );
  }
}
