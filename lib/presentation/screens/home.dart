import 'package:cyclego/constants/utils/authentication_popUp.dart';
import 'package:cyclego/constants/utils/empty_data_message.dart';
import 'package:cyclego/constants/utils/loading.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/logic/cycle/cycle_bloc.dart';
import 'package:cyclego/logic/profile/profile_bloc.dart';
import 'package:cyclego/presentation/drawer/custom_drawer.dart';
import 'package:cyclego/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        width: phoneWidth(context),
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
      drawer: const CustomDrawer(),
    );
  }

  Widget _ourLoaction() {
    return Container(
      alignment: Alignment.center,
      width: 180,
      height: 40,
      child: Text(
        "Our Location".tr(),
        style: const TextStyle(
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
      width: phoneWidth(context),
      child: GoogleMap(
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
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

class BottomInfo extends StatefulWidget {
  const BottomInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomInfo> createState() => _BottomInfoState();
}

class _BottomInfoState extends State<BottomInfo> {
  late CycleBloc _cycleBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cycleBloc = CycleBloc()..add(InitialCycleEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: phoneHeight(context) * .29,
      // height: 225,
      width: phoneWidth(context),
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
                  'Choose Bicycle'.tr(),
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
                  onTap: () {
                    if (BlocProvider.of<ProfileBloc>(context).state
                        is ProfileFecthed) {
                      Navigator.pushNamed(context, Routes.moreCycles);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => const AuthenticationDialog(
                            message: "Please Login to access this feature."),
                      );
                    }
                  },
                  child: Wrap(
                    children: [
                      Text(
                        'Explore More'.tr(),
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
            child: BlocBuilder<CycleBloc, CycleState>(
              bloc: _cycleBloc,
              builder: (context, state) {
                if (state is CycleLoading) {
                  return Center(
                    child: LoadingBar(),
                  );
                }
                if (state is CycleFetched) {
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                    itemBuilder: (context, index) {
                      return AppTheme.cycleContainer(
                        context,
                        cycle: state.allCycles[index],
                        onTap: () => Navigator.pushNamed(
                            context, Routes.cycleDescription,
                            arguments: {'cycleId': state.allCycles[index].id}),
                      );
                    },
                  );
                }
                return Center(
                  child: EmptyDataMessage.emptyDataMessage(
                      height: 100, message: 'No Cycle for now'),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
