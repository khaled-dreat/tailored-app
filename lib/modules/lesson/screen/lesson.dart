import 'package:tailored/utilities/color_manager.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ClassScreen extends StatefulWidget {
  const ClassScreen({Key? key}) : super(key: key);

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: ColorManager.primary,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 35,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.play_circle,
                            color: Colors.white,
                            size: 50,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset("assets/images/lesson.png"),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "اختبار أساسيات التصميم",
                            style: TextStyle(
                              color: ColorManager.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 2,
                          ),
                          Text(
                            "المدرسة الثانوية العليا - الصف الثاني عشر",
                            style: TextStyle(
                              color: ColorManager.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 2,
                          ),
                          Text(
                            "المحتوى و الدروس",
                            style: TextStyle(
                              color: ColorManager.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "٥٥ طالب",
                                    style: TextStyle(
                                      color: ColorManager.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.video_camera_back,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "٢٥ درس",
                                    style: TextStyle(
                                      color: ColorManager.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            ListView.builder(
                itemCount: 6,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExpandablePanel(
                      header: Container(
                        color: ColorManager.black12,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "اختبار أساسيات التصميم",
                                style: TextStyle(
                                    color: ColorManager.primary, fontSize: 25),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.person,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        "٥٥ طالب",
                                        style: TextStyle(
                                          color: ColorManager.grey,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.video_camera_back,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        "٢٥ درس",
                                        style: TextStyle(
                                          color: ColorManager.grey,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      expanded: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          color: ColorManager.black12,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "العلوم والتكنولوجيا للمبتدئين",
                                      style: TextStyle(
                                        color: ColorManager.grey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 2,
                                    ),
                                    const Icon(
                                      Icons.video_camera_back,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "العلوم والتكنولوجيا للمبتدئين",
                                      style: TextStyle(
                                        color: ColorManager.grey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 2,
                                    ),
                                    const Icon(
                                      Icons.video_camera_back,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "العلوم والتكنولوجيا للمبتدئين",
                                      style: TextStyle(
                                        color: ColorManager.grey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 2,
                                    ),
                                    const Icon(
                                      Icons.video_camera_back,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "العلوم والتكنولوجيا للمبتدئين",
                                      style: TextStyle(
                                        color: ColorManager.grey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 2,
                                    ),
                                    const Icon(
                                      Icons.video_camera_back,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      collapsed: Container(),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
