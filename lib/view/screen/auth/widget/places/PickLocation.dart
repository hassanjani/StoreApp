import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:user_app/provider/auth_provider.dart';
import 'package:user_app/utill/color_resources.dart';
import 'package:user_app/view/screen/auth/widget/places/AddressSearch.dart';

import 'Suggestion.dart';

class PickLocation extends StatefulWidget {
  const PickLocation({Key key}) : super(key: key);

  @override
  State<PickLocation> createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  // late GoogleMapController _controller;
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition initialLocation = CameraPosition(
    bearing: 0,
    target: LatLng(34.76794253432019, 72.35988692832102),
    zoom: 16.4746,
  );
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};

  final markers = Set<Marker>();
  MarkerId markerId = MarkerId("m1");
  LatLng currentposition;

  @override
  void initState() {
    // TODO: implement initState
    markers.add(Marker(
      draggable: true,
      markerId: markerId,
      position: initialLocation.target,
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: const InfoWindow(
        title: 'Pick',
      ),
    ));

    Marker marker = Marker(
      markerId: markerId,
      position: initialLocation.target,
      draggable: false,
    );
    setState(() {
      _markers[markerId] = marker;
    });

    super.initState();
  }

  TextEditingController Textcontroller = TextEditingController();

  @override
  void dispose() {
    Textcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition:
                context.watch<AuthProvider>().initialLocation,
            // markers: Set<Marker>.of(_markers.values),
            onCameraMove: (position) {
              currentposition =
                  LatLng(position.target.latitude, position.target.longitude);
              //
              // Marker? marker = _markers[markerId];
              // Marker updatedMarker = marker!.copyWith(
              //   positionParam: position.target,
              // );

              // setState(() {
              //   _markers[markerId] = updatedMarker;
              // });

              // setState(() {
              //   markers
              //       .add(Marker(markerId: markerId, position: position.target));
              // });
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              // _controller = controller;
            },
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/marker.png',
              height: 50,
              width: 50,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                return Transform.translate(
                  offset: const Offset(0, -25),
                  child: child,
                );
              },
            ),
          ),
          Positioned(
            top: 40,
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1),
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    border: Border.all(
                        color: ColorResources.PRIMARY_MATERIAL,
                        width: 1,
                        style: BorderStyle.solid)),
                child: TextField(
                  controller: Textcontroller,
                  onTap: () async {
                    // should show search screen here
                    showSearch(
                      context: context,
                      // we haven't created AddressSearch class
                      // this should be extending SearchDelegate
                      delegate: AddressSearch(),
                    );
                  },
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.black,
                      size: 30,
                    ),
                    hintText: context.watch<AuthProvider>().SelectedArea == ""
                        ? 'Search Location'
                        : '${context.watch<AuthProvider>().SelectedArea}',
                    // "Search Location",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      left: 8.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            // height: 50,
            // width: MediaQuery.of(context).size.width / 2,
            bottom: 20,
            child: InkWell(
              onTap: () async {
                String address = await PlaceApiProvider().getAddressFromLatLng(
                    context,
                    currentposition.latitude,
                    currentposition.longitude);
                Provider.of<AuthProvider>(context, listen: false)
                    .onchangeAddres(address);
                Provider.of<AuthProvider>(context, listen: false)
                    .onchangeArea(address);
                Navigator.pop(context);
              },
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.2),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  decoration: BoxDecoration(
                      color: ColorResources.PRIMARY_MATERIAL,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Text(
                    "Pick This Location",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  // void _updatePosition(CameraPosition _position) {
  //
  //
  //   markers.remove(markers[0]);
  //   markers.add(
  //     Marker(
  //       markerId: MarkerId('1'),
  //       position: LatLng(_position.target.latitude, _position.target.longitude),
  //       draggable: true,
  //     ),
  //   );
  //   setState(() {
  //     markers;
  //   });
  //
  // }

  @override
  Future<void> didChangeDependencies() async {
    print("didchange called");
    final GoogleMapController controller = await _controller.future;

    controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: Provider.of<AuthProvider>(context, listen: false)
            .currentsearchArea_latLng,
        zoom: 16.4746,
        bearing: 0)));

    // _updatePosition(
    //   CameraPosition(
    //       target: Provider.of<LocationProvider>(context, listen: false)
    //           .currentsearchArea_latLng),
    // );

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
