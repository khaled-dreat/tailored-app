import 'package:cached_network_image/cached_network_image.dart';
import 'package:tailored/all_widgets/result_overlay.dart';
import 'package:tailored/utilities/color_manager.dart';
import 'package:tailored/model/Profile.dart';
import 'package:tailored/model/user.dart';
import 'package:tailored/utilities/screen_size.dart';
import 'package:tailored/service/api.dart';
import 'package:tailored/model/course.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../model/material.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({Key? key, required this.course}) : super(key: key);
  final Course course;

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  List<Materials>? materialContent;
  List<Profile>? users;

  @override
  void initState() {
    API(context)
        .get('core/courses/${widget.course.id}/materials', Token: true)
        .then((value) {
      print(value);
      var data = value['data'];
      materialContent = [];
      data.forEach((element) {
        print(element['content']);
        setState(() {
          materialContent?.add(Materials.fromJson(element));
        });
      });
    });

    API(context)
        .get('core/courses/${widget.course.id}/members', Token: true)
        .then((value) {
      print(value);
      var data = value['data'];
      users = [];
      data.forEach((element) {
        setState(() {
          users?.add(Profile.fromJson(element));
        });
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تفاصيل الدورة'),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: ScreenUtil.getHeight(context) / 1,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 180,
                        child: Text(
                          "${widget.course.name}",
                          style: TextStyle(
                            color: ColorManager.primary,
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Text(
                        "${widget.course?.description ?? ''}",
                        style: TextStyle(
                            color: ColorManager.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "30 دولارا",
                          style: TextStyle(
                            color: ColorManager.primary,
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 2,
                        ),
                        Row(
                          children: [
                            Icon(Icons.person),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "شخص مسجل في هذه الدورة",
                              style: TextStyle(
                                  color: ColorManager.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Text(
                              "4.8",
                              style: TextStyle(
                                  color: ColorManager.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "120 التعليقات",
                              style: TextStyle(
                                  color: ColorManager.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.access_time_filled_sharp),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "شخص مسجل في هذه الدورة",
                              style: TextStyle(
                                  color: ColorManager.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("نظرة عامة"),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ColorManager.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          API(context)
                              .post('core/courses/${widget.course.id}/join', {},
                                  token: true)
                              .then((value) async {
                            if (value['code'] == 301) {
                              showDialog(
                                  context: context,
                                  builder: (_) => ResultOverlay(
                                        "  ${value['code'] ?? " "} \n تم التسجيل ",
                                        cash: false,
                                      ));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (_) => ResultOverlay(
                                        " ${value['code'] ?? " "} \n  ${value['data'] ?? " "} ",
                                        cash: false,
                                      ));
                            }
                          });
                        },
                        child: const Text(
                          ' تسجيل',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: ColorManager.black12,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5.0,
                              spreadRadius: 1,
                              offset: Offset(0.0, 2)),
                        ]),
                    height: 50,
                    child: TabBar(
                        unselectedLabelColor: ColorManager.grey,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: ColorManager.primary,
                        indicator: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              ColorManager.white,
                              ColorManager.white
                            ]),
                            borderRadius: BorderRadius.circular(50),
                            color: ColorManager.white),
                        tabs: [
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("الدروس"),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("الاعضاء"),
                            ),
                          ),
                        ]),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Column(
                          children: [
                            materialContent == null
                                ? Center(child: CircularProgressIndicator())
                                : ListView.builder(
                                    itemCount: materialContent?.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return materialContent![index].content ==
                                              null
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : ListView.builder(
                                              itemCount: materialContent![index]
                                                  .content
                                                  ?.length,
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return GestureDetector(
                                                  onTap: () {},
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 16),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: <Widget>[
                                                        CachedNetworkImage(
                                                          imageUrl:
                                                              "${materialContent![index].content?[index].file}",
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            "${materialContent![index].content?[index].type ?? ' '}",
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: ColorManager
                                                                    .darkGrey),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            "${materialContent![index].content?[index].text ?? ' '}",
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color:
                                                                    ColorManager
                                                                        .primary),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                    },
                                  ),
                            InkWell(
                              onTap: () {
                                API(context)
                                    .get(
                                        'core/courses/${widget.course.id}/materials/next',
                                        Token: true)
                                    .then((value) {
                                  print(value);
                                  if (value['code'] == 200) {
                                    var data = value['data'];
                                    materialContent = [];
                                    data.forEach((element) {
                                      print(element['content']);
                                      setState(() {
                                        materialContent
                                            ?.add(Materials.fromJson(element));
                                      });
                                    });
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (_) => ResultOverlay(
                                            "لا توجد ماتريال الان ",
                                            cash: false));
                                  }
                                });
                              },
                              child: Container(
                                  width: ScreenUtil.getWidth(context) / 2.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: ColorManager.primary),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Next Materials',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ))),
                            )
                          ],
                        ),
                        Container(
                          child: users == null
                              ? Center(child: CircularProgressIndicator())
                              : ListView.builder(
                                  itemCount: users?.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListView.builder(
                                      itemCount: materialContent![index]
                                          .content
                                          ?.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final friend = users![index];

                                        return ListTile(
                                          title: Text(
                                              "${friend?.firstName} ${friend?.lastName}"),
                                          subtitle: Text(
                                            "${friend?.email ?? friend?.phoneNumber ?? ''}",
                                            style: TextStyle(
                                                color: ColorManager.primary),
                                          ),
                                          leading: CachedNetworkImage(
                                            imageUrl: "${friend?.avatar}",
                                            width: 50,
                                            height: 50,
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.person),
                                          ),
                                          trailing: IconButton(
                                            icon: Icon(Icons.add),
                                            onPressed: () {
                                              API(context).post(
                                                  'profile/${friend.id}/send_friend_request/',
                                                  {}).then((value) {
                                                print(value);
                                                var data = value['data'];
                                                final snackBar;
                                                if (value['code'] == 200) {
                                                  snackBar = SnackBar(
                                                    content: Center(
                                                        child: Text(
                                                      '${data['message']}',
                                                      style: TextStyle(
                                                          color: Colors.white,),
                                                    )),
                                                    behavior: SnackBarBehavior.floating,
                                                    margin: EdgeInsets.symmetric(horizontal: 50,vertical: 50),

                                                    backgroundColor:
                                                        Colors.green,
                                                  );
                                                } else {
                                                  snackBar = SnackBar(
                                                    content: Center(
                                                        child: Text(
                                                      '${data['non_field_errors']['message']}',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                                    behavior: SnackBarBehavior.floating,
                                                    margin: EdgeInsets.symmetric(horizontal: 50,vertical: 50),

                                                    backgroundColor:
                                                        Colors.red,
                                                  );
                                                }

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              });
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                        ),
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
