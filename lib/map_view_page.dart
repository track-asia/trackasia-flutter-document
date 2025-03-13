import 'package:flutter/material.dart';
import 'package:trackasia/components/address_map_widget.dart';
import 'components/trackasia_map_widget.dart';
import 'package:rudder_sdk_flutter/RudderController.dart';

class MapViewPage extends StatefulWidget {
  @override
  State<MapViewPage> createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (value) {
        // setState(() {
        //   isShowAddress = false;
        // });
        // clearFocus();
      },
      child: Stack(
        children: [
          const TrackAsiaMapWidget(),
          Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: const AddressMapWidget()),
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () async {},
              child: const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.my_location_outlined,
                  color: Colors.green,
                  size: 24,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // void clearFocus() {
  //   FocusScopeNode currentFocus = FocusScope.of(context);
  //   if (isClearFocus == false) {
  //     if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
  //       FocusManager.instance.primaryFocus?.unfocus();
  //     }
  //   } else {
  //     FocusScope.of(context).requestFocus(FocusNode());
  //   }
  // }
}
