import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:mekancimapp/models/post.dart';
import 'package:mekancimapp/screens/comment_screen.dart';
import 'package:provider/provider.dart';

class PostWidget extends StatefulWidget {
  final uavatar, uname, uyorum, urating, uliked, mapImageUrl, placeName;

  const PostWidget(
      {Key key,
      this.uavatar,
      this.uname,
      this.uyorum,
      this.urating,
      this.uliked,
      this.mapImageUrl,
      this.placeName})
      : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    final posts =
        Provider.of<Post>(context, listen: false); //Provider of Post. Post

    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => ViewPostScreen(
                  uavatar: widget.uavatar, // widget.uavatar,
                  urating: widget.urating, // widget.urating,
                  uname: widget.uname, //.uname,
                  uyorum: widget.uyorum,
                  mapUrl: widget.mapImageUrl, // widget.uyorum,
                )));
      },
      child: Container(
        margin: EdgeInsets.all(10),
        width: double.infinity,
        height: 350,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            posts.imageUrl,
                            // widget.uavatar,
                          ),
                        ),
                        title: Text(
                          posts.name,
                          //widget.uname,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15),
                        ),
                        subtitle: Text(
                          widget.placeName,
                          style: TextStyle(fontSize: 10),
                        ),
                        trailing: Card(
                          color: Colors.blue,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: EdgeInsets.all(3),
                            child: RatingBarIndicator(
                              rating: posts.rate, //widget.urating,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 18,
                              direction: Axis.horizontal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 150,
                  child: Image.network(widget.mapImageUrl),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          posts.comment,
                          //widget.uyorum,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: true //widget.uliked
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : Icon(Icons.favorite_outline),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.comment),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => ViewPostScreen(
                                      uavatar: widget.uavatar,
                                      urating: widget.urating,
                                      uname: widget.uname,
                                      uyorum: widget.uyorum,
                                    )));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.near_me),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.share),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
