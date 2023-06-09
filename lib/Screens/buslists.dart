import 'dart:convert';

import 'package:bootstrap_icons/bootstrap_icons.dart';
// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class Bus_lists extends StatefulWidget {
  const Bus_lists({super.key});

  @override
  State<StatefulWidget> createState() => HiveDemoState();
}

class HiveDemoState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
              color: Colors.white,
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      BootstrapIcons.search_heart,
                      size: 19,
                    ),
                    border: InputBorder.none,
                    hintText: "SEARCH HERE...",
                    hintStyle: GoogleFonts.poppins()),
              )),
        ),
        title: Text(
          "FIND YOUR ROUTE",
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text("ADD ME"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: () => _showForm(context, null),
        label: Text("ADD NEW ROUTE", style: GoogleFonts.poppins()),
      ),
    );
  }

  TimeOfDay _timeOfDay = const TimeOfDay(hour: 0, minute: 0);
  final name_controller = TextEditingController();
  final from_controller = TextEditingController();
  final time_controller = TextEditingController();
  final to_controller = TextEditingController();
  final number_controller = TextEditingController();
  Future<void> insertdetails() async {
    if (name_controller.text != "" ||
        from_controller.text != "" ||
        time_controller.text != "" ||
        to_controller.text != "") {
      try {
        String uri = "http://localhost:8080/idzo_api/insert_details.php";
        var res = await http.post(Uri.parse(uri), body: {
          "Bus_name": name_controller.text,
          "Bus_number": number_controller.text,
          "From": from_controller.text,
          "To": to_controller.text,
          "Time": time_controller.text
        });
        var response = jsonDecode(res.body);
        if (response["success"] == "true") {
          print("record inserted");
        } else {
          print("some issue");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Please fill all fields");
    }
  }

  _showForm(BuildContext context, int? itemKey) async {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        isScrollControlled: true,
        elevation: 3,
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 15,
              left: 15,
              right: 15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  textCapitalization: TextCapitalization.characters,
                  controller: name_controller,
                  decoration: const InputDecoration(hintText: 'Bus Name'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 150,
                      child: TextField(
                        textCapitalization: TextCapitalization.characters,
                        controller: from_controller,
                        decoration: const InputDecoration(hintText: 'from'),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 150,
                      child: TextField(
                        textCapitalization: TextCapitalization.characters,
                        controller: to_controller,
                        decoration: const InputDecoration(hintText: 'to'),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  textCapitalization: TextCapitalization.characters,
                  controller: number_controller,
                  decoration: const InputDecoration(hintText: 'Bus Number'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          _showtimepicker();
                        },
                        child: Text(
                          _timeOfDay.format(context).toString(),
                          style: GoogleFonts.poppins(fontSize: 20),
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        insertdetails();
                      },
                      child: Text("Update item")),
                )
              ],
            ),
          );
        });
  }

  void _showtimepicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        _timeOfDay = value!;
      });
    });
  }
}
