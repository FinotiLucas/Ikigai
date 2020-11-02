import 'package:firebase_admob/firebase_admob.dart';

BannerAd myBanner;
String adUnitId = 'ca-app-pub-5758582456737164/5098810094';

BannerAd buildBannerAd() {
  return BannerAd(
    adUnitId: adUnitId,
    size: AdSize.banner,
    listener: (MobileAdEvent event) {
      if (event == MobileAdEvent.loaded) {
        myBanner..show();
      }
    },
  );
}

BannerAd buildLargeBannerAd() {
  return BannerAd(
    adUnitId: adUnitId,
    size: AdSize.largeBanner,
    listener: (MobileAdEvent event) {
      if (event == MobileAdEvent.loaded) {
        myBanner
          ..show(
            anchorType: AnchorType.top,
            anchorOffset: 60.0,
          );
      }
    },
  );
}
