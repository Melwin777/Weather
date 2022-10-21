import 'package:flutter/material.dart';
import 'package:weather/view/animation.dart';

class Weathercarddetails{
showBottom(BuildContext context, maintemp, mintemp, maxtemp) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromARGB(255, 119, 204, 22)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(left: 30.0, right: 30.0),
                            child: HomePage()),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(children: [
                                const Icon(Icons.keyboard_arrow_down_rounded,
                                    color: Colors.white),
                                Text("${mintemp.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white54)),
                              ]),
                              Text("${maintemp.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              Column(children: [
                                const Icon(Icons.keyboard_arrow_up_rounded,
                                    color: Colors.white),
                                Text("${maxtemp.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white54)),
                              ])
                            ])
                      ])));
        });
  }
}