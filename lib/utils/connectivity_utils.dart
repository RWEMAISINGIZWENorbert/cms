// ignore_for_file: avoid_print
import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> hasInternetConnection() async {
  final Connectivity connectivity = Connectivity();
  try {
    List<ConnectivityResult> connectivityResult = await connectivity.checkConnectivity();
    
    if (
        connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet) ||
        connectivityResult.contains(ConnectivityResult.vpn)) {
      // If Bluetooth is present, ensure another primary connection also exists for general internet.
      if (connectivityResult.contains(ConnectivityResult.bluetooth) &&
          !(connectivityResult.contains(ConnectivityResult.mobile) ||
            connectivityResult.contains(ConnectivityResult.wifi) ||
            connectivityResult.contains(ConnectivityResult.ethernet) ||
            connectivityResult.contains(ConnectivityResult.vpn))) {
        print("Connectivity Util: Only Bluetooth found, assuming no general internet.");
        return false; 
      }
      print("Connectivity Util: Internet connection available via ${connectivityResult.join(', ')}.");
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      print("Connectivity Util: No connection (ConnectivityResult.none).");
      return false;
    }
    // If the list is empty or contains other types without a primary internet source
    print("Connectivity Util: No primary internet connection found among results: ${connectivityResult.join(', ')}.");
    return false;
  } catch (e) {
    print("Connectivity Util: Error checking connectivity: $e");
    return false; // In case of an error, assume no connection
  }
} 