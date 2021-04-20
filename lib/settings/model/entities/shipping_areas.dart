class ShippingAreas {
  String name;
  int price;

  ShippingAreas(this.name, this.price);

  ShippingAreas.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        price = json['price'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
      };
}
