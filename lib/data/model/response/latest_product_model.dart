/// id : 7
/// added_by : "seller"
/// user_id : 24
/// name : "Shoes"
/// slug : "shoes-PpGD8E"
/// category_ids : [{"id":"6","position":1}]
/// category : "1"
/// brand_id : 13
/// unit : "pc"
/// min_qty : 1
/// refundable : 1
/// images : ["2021-11-10-618b67c002cd7.png"]
/// thumbnail : "2021-11-10-618b67c004a3b.png"
/// featured : null
/// flash_deal : null
/// video_provider : null
/// video_url : null
/// colors : []
/// variant_product : "0"
/// attributes : null
/// choice_options : []
/// variation : []
/// published : 0
/// unit_price : 150
/// purchase_price : 135
/// tax : 0
/// tax_type : "percent"
/// discount : 0
/// discount_type : "flat"
/// current_stock : 200
/// details : null
/// free_shipping : 0
/// attachment : null
/// created_at : "2021-11-10 12:33:36"
/// updated_at : "2021-11-10 12:33:36"
/// status : 1
/// featured_status : 1
/// commission : "0"

class Latest_product_model {
  Latest_product_model({
    int id,
    String addedBy,
    int userId,
    String name,
    String slug,
    List<Category_ids> categoryIds,
    String category,
    int brandId,
    String unit,
    int minQty,
    int refundable,
    List<String> images,
    String thumbnail,
    dynamic featured,
    dynamic flashDeal,
    dynamic videoProvider,
    dynamic videoUrl,
    List<dynamic> colors,
    String variantProduct,
    dynamic attributes,
    List<dynamic> choiceOptions,
    List<dynamic> variation,
    int published,
    int unitPrice,
    int purchasePrice,
    int tax,
    String taxType,
    int discount,
    String discountType,
    int currentStock,
    dynamic details,
    int freeShipping,
    dynamic attachment,
    String createdAt,
    String updatedAt,
    int status,
    int featuredStatus,
    String commission,
  }) {
    _id = id;
    _addedBy = addedBy;
    _userId = userId;
    _name = name;
    _slug = slug;
    _categoryIds = categoryIds;
    _category = category;
    _brandId = brandId;
    _unit = unit;
    _minQty = minQty;
    _refundable = refundable;
    _images = images;
    _thumbnail = thumbnail;
    _featured = featured;
    _flashDeal = flashDeal;
    _videoProvider = videoProvider;
    _videoUrl = videoUrl;
    _colors = colors;
    _variantProduct = variantProduct;
    _attributes = attributes;
    _choiceOptions = choiceOptions;
    _variation = variation;
    _published = published;
    _unitPrice = unitPrice;
    _purchasePrice = purchasePrice;
    _tax = tax;
    _taxType = taxType;
    _discount = discount;
    _discountType = discountType;
    _currentStock = currentStock;
    _details = details;
    _freeShipping = freeShipping;
    _attachment = attachment;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _status = status;
    _featuredStatus = featuredStatus;
    _commission = commission;
  }

  Latest_product_model.fromJson(dynamic json) {
    _id = json['id'];
    _addedBy = json['added_by'];
    _userId = json['user_id'];
    _name = json['name'];
    _slug = json['slug'];
    if (json['category_ids'] != null) {
      _categoryIds = [];
      json['category_ids'].forEach((v) {
        _categoryIds.add(Category_ids.fromJson(v));
      });
    }
    _category = json['category'];
    _brandId = json['brand_id'];
    _unit = json['unit'];
    _minQty = json['min_qty'];
    _refundable = json['refundable'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
    _thumbnail = json['thumbnail'];
    _featured = json['featured'];
    _flashDeal = json['flash_deal'];
    _videoProvider = json['video_provider'];
    _videoUrl = json['video_url'];
    if (json['colors'] != null) {
      _colors = [];
      json['colors'].forEach((v) {
        _colors.add(Latest_product_model.fromJson(v));
      });
    }
    _variantProduct = json['variant_product'];
    _attributes = json['attributes'];
    if (json['choice_options'] != null) {
      _choiceOptions = [];
      json['choice_options'].forEach((v) {
        _choiceOptions.add(Latest_product_model.fromJson(v));
      });
    }
    if (json['variation'] != null) {
      _variation = [];
      json['variation'].forEach((v) {
        _variation.add(Latest_product_model.fromJson(v));
      });
    }
    _published = json['published'];
    _unitPrice = json['unit_price'];
    _purchasePrice = json['purchase_price'];
    _tax = json['tax'];
    _taxType = json['tax_type'];
    _discount = json['discount'];
    _discountType = json['discount_type'];
    _currentStock = json['current_stock'];
    _details = json['details'];
    _freeShipping = json['free_shipping'];
    _attachment = json['attachment'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _status = json['status'];
    _featuredStatus = json['featured_status'];
    _commission = json['commission'];
  }
  int _id;
  String _addedBy;
  int _userId;
  String _name;
  String _slug;
  List<Category_ids> _categoryIds;
  String _category;
  int _brandId;
  String _unit;
  int _minQty;
  int _refundable;
  List<String> _images;
  String _thumbnail;
  dynamic _featured;
  dynamic _flashDeal;
  dynamic _videoProvider;
  dynamic _videoUrl;
  List<dynamic> _colors;
  String _variantProduct;
  dynamic _attributes;
  List<dynamic> _choiceOptions;
  List<dynamic> _variation;
  int _published;
  int _unitPrice;
  int _purchasePrice;
  int _tax;
  String _taxType;
  int _discount;
  String _discountType;
  int _currentStock;
  dynamic _details;
  int _freeShipping;
  dynamic _attachment;
  String _createdAt;
  String _updatedAt;
  int _status;
  int _featuredStatus;
  String _commission;

  int get id => _id;
  String get addedBy => _addedBy;
  int get userId => _userId;
  String get name => _name;
  String get slug => _slug;
  List<Category_ids> get categoryIds => _categoryIds;
  String get category => _category;
  int get brandId => _brandId;
  String get unit => _unit;
  int get minQty => _minQty;
  int get refundable => _refundable;
  List<String> get images => _images;
  String get thumbnail => _thumbnail;
  dynamic get featured => _featured;
  dynamic get flashDeal => _flashDeal;
  dynamic get videoProvider => _videoProvider;
  dynamic get videoUrl => _videoUrl;
  List<dynamic> get colors => _colors;
  String get variantProduct => _variantProduct;
  dynamic get attributes => _attributes;
  List<dynamic> get choiceOptions => _choiceOptions;
  List<dynamic> get variation => _variation;
  int get published => _published;
  int get unitPrice => _unitPrice;
  int get purchasePrice => _purchasePrice;
  int get tax => _tax;
  String get taxType => _taxType;
  int get discount => _discount;
  String get discountType => _discountType;
  int get currentStock => _currentStock;
  dynamic get details => _details;
  int get freeShipping => _freeShipping;
  dynamic get attachment => _attachment;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  int get status => _status;
  int get featuredStatus => _featuredStatus;
  String get commission => _commission;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['added_by'] = _addedBy;
    map['user_id'] = _userId;
    map['name'] = _name;
    map['slug'] = _slug;
    if (_categoryIds != null) {
      map['category_ids'] = _categoryIds.map((v) => v.toJson()).toList();
    }
    map['category'] = _category;
    map['brand_id'] = _brandId;
    map['unit'] = _unit;
    map['min_qty'] = _minQty;
    map['refundable'] = _refundable;
    map['images'] = _images;
    map['thumbnail'] = _thumbnail;
    map['featured'] = _featured;
    map['flash_deal'] = _flashDeal;
    map['video_provider'] = _videoProvider;
    map['video_url'] = _videoUrl;
    if (_colors != null) {
      map['colors'] = _colors.map((v) => v.toJson()).toList();
    }
    map['variant_product'] = _variantProduct;
    map['attributes'] = _attributes;
    if (_choiceOptions != null) {
      map['choice_options'] = _choiceOptions.map((v) => v.toJson()).toList();
    }
    if (_variation != null) {
      map['variation'] = _variation.map((v) => v.toJson()).toList();
    }
    map['published'] = _published;
    map['unit_price'] = _unitPrice;
    map['purchase_price'] = _purchasePrice;
    map['tax'] = _tax;
    map['tax_type'] = _taxType;
    map['discount'] = _discount;
    map['discount_type'] = _discountType;
    map['current_stock'] = _currentStock;
    map['details'] = _details;
    map['free_shipping'] = _freeShipping;
    map['attachment'] = _attachment;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['status'] = _status;
    map['featured_status'] = _featuredStatus;
    map['commission'] = _commission;
    return map;
  }
}

/// id : "6"
/// position : 1

class Category_ids {
  Category_ids({
    String id,
    int position,
  }) {
    _id = id;
    _position = position;
  }

  Category_ids.fromJson(dynamic json) {
    _id = json['id'];
    _position = json['position'];
  }
  String _id;
  int _position;

  String get id => _id;
  int get position => _position;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['position'] = _position;
    return map;
  }
}
