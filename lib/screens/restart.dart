import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Restart extends StatefulWidget {
Restart({super.key});
  @override
  _RestartState createState() => _RestartState();
}

class _RestartState extends State<Restart> {
  bool visible = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void loginAndRestart() async {
    // Define the URL and headers for the login request
    String loginUrl = "http://192.168.1.1/";
    Map<String, String> loginHeaders = {
      "Content-Type": "application/x-www-form-urlencoded",
    };

    // Define the data for the login request
    Map<String, String> loginData = {
      "action": "login",
      "Username": "admin",
      "Password": "elgaml2191168",
    };

    // Create a session and make the POST request for login
    http.Client client = http.Client();
    http.Response loginResponse = await client.post(
      Uri.parse(loginUrl),
      headers: loginHeaders,
      body: loginData,
    );

    // Check if login was successful
    if (loginResponse.statusCode == 200) {
      // Define the URL and headers for the restart request
      String restartUrl =
          "http://192.168.1.1/getpage.gch?pid=1002&nextpage=manager_dev_conf_t.gch";
      Map<String, String> restartHeaders = {
        "Content-Type": "application/x-www-form-urlencoded",
      };

      // Define the data for the restart request
      Map<String, String> restartData = {
        "IF_ACTION": "devrestart",
        "IF_ERRORSTR": "SUCC",
        "IF_ERRORPARAM": "SUCC",
        "IF_ERRORTYPE": "-1",
        "flag": "1",
      };

      // Make the POST request to restart the router
      http.Response restartResponse = await client.post(
        Uri.parse(restartUrl),
        headers: restartHeaders,
        body: restartData,
      );

      // Check if router restart was successful
      if (restartResponse.statusCode == 200) {
        print("Router restarted successfully.");
      } else {
        print("Failed to restart router: ${restartResponse.statusCode}");
      }
    } else {
      print("Failed to login: ${loginResponse.statusCode}");
    }

    // Close the client
    client.close();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 22, 22, 22),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 38, 38, 38),
          title: const Text(
            "Restart Router",
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: usernameController,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      decoration: const InputDecoration(
                        hintText: "Enter Username",
                        hintStyle: TextStyle(
                            fontSize: 17,
                            color: Color.fromARGB(255, 234, 233, 233)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 242, 89, 78))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 242, 89, 78))),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 13, vertical: 13),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: passwordController,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      keyboardType: TextInputType.text,
                      obscureText: visible,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                visible = !visible;
                              });
                            },
                            icon: const Icon(
                              Icons.visibility,
                              color: Color.fromARGB(255, 242, 89, 78),
                            )),
                        hintText: "Enter password",
                        hintStyle: const TextStyle(
                            fontSize: 17,
                            color: Color.fromARGB(255, 234, 233, 233)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 242, 89, 78))),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 242, 89, 78))),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 13),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        loginAndRestart();
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 242, 89, 78)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Restart Router",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 23),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
