import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cura/model/general/room.dart';
import 'package:cura/model/patient/patient.dart';
import 'package:cura/model/patient/patient_treatment/wound/wound_entry.dart';
import 'package:cura/model/widget/AppColors.dart';
import 'package:cura/screens/full_screen_screen.dart';
import 'package:cura/utils/query_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddWoundEntryScreen extends StatefulWidget {
  final Patient patient;
  final Room room;
  final String woundIndex;
  final WoundEntry woundEntry;
  const AddWoundEntryScreen(
      {Key? key,
      required this.patient,
      required this.room,
      required this.woundIndex,
      required this.woundEntry})
      : super(key: key);

  @override
  _AddWoundEntryScreenState createState() => _AddWoundEntryScreenState();
}

class _AddWoundEntryScreenState extends State<AddWoundEntryScreen> {
  List<File> _images = [];
  int _currentPic = 0;
  final CarouselController _controller = CarouselController();

  String currentDate = DateFormat('dd.MM.yyyy').format(DateTime.now());

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _imgFromCamera() async {
      XFile? image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 50);
      if (!mounted) return;
      setState(() {
        if (image != null) {
          QueryWrapper.postWoundEntry(File(image.path), widget.patient,
              widget.room, widget.woundIndex, widget.woundEntry);
          _images.add(File(image.path));
        }
      });
    }

    _imgFromGallery() async {
      XFile? image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (!mounted) return;
      setState(() {
        if (image != null) {
          _images.add(File(image.path));
        }
      });
    }

    void _showPicker(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return SafeArea(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    ListTile(
                        leading: Icon(Icons.photo_library),
                        title: Text('Photo Library'),
                        onTap: () {
                          _imgFromGallery();
                          Navigator.of(context).pop();
                        }),
                    ListTile(
                      leading: Icon(Icons.photo_camera),
                      title: Text('Camera'),
                      onTap: () {
                        _imgFromCamera();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          });
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 17),
                Container(
                  height: 40,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: Offset(0, 3))
                  ]),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                          child: Center(
                              child: Text(
                        "Date: $currentDate",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ))),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                _images.isEmpty
                    ? Image.asset("assets/no-image.jpg")
                    : CarouselSlider(
                        items: _images
                            .map((item) => Container(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return FullScreenImage(imageFile: item);
                                      }));
                                    },
                                    child: Center(
                                        child: Hero(
                                      tag: "imageHero",
                                      child: Image.file(item,
                                          width: double.infinity),
                                    )),
                                  ),
                                ))
                            .toList(),
                        options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentPic = index;
                            });
                          },
                          viewportFraction: 1,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.scale,
                          autoPlay: false,
                          enableInfiniteScroll: false,
                        )),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _images.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.cura_darkBlue.withOpacity(
                                  _currentPic == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    }).toList()),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.cura_cyan),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                side: BorderSide(color: AppColors.cura_cyan)))),
                    onPressed: () {
                      _showPicker(context);
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 60,
                        child: Center(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.photo_camera,
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Add"),
                          ],
                        ))),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
