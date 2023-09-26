import 'package:cached_network_image/cached_network_image.dart';
import 'package:finvu_bank_pfm/core/utilities/styleguide.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  final String url;
  final BoxFit? fit;
  final double? width;
  const AppNetworkImage({Key? key, required this.url, this.fit, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width ?? 33,
      imageUrl: url,
      fit: fit,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
        Center(
          child: CircularProgressIndicator(
            value: downloadProgress.progress,
          ),
        ),
      errorWidget: (context, url, error) => const Icon(
        Icons.currency_rupee,
        color: AppColors.primary,
      ),
    );
  }
}
