import 'package:flutter/material.dart';

class BuildCarouselItem extends StatefulWidget {
  final String? imageCarusel;
  final String? title;

  const BuildCarouselItem({super.key, this.imageCarusel, this.title});

  @override
  State<BuildCarouselItem> createState() => _BuildCarouselItemState();
}

class _BuildCarouselItemState extends State<BuildCarouselItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.5),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(228, 228, 225, 1),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: widget.imageCarusel != null && widget.imageCarusel!.isNotEmpty
            ? Image.asset(
                widget.imageCarusel!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              )
            : Center(
                child: Text(
                  widget.title ?? '',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
      ),
    );
  }
}
