import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_demo/venue_details.dart';
import 'package:maps_demo/location.dart';

class Venues extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: const Text("Sydney")),
      body: GoogleMaps(),
    );
  }
}

class GoogleMaps extends StatefulWidget {
  GoogleMaps({Key key}) : super(key: key);

  @override
  _GoogleMaps createState() => new _GoogleMaps();
}

class _GoogleMaps extends State<GoogleMaps> {
  CameraPosition _position;
  GoogleMapOptions _options;
  bool _isMoving;
  GoogleMapOverlayController mapOverlayController;
  List<Location> locations = List<Location>();

  @override
  void didUpdateWidget(GoogleMaps oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    mapOverlayController.overlayController.deactivateOverlay();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void initState() {
    locations.add(Location(
        id: 1,
        name: 'Sydney Opera House',
        address1: 'Bennelong Point',
        address2: 'Sydney NSW 2000, Australia',
        lat: '-33.856159',
        long: '151.215256',
        imageUrl:
            'https://www.planetware.com/photos-large/AUS/australia-sydney-opera-house-2.jpg'));
    locations.add(Location(
        id: 2,
        name: 'Sydney Harbour Bridge',
        address1: '',
        address2: 'Sydney NSW, Australia',
        lat: '-33.857013',
        long: '151.207694',
        imageUrl:
            'https://www.planetware.com/photos-large/AUS/australia-sydney-harbour-bridge.jpg'));
    super.initState();
  }

  void _onMapChanged() {
    if (mounted) {
      setState(() {
        _extractMapInfo();
      });
    }
  }

  void _extractMapInfo() {
    _options = mapOverlayController.mapController.options;
    _position = mapOverlayController.mapController.cameraPosition;
    _isMoving = mapOverlayController.mapController.isCameraMoving;
  }

  void buildMap() async {
    if (mapOverlayController != null) return;

    var mq = MediaQuery.of(context);
    // add delay so overlay is positioned correctly
    await new Future<Null>.delayed(new Duration(milliseconds: 20));

    mapOverlayController = GoogleMapOverlayController.fromSize(
      width: mq.size.width,
      height: mq.size.height,
      options: GoogleMapOptions(
        cameraPosition: CameraPosition(
          target: LatLng(
              double.parse(locations[0].lat), double.parse(locations[0].long)),
          zoom: 15.0,
        ),
        trackCameraPosition: true,
      ),
    );
    mapOverlayController.mapController.addListener(_onMapChanged);
    locations.forEach((loc) {
      mapOverlayController.mapController.addMarker(MarkerOptions(
          zIndex: loc.id.toDouble(),
          position: LatLng(double.parse(loc.lat), double.parse(loc.long)),
          infoWindowText:
              InfoWindowText(loc.name, loc.address1 + ', ' + loc.address2)));
    });

    mapOverlayController.mapController.onInfoWindowTapped.add((Marker marker) {
      mapOverlayController.overlayController.deactivateOverlay();
      var index = marker.options.zIndex.toInt() - 1;
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) =>
              VenueDetails(locations[index], _notifyPop)));
    });

    mapOverlayController.overlayController.activateOverlay();
    setState(() {});
  }

  Widget renderMap() {
    if (mapOverlayController == null) {
      return Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            SizedBox(
              height: 150.0,
              width: 150.0,
              child: new CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                value: null,
                strokeWidth: 7.0,
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(top: 25.0),
              child: new Center(
                child: new Text(
                  "Loading.. please wait...",
                ),
              ),
            ),
          ]));
    } else {
      return GoogleMapOverlay(controller: mapOverlayController);
    }
  }

  @override
  Widget build(BuildContext context) {
    buildMap();
    return renderMap();
  }

  void _notifyPop(bool success) {
    mapOverlayController.overlayController.activateOverlay();
  }
}
