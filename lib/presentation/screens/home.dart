import 'package:cyclego/presentation/screens/customer_drawer.dart';
import 'package:flutter/material.dart';

GlobalKey<ScaffoldState>? scaffoldKey;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: '_scaffoldKey');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scaffoldKey = _scaffoldKey;
  }

  void openDrawer() {
    scaffoldKey?.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: 80,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 20, 0, 20),
          child: Builder(builder: (context) {
            return InkWell(
              onTap: openDrawer,
              child: Container(
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 2,
                          spreadRadius: 1)
                    ]),
              ),
            );
          }),
        ),
        title: Container(
          alignment: Alignment.center,
          width: 180,
          height: 40,
          child: const Text(
            "Our Location",
            style: TextStyle(
                fontFamily: 'Tondo',
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 42, 42, 42)),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade400,
                    offset: const Offset(0, 2),
                    blurRadius: 3,
                    spreadRadius: 1)
              ]),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text("Home Page"),
      ),
      drawer: CustomDrawer(),
    );
  }
}
