import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/Controller/Api.dart';
import 'package:weather/view/CityDetails.dart';
import 'package:weather/view/searchview.dart';

import '../Controller/webServer.dart';
import '../Widgets/Weathercard.dart';
import 'animation.dart';

class WeatherReport extends StatefulWidget {
  const WeatherReport({super.key});

  @override
  State<WeatherReport> createState() => _WeatherReportState();
}

class _WeatherReportState extends State<WeatherReport> {
  var data, forecast = [];

  @override
  void initState() {
    data = Get.arguments;
    getData();
    super.initState();
  }

  getData() async {
    var url =
        "${Api.getforecast}?lat=${data["coord"]["lat"]}&lon=${data["coord"]["lon"]}&appid=${Api.key}";
    var response = await WebServer().gett(url);
    forecast = response.body["list"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(true),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize:
                const Size.fromHeight(100.0), // here the desired height
            child: Container(
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 1.0),
              ], borderRadius: BorderRadius.circular(30), color: Colors.white),
              width: 50,
              height: 100,
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5,
                                color: Colors.black26,
                                spreadRadius: 2),
                            BoxShadow(
                                blurRadius: 5,
                                color: Colors.white,
                                spreadRadius: 2)
                          ]),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20.0,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 40,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(data["name"],
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    const Spacer()
                  ],
                ),
              ),
            )),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              const Text("Current",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green)),
              const SizedBox(height: 10),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 119, 204, 22)),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3.5,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Text("${data["main"]["temp"] / 10}",
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white54)),
                        const Text("Clear",
                            style:
                                TextStyle(fontSize: 22, color: Colors.white54)),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                Row(
                                                  children: [
                                                    const Text("Humidity ",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white)),
                                                    Text(
                                                        "${data["main"]["humidity"]}",
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white54))
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    const Text("Wind ",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white)),
                                                    Text(
                                                        "${data["wind"]["speed"]}km/hr",
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.white54))
                                                  ],
                                                )
                                              ])),
                                          const HomePage()
                                        ]))))
                      ])),
              const SizedBox(height: 20),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3.5,
                  child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: forecast.length > 5 ? 5 : forecast.length,
                      itemBuilder: (context, index) {
                        var maintemp = forecast[index]["main"]["temp"] / 10;
                        var mintemp = forecast[index]["main"]["temp_min"] / 10;
                        var maxtemp = forecast[index]["main"]["temp_max"] / 10;

                        return GestureDetector(
                          onTap: () => Weathercarddetails()
                              .showBottom(context, maintemp, mintemp, maxtemp),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color.fromARGB(255, 119, 204, 22)),
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.height / 4,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Padding(
                                            padding: EdgeInsets.only(
                                                left: 30.0, right: 30.0),
                                            child: HomePage()),
                                        Text("${maintemp.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                                fontSize: 26,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(children: [
                                                const Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    color: Colors.white),
                                                Text(
                                                    "${mintemp.toStringAsFixed(2)}",
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white54)),
                                              ]),
                                              Column(children: [
                                                const Icon(
                                                    Icons
                                                        .keyboard_arrow_up_rounded,
                                                    color: Colors.white),
                                                Text(
                                                    "${maxtemp.toStringAsFixed(2)}",
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white54)),
                                              ])
                                            ])
                                      ]))),
                        );
                      }))
            ])),
      ),
    );
  }
}
