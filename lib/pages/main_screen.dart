import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/pages/music/music_screen.dart';
import 'package:flutter_application_test/pages/profile/profile_data.dart';
import 'package:flutter_application_test/pages/wallpaper/wallpaper_screen.dart';
import 'package:flutter_application_test/store/store.dart';
import 'package:flutter_svg/svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;
  final PageController _pageController = PageController(initialPage: 0);

  List<Widget> tabViews = [
    const WallpaperScreen(),
    const MusicScreen(),
    const ProfileData()
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    initDeviceIdentifier();
  }

  Future<void> initDeviceIdentifier() async {
    String deviceIdentifier = "";

    try {
      var deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        var androidInfo = await deviceInfo.androidInfo;
        deviceIdentifier = generateDeviceIdentifier(androidInfo);
      } else if (Platform.isIOS) {
        var iosInfo = await deviceInfo.iosInfo;
        deviceIdentifier = iosInfo.identifierForVendor!;
      }
      // ignore: empty_catches
    } catch (e) {}

    if (!mounted) return;

    setState(() {
      DeviceInfo.saveInfo(deviceIdentifier);
    });
  }

  String generateDeviceIdentifier(AndroidDeviceInfo androidInfo) {
    // 拼接设备的各种信息
    final String deviceData = '${androidInfo.brand}'
        '${androidInfo.device}'
        '${androidInfo.hardware}'
        '${androidInfo.id}'
        '${androidInfo.manufacturer}'
        '${androidInfo.model}'
        '${androidInfo.product}';

    // 生成MD5哈希
    final bytes = utf8.encode(deviceData);
    final digest = md5.convert(bytes);

    return digest.toString();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (!_tabController.indexIsChanging) {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: IndexedStack(
        index: _selectedIndex,
        children: tabViews,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        selectedItemColor: const Color.fromRGBO(0, 123, 254, 1),
        unselectedItemColor: const Color.fromRGBO(168, 168, 168, 1),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icon/library.svg"),
            activeIcon: SvgPicture.asset("assets/icon/library_selected.svg"),
            label: '图库',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.music_note_outlined),
            activeIcon: Icon(Icons.music_note),
            label: '音乐',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: '我的',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _tabController.index = index;
            // _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}
