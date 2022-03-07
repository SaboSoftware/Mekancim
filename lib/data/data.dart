import 'package:flutter/foundation.dart';

import 'package:mekancimapp/models/comment_model.dart';

import 'package:mekancimapp/models/post.dart';

List<bool> uliked = [true, false, true];

class Data with ChangeNotifier {
  List<Comment> comments = [
    Comment(
      authorName: 'Elliot Alderson',
      authorImageUrl:
          'https://i1.sndcdn.com/avatars-000239937625-wn66b5-t500x500.jpg',
      text: 'Hello My Friend...',
    ),
    Comment(
      authorName: 'Mr.Robot',
      authorImageUrl:
          'https://i.pinimg.com/474x/92/73/51/927351ae85dcc52d569fa7962a832489--mr-robot-robots.jpg',
      text: 'FSociety',
    ),
    Comment(
      authorName: 'Angela Moss',
      authorImageUrl:
          'https://sm.ign.com/ign_tr/screenshot/p/portia-dou/portia-doubleday-as-angela-moss-on-mr-robot_bard.jpg',
      text: 'Elliot are you ok?',
    ),
    Comment(
      authorName: 'Darlene Alderson',
      authorImageUrl:
          'https://static.wikia.nocookie.net/lgbt-characters/images/a/a5/Darlene_Alderson.jpg/revision/latest/top-crop/width/360/height/450?cb=20200618225245',
      text: 'Fuck you cocksucker',
    ),
    Comment(
      authorName: 'White Rose',
      authorImageUrl:
          'https://pyxis.nymag.com/v1/imgs/a62/23a/303a4d669b363bf27aab17864352764dea-25-bd-wong-chatroom.2x.rsocial.w600.jpg',
      text: 'Ana da vinüm',
    ),
    Comment(
      authorName: 'Elliot Alderson',
      authorImageUrl:
          'https://i1.sndcdn.com/avatars-000239937625-wn66b5-t500x500.jpg',
      text: 'Hello My Friend...',
    ),
  ];
  List<Post> _items = [
    Post(
        imageUrl:
            'https://cdn.armut.com/UserPics/tr:w-325,h-325/9c2c7e5c-1ff5-404e-88d4-cbc932602d9b.jpeg',
        name: 'Hüseyin Ablay',
        rate: 3.5,
        mapUrl:
            'https://maps.googleapis.com/maps/api/staticmap?center=&37.4219983,-122.084&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C37.4219983,-122.084&key=AIzaSyDIHmjHtROLJJDokOygcWC37l4Y-Npp_pk',
        comment: 'çok iyi mq',
        placeName: 'McDonalds'),
    Post(
      imageUrl:
          'https://cdn.armut.com/UserPics/tr:w-325,h-325/9c2c7e5c-1ff5-404e-88d4-cbc932602d9b.jpeg',
      name: 'İbrahim Tunç',
      rate: 5,
      mapUrl:
          'https://maps.googleapis.com/maps/api/staticmap?center=&37.4219983,-122.084&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C37.4219983,-122.084&key=AIzaSyDIHmjHtROLJJDokOygcWC37l4Y-Npp_pk',
      comment: 'OOO baba dönerke parçalıyoruzke',
      placeName: 'Bay Döner',
    ),
    Post(
      imageUrl: 'https://i.hizliresim.com/6mv81yu.jpg',
      name: 'Berk Topçu',
      rate: 4,
      mapUrl:
          'https://maps.googleapis.com/maps/api/staticmap?center=&37.4219983,-122.084&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C37.4219983,-122.084&key=AIzaSyDIHmjHtROLJJDokOygcWC37l4Y-Npp_pk',
      comment: 'baba muzke yiyoruzke',
      placeName: 'Bim',
    ),
  ];

  List<Post> get items {
    return [..._items];
  }

  void fetchandsetposts() {}

  void addComment(Comment comment) {
    final newComment = Comment(
      authorImageUrl: comment.authorImageUrl,
      authorName: comment.authorName,
      text: comment.text,
    );
    comments.add(newComment);
    notifyListeners();
  }

  void addPost(Post post) {
    final newPost = Post(
      placeName: post.placeName,
      imageUrl: post.imageUrl,
      name: post.name,
      rate: post.rate,
      mapUrl: post.mapUrl,
      comment: post.comment,
    );
    _items.add(newPost);
    notifyListeners();
  }
}
