import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/Controller/webServer.dart';
import 'package:weather/view/CityDetails.dart';
import '../Controller/Api.dart';
import '../Widgets/AppBar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController textController = TextEditingController();

  String get text => textController.text;
  TextEditingController city = TextEditingController();
  static bool mark = false;
  List searchwordlist = [];
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  var selecteditem = [];
  static const kGoogleApiKey = "AIzaSyDrPv_Fdll54Bm4KdtZEwQVi3enJ459XNw";
  var weatherdetailslist = [];
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/city.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
      Scaffold(
          backgroundColor: const Color.fromARGB(222, 249, 246, 246),
          appBar: ApBar.getAppbar(tittle: 'Forecast Weather'),
          body: SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(""),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('     What would you like to '),
                      const Text('search weather for differnt citites?'),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'search below.',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: TextField(
                            onSubmitted: (value) {
                              setState(() {
                                searchwordlist.add(value);
                              });
                            },
                            controller: textController,
                            onChanged: (value) {
                              setState(() {});
                            },
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              iconColor: Colors.black,
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: Icon(
                                Icons.check_circle_rounded,
                                color:
                                    textController.text.isNotEmpty ? Colors.green : Colors.black,
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(222, 249, 246, 246)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(222, 249, 246, 246)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                              hintText: 'Search cities',
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: searchwordlist.isNotEmpty,
                        child: SizedBox(
                            width: 300,
                            height: 100,
                            child: Wrap(
                              direction: Axis.vertical,
                              children: searchwordlist.map((item) {
                                return GestureDetector(
                                  onTap: () {
                                    if (selecteditem.contains(item)) {
                                      selecteditem.remove(item);
                                    } else {
                                      selecteditem.add(item);
                                    }
                                    setState(() {});
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(item),
                                    ),
                                    color: selecteditem.contains(item)
                                        ? Colors.lightBlue
                                        : Colors.black12,
                                  ),
                                );
                              }).toList(),
                            )),
                      ),
                      SizedBox(
                        width: 400,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 60, 223, 66),
                            // side: BorderSide(color: Colors.yellow, width: 5),
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontStyle: FontStyle.normal),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            shadowColor: Colors.lightBlue,
                          ),
                          onPressed: () async {
                            getData();
                          },
                          child: const Text(
                            'Search City',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                          width: 400,
                          height: 45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 60, 223, 66),
                              // side: BorderSide(color: Colors.yellow, width: 5),
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontStyle: FontStyle.normal),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              shadowColor: Colors.lightBlue,
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Check Weather',
                              style: TextStyle(fontSize: 20),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ))
    ]);
  }

  Future<void> getData() async {
    weatherdetailslist = [];
    for (var v = 0; v <= selecteditem.length; v++) {
      var url =
          "${Api.getlatlong}?q=${selecteditem[v]}&limit=1&appid=${Api.key}";
      var response = await WebServer().gett(url);
      var lat = response.body[0]["lat"].toStringAsFixed(2);
      var lon = response.body[0]["lon"].toStringAsFixed(2);
      var getweather = "${Api.getweather}?lat=$lat&lon=$lon&appid=${Api.key}";
      var response1 = await WebServer().gett(getweather);

      weatherdetailslist.add(response1.body);
      weatherdetailslist;
      if (selecteditem.length == weatherdetailslist.length) {
        Get.to(() => CityDetails(), arguments: weatherdetailslist);
      }
    }
  }
}
