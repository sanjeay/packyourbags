import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedBusType;
  TextEditingController _fromcontroller = TextEditingController();
  TextEditingController _tocontroller = TextEditingController();
  String firsttext = '';
  String secondtext = '';
  void swaptext() {
    String temptext = firsttext;
    setState(() {
      firsttext = secondtext;
      secondtext = temptext;
      _fromcontroller.text = firsttext;
      _tocontroller.text = secondtext;
    });
  }

  List<String> busTypes = [
    'AC SLEEPER',
    'NON AC SLEEPER',
    'AC SEATER',
    'NON AC SEATER',
    'VOLVO',
    'MINI BUS',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FIND MY BUS",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Container(
              width: MediaQuery.of(context).size.height * 0.4,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.1, color: Colors.grey)),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      firsttext = value;
                    });
                  },
                  controller: _fromcontroller,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                      suffixIcon: Icon(BootstrapIcons.bus_front),
                      hintText: "     FROM ",
                      hintStyle: GoogleFonts.poppins(),
                      border: InputBorder.none),
                ),
              ),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(shape: CircleBorder()),
              onPressed: swaptext,
              child: Icon(Icons.arrow_upward)),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Container(
              width: MediaQuery.of(context).size.height * 0.4,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.1, color: Colors.grey)),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      secondtext = value;
                    });
                  },
                  controller: _tocontroller,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                      suffixIcon: Icon(BootstrapIcons.bus_front),
                      hintText: "     TO      ",
                      hintStyle: GoogleFonts.poppins(),
                      border: InputBorder.none),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            width: 200,
            child: DropdownButton<String>(
                isExpanded: true,
                elevation: 0,
                hint: Text(
                  "SELECT BUS TYPES",
                  style: GoogleFonts.poppins(color: Colors.black),
                ),
                value: selectedBusType,
                items: busTypes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newvalue) {
                  setState(() {
                    selectedBusType = newvalue;
                  });
                }),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
                onPressed: () {
                  // showSearch(context: context,
                  //     delegate: customsearch());
                },
                child: Text(
                  "SEARCH",
                  style: GoogleFonts.poppins(),
                )),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
                onPressed: () {
                  // ignore: prefer_const_constructors
                  Navigator.pushNamed(context, "/checkroutes");
                },
                child: Text(
                  "CHECK ROUTES",
                  style: GoogleFonts.poppins(),
                )),
          ),
        ],
      ),
    );
  }
}
