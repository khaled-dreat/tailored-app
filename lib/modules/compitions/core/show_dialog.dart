import 'package:flutter/material.dart';

class ShowDialog {
  static void showMyDialog(
    BuildContext context, {
    required String title,
    required String discription,
    required String? choiceTrue,
    String? choiceFalse,
    double? height,
    required void Function()? onChoiceTrue,
    void Function()? onChoiceFalse,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    SizedBox(height: 10),
                    Text(
                      textAlign: TextAlign.center,
                      discription,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFF46A0AE)),
                            elevation: MaterialStateProperty.all(1),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(25))),
                          ),
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: Text(
                            choiceTrue!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        const Spacer(),
                        if (choiceFalse != null)
                          ElevatedButton(
                            style: ButtonStyle(
                                   shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(25))),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                                    
                            child: Text(
                              choiceFalse,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                            onPressed: () {
                              // Perform saving action here
                              Navigator.pop(context, false);
                            },
                          ),
                        if (choiceFalse != null) const Spacer(),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ).then((value) {
      // Handle result of user's action
      if (value) {
        onChoiceTrue!();
      } else {
        onChoiceFalse!();
      }
    });
  }
}
