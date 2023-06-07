import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_advisor/Pages/attractions_screen.dart';
import 'package:smart_travel_advisor/Pages/home_page.dart';

import '../provider/provider_class.dart';
import '../services/utils/app_colors.dart';
import '../services/utils/app_test_styles.dart';
import '../widgets/radio_widget.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int? q1GroupValue;
  int? q2GroupValue;
  int? q3GroupValue;
  int? q4GroupValue;
  int? q5GroupValue;
  List<String> document = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Choose your trip locations",
              style: AppTextStyles.popins(
                  style: const TextStyle(
                      color: AppColors.kWhiteColor, fontSize: 14))),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10, top: 10),
              child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => HomeScreen()));
                  },
                  child: Text(
                    "Manual",
                    style: AppTextStyles.popins(
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12)),
                  )),
            )
          ]),
      body: ChangeNotifierProvider(
        create: (context) => ProviderClass(),
        child: Consumer<ProviderClass>(
            builder: (BuildContext context, value, Widget? child) {
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 14),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.73,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        questionBox(
                            "Q.1: Do you want the top-rated cafes in a particular destination in lahore?"),
                        radioButtons1(),
                        questionBox(
                            "Q.2: Do you want he best local or ethnic restaurants in a particular destination in lahore?"),
                        radioButtons2(),
                        questionBox(
                          "Q.3: Do you want the best parks or outdoor spaces to visit in a particular destination in lahore?",
                        ),
                        radioButtons3(),
                        questionBox(
                            "Q.4: Do you want the best historical sites or landmarks to visit in a particular destination lahore?"),
                        radioButtons4(),
                        questionBox(
                          "Q.5: Do you want the best Cinemas centers to visit in a particular destination in lahore?",
                        ),
                        radioButtons5()
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20, left: 20, right: 20, top: 15),
                    child: Container(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              document = [];
                              if (q1GroupValue == 1) {
                                document.add("Cafe");
                              }
                              if (q2GroupValue == 1) {
                                document.add("Restaurant");
                              }
                              if (q3GroupValue == 1) {
                                document.add("Park");
                              }
                              if (q4GroupValue == 1) {
                                document.add("Historical Place");
                              }
                              if (q5GroupValue == 1) {
                                document.add("Cinema");
                              }
                              if (document.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select the options or continue manual")));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => AttractionsScreen(
                                            documentName: document)));
                              }
                            },
                            child: Text("Continue")))),
              ],
            ),
          );
        }),
      ),
    );
  }

  Text questionBox(String text) {
    return Text(
      text,
      style: AppTextStyles.popins(
          style: const TextStyle(
        color: AppColors.kDarkColor,
      )),
    );
  }

  Widget radioButtons1() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 130,
          child: RadioListTile(
            value: 1,
            groupValue: q1GroupValue,
            title: Text(
              "Yes",
              style: AppTextStyles.popins(
                  style: const TextStyle(
                      color: AppColors.kDarkColor, fontSize: 12)),
            ),
            onChanged: (newValue) {
              print(newValue);
              setState(() {
                q1GroupValue = newValue;
              });
            },
            activeColor: AppColors.kPrimaryColor,
            selected: false,
          ),
        ),
        Expanded(
          flex: 1,
          child: RadioListTile(
            value: 0,
            groupValue: q1GroupValue,
            title: Text(
              "No",
              style: AppTextStyles.popins(
                  style: const TextStyle(
                      color: AppColors.kDarkColor, fontSize: 12)),
            ),
            onChanged: (newValue) {
              setState(() {
                q1GroupValue = newValue;
              });
            },
            activeColor: AppColors.kPrimaryColor,
            selected: false,
          ),
        ),
      ],
    );
  }

  Widget radioButtons2() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 130,
          child: RadioListTile(
            value: 1,
            groupValue: q2GroupValue,
            title: Text(
              "Yes",
              style: AppTextStyles.popins(
                  style: const TextStyle(
                      color: AppColors.kDarkColor, fontSize: 12)),
            ),
            onChanged: (newValue) {
              print(newValue);
              setState(() {
                q2GroupValue = newValue;
              });
            },
            activeColor: AppColors.kPrimaryColor,
            selected: false,
          ),
        ),
        Expanded(
          flex: 1,
          child: RadioListTile(
            value: 0,
            groupValue: q2GroupValue,
            title: Text(
              "No",
              style: AppTextStyles.popins(
                  style: const TextStyle(
                      color: AppColors.kDarkColor, fontSize: 12)),
            ),
            onChanged: (newValue) {
              setState(() {
                q2GroupValue = newValue;
              });
            },
            activeColor: AppColors.kPrimaryColor,
            selected: false,
          ),
        ),
      ],
    );
  }

  Widget radioButtons3() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 130,
          child: RadioListTile(
            value: 1,
            groupValue: q3GroupValue,
            title: Text(
              "Yes",
              style: AppTextStyles.popins(
                  style: const TextStyle(
                      color: AppColors.kDarkColor, fontSize: 12)),
            ),
            onChanged: (newValue) {
              print(newValue);
              setState(() {
                q3GroupValue = newValue;
              });
            },
            activeColor: AppColors.kPrimaryColor,
            selected: false,
          ),
        ),
        Expanded(
          flex: 1,
          child: RadioListTile(
            value: 0,
            groupValue: q3GroupValue,
            title: Text(
              "No",
              style: AppTextStyles.popins(
                  style: const TextStyle(
                      color: AppColors.kDarkColor, fontSize: 12)),
            ),
            onChanged: (newValue) {
              setState(() {
                q3GroupValue = newValue;
              });
            },
            activeColor: AppColors.kPrimaryColor,
            selected: false,
          ),
        ),
      ],
    );
  }

  Widget radioButtons4() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 130,
          child: RadioListTile(
            value: 1,
            groupValue: q4GroupValue,
            title: Text(
              "Yes",
              style: AppTextStyles.popins(
                  style: const TextStyle(
                      color: AppColors.kDarkColor, fontSize: 12)),
            ),
            onChanged: (newValue) {
              print(newValue);
              setState(() {
                q4GroupValue = newValue;
              });
            },
            activeColor: AppColors.kPrimaryColor,
            selected: false,
          ),
        ),
        Expanded(
          flex: 1,
          child: RadioListTile(
            value: 0,
            groupValue: q4GroupValue,
            title: Text(
              "No",
              style: AppTextStyles.popins(
                  style: const TextStyle(
                      color: AppColors.kDarkColor, fontSize: 12)),
            ),
            onChanged: (newValue) {
              setState(() {
                q4GroupValue = newValue;
              });
            },
            activeColor: AppColors.kPrimaryColor,
            selected: false,
          ),
        ),
      ],
    );
  }

  Widget radioButtons5() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 130,
          child: RadioListTile(
            value: 1,
            groupValue: q5GroupValue,
            title: Text(
              "Yes",
              style: AppTextStyles.popins(
                  style: const TextStyle(
                      color: AppColors.kDarkColor, fontSize: 12)),
            ),
            onChanged: (newValue) {
              print(newValue);
              setState(() {
                q5GroupValue = newValue;
              });
            },
            activeColor: AppColors.kPrimaryColor,
            selected: false,
          ),
        ),
        Expanded(
          flex: 1,
          child: RadioListTile(
            value: 0,
            groupValue: q5GroupValue,
            title: Text(
              "No",
              style: AppTextStyles.popins(
                  style: const TextStyle(
                      color: AppColors.kDarkColor, fontSize: 12)),
            ),
            onChanged: (newValue) {
              setState(() {
                q5GroupValue = newValue;
              });
            },
            activeColor: AppColors.kPrimaryColor,
            selected: false,
          ),
        ),
      ],
    );
  }
}
