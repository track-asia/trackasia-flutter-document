import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackasia/app_bloc.dart';
import 'package:trackasia/app_event.dart';
import 'package:trackasia/core/api_service.dart';
import 'package:trackasia/model/feature_model/feature_model.dart';
import 'package:trackasia/utils/map_option_utils.dart';
import 'package:trackasia/utils/map_utils.dart';
import 'package:trackasia_gl/trackasia_gl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressMapWidget extends StatefulWidget {
  const AddressMapWidget({this.isShowLocation, this.title, this.callBackClear, this.callBackSelectAddress, super.key});

  final bool? isShowLocation;
  final String? title;
  final Function(LatLng point, String title)? callBackSelectAddress;
  final Function()? callBackClear;

  @override
  State<AddressMapWidget> createState() => _AddressMapWidgetState();
}

class _AddressMapWidgetState extends State<AddressMapWidget> {
  bool isShowAddress = false;
  final TextEditingController? addressControl = TextEditingController();
  final FocusNode addressFocus = FocusNode();
  final ApiService _apiService = ApiService();
  String countryId = "vn";
  List<FeatureModel> addressSuggestions = [];
  bool? isClearFocus = false;
  bool? isShowClear = false;

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    countryId = prefs.getString('country') ?? 'vn';
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isShowAddress = false;
        });
        clearFocus();
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Column(
            children: [
              Stack(
                children: [
                  TextFormField(
                    showCursor: true,
                    controller: addressControl,
                    focusNode: addressFocus,
                    maxLines: 1,
                    minLines: 1,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: -4),
                      hintText: widget.title ?? "Nhập địa chỉ",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      labelStyle: const TextStyle(color: Colors.black87),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      fetchData(value);
                    },
                  ),
                  Positioned(
                    right: 10,
                    top: 12,
                    child: Row(
                      children: [
                        Visibility(
                          visible: isShowClear ?? false,
                          child: GestureDetector(
                            onTap: () {
                              addressControl?.text = "";
                              setState(() {
                                addressSuggestions.clear();
                                isShowAddress = false;
                                isShowClear = false;
                                if (widget.callBackClear != null) {
                                  widget.callBackClear!();
                                }
                              });
                            },
                            child: Container(
                                height: 24,
                                width: 24,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(color: Colors.black54.withOpacity(0.2), borderRadius: BorderRadius.circular(64)),
                                child: const Icon(
                                  Icons.clear,
                                  size: 16,
                                )),
                          ),
                        ),
                        Visibility(
                          visible: widget.isShowLocation ?? false,
                          child: GestureDetector(
                              onTap: () {
                                MapOptionHelper.getLocation().then((value) {
                                  if (value != null) {
                                    context.read<AppBloc>().add(PointUpdatedEvent(LatLng(value.latitude, value.longitude), MapHelper.zoom(countryId)));
                                  }
                                });
                              },
                              child: const SizedBox(height: 24, width: 24, child: Icon(Icons.location_on, size: 24))),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Visibility(
                visible: isShowAddress,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: addressSuggestions.length,
                    itemBuilder: (context, index) {
                      final item = addressSuggestions[index];
                      final title = item.properties?.label ?? "";
                      return Container(
                        color: Colors.white,
                        child: ListTile(
                          title: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isShowAddress = false;
                                });
                                addressControl?.text = title;
                                final latLng = LatLng(item.geometry!.coordinates!.last, item.geometry!.coordinates!.first);
                                if (widget.callBackSelectAddress != null) {
                                  widget.callBackSelectAddress!(latLng, title);
                                } else {
                                  context.read<AppBloc>().add(PointUpdatedEvent(latLng, MapHelper.zoom(countryId)));
                                }
                              },
                              child: Text(title)),
                        ),
                      );
                    },
                    shrinkWrap: true,
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Future<void> fetchData(String value) async {
    try {
      final response = await _apiService.autocomplete(value);
      setState(() {
        addressSuggestions = response;
        isShowAddress = true;
        isShowClear = true;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void clearFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (isClearFocus == false) {
      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    } else {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }
}
