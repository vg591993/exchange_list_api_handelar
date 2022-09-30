import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:exchange_list_api_handelar/exchange_list.dart';
import 'package:flutter/material.dart';
import 'InputDecom_design.dart';
import 'package:http/http.dart' as http;

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String? name;
  List list = ["Male", "Female"];
  List activityList = ["Sedentary", "Moderate", "Heavy"];
  List abnormalities = [
    "Fever",
    "Normal",
    "T2dm",
    "CVD",
    "Renal",
    "PCOD",
    "Hepatic",
    "Anemia",
    "Gastritis",
    "Celiac",
    "IBD",
    "Acidity",
    "RENAL DIALYSIS",
    "Liver Disease",
    "Anemia",
    "ADOLESCENCE",
    "SPORTS PERSON",
    "Celiac",
    "Peptic ulcer",
    "Peptic ulcer (Mild to Moderate)",
  ];

  Map abnormalitiesMap = {
    "Fever": "exchangeList_for_Fever",
    "Normal": "exchangeList_for_Range_for_normal",
    "T2dm": "exchangeList_for_Range_for_T2dm",
    "CVD": "exchangeList_for_Range_for_cvd",
    "Renal": "exchangeList_for_renal_disease",
    "PCOD": "exchangeList_for_PCOD_disease",
    "Hepatic": "exchangeList_for_Hepatic_Disease",
    "Gastritis": "exchangeList_for_Gastritis",
    "IBD": "exchangeList_for_IBD",
    "Acidity": "exchangeList_for_acidity",
    "RENAL DIALYSIS": "exchangeList_for_RENAL_DIALYSIS_disease",
    "Liver Disease": "exchangeList_for_Liver_Disease",
    "Anemia": "exchangeList_for_Anemia_Disease",
    "ADOLESCENCE": "exchangeList_for_ADOLESCENCE",
    "SPORTS PERSON": "exchangeList_for_SPORTS_PERSON",
    "Celiac": "exchangeList_for_Celiac_Disease",
    "Peptic ulcer": "exchangeList_for_Peptic_ulcer_Disease_Severe",
    "Peptic ulcer (Mild to Moderate)":
        "exchangeList_for_Peptic_ulcer_Disease_Mield_to_Moderate",
  };
  List deseas = [
    "exchangeList_for_Fever",
    "exchangeList_for_Range_for_normal",

    "exchangeList_CLEAR_FLUID_DIET",
    "exchangeList_FULL_FLUID_DIET"
        "exchangeList_PEG_TUBE_FEEDING"
        "exchangeList_NG_TUBE_FEEDING"
        "exchangeList_NJ_TUBE_FEEDING"
        "exchangeList_IBS"
  ];

  List foodGroupLevel = [
    "not applied",
    "normal",
    "low preferable",
    "high preferable"
  ];

  List allFoodGroups = [
    "Cereals",
    "Veg_C",
    "Fats",
    "Sugar",
    "Meat_fish_egg",
    "Milk",
    "Nuts",
    "SkimmedMilk",
    "Pulses",
    "Veg_A",
    "Veg_B",
    "Fruits"
  ];

  Map non_veg = {
    "Cereals": 1,
    "Veg_C": 1,
    "Fats": 1,
    "Sugar": 1,
    "Meat_fish_egg": 1,
    "Milk": 1,
    // "Nuts": 1,
    "SkimmedMilk": 1,
    "Pulses": 1,
    "Veg_A": 1,
    "Veg_B": 1,
    "Fruits": 1
  };

  String? weight,
      height,
      gender = "Male",
      age,
      foodClass = "Normal",
      diseaseSet,
      activityLevel = "Sedentary";

  Map foodLikes = {
    "Cereals": "normal",
    "Veg_C": "normal",
    "Fats": "normal",
    "Sugar": "normal",
    "Meat_fish_egg": "normal",
    "Milk": "normal",
    "Nuts": "not applied",
    "SkimmedMilk": "not applied",
    "Pulses": "normal",
    "Veg_A": "normal",
    "Veg_B": "normal",
    "Fruits": "normal"
  };

  Map valueInMap = {
    "not applied":0,
    "normal":1,
    "low preferable":0.5,
    "high preferable":1.5
  };

  //TextController to read text entered in text field
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


  void getHttp() async {
    Map<String, dynamic> request = {
      "Person": "Vikas",
      "weight": 80,
      "height": 172,
      "gender": "M",
      "age": 30,
      "foodClass": "exchangeList_for_Range_for_normal",
      "diseaseSet": ["A", "B"],
      "activityLevel": "Sedentary",
      "foodLikes": {
        "Cereals": 1,
        "Veg_C": 1,
        "Fats": 1,
        "Sugar": 1,
        "Milk": 1,
        "Pulses": 1,
        "Veg_A": 1,
        "Veg_B": 1,
        "Fruits": 1
      }
    };
    String url = "https://asia-south1-nursing-care2.cloudfunctions.net/ExchangeList1?key=$request";



    String foodLikesText ="%20%22foodLikes%22%20:%20{%20%22Cereals%22:%20${valueInMap[foodLikes["Cereals"]]},%20%22Veg_C%22:%201,%20%22Fats%22:%201,%20%22Sugar%22:%201,%20%22Milk%22:%201,%20%22Pulses%22:%201,%20%22Veg_A%22:%201,%20%22Veg_B%22:%201,%20%22Fruits%22:%201%20}";

    bool isFirst = true;
    String text = "%20%22foodLikes%22%20:%20{";
    for(String food in foodLikes.keys){
      if(isFirst){
        if(foodLikes[food] != "not applied"){
          text +=  "%20%22$food%22:%20${valueInMap[foodLikes[food]]}";
        }
        isFirst = false;
      }else{
        if(foodLikes[food] != "not applied"){
          text +=  ",%20%22$food%22:%20${valueInMap[foodLikes[food]]}";
        }
      }

    }

    text +="%20}";

    String actText = "%20%22foodLikes%22%20:%20{%20%22Cereals%22:%201,%20%22Veg_C%22:%201,%20%22Fats%22:%201,%20%22Sugar%22:%201,%20%22Milk%22:%201,%20%22Pulses%22:%201,%20%22Veg_A%22:%201,%20%22Veg_B%22:%201,%20%22Fruits%22:%201%20}";



    if(text == actText){
      log("URL ==== equal");
    }else{
      log(" !== not equal");
      log("url ${url.length}");
      log("act url ${actText.length}");
      for(int i = 0; i < url.length; i++){
        if( url.substring(i, i+1) == actText.substring(i, i+1)){
        } else{
          log("act text ${i}");
          log("act text ${actText.substring(i, actText.length - 1)}");
          break;
        }
      }
    }

    foodLikesText = text;
    log(foodLikesText);
    url = "https://asia-south1-nursing-care2.cloudfunctions.net/ExchangeList1?key={%22Person%22%20:%20%22$name%22,%20%22weight%22%20:%20$weight,%20%22height%22%20:%20$height,%20%22gender%22%20:%20%22${gender!.substring(0,1)}%22,%20%22age%22:$age,%20%22foodClass%22%20:%20%22${abnormalitiesMap[foodClass]}%22,%20%20%22diseaseSet%22%20:%20[%22A%22,%20%22B%22],%20%22activityLevel%22%20:%20%22$activityLevel%22,$foodLikesText}";

    log(url);

    String actualURL = "https://asia-south1-nursing-care2.cloudfunctions.net/ExchangeList1?key={%22Person%22%20:%20%22Vikas%22,%20%22weight%22%20:%2080,%20%22height%22%20:%20172,%20%22gender%22%20:%20%22M%22,%20%22age%22:30,%20%22foodClass%22%20:%20%22exchangeList_for_Range_for_normal%22,%20%20%22diseaseSet%22%20:%20[%22A%22,%20%22B%22],%20%22activityLevel%22%20:%20%22Sedentary%22,%20%22foodLikes%22%20:%20{%20%22Cereals%22:%201,%20%22Veg_C%22:%201,%20%22Fats%22:%201,%20%22Sugar%22:%201,%20%22Milk%22:%201,%20%22Pulses%22:%201,%20%22Veg_A%22:%201,%20%22Veg_B%22:%201,%20%22Fruits%22:%201%20}}";

    log(actualURL);

    if(actualURL == url){
      log("URL ==== equal");
    }else{
      log(" !== not equal");
      log("url ${url.length}");
      log("act url ${actualURL.length}");
      for(int i = 0; i < url.length; i++){

       if( url.substring(i, i+1) == actualURL.substring(i, i+1)){

       }else{
         log("act url ${actualURL.substring(i, actualURL.length - 1)}");
         break;
       }

      }
    }


    try {
      var response = await Dio().get(url
          //, queryParameters: request
          );
      // print(response);
      Map valueMap = jsonDecode(response.toString());
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ExchangeList(name: "Vikas", exchangeList: valueMap["print"] )
      ));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // activityLevel = activityList.first;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: buildInputDecoration(Icons.person, "Full Name"),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        name = value!;
                      });
                    },
                  ),
                ), //name
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration:
                        buildInputDecoration(Icons.numbers, "Age in years"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please a Enter a valid age';
                      }
                      if (int.parse(value) > 0) {
                        age = value;
                        return value;
                      }
                      return null;
                    },
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        age = value!;
                      });
                    },
                  ),
                ), //age
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration:
                        buildInputDecoration(Icons.numbers, "Weight in kg"),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        weight = value!;
                      });
                    },
                  ),
                ), //weight
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration:
                        buildInputDecoration(Icons.numbers, "Height in cm"),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        height = value!;
                      });
                    },
                  ),
                ), //height
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: Row(children: <Widget>[
                    const Text(' Gender :    '),
                    DropdownButton<String>(
                      value: gender,
                      icon: const Icon(Icons.transgender),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          gender = value!;
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ]),
                ), //gender
                Padding(
                    padding:
                        const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                    child: Row(children: <Widget>[
                      const Text(' Abnormalities : '),
                      DropdownButton<String>(
                        value: foodClass,
                        icon: const Icon(Icons.monitor_heart),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            foodClass = value!;
                          });
                        },
                        items: abnormalities
                            .map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ])), //abnormalities
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: Row(children: <Widget>[
                    const Text(' Activity Level : '),
                    DropdownButton<String>(
                      value: activityLevel,
                      icon: const Icon(Icons.directions_walk_sharp),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          activityLevel = value!;
                        });
                      },
                      items:
                          activityList.map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ]),
                ), //activityLevel

                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: allFoodGroups.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Row(
                          children: <Widget>[
                            const Text(' '),
                            Text('${allFoodGroups[index]}'),
                            const Text('        '),
                            DropdownButton<String>(
                              value: foodLikes[allFoodGroups[index]],
                              // icon: const Icon(Icons.food_bank_sharp),
                              elevation: 16,
                              style: const TextStyle(color: Colors.blue),
                              underline: Container(
                                height: 2,
                                color: Colors.blueGrey,
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  foodLikes[allFoodGroups[index]] = value!;
                                });
                              },
                              items: foodGroupLevel
                                  .map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ), //foodLikes

                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      print(
                          "$weight, $height, $gender , $age, $foodClass , $diseaseSet, $activityLevel");
                      print("$foodLikes");

                      List printList = [
                        "|FOOD GROUP|   NOE   |amount____  |carboh____  |protei____  |fat_in____  |energy____",
                        "Cereal____|    6.10|  121.96    |   91.47    |   12.20    |    0.00    |  426.87    |",
                        "Veg_C_____|    3.58|  215.10    |   53.77    |    7.17    |    0.00    |  250.95    |",
                        "Fats______|    3.40|   16.98    |    0.00    |    0.00    |   16.98    |  152.83    |",
                        "Sugar_____|    3.20|   16.10    |   16.10    |    0.00    |    0.00    |   64.40    |",
                        "Milk______|    2.40|  600.74    |   28.84    |   19.22    |   24.30    |  408.50    |",
                        "Pulses____|    1.60|   48.60    |   27.23    |   11.21    |    0.00    |  160.20    |",
                        "Veg_A_____|    1.80|  180.29    |    6.31    |    1.80    |    0.00    |   36.60    |",
                        "Veg_B_____|    5.72|  572.42    |   40.70    |   11.45    |    0.00    |  228.97    |",
                        "Fruits____|    2.40|  192.24    |   24.30    |    0.00    |    0.00    |   96.12    |",
                        "disease : exchangeList_for_Range_for_normal",
                        "",
                        "As BMR req",
                        "carboh____  total:   287.73; req:   296.48; diff: -8.751360599999998",
                        "protei____  total:    63.50; req:    54.74; diff: 8.319097200000002",
                        "fat_in____  total:    41.10; req:    50.68; diff: -9.6708871111111",
                        "energy____  total:  1824.52; req:  1824.52; diff: -1.9999999949504854e-06",
                        "",
                        "",
                        "Carbohydrate Percentage:    63.80; protien Percentage:    13.82; fat Percentage:    20.23; totalOf_CPF:   97.85",
                        "",
                        "amount_in_gm_or_ml : 1963.7944200000002"
                      ];

                      // _getMethod(context);
                      // getRequest();
                      getHttp();
                      // postMethod({});
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ExchangeList( name: name!, exchangeList: printList )));
                    },
                    child: const Text('Get Exchange'),
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
