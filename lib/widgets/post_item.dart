import 'package:flutter/material.dart';

import 'package:mekancimapp/data/data.dart';

import 'package:mekancimapp/widgets/post_widget.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PostItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postData = Provider.of<Data>(context);
    final posts = postData.items;
    return ListView.builder(
        reverse: true,
        itemCount: posts.length,
        itemBuilder: (context, i) => ChangeNotifierProvider.value(
              value: posts[i],
              child: PostWidget(
                uavatar: posts[i].imageUrl,
                urating: posts[i].rate,
                uyorum: posts[i].comment,
                uname: posts[i].name,
                mapImageUrl: posts[i].mapUrl,
                placeName: posts[i].placeName,
              ),
            ));
  }
}
