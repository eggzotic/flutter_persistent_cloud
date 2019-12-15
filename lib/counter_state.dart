import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'my_device.dart';

// this class contains all the state used in the sample app
class CounterState with ChangeNotifier {
  //
  // default Constructor - ensures we load the latest saved-value from the DB
  CounterState() {
    _myDevice = MyDevice()
      ..addListener(() {
        notifyListeners();
      });
    // start listening for DB data
    _listenForUpdates();
  }
  //
  // the location of the document containing our state data
  final _sharedCounterDoc = Firestore.instance.collection('counterApp').document('shared');
  //
  // convenience, to avoid using these string-literals more than once
  static const _dbCounterValueField = 'counterValue';
  static const _dbDeviceNameField = 'deviceName';
  //
  // persistent state - i.e. what we will store and load across app runs
  int _value;
  String _lastUpdatedByDevice;
  MyDevice _myDevice;
  //
  // read-only access to the state
  // - ensuring state is modified only via whatever methods
  //   we expose (in this case "increment" and "reset" only)
  int get value => _value;
  String get lastUpdatedByDevice => _lastUpdatedByDevice;
  String get myDevice => _myDevice.name;
  //
  // transient state - i.e. will not be stored when the app is not running
  //  internal-only readiness- & error-status
  bool _isWaiting = true;
  bool _hasError = false;
  //
  // read-only status indicators
  bool get isWaiting => _isWaiting || _myDevice.isWaiting;
  bool get hasError => _hasError;
  //
  // how we modify the state
  void increment() => _setValue(_value + 1);
  void reset() => _setValue(0);

  void _setValue(int newValue) {
    _value = newValue;
    _save();
  }

  //
  //  save the updated _value to the DB
  void _save() async {
    _hasError = false;
    _isWaiting = true;
    notifyListeners();
    try {
      await _sharedCounterDoc.setData({
        _dbCounterValueField: _value,
        _dbDeviceNameField: myDevice,
      });
      _hasError = false;
    } catch (error) {
      _hasError = true;
    }
    _isWaiting = false;
    notifyListeners();
  }

  //
  // how we receive data from the DB, and notify
  void _listenForUpdates() {
    // listen to the stream of updates (e.g. due to other devices)
    _sharedCounterDoc.snapshots().listen(
      (snapshot) {
        _isWaiting = false;
        if (!snapshot.exists) {
          _hasError = true;
          notifyListeners();
          return;
        }
        _hasError = false;
        // Don't trust what we receive
        // - convert to string, then try to extract a number
        final counterText = (snapshot.data[_dbCounterValueField] ?? 0).toString();
        // last resort is use 0
        _value = int.tryParse(counterText) ?? 0;
        _lastUpdatedByDevice = (snapshot.data[_dbDeviceNameField] ?? 'No device').toString();
        notifyListeners();
      },
      onError: (error) {
        _hasError = true;
        notifyListeners();
      },
    );
  }
}
