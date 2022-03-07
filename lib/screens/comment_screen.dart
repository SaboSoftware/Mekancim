import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mekancimapp/data/data.dart';

import 'package:mekancimapp/models/comment_model.dart';
import 'package:mekancimapp/models/post.dart';
import 'package:provider/provider.dart';

class ViewPostScreen extends StatefulWidget {
  final uavatar, uname, urating, uyorum, mapUrl;

  const ViewPostScreen({
    Key key,
    this.uavatar,
    this.uname,
    this.urating,
    this.uyorum,
    this.mapUrl,
  }) : super(key: key);

  @override
  _ViewPostScreenState createState() => _ViewPostScreenState();
}

class _ViewPostScreenState extends State<ViewPostScreen> {
  TextEditingController commentController = new TextEditingController();
  FocusNode focusNode = new FocusNode();
  var _newComment = Comment(
    authorImageUrl:
        'https://cdn.armut.com/UserPics/tr:w-325,h-325/9c2c7e5c-1ff5-404e-88d4-cbc932602d9b.jpeg',
    authorName: 'Hüseyin Ablay',
    text: '',
  );
  void saveFrom() {
    Provider.of<Data>(context, listen: false).addComment(_newComment);
    _newComment.text = '';
    focusNode.unfocus();
    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final commentsData = Provider.of<Data>(context, listen: false);
    Widget _buildComment(int index) {
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: ListTile(
          leading: Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: CircleAvatar(
              child: ClipOval(
                child: Image(
                  height: 50.0,
                  width: 50.0,
                  image:
                      NetworkImage(commentsData.comments[index].authorImageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          title: Text(
            commentsData.comments[index].authorName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            commentsData.comments[index].text,
            style: TextStyle(fontSize: 18),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.favorite_border,
            ),
            color: Colors.grey,
            onPressed: () => print('Like comment'),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFEDF0F6),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: widget.uyorum.length > 100 ? 450 : 350.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.chevron_left_outlined,
                                ),
                                iconSize: 35.0,
                                color: Colors.black,
                                onPressed: () => Navigator.pop(context),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: ListTile(
                                  leading: Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black45,
                                          offset: Offset(0, 2),
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      child: ClipOval(
                                        child: Image(
                                          height: 50.0,
                                          width: 50.0,
                                          image: NetworkImage(widget.uavatar),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    widget.uname,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: RatingBarIndicator(
                                      rating: widget.urating,
                                      itemSize: 18,
                                      direction: Axis.horizontal,
                                      itemCount: 5,
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.more_horiz),
                                    color: Colors.black,
                                    onPressed: () => print('More'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onDoubleTap: () => print('Like post'),
                            child: Container(
                              margin: EdgeInsets.all(10.0),
                              width: double.infinity,
                              height: 150.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: Image.network(widget.mapUrl),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.uyorum,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.favorite_border),
                                          iconSize: 30.0,
                                          onPressed: () => print('Like post'),
                                        ),
                                        Text(
                                          '2,515',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 20.0),
                                    Row(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.chat),
                                          iconSize: 30.0,
                                          onPressed: () {
                                            print('Chat');
                                          },
                                        ),
                                        Text(
                                          '350',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                width: double.infinity,
                // height: 600.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    for (int i = 0; i < commentsData.comments.length; i++)
                      _buildComment(i),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, -2),
                blurRadius: 6.0,
              ),
            ],
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: TextField(
              focusNode: focusNode,
              controller: commentController,
              onChanged: (value) {
                setState(() {
                  _newComment.text = value;
                });
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                contentPadding: EdgeInsets.all(20.0),
                hintText: 'Add a comment',
                prefixIcon: Container(
                  margin: EdgeInsets.all(4.0),
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    child: ClipOval(
                      child: Image(
                        height: 48.0,
                        width: 48.0,
                        image: NetworkImage(widget.uavatar),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                suffixIcon: Container(
                  margin: EdgeInsets.only(right: 4.0),
                  width: 70.0,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    onPressed:
                        commentController.text.trim().isEmpty ? null : saveFrom,
                    child: Icon(
                      Icons.send,
                      size: 25.0,
                      color: commentController.text.trim().isEmpty
                          ? Colors.grey
                          : Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
