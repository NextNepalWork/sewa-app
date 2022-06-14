import 'package:flutter/material.dart';
import 'package:sewa_digital/constant/assets_manager.dart';

class DrawerModel {
  String title;
  IconData icon;
  DrawerModel(this.title, this.icon);
}

class DrawerModel1 {
  String title;
  Widget icon;
  DrawerModel1(this.title, this.icon);
}

class SocialMedia {
  String icon;
  SocialMedia(this.icon);
}

class FilterModel {
  String value;
  String key;
  FilterModel(this.value, this.key);
}

final drawerData = <DrawerModel1>[
  DrawerModel1("home", const Icon(Icons.home)),
  DrawerModel1("category", const Icon(Icons.category)),
  DrawerModel1("wishlist", const Icon(Icons.favorite)),
  DrawerModel1("orders", const Icon(Icons.inventory_rounded)),
  DrawerModel1("trackorder", const Icon(Icons.track_changes)),
  DrawerModel1("sellonsewa", const Icon(Icons.sell)),
  DrawerModel1("referearn", const Icon(Icons.money_rounded)),
  DrawerModel1("notification", const Icon(Icons.notifications)),
  DrawerModel1("setting", const Icon(Icons.settings)),
  DrawerModel1("help", const Icon(Icons.help)),
  DrawerModel1("faq", const Icon(Icons.question_answer)),
];
final profileData = <DrawerModel>[
  DrawerModel("profile", Icons.person),
  DrawerModel("orders", Icons.inventory_rounded),
  DrawerModel("address", Icons.location_on),
  DrawerModel("changepassword", Icons.lock),
  DrawerModel("payment", Icons.payment)
];
final settingData = <DrawerModel>[
  DrawerModel("term", Icons.help),
  DrawerModel("return", Icons.policy),
  DrawerModel("privacy", Icons.privacy_tip),
  DrawerModel("rate", Icons.star_rate_rounded),
  DrawerModel("share", Icons.share),
];
final socialMediaIcon = <SocialMedia>[
  SocialMedia(ImageAssets.facebook),
  SocialMedia(ImageAssets.google),
  SocialMedia(ImageAssets.instagram),
  SocialMedia(ImageAssets.twitter),
  SocialMedia(ImageAssets.youtube),
];
final paymentGateway = <SocialMedia>[
  SocialMedia(ImageAssets.cod),
  SocialMedia(ImageAssets.esewa),
];
final filterData = <FilterModel>[
  FilterModel("price_low_to_high", "Price low to high"),
  FilterModel("price_high_to_low", "Price high to low"),
  FilterModel("new_arrival", "New arrival"),
  FilterModel("popularity", "Popularity"),
  FilterModel("top_rated", "Top rated"),
];
