

import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';

class DiscoverProvider extends ChangeNotifier {
  bool isLoading = true;
  final List<VideoPost> videos = [];

  Future<void> loadNextPage() async {


    notifyListeners();
  }
}