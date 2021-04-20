import 'dart:convert';

ManagerSettingsResponse managerSettingsResponseFromJson(String str) =>
    ManagerSettingsResponse.fromJson(json.decode(str));

class ManagerSettingsResponse {
  ManagerSettingsResponse({
    this.data,
  });

  Datum data;

  factory ManagerSettingsResponse.fromJson(Map<String, dynamic> json) =>
      ManagerSettingsResponse(
        data: Datum.fromJson(json["data"]),
      );
}

class Datum {
  Datum({
    this.id,
    this.status,
    this.enableStore,
    this.displayInMarketplace,
    this.name,
    this.subdomain,
    this.billName,
    this.billNotes,
    this.latestProducts,
    this.logo,
    this.logoName,
    this.banner,
    this.bannerName,
    this.favicon,
    this.faviconName,
    this.footerLogo,
    this.footerLogoName,
    this.facebookUrl,
    this.twitterUrl,
    this.instagramUrl,
    this.youtubeUrl,
    this.snapchatUrl,
    this.tiktokUrl,
    this.whatsappNumber,
    this.description,
    this.enableTax,
    this.taxValue,
    this.enableShippingPriceList,
    this.shippingPriceList,
    this.notificationEmail,
    this.taxNumber,
    this.surebillsExpiryMinutes,
  });

  int id;
  int status;
  dynamic enableStore;
  String displayInMarketplace;
  String name;
  String subdomain;
  dynamic billName;
  dynamic billNotes;
  List<LatestProduct> latestProducts;
  dynamic logo;
  dynamic logoName;
  dynamic banner;
  String bannerName;
  dynamic favicon;
  dynamic faviconName;
  dynamic footerLogo;
  String footerLogoName;
  dynamic facebookUrl;
  dynamic twitterUrl;
  dynamic instagramUrl;
  dynamic youtubeUrl;
  dynamic snapchatUrl;
  dynamic tiktokUrl;
  dynamic whatsappNumber;
  String description;
  dynamic enableTax;
  String taxValue;
  dynamic enableShippingPriceList;
  List<ShippingPriceList> shippingPriceList;
  dynamic notificationEmail;
  String taxNumber;
  String surebillsExpiryMinutes;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        status: json["status"],
        enableStore: json["enable_store"],
        displayInMarketplace: json["display_in_marketplace"],
        name: json["name"],
        subdomain: json["subdomain"],
        billName: json["bill_name"],
        billNotes: json["bill_notes"],
        latestProducts: List<LatestProduct>.from(
            json["latest_products"].map((x) => LatestProduct.fromJson(x))),
        logo: json["logo"],
        logoName: json["logo_name"],
        banner: json["banner"],
        bannerName: json["banner_name"],
        favicon: json["favicon"],
        faviconName: json["favicon_name"],
        footerLogo: json["footer_logo"],
        footerLogoName: json["footer_logo_name"],
        facebookUrl: json["facebook_url"],
        twitterUrl: json["twitter_url"],
        instagramUrl: json["instagram_url"],
        youtubeUrl: json["youtube_url"],
        snapchatUrl: json["snapchat_url"],
        tiktokUrl: json["tiktok_url"],
        whatsappNumber: json["whatsapp_number"],
        description: json["description"],
        enableTax: json["enable_tax"],
        taxValue: json["tax_value"],
        enableShippingPriceList: json["enable_shipping_price_list"],
        shippingPriceList: List<ShippingPriceList>.from(
            json["shipping_price_list"]
                .map((x) => ShippingPriceList.fromJson(x))),
        notificationEmail: json["notification_email"],
        taxNumber: json["tax_number"],
        surebillsExpiryMinutes: json["surebills_expiry_minutes"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enable_shipping_price_list'] = this.enableShippingPriceList;
    if (this.shippingPriceList != null) {
      data['shipping_price_list'] =
          this.shippingPriceList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LatestProduct {
  LatestProduct({
    this.id,
    this.accountId,
    this.categoryId,
    this.price,
    this.name,
    this.image,
    this.quantity,
    this.description,
    this.slug,
    this.slugKey,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  int accountId;
  dynamic categoryId;
  int price;
  String name;
  dynamic image;
  int quantity;
  String description;
  String slug;
  String slugKey;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory LatestProduct.fromJson(Map<String, dynamic> json) => LatestProduct(
        id: json["id"],
        accountId: json["account_id"],
        categoryId: json["category_id"],
        price: json["price"],
        name: json["name"],
        image: json["image"],
        quantity: json["quantity"],
        description: json["description"],
        slug: json["slug"],
        slugKey: json["slug_key"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );
}

class ShippingPriceList {
  ShippingPriceList({
    this.name,
    this.price,
  });

  String name;
  String price;

  factory ShippingPriceList.fromJson(Map<String, dynamic> json) =>
      ShippingPriceList(
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}
