import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tailored/model/course.dart';
import 'package:tailored/providers/provider_notifier.dart';
import 'package:tailored/service/api.dart';
import 'package:tailored/utilities/color_manager.dart';

import '../../compitions/controllers/compitition_controller.dart';
import '../../compitions/core/constants.dart';
import '../../compitions/screens/commpititions/components/competition_item.dart';
import '../../compitions/screens/quiz/quiz_screen.dart';
import '../../compitions/sevices/firebase_fireStore/firebase_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String matchId = '';
  bool iswitting = false;
  final List<Course> courses = [];

  @override
  void initState() {
    Get.put(FirestoreService());
    
    Get.put(CompitionController(Get.find<FirestoreService>()));
    API(context).get('core/courses').then((value) {
      List<dynamic> data = value['data'];
      setState(() {
        courses.addAll(data.map((element) => Course.fromJson(element)));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext ctx) {
    final themeColor = Provider.of<Provider_control>(context);
    CompitionController competitionController = Get.find<CompitionController>();

    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
              child: _buildSearchBar(),
            ),
            // CourseList(
            //   courses: courses,
            // ),
            // const CompetitionsList()

            Obx(() {
              if (competitionController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: matchId == ''
                          ? null
                          : competitionController.getMatchStatus(
                              competitionController.matchIdFirebase),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (matchId != '') {
                            var data = snapshot.data!.data();
                            if (data!['players'].cast<List>().length == 2) {
                              SchedulerBinding.instance
                                  .addPostFrameCallback((_) {
                                Get.to(
                                  () => const QuizScreen(),
                                );
                                // add your code here.
                              });
                            }
                          }
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return SizedBox(
                            height: 500,
                            child: ListView.builder(
                                itemCount:
                                    competitionController.competitions.length,
                                itemBuilder: (context, index) {
                                  return
                                      //Text( competitionController.competitions.length.toString());

                                      CompetitionItem(
                                          isWitting: iswitting,
                                          onTap: () async {

                                            await competitionController
                                                .joinCompetition(
                                                    competitionController
                                                        .competitions[index].id,
                                                    ctx
                                                    // competitionController
                                                    // .emptyCompetitions[index].id,
                                                    );
                                            setState(() {
                                              iswitting = !iswitting;
                                              matchId = competitionController
                                                  .competitions[index].id;
                                            });
                                          
                                          
                                           // Get.to(()=> const QuizScreen());
                                          },
                                          competition: competitionController
                                              .competitions[index]);
                                }),
                          );
                        }
                      }),
                );
              }
            })
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorManager.primary,
      title: Image.asset(
        "assets/images/logo.png",
        height: 70,
        width: 70,
        color: ColorManager.white,
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.circle_notifications_outlined,
            color: ColorManager.white,
            size: 50,
          ),
          onPressed: () {},
        )
      ],
    );
  }

  TextFormField _buildSearchBar() {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        prefixIcon:
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        hintText: "البحث عن  . . .",
        hintStyle: TextStyle(color: ColorManager.grey),
        contentPadding: const EdgeInsets.all(10.0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(
            color: Colors.black12,
            width: 1.0,
          ),
        ),
        filled: true,
        suffixIcon: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.filter_list),
        ),
      ),

      //  validator: validator,
      // autovalidate: true,
    );
  }
}
