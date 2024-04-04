import 'package:flutter/material.dart';
import 'package:posts_app/core/app_theme/app_theme.dart';
import 'package:posts_app/features/post/domain/entities/post_entity.dart';

class ListPostWidget extends StatelessWidget {
  final List<PostEntity> posts;

  const ListPostWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(posts[index].id.toString(), style: styleSubtites),
            title: Text(posts[index].title.toString(), style: styleTitles),
            subtitle: Text(posts[index].body.toString(), style: stylebody),
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: posts.length);
  }
}
