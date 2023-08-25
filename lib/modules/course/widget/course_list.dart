import 'package:tailored/utilities/color_manager.dart';
import 'package:tailored/modules/course/widget/course_item.dart';
import 'package:tailored/local/LanguageTranslated.dart';
import 'package:tailored/utilities/screen_size.dart';
import 'package:tailored/model/course.dart';
import 'package:flutter/material.dart';

class CourseList extends StatelessWidget {
  CourseList({
    this.courses,
  });

  final List<Course>? courses;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 8),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: courses == null
                ? Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            ColorManager.primary)))
                : courses!.isEmpty
                    ? Center(
                        child: Text("${getTransrlate(context, "noCategory")}"))
                    : Container(
                        height: 200,
                        width: ScreenUtil.getWidth(context),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: courses?.length,
                            itemBuilder: (context, i) {
                              return CourseItem(course: courses![i]);
                            })),
          ),
        ],
      ),
    );
  }
}
