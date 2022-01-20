import 'dart:convert';
import 'dart:core';

ProductList productListFromJson(String str) => ProductList.fromJson(json.decode(str) as Map<String, dynamic>);

String productListToJson(ProductList data) => json.encode(data.toJson());

class ProductList {
  int? id;
  String? name;
  String? slug;
  String? postAuthor;
  String? permalink;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  DateTime? dateModified;
  DateTime? dateModifiedGmt;
  String? type;
  String? status;
  bool? featured;
  String? catalogVisibility;
  String? description;
  String? shortDescription;
  String? sku;
  String? price;
  String? regularPrice;
  String? salePrice;
  dynamic dateOnSaleFrom;
  dynamic dateOnSaleFromGmt;
  dynamic dateOnSaleTo;
  dynamic dateOnSaleToGmt;
  String? priceHtml;
  bool? onSale;
  bool? purchasable;
  int? totalSales;
  bool? virtual;
  bool? downloadable;
  List? downloads;
  int? downloadLimit;
  int? downloadExpiry;
  String? externalUrl;
  String? buttonText;
  String? taxStatus;
  String? taxClass;
  bool? manageStock;
  dynamic stockQuantity;
  dynamic lowStockAmount;
  bool? inStock;
  String? backorders;
  bool? backordersAllowed;
  bool? backordered;
  bool? soldIndividually;
  String? weight;
  Dimensions? dimensions;
  bool? shippingRequired;
  bool? shippingTaxable;
  String? shippingClass;
  int? shippingClassId;
  bool? reviewsAllowed;
  String? averageRating;
  int? ratingCount;
  List<int>? relatedIds;
  List<dynamic>? upsellIds;
  List<dynamic>? crossSellIds;
  int? parentId;
  String? purchaseNote;
  List<Category>? categories;
  List<dynamic>? tags;
  List<Image>? images;
  List<dynamic>? attributes;
  List<dynamic>? defaultAttributes;
  List<dynamic>? variations;
  List<dynamic>? groupedProducts;
  int? menuOrder;
  List<MetaDatum>? metaData;
  Store? store;
  Links? links;

  ProductList({
    this.id,
    this.name,
    this.slug,
    this.postAuthor,
    this.permalink,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.type,
    this.status,
    this.featured,
    this.catalogVisibility,
    this.description,
    this.shortDescription,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.dateOnSaleFrom,
    this.dateOnSaleFromGmt,
    this.dateOnSaleTo,
    this.dateOnSaleToGmt,
    this.priceHtml,
    this.onSale,
    this.purchasable,
    this.totalSales,
    this.virtual,
    this.downloadable,
    this.downloads,
    this.downloadLimit,
    this.downloadExpiry,
    this.externalUrl,
    this.buttonText,
    this.taxStatus,
    this.taxClass,
    this.manageStock,
    this.stockQuantity,
    this.lowStockAmount,
    this.inStock,
    this.backorders,
    this.backordersAllowed,
    this.backordered,
    this.soldIndividually,
    this.weight,
    this.dimensions,
    this.shippingRequired,
    this.shippingTaxable,
    this.shippingClass,
    this.shippingClassId,
    this.reviewsAllowed,
    this.averageRating,
    this.ratingCount,
    this.relatedIds,
    this.upsellIds,
    this.crossSellIds,
    this.parentId,
    this.purchaseNote,
    this.categories,
    this.tags,
    this.images,
    this.attributes,
    this.defaultAttributes,
    this.variations,
    this.groupedProducts,
    this.menuOrder,
    this.metaData,
    this.store,
    this.links,
  });

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        id: json['id'] as int,
        name: json['name'] as String,
        slug: json['slug'] as String,
        postAuthor: json['post_author'] as String,
        permalink: json['permalink'] as String,
        dateCreated: DateTime.parse(json['date_created'] as String),
        dateCreatedGmt: DateTime.parse(json['date_created_gmt'] as String),
        dateModified: DateTime.parse(json['date_modified'] as String),
        dateModifiedGmt: DateTime.parse(json['date_modified_gmt'] as String),
        type: json['type'] as String,
        status: json['status'] as String,
        featured: json['featured'] as bool,
        catalogVisibility: json['catalog_visibility'] as String,
        description: json['description'] as String,
        shortDescription: json['short_description'] as String,
        sku: json['sku'] as String,
        price: json['price'] as String,
        regularPrice: json['regular_price'] as String,
        salePrice: json['sale_price'] as String,
        dateOnSaleFrom: json['date_on_sale_from'],
        dateOnSaleFromGmt: json['date_on_sale_from_gmt'],
        dateOnSaleTo: json['date_on_sale_to'],
        dateOnSaleToGmt: json['date_on_sale_to_gmt'],
        priceHtml: json['price_html'] as String,
        onSale: json['on_sale'] as bool,
        purchasable: json['purchasable'] as bool,
        totalSales: json['total_sales'] as int,
        virtual: json['virtual'] as bool,
        downloadable: json['downloadable'] as bool,
        downloads: List<Download>.from(json['downloads'].map((x) => Download.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>),
        downloadLimit: json['download_limit'] as int,
        downloadExpiry: json['download_expiry'] as int,
        externalUrl: json['external_url'] as String,
        buttonText: json['button_text'] as String,
        taxStatus: json['tax_status'] as String,
        taxClass: json['tax_class'] as String,
        manageStock: json['manage_stock'] as bool,
        stockQuantity: json['stock_quantity'] as dynamic,
        lowStockAmount: json['low_stock_amount'],
        inStock: json['in_stock'] as bool,
        backorders: json['backorders'] as String,
        backordersAllowed: json['backorders_allowed'] as bool,
        backordered: json['backordered'] as bool,
        soldIndividually: json['sold_individually'] as bool,
        weight: json['weight'] as String,
        dimensions: Dimensions.fromJson(json['dimensions'] as Map<String, dynamic>),
        shippingRequired: json['shipping_required'] as bool,
        shippingTaxable: json['shipping_taxable'] as bool,
        shippingClass: json['shipping_class'] as String,
        shippingClassId: json['shipping_class_id'] as int,
        reviewsAllowed: json['reviews_allowed'] as bool,
        averageRating: json['average_rating'] as String,
        ratingCount: json['rating_count'] as int,
        relatedIds: List<int>.from(json['related_ids'].map((x) => x) as Iterable<dynamic>),
        upsellIds: List<dynamic>.from(json['upsell_ids'].map((x) => x) as Iterable<dynamic>),
        crossSellIds: List<dynamic>.from(json['cross_sell_ids'].map((x) => x) as Iterable<dynamic>),
        parentId: json['parent_id'] as int,
        purchaseNote: json['purchase_note'] as String,
        categories: List<Category>.from(json['categories'].map((x) => Category.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>),
        tags: List<dynamic>.from(json['tags'].map((x) => x) as Iterable<dynamic>),
        images: List<Image>.from(json['images'].map((x) => Image.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>),
        attributes: List<dynamic>.from(json['attributes'].map((x) => x) as Iterable<dynamic>),
        defaultAttributes: List<dynamic>.from(json['default_attributes'].map((x) => x) as Iterable<dynamic>),
        variations: List<dynamic>.from(json['variations'].map((x) => x) as Iterable<dynamic>),
        groupedProducts: List<dynamic>.from(json['grouped_products'].map((x) => x) as Iterable<dynamic>),
        menuOrder: json['menu_order'] as int,
        metaData: List<MetaDatum>.from(json['meta_data'].map((x) => MetaDatum.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>),
        store: Store.fromJson(json['store'] as Map<String, dynamic>),
        links: Links.fromJson(json['_links'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
        'post_author': postAuthor,
        'permalink': permalink,
        'date_created': dateCreated?.toIso8601String(),
        'date_created_gmt': dateCreatedGmt?.toIso8601String(),
        'date_modified': dateModified?.toIso8601String(),
        'date_modified_gmt': dateModifiedGmt?.toIso8601String(),
        'type': type,
        'status': status,
        'featured': featured,
        'catalog_visibility': catalogVisibility,
        'description': description,
        'short_description': shortDescription,
        'sku': sku,
        'price': price,
        'regular_price': regularPrice,
        'sale_price': salePrice,
        'date_on_sale_from': dateOnSaleFrom,
        'date_on_sale_from_gmt': dateOnSaleFromGmt,
        'date_on_sale_to': dateOnSaleTo,
        'date_on_sale_to_gmt': dateOnSaleToGmt,
        'price_html': priceHtml,
        'on_sale': onSale,
        'purchasable': purchasable,
        'total_sales': totalSales,
        'virtual': virtual,
        'downloadable': downloadable,
        'downloads': List<dynamic>.from(downloads!.map((x) => x.toJson())),
        'download_limit': downloadLimit,
        'download_expiry': downloadExpiry,
        'external_url': externalUrl,
        'button_text': buttonText,
        'tax_status': taxStatus,
        'tax_class': taxClass,
        'manage_stock': manageStock,
        'stock_quantity': stockQuantity,
        'low_stock_amount': lowStockAmount,
        'in_stock': inStock,
        'backorders': backorders,
        'backorders_allowed': backordersAllowed,
        'backordered': backordered,
        'sold_individually': soldIndividually,
        'weight': weight,
        'dimensions': dimensions?.toJson(),
        'shipping_required': shippingRequired,
        'shipping_taxable': shippingTaxable,
        'shipping_class': shippingClass,
        'shipping_class_id': shippingClassId,
        'reviews_allowed': reviewsAllowed,
        'average_rating': averageRating,
        'rating_count': ratingCount,
        'related_ids': List<dynamic>.from(relatedIds!.map((x) => x)),
        'upsell_ids': List<dynamic>.from(upsellIds!.map((x) => x)),
        'cross_sell_ids': List<dynamic>.from(crossSellIds!.map((x) => x)),
        'parent_id': parentId,
        'purchase_note': purchaseNote,
        'categories': List<dynamic>.from(categories!.map((x) => x.toJson())),
        'tags': List<dynamic>.from(tags!.map((x) => x)),
        'images': List<dynamic>.from(images!.map((x) => x.toJson())),
        'attributes': List<dynamic>.from(attributes!.map((x) => x)),
        'default_attributes': List<dynamic>.from(defaultAttributes!.map((x) => x)),
        'variations': List<dynamic>.from(variations!.map((x) => x)),
        'grouped_products': List<dynamic>.from(groupedProducts!.map((x) => x)),
        'menu_order': menuOrder,
        'meta_data': List<dynamic>.from(metaData!.map((x) => x.toJson())),
        'store': store!.toJson(),
        '_links': links!.toJson(),
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.slug,
  });

  int? id;
  String? name;
  String? slug;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'] as int,
        name: json['name'] as String,
        slug: json['slug'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
      };
}

class Dimensions {
  Dimensions({
    this.length,
    this.width,
    this.height,
  });

  String? length;
  String? width;
  String? height;

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        length: json['length'] as String,
        width: json['width'] as String,
        height: json['height'] as String,
      );

  Map<String, dynamic> toJson() => {
        'length': length,
        'width': width,
        'height': height,
      };
}

class Download {
  Download({
    this.id,
    this.name,
    this.file,
  });

  String? id;
  String? name;
  String? file;

  factory Download.fromJson(Map<String, dynamic> json) => Download(
        id: json['id'] as String,
        name: json['name'] as String,
        file: json['file'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'file': file,
      };
}

class Image {
  Image({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.src,
    this.name,
    this.alt,
    this.position,
  });

  int? id;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  DateTime? dateModified;
  DateTime? dateModifiedGmt;
  String? src;
  String? name;
  String? alt;
  int? position;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json['id'] as int,
        dateCreated: DateTime.parse(json['date_created'] as String),
        dateCreatedGmt: DateTime.parse(json['date_created_gmt'] as String),
        dateModified: DateTime.parse(json['date_modified'] as String),
        dateModifiedGmt: DateTime.parse(json['date_modified_gmt'] as String),
        src: json['src'] as String,
        name: json['name'] as String,
        alt: json['alt'] as String,
        position: json['position'] as int,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'date_created': dateCreated?.toIso8601String(),
        'date_created_gmt': dateCreatedGmt?.toIso8601String(),
        'date_modified': dateModified?.toIso8601String(),
        'date_modified_gmt': dateModifiedGmt?.toIso8601String(),
        'src': src,
        'name': name,
        'alt': alt,
        'position': position,
      };
}

class Links {
  Links({
    this.self,
    this.collection,
  });

  List<Collection>? self;
  List<Collection>? collection;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: List<Collection>.from(json['self'].map((x) => Collection.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>),
        collection: List<Collection>.from(json['collection'].map((x) => Collection.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'self': List<dynamic>.from(self!.map((x) => x.toJson())),
        'collection': List<dynamic>.from(collection!.map((x) => x.toJson())),
      };
}

class Collection {
  Collection({
    this.href,
  });

  String? href;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        href: json['href'] as String,
      );

  Map<String, dynamic> toJson() => {
        'href': href,
      };
}

class MetaDatum {
  MetaDatum({
    this.id,
    this.key,
    this.value,
  });

  int? id;
  String? key;
  dynamic value;

  factory MetaDatum.fromJson(Map<String, dynamic> json) => MetaDatum(
        id: json['id'] as int,
        key: json['key'] as String,
        value: json['value'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'key': key,
        'value': value,
      };
}

class Store {
  Store({
    this.id,
    this.name,
    this.url,
    this.avatar,
    this.address,
  });

  int? id;
  String? name;
  String? url;
  String? avatar;
  Address? address;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json['id'] as int,
        name: json['name'] as String,
        url: json['url'] as String,
        avatar: json['avatar'] as String,
        address: Address.fromJson(json['address'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'url': url,
        'avatar': avatar,
        'address': address?.toJson(),
      };
}

class Address {
  Address({
    this.street1,
    this.street2,
    this.city,
    this.zip,
    this.country,
    this.state,
  });

  String? street1;
  String? street2;
  String? city;
  String? zip;
  String? country;
  String? state;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street1: json['street_1'] as String,
        street2: json['street_2'] as String,
        city: json['city'] as String,
        zip: json['zip'] as String,
        country: json['country'] as String,
        state: json['state'] as String,
      );

  Map<String, dynamic> toJson() => {
        'street_1': street1,
        'street_2': street2,
        'city': city,
        'zip': zip,
        'country': country,
        'state': state,
      };
}
