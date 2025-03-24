import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BuildCarouselItem extends StatelessWidget {
  final String? image;

  const BuildCarouselItem({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.5),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(228, 228, 225, 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: image != null && image!.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: "https://back.stroybazan1.uz$image",
                imageBuilder: (context, imageProvider) => Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => const Center(child: CupertinoActivityIndicator()),
                errorWidget: (context, url, error) => Image.asset(
                  "assets/images/empty_image.png",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              )
            : Image.asset(
                "assets/images/empty_image.png",
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
      ),
    );
  }
}
