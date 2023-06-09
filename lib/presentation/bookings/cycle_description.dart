import 'package:carousel_slider/carousel_slider.dart';
import 'package:cyclego/constants/utils/authentication_popUp.dart';
import 'package:cyclego/constants/utils/backButton.dart';
import 'package:cyclego/constants/utils/buttons.dart';
import 'package:cyclego/constants/utils/loading.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/data/models/cycle.dart';
import 'package:cyclego/get_it/get_it.dart';
import 'package:cyclego/logic/cycle/cycle_bloc.dart';
import 'package:cyclego/logic/profile/profile_bloc.dart';
import 'package:cyclego/presentation/screens/start_up_screen.dart';
import 'package:cyclego/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CycleDescriptionScreen extends StatefulWidget {
  final String cycleId;
  const CycleDescriptionScreen({Key? key, required this.cycleId})
      : super(key: key);

  @override
  State<CycleDescriptionScreen> createState() => _CycleDescriptionScreenState();
}

class _CycleDescriptionScreenState extends State<CycleDescriptionScreen> {
  int _current = 0;
  final List<String> _images = [];
  late CycleBloc _cycleBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _cycleBloc = getIt.get<CycleBloc>()
      ..add(FetchCycleDetailEvent(cycleId: widget.cycleId));
    _images.addAll([
      "assets/images/cycle.png",
      "assets/images/cycle-icon.png",
      "assets/images/cycle-icon.png",
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CycleBloc, CycleState>(
          bloc: _cycleBloc,
          listener: (context, state) {
            if (state is CycleLoading) {
              PageLoading.showProgress(context);
            }
            if (state is CycleDetailFetched) {
              Navigator.pop(context);
            }
          },
        )
      ],
      child: BlocBuilder<CycleBloc, CycleState>(
        bloc: _cycleBloc,
        builder: (context, state) {
          if (state is CycleDetailFetched) {
            CycleDetail cycleDetail = state.cycleDetail;
            return Scaffold(
                appBar: AppBar(
                  leading: const AppBackButton(),
                  actions: [
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        if (state is ProfileFecthed) {
                          return FavButton(
                              cycleId: cycleDetail.id!, onTap: () {});
                        }
                        return const SizedBox();
                      },
                    )
                  ],
                ),
                body: Column(
                  children: [
                    Container(
                      height: phoneHeight(context) * .45,
                      width: phoneWidth(context),
                      decoration: _boxDecoration(context),
                      child: Column(
                        children: [
                          Expanded(
                            child: CarouselSlider(
                                items: cycleDetail.image!
                                    .map(
                                      (image) => Container(
                                        margin: const EdgeInsets.all(10),
                                        width: phoneWidth(context),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(image))),
                                      ),
                                    )
                                    .toList(),
                                options: CarouselOptions(
                                  aspectRatio: 11 / 9,
                                  onPageChanged: (index, reason) {
                                    setState(() => _current = index);
                                  },
                                )),
                          ),
                          SizedBox(
                            height: 25,
                            child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 3,
                                  itemBuilder: (context, index) {
                                    return Center(
                                      child: Container(
                                        width: 5.0,
                                        height: 5.0,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 4.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: index == _current
                                              ? Theme.of(context).primaryColor
                                              : Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color
                                                  ?.withOpacity(.2),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: SizedBox(
                      // color: Colors.grey.shade600,
                      width: phoneWidth(context),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cycleDetail.name!,
                              style: const TextStyle(
                                  wordSpacing: 2,
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                  color: Colors.green),
                            ),
                            verticalGap5,
                            const Divider(
                              thickness: 1,
                            ),
                            verticalGap5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  direction: Axis.vertical,
                                  children: [
                                    const Text(
                                      "Primary Color",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(cycleDetail.color!),
                                  ],
                                ),
                                Wrap(
                                  direction: Axis.vertical,
                                  children: [
                                    Text(
                                      "${cycleDetail.speed} km/h",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text("Speed"),
                                  ],
                                ),
                                // Wrap(
                                //   direction: Axis.vertical,
                                //   children: [
                                //     Text(
                                //       cycleDetail.rating.toString(),
                                //       style: const TextStyle(
                                //           fontWeight: FontWeight.bold),
                                //     ),
                                //     const Text("Rating"),
                                //   ],
                                // ),
                                horizontalGap5
                              ],
                            ),
                            verticalGap5,
                            const Divider(
                              thickness: 1,
                            ),
                            verticalGap5,
                            Text(cycleDetail.description!),
                            const Expanded(child: SizedBox()),
                            BlocBuilder<ProfileBloc, ProfileState>(
                              builder: (context, state) {
                                return FullButton(
                                  onTap: state is ProfileFecthed
                                      ? !cycleDetail.bookedStatus!
                                          ? () => Navigator.pushNamed(context,
                                                  Routes.cycleBookingScreen,
                                                  arguments: {
                                                    'cycleDetail': cycleDetail
                                                  })
                                          : null
                                      : () => showDialog(
                                            context: context,
                                            builder: (context) =>
                                                AuthenticationDialog(
                                              message:
                                                  "Please login to access this feature."
                                                      .tr(),
                                            ),
                                          ),
                                  padding: const EdgeInsets.all(10),
                                  text: "SET TIME".toString().tr(),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    )),
                  ],
                ));
          }
          return const Scaffold();
        },
      ),
    );
  }

  BoxDecoration _boxDecoration(BuildContext context) {
    return BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
              blurRadius: 3,
              offset: const Offset(0, 6),
              color: Theme.of(context).highlightColor)
        ],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ));
  }
}
