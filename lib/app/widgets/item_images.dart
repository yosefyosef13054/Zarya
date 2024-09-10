import 'dart:io';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zarya/app/constants/app_constants.dart';
import 'package:http/http.dart' as http;

class ItemImages extends StatefulWidget {
  final List<String> imgList;
  final String name;
  final String desc;
  final bool isImage;
  final double height;
  final double width;

  ItemImages(this.imgList, this.height, this.width, this.isImage, this.name,
      this.desc) {}

  @override
  State<ItemImages> createState() => _ItemImagesState();
}

class _ItemImagesState extends State<ItemImages> {
  List<Widget> imageSliders = [];
  final CarouselController _controller = CarouselController();
  int index = 0;
  // int _current = 0;

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            height: height * 0.3,
            child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              onPageChanged: (i) => setState(() {
                this.index = i;
              }),
              backgroundDecoration: BoxDecoration(color: Colors.white),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(
                    widget.imgList[index],
                  ),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.contained * 4,
                  initialScale: PhotoViewComputedScale.contained * 0.8,
                  // filterQuality: FilterQuality.high
                );
              },
              itemCount: widget.imgList.length,
              loadingBuilder: (context, event) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == entry.key ? Colors.blue : Colors.grey),
                ),
              );
            }).toList(),
          ),
          // Positioned(
          //   top: 5,
          //   right: 20,
          //   child: Container(
          //     width: 45,
          //     color: Colors.white,
          //     child: Text(
          //       '${this.index + 1}/${widget.imgList.length}',
          //       style: TextStyle(
          //           fontSize: 20,
          //           fontWeight: FontWeight.w700,
          //           color: AppConstants.mainColor),
          //     ),
          //   ),
          // ),
        ],
      ),
      //  Container(
      //   width: width,
      //   child: Stack(
      //     children: [
      //       CarouselSlider(
      //         options: CarouselOptions(
      //           aspectRatio: 2.0,
      //           enlargeCenterPage: true,
      //           enableInfiniteScroll: false,
      //           initialPage: 0,
      //           autoPlay: false,
      //         ),
      //         items: imageSliders,
      //       ),
      //       // Positioned(
      //       //   top: 5,
      //       //   right: 20,
      //       //   child: Text(
      //       //     '1/${imgList.length}',
      //       //     style: TextStyle(
      //       //         fontSize: 16,
      //       //         fontWeight: FontWeight.w700,
      //       //         color: AppConstants.mainColor),
      //       //   ),
      //       // ),
      //     ],
      //   ),
      // ),
    );
  }
}
