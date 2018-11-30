import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_demo/venue_details.dart';
import 'package:maps_demo/location.dart';

class Venues extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: const Text("Sydney")),
      body: new GoogleMaps(),
    );
  }
}

class GoogleMaps extends StatefulWidget {
  GoogleMaps({Key key}) : super(key: key);

  @override
  _GoogleMaps createState() => new _GoogleMaps();
}

class _GoogleMaps extends State<GoogleMaps> {
  GoogleMapController mapController;
  List<Location> locations = List<Location>();

  @override
  void initState() {
    var location = Location(
        id: 1,
        name: 'Sydney Opera House',
        address1: 'Bennelong Point',
        address2: 'Sydney NSW 2000, Australia',
        lat: '-33.856159',
        long: '151.215256',
        imageUrl:
            'https://www.planetware.com/photos-large/AUS/australia-sydney-opera-house-2.jpg');
    locations.add(location);
    location = Location(
        id: 2,
        name: 'Sydney Harbour Bridge',
        address1: '',
        address2: 'Sydney NSW, Australia',
        lat: '-33.857013',
        long: '151.207694',
        imageUrl:
            'https://www.planetware.com/photos-large/AUS/australia-sydney-harbour-bridge.jpg');
    locations.add(location);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //buildMap();
    var mq = MediaQuery.of(context);
    return Center(
      child: SizedBox(
        width: mq.size.width,
        height: mq.size.height,
        child: GoogleMap(
          onMapCreated: _onMapCreated,
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      locations.forEach((loc) {
        mapController.addMarker(MarkerOptions(
            zIndex: loc.id.toDouble(),
            position: LatLng(double.parse(loc.lat), double.parse(loc.long)),
            infoWindowText:
                InfoWindowText(loc.name, loc.address1 + ', ' + loc.address2)));
      });

      mapController.onInfoWindowTapped.add((Marker marker) {
        var index = marker.options.zIndex.toInt() - 1;
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => VenueDetails(locations[index])));
      });
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 270.0,
          target: LatLng(
              double.parse(locations[0].lat), double.parse(locations[0].long)),
          tilt: 30.0,
          zoom: 17.0,
        ),
      ));
    });
  }
}
