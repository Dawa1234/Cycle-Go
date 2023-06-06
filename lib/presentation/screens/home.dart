import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 20, 0, 20),
          child: InkWell(
            onTap: () => Drawer(
              child: Container(
                width: 100,
              ),
            ),
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
          ),
        ),
        title: Container(
          alignment: Alignment.center,
          width: 180,
          height: 40,
          child: const Text("Our Location"),
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
    );
  }
}
