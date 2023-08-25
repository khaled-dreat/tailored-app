import 'package:tailored/utilities/color_manager.dart';
import 'package:tailored/modules/course/screen/course_page.dart';
import 'package:tailored/utilities/fun_app/navigator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tailored/model/course.dart';

class CourseItem extends StatefulWidget {
  final Course course;
  final themeColor;

  CourseItem({this.themeColor, required this.course});
  @override
  _CourseItemState createState() => _CourseItemState();
}

class _CourseItemState extends State<CourseItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Nav.route(
            context,
            CoursePage(
              course: widget.course,
            ));
      },
      child: Container(
        margin: EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5.0,
                  spreadRadius: 1,
                  offset: Offset(0.0, 1)),
            ]),
        //  width: ScreenUtil.getWidth(context) / 1.25,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: "${widget.course.image}",
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.fitWidth,
                        height: 100,
                        width: 300,
                      )),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 180,
                        child: Text(
                          "${widget.course?.name ?? ''}",
                          style: TextStyle(
                            color: ColorManager.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Text(
                        "${widget.course?.description ?? ''}",
                        style: TextStyle(
                            color: ColorManager.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              left: 1,
              top: 70,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                ),
                padding: EdgeInsets.all(8),
                child: Text(
                  "انضم إلينا الآن",
                  style: TextStyle(
                      color: ColorManager.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w100),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
