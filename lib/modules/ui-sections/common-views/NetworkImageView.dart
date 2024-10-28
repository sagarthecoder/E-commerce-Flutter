import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageView extends StatelessWidget {
  final String url;
  BoxFit aspectType;
  NetworkImageView(
      {required this.url, this.aspectType = BoxFit.cover, super.key});

  @override
  Widget build(BuildContext context) {
    return buildNetworkImage();
  }

  Widget buildNetworkImage() {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: aspectType,
          ),
        ),
      ),
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
