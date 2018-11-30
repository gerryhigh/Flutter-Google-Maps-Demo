import 'package:flutter/material.dart';
import 'package:android_intent/android_intent.dart';
import 'package:maps_demo/location.dart';

class VenueDetails extends StatefulWidget {
  final Location location;

  VenueDetails(this.location);

  @override
  _VenueDetailState createState() => _VenueDetailState();
}

class _VenueDetailState extends State<VenueDetails> {
  void _launchNavigationInGoogleMaps() {
    if (Theme.of(context).platform == TargetPlatform.android) {
      final AndroidIntent intent = new AndroidIntent(
          action: 'action_view',
          data:
              "http://maps.google.com/maps?daddr=${widget.location.lat},${widget.location.long}",
          package: 'com.google.android.apps.maps');
      intent.launch();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(widget.location.name),
      ),
      body: new Container(
        padding: new EdgeInsets.all(8.0),
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Text(widget.location.name,
                    style: new TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                // new Divider(),
                // new Text(widget.location.address1, style: new TextStyle(fontSize: 16.0)),
                // new Divider(),
                // new Text(widget.location.city + ', ' + widget.location.state, style: new TextStyle(fontSize: 16.0)),
                // new Divider(),
                // new Text('LAT:'+ widget.location.lat + ' LON:' + widget.location.long, style: new TextStyle(fontSize: 16.0)),
              ],
            ),
            new Row(
              children: <Widget>[
                new Divider(
                  height: 10.0,
                ),
              ],
            ),
            new Row(
              children: <Widget>[
                new Text(widget.location.address1,
                    style: new TextStyle(fontSize: 16.0)),
              ],
            ),
            new Row(
              children: <Widget>[
                new Divider(
                  height: 10.0,
                ),
              ],
            ),
            new Row(
              children: <Widget>[
                new Text(widget.location.address2,
                    style: new TextStyle(fontSize: 16.0)),
              ],
            ),
            new Row(
              children: <Widget>[
                new Divider(
                  height: 10.0,
                ),
              ],
            ),
            new Row(
              children: <Widget>[
                new Text(
                    'LAT:' +
                        widget.location.lat +
                        //widget.location.lat +
                        ' LON:' +
                        widget.location.long,
                    //widget.location.long,
                    style: new TextStyle(fontSize: 16.0)),
              ],
            ),
            new Row(
              children: <Widget>[
                new Divider(
                  height: 10.0,
                ),
              ],
            ),
            new Row(
              children: <Widget>[
                Material(
                  borderRadius: BorderRadius.circular(30.0),
                  shadowColor: Colors.lightBlueAccent.shade100,
                  elevation: 5.0,
                  child: MaterialButton(
                    minWidth: 200.0,
                    height: 42.0,
                    onPressed: _launchNavigationInGoogleMaps,
                    //Navigator.of(context).pushNamed(HomePage.tag);
                    color: Colors.lightBlueAccent,
                    child: Text('Directions',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
