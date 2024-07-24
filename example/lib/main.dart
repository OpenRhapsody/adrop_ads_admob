import 'dart:async';
import 'dart:io';

import 'package:adrop_ads_admob/adrop_ads_admob.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  runApp(const MyApp());
  Adrop.initialize(false);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final adUnitId =
      Platform.isAndroid ? 'ca-app-pub-3141837772329875/5738237096' : 'ca-app-pub-3141837772329875/5227710010';

  InitializationStatus? status;
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  void loadAd() {
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.largeBanner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          setState(() {
            _isLoaded = false;
          });
          debugPrint('BannerAd failed to load: $err');
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Adrop for Admob mediation')),
        ),
        body: Center(
          child: Column(
            children: [
              TextButton(onPressed: loadAd, child: const Text("Load Ad")),
              const SizedBox(height: 32),
              if (_isLoaded && _bannerAd != null)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                    child: SizedBox(
                      width: _bannerAd!.size.width.toDouble(),
                      height: _bannerAd!.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd!),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
