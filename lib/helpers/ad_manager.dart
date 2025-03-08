import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  RewardedInterstitialAd? _rewardedInterstitialAd;

  /* Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5354046379'
      : 'ca-app-pub-3940256099942544/6978759866';*/

  /// RewardedInterstitialAd
  void loadRewardedInterstitialAd() {
    const adUnitIdForRewardedInterstitialAd =
        "ca-app-pub-2846618561973841/3721184123";

    RewardedInterstitialAd.load(
        adUnitId: adUnitIdForRewardedInterstitialAd,
        request: const AdRequest(),
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});
            _rewardedInterstitialAd = ad;
            showRewardedInterstitialAd();
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            // print(
            //     'XXX>>>>>>.RewardedInterstitialAd failed to load: ${error.message}');
            // print(
            //     'XXX>>>>>>.RewardedInterstitialAd failed to load: ${error.code}');
            // print(
            //     'XXX>>>>>>.RewardedInterstitialAd failed to load: ${error.domain}');
          },
        ));
  }

  void showRewardedInterstitialAd() {
    if (_rewardedInterstitialAd != null) {
      _rewardedInterstitialAd!.fullScreenContentCallback =
          FullScreenContentCallback(
              onAdShowedFullScreenContent: (RewardedInterstitialAd ad) {
        // print("ZXC>>>>>>>>>>>>>. Ad onAdShowedFullScreenContent");
      }, onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
        ad.dispose();
        loadRewardedAd();
      }, onAdFailedToShowFullScreenContent:
                  (RewardedInterstitialAd ad, AdError error) {
        ad.dispose();
        loadRewardedAd();
      });

      _rewardedInterstitialAd!.setImmersiveMode(true);
      _rewardedInterstitialAd!.show(
          onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        debugPrint("${reward.amount} ${reward.type}");
      });
    }
  }

  /// InterstitialAd
  void loadInterstitialAd() {
    const interstitialAdId = "ca-app-pub-2846618561973841/4208269284";

    InterstitialAd.load(
        adUnitId: interstitialAdId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;

            // ad.fullScreenContentCallback = FullScreenContentCallback(
            //   onAdDismissedFullScreenContent: (InterstitialAd ad) {
            //     ad.dispose();
            //     // loadInterstitialAd();
            //   },
            //   onAdFailedToShowFullScreenContent:
            //       (InterstitialAd ad, AdError error) {
            //     // print('InterstitialAd failed to loadbbbbbbbbbbbbbbbb: $error');
            //     // print('InterstitialAd failed to loadbbbbbbbbb2bbbbbbb: ${error.code}');
            //     // print('InterstitialAd failed to loadbbbbbbbbbb3bbbbbb: ${error.message}');
            //
            //     ad.dispose();
            //     loadInterstitialAd();
            //   },
            // );
            _interstitialAd!.show();

            // showInterstitialAd();
          },
          onAdFailedToLoad: (LoadAdError error) {
            // print('InterstitialAd failed to load: $error');
            // print('InterstitialAd failed to load cccccccccccccc: $error');
          },
        ));
  }

  // void loadBannerAd() {
  //   _bannerAd = BannerAd(
  //     adUnitId: Platform.isIOS
  //         ? "ca-app-pub-3940256099942544/2934735716"
  //         : "ca-app-pub-3940256099942544/6300978111",
  //     size: AdSize.banner,
  //     request: const AdRequest(),
  //     listener: const BannerAdListener(),
  //   );
  //
  //   _bannerAd?.load();
  // }

  // ca-app-pub-2846618561973841/3721184123

  void loadRewardedAd() {
    RewardedAd.load(
        adUnitId: Platform.isIOS
            ? "ca-app-pub-3940256099942544/1712485313"
            : "ca-app-pub-3940256099942544/5224354917",
        request: const AdRequest(),
        rewardedAdLoadCallback:
            RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
        }, onAdFailedToLoad: (LoadAdError error) {
          _rewardedAd = null;
        }));
  }

  void addAds(
    bool interstitial,
    /*bool bannerAd,bool rewardedAd*/
  ) {
    if (interstitial) {
      loadInterstitialAd();
    }

    // if (bannerAd) {
    //   loadBannerAd();
    // }

    // if (rewardedAd) {
    //   loadRewardedAd();
    // }
  }

  void showInterstitial() {
    _interstitialAd?.show();
  }

  BannerAd? getBannerAd() {
    return _bannerAd;
  }

  void showRewardedAd() {
    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (RewardedAd ad) {
        debugPrint("Ad onAdShowedFullScreenContent");
      }, onAdDismissedFullScreenContent: (RewardedAd ad) {
        ad.dispose();
        loadRewardedAd();
      }, onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        ad.dispose();
        loadRewardedAd();
      });

      _rewardedAd!.setImmersiveMode(true);
      _rewardedAd!.show(
          onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        debugPrint("${reward.amount} ${reward.type}");
      });
    }
  }

  void disposeAds() {
    // _bannerAd?.dispose();
    _interstitialAd?.dispose();
    _rewardedInterstitialAd?.dispose();
    // _rewardedAd?.dispose();
  }
}
