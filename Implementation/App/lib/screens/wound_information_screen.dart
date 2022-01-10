import 'package:carousel_slider/carousel_slider.dart';
import 'package:cura/model/patient/patient_treatment/wound/wound_entry.dart';
import 'package:cura/model/widget/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'add_wound_entry_screen.dart';
import 'full_screen_screen.dart';

class WoundInformationScreen extends StatefulWidget {
  final String patientName;
  final List<WoundEntry> woundEntrys;
  const WoundInformationScreen(
      {Key? key, required this.patientName, required this.woundEntrys})
      : super(key: key);

  @override
  _WoundInformationScreenState createState() => _WoundInformationScreenState();
}

class _WoundInformationScreenState extends State<WoundInformationScreen> {
  late int _currentIndex;

  void _sortByDate() {
    widget.woundEntrys.sort((a, b) => a.date.compareTo(b.date));
  }

  @override
  void initState() {
    _sortByDate();
    _currentIndex =
        widget.woundEntrys.isNotEmpty ? widget.woundEntrys.length - 1 : 0;
    super.initState();
  }

  final CarouselController _controller = CarouselController();
  int _currentPic = 0;

  @override
  Widget build(BuildContext context) {
    WoundEntry? _currentEntry = widget.woundEntrys.isNotEmpty
        ? widget.woundEntrys[_currentIndex]
        : null;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColors.cura_darkCyan,
        title: Text(
          widget.patientName,
          style: TextStyle(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddWoundEntryScreen(
                          patientName: widget.patientName,
                          woundEntrys: widget.woundEntrys,
                        )));
          },
          child: Icon(Icons.add),
          backgroundColor: AppColors.cura_darkCyan),
      body: SafeArea(
          child: SingleChildScrollView(
              child: _currentEntry == null
                  ? Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Center(
                        child: Text(
                            "No entries.\nPlease add an entry for this wound."),
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 17),
                        Container(
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                spreadRadius: 1,
                                offset: Offset(0, 3))
                          ]),
                          width: double.infinity,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: IconButton(
                                    color: Color(0x5500B4D8),
                                    disabledColor: Color(0x5500B4D8),
                                    icon: Icon(
                                      Icons.arrow_back_ios_new,
                                    ),
                                    onPressed: _currentIndex > 0
                                        ? () {
                                            setState(() {
                                              if (_currentIndex > 0) {
                                                _currentEntry =
                                                    widget.woundEntrys[
                                                        _currentIndex--];
                                              }
                                            });
                                          }
                                        : null),
                              ),
                              Expanded(
                                  child: Center(
                                      child: Text(
                                _currentEntry!.formattedDate(),
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ))),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: IconButton(
                                    color: Color(0x5500B4D8),
                                    disabledColor: Color(0x5500B4D8),
                                    icon: Icon(Icons.arrow_forward_ios),
                                    onPressed: _currentIndex <
                                            widget.woundEntrys.length
                                        ? () {
                                            setState(() {
                                              if (_currentIndex <
                                                  widget.woundEntrys.length -
                                                      1) {
                                                _currentEntry =
                                                    widget.woundEntrys[
                                                        _currentIndex++];
                                              }
                                            });
                                          }
                                        : null),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CarouselSlider(
                            items: _currentEntry!.images
                                .map((item) => Container(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (_) {
                                            return FullScreenImage(
                                                imageUrl: item);
                                          }));
                                        },
                                        child: Center(
                                            child: Hero(
                                          tag: "imageHero",
                                          child: Image.network(item,
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
                            children: _currentEntry!.images
                                .asMap()
                                .entries
                                .map((entry) {
                              return GestureDetector(
                                onTap: () =>
                                    _controller.animateToPage(entry.key),
                                child: Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.cura_darkBlue
                                          .withOpacity(_currentPic == entry.key
                                              ? 0.9
                                              : 0.4)),
                                ),
                              );
                            }).toList()),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            "Pain level",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SfSlider(
                          value: _currentEntry!.painLevel != null
                              ? _currentEntry!.painLevel!.toDouble()
                              : 0,
                          onChanged: (value) {},
                          min: 0,
                          max: 10,
                          showLabels: true,
                          showDividers: true,
                          showTicks: true,
                          interval: 2,
                          stepSize: 1,
                          minorTicksPerInterval: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            "Wound information",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom:
                                      BorderSide(color: Color(0xFFe2e2e2)))),
                          width: 500,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Is the wound open?",
                                      style: TextStyle(
                                          color: Colors.black, height: 1.5),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      _currentEntry!.isOpen != null
                                          ? (_currentEntry!.isOpen!
                                              ? "Yes"
                                              : "No")
                                          : "Not set",
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 20,
                                thickness: 1,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Phase of healing",
                                        style: TextStyle(
                                            height: 1.5, color: Colors.black)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        _currentEntry!.phase != null
                                            ? _currentEntry!.phase.toString()
                                            : "Not set",
                                        style:
                                            TextStyle(color: Colors.grey[700])),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 20,
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 25, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Wound length",
                                        style: TextStyle(
                                            height: 1.5, color: Colors.black)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        _currentEntry!.length != null
                                            ? _currentEntry!.length.toString()
                                            : "Not set",
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            height: 1.5)),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 20,
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 25, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Wound width",
                                        style: TextStyle(
                                            height: 1.5, color: Colors.black)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        _currentEntry!.width != null
                                            ? _currentEntry!.width.toString()
                                            : "Not set",
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            height: 1.5)),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 20,
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 25, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Wound depth",
                                        style: TextStyle(
                                            height: 1.5, color: Colors.black)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        _currentEntry!.depth != null
                                            ? _currentEntry!.depth.toString()
                                            : "Not set",
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            height: 1.5)),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 20,
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 25, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Wound edges",
                                        style: TextStyle(
                                            height: 1.5, color: Colors.black)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        _currentEntry!.edge != null
                                            ? _currentEntry!.edge.toString()
                                            : "Not set",
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            height: 1.5)),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 20,
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 25, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Is the wound smelly?",
                                        style: TextStyle(
                                            height: 1.5, color: Colors.black)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        _currentEntry!.isSmelly != null
                                            ? (_currentEntry!.isSmelly!
                                                ? "Yes"
                                                : "No")
                                            : "Not set",
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            height: 1.5)),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 20,
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 25, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Wound exudate",
                                        style: TextStyle(
                                            height: 1.5, color: Colors.black)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        _currentEntry!.exudate != null
                                            ? _currentEntry!.exudate.toString()
                                            : "Not set",
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            height: 1.5)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ))),
    );
  }
}
