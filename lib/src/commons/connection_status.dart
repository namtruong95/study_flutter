import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:connectivity/connectivity.dart';

class ConnectionStatus extends StatefulWidget {
  @override
  ConnectionStatusState createState() {
    return new ConnectionStatusState();
  }
}

class ConnectionStatusState extends State<ConnectionStatus> {
  bool isConnected = false;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    _initConnectivity();
    _onChangeConnection();
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  void _onChangeConnection() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        isConnected = result == ConnectivityResult.wifi ||
            result == ConnectivityResult.mobile;
      });
    });
  }

  Future<void> _initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      isConnected = false;
      throw new Exception(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    setState(() {
      isConnected = result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isConnected
        ? Container(
            width: 0,
            height: 0,
          )
        : Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Text(
              'No Internet Connection',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
  }
}
