import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackasia/animation_view_page.dart';
import 'package:trackasia/app_bloc.dart';
import 'package:trackasia/app_state.dart';
import 'package:trackasia/cluster_view_page.dart';
import 'package:trackasia/feature_view_page.dart';
import 'package:trackasia/map_view_page.dart';
import 'package:trackasia/utils/map_utils.dart';
import 'package:trackasia/waypoint_view_page.dart';

import 'app_event.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  String _selectedCountry = 'vn';

  final List<Widget> _pages = [
    MapViewPage(),
    WayPointViewPage(),
    ClusterViewPage(),
    AnimationViewPage(),
    FeatureViewPage(),
  ];

  final List<String> _pageTitles = [
    'MapView',
    'WayPointView',
    'ClustertView',
    'AnimationView',
    'FeatureView',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_currentIndex]),
        actions: [
          _buildCountrySelection(),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(color: Colors.green),
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.map,
              color: Colors.green,
            ),
            icon: Icon(
              Icons.map,
              color: Colors.grey,
            ),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.pages,
              color: Colors.green,
            ),
            icon: Icon(Icons.pages, color: Colors.grey),
            label: 'PointView',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.pie_chart_outline_outlined,
              color: Colors.green,
            ),
            icon: Icon(Icons.pie_chart_outline_outlined, color: Colors.grey),
            label: 'ClusterView',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.animation,
              color: Colors.green,
            ),
            icon: Icon(Icons.animation, color: Colors.grey),
            label: 'Animation',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.featured_video,
              color: Colors.green,
            ),
            icon: Icon(Icons.featured_video, color: Colors.grey),
            label: 'Feature',
          ),
        ],
      ),
    );
  }

  Widget _buildCountrySelection() {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        String selectedCountry = (state is CountryUpdatedState) ? state.selectedCountry : 'vn';
        return PopupMenuButton<String>(
          onSelected: (selectedCountry) async {
            context.read<AppBloc>().add(UpdateCountryEvent(selectedCountry));
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('country', selectedCountry);
          },
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(value: 'vn', child: Text('Vietnam')),
              const PopupMenuItem(value: 'sg', child: Text('Singapore')),
              const PopupMenuItem(value: 'th', child: Text('Thailand')),
              const PopupMenuItem(value: 'tw', child: Text('Taiwan')),
              const PopupMenuItem(value: 'my', child: Text('Malaysia')),
            ];
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  'Country: ${MapHelper.getNameCountry(selectedCountry)}',
                  style: const TextStyle(color: Colors.white),
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.white),
              ],
            ),
          ),
        );
      },
    );
  }
}
