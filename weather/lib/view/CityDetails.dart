import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/Controller/Api.dart';
import 'package:weather/Widgets/AppBar.dart';
import 'package:weather/view/WeatherReport.dart';

class CityDetails extends StatefulWidget {
  @override
  State<CityDetails> createState() => _CityDetailsState();
}

class _CityDetailsState extends State<CityDetails> {
  var data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ApBar.getAppbar(tittle: ' City Forecast Weather'),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage("images/city.png"),
              onError: (exception, stackTrace) =>
                  debugPrint(stackTrace.toString()),
              fit: BoxFit.fill,
            ),
          ),
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        Get.to(() => WeatherReport(), arguments: data[index]);
                      });
                    },
                    child: City(
                        City: data[index]["name"],
                        Humidity: data[index]["main"]["humidity"],
                        Wind: data[index]["wind"]["speed"],
                        Max: data[index]["main"]["temp_max"] / 10,
                        Min: data[index]["main"]["temp_min"] / 10,
                        image: data[index]["sys"]["country"]),
                  ),
                );
              }),
        ));
  }

  Widget City(
      {String? City,
      int? Humidity,
      double? Wind,
      double? Max,
      double? Min,
      image}) {
    return Container(
      height: 150,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
        color: Colors.white,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image.network(
                  '${Api.getflag}$image',
                  height: 80.0,
                  width: 80.0,
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('$City'),
                      const SizedBox(
                        height: 10,
                        width: 50,
                      ),
                      Text('Humidity :$Humidity'),
                      SizedBox(height: 10),
                      Text('Wind: $Wind'),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    //flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Max:${Max!.toStringAsFixed(2)}'),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Min:${Min!.toStringAsFixed(2)}'),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.green,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
