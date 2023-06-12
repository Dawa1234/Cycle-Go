import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/presentation/drawer/custom_drawer.dart';
import 'package:cyclego/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

GlobalKey<ScaffoldState>? scaffoldKey;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  GoogleMapController? googleMapController;
  Set<Marker> marker = {};
  LatLng myLocation = const LatLng(27.706138023691675, 85.3299790407648);
  final _scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: '_scaffoldKey');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scaffoldKey = _scaffoldKey;
    marker.add(
      Marker(
          markerId: MarkerId(myLocation.toString()),
          position: myLocation,
          infoWindow: const InfoWindow(
              title: 'Softwarica College', snippet: 'Bsc Hons(Computing)'),
          icon: BitmapDescriptor.defaultMarker),
    );
  }

  void openDrawer() {
    scaffoldKey?.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SizedBox(
        height: phoneHeight(context),
        width: phoneWeight(context),
        child: Stack(
          children: [
            _googleMapScreen(context),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
              child: Row(
                children: [
                  // drawer
                  InkWell(
                    onTap: openDrawer,
                    child: Container(
                      height: 40,
                      width: 45,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.menu,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius: 2,
                                spreadRadius: 1)
                          ]),
                    ),
                  ),
                  // title "Our Location"
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _ourLoaction(),
                        const SizedBox(
                          width: 35,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(bottom: 0, child: BottomInfo()),
          ],
        ),
      ),
      drawer: CustomDrawer(),
    );
  }

  Widget _ourLoaction() {
    return Container(
      alignment: Alignment.center,
      width: 180,
      height: 40,
      child: const Text(
        "Our Location",
        style: TextStyle(
          fontFamily: 'Tondo',
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade400,
                offset: const Offset(0, 2),
                blurRadius: 3,
                spreadRadius: 1)
          ]),
    );
  }

  Widget _googleMapScreen(BuildContext context) {
    return SizedBox(
      height: 560,
      width: phoneWeight(context),
      child: GoogleMap(
        compassEnabled: true,
        mapToolbarEnabled: true,
        zoomGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
          target: myLocation,
          zoom: 13,
        ),
        markers: marker,
        mapType: MapType.normal,
        onMapCreated: (controller) {
          setState(() {
            googleMapController = controller;
          });
        },
      ),
    );
  }
}

class BottomInfo extends StatelessWidget {
  const BottomInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 225,
      width: phoneWeight(context),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade500,
                blurRadius: 5,
                spreadRadius: 2,
                offset: const Offset(0, -2))
          ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Choose Bicycle',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: Theme.of(context).primaryColor,
                      color: Colors.transparent,
                      shadows: [
                        Shadow(
                            color: Theme.of(context).primaryColor,
                            offset: const Offset(0, -6))
                      ]),
                ),
                InkWell(
                  onTap: () {},
                  child: Wrap(
                    children: [
                      Text(
                        'More',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.green,
                            color: Colors.transparent,
                            shadows: [
                              const Shadow(
                                  color: Colors.green, offset: Offset(0, -6))
                            ]),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: Colors.green,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
              itemBuilder: (context, index) {
                return AppTheme.cycleContainer(
                  context,
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.cycleDescription),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
