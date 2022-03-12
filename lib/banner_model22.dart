class BannerModel22 {
  final int price;
  final int discount;
  final int id;
  final String photo;
  final String url;
  BannerModel22({
    this.price,
    this.discount,
    this.url,
    this.id,
    this.photo,
  });
}
/*
{
        "id": 7,
        "added_by": "seller",
        "user_id": 24,
        "name": "Shoes",
        "slug": "shoes-PpGD8E",
        "category_ids": [
            {
                "id": "6",
                "position": 1
            }
        ],
        "category": "1",
        "brand_id": 13,
        "unit": "pc",
        "min_qty": 1,
        "refundable": 1,
        "images": [
            "2021-11-10-618b67c002cd7.png"
        ],
        "thumbnail": "2021-11-10-618b67c004a3b.png",
        "featured": null,
        "flash_deal": null,
        "video_provider": null,
        "video_url": null,
        "colors": [],
        "variant_product": "0",
        "attributes": null,
        "choice_options": [],
        "variation": [],
        "published": 0,
        "unit_price": 150,
        "purchase_price": 135,
        "tax": 0,
        "tax_type": "percent",
        "discount": 0,
        "discount_type": "flat",
        "current_stock": 200,
        "details": null,
        "free_shipping": 0,
        "attachment": null,
        "created_at": "2021-11-10 12:33:36",
        "updated_at": "2021-11-10 12:33:36",
        "status": 1,
        "featured_status": 1,
        "commission": "0"
    }
]
 */
//
// class UserLogin {
//   String username;
//   String password;
//
//   UserLogin({this.username, this.password});
//
//   Map<String, dynamic> toDatabaseJson() =>
//       {"username": this.username, "password": this.password};
// }
//
// class Token {
//   String token;
//
//   Token({this.token});
//
//   factory Token.fromJson(Map<String, dynamic> json) {
//     return Token(token: json['token']);
//   }
// }
