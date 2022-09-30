import 'package:flutter/material.dart';
import 'InputDecom_design.dart';

class ExchangeList extends StatelessWidget  {

  String name ;
  List exchangeList;
  ExchangeList({Key? key,required this.name, required this.exchangeList}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // activityLevel = activityList.first;


    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: exchangeList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Row(
                          children: <Widget>[
                            Text('${exchangeList[index]}',
                              style: const TextStyle(fontFamily: 'Lato'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

