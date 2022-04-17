import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:user_app/data/model/response/product_model.dart';
import 'package:user_app/helper/price_converter.dart';
import 'package:user_app/provider/auth_provider.dart';
import 'package:user_app/provider/splash_provider.dart';
import 'package:user_app/provider/theme_provider.dart';
import 'package:user_app/utill/color_resources.dart';
import 'package:user_app/utill/custom_themes.dart';
import 'package:user_app/utill/dimensions.dart';
import 'package:user_app/utill/images.dart';
import 'package:user_app/view/screen/product/product_details_screen.dart';

class ProductWidget extends StatelessWidget {
  final Product productModel;
  final bool loginCheck;
  ProductWidget({@required this.productModel, this.loginCheck});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 1000),
              pageBuilder: (context, anim1, anim2) =>
                  ProductDetails(product: productModel),
            ));
      },
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).accentColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5)
          ],
        ),
        child: Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            // Product Image
            Container(
              height: 150,
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
              decoration: BoxDecoration(
                color: ColorResources.getIconBg(context),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: FadeInImage.assetNetwork(
                placeholder: Images.placeholder,
                image:
                    '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productThumbnailUrl}'
                    // 'https://alhafizcloth.com/100min/storage/app/public…restaurant/thumbnail/'
                    '/${productModel.thumbnail}',
                fit: BoxFit.cover,
              ),
            ),

            // Product Details
            Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(productModel.name ?? '',
                      style: robotoRegular,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Row(children: [
                    Text(
                      PriceConverter.convertPrice(
                          context, productModel.unitPrice,
                          discountType: productModel.discountType,
                          discount: productModel.discount),
                      style: robotoBold.copyWith(
                          color: ColorResources.getPrimary(context)),
                    ),
                    Expanded(child: SizedBox.shrink()),
                    Text(
                        productModel.rating != null
                            ? productModel.rating.length != 0
                                ? double.parse(productModel.rating[0].average)
                                    .toStringAsFixed(1)
                                : '0.0'
                            : '0.0',
                        style: robotoRegular.copyWith(
                          color: Provider.of<ThemeProvider>(context).darkTheme
                              ? Colors.white
                              : Colors.orange,
                          fontSize: Dimensions.FONT_SIZE_SMALL,
                        )),
                    Icon(Icons.star,
                        color: Provider.of<ThemeProvider>(context).darkTheme
                            ? Colors.white
                            : Colors.orange,
                        size: 15),
                  ]),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  productModel.discount > 0
                      ? Text(
                          PriceConverter.convertPrice(
                              context, productModel.unitPrice),
                          style: robotoBold.copyWith(
                            color: Theme.of(context).hintColor,
                            decoration: TextDecoration.lineThrough,
                            fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                          ),
                        )
                      : SizedBox.shrink(),
                  loginCheck
                      ? FutureBuilder<double>(
                          future: calculateDistance(
                              context,
                              double.parse(productModel.shop.lt),
                              double.parse(productModel.shop.lg)),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                  "distance from you: ${snapshot.data}km");
                            } else {
                              return Text("");
                            }
                          },
                        )
                      : Text(""),
                ],
              ),
            ),
          ]),

          // Off
          productModel.discount >= 1
              ? Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 20,
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    decoration: BoxDecoration(
                      color: ColorResources.getPrimary(context),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        PriceConverter.percentageCalculation(
                            context,
                            productModel.unitPrice,
                            productModel.discount,
                            productModel.discountType),
                        style: robotoRegular.copyWith(
                            color: Theme.of(context).accentColor,
                            fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ]),
      ),
    );
  }

  Future<double> calculateDistance(
      BuildContext context, double lat2, double lon2) async {
    double lat1 = Provider.of<AuthProvider>(context, listen: false).lat;
    double lon1 = Provider.of<AuthProvider>(context, listen: false).lng;
    double distanceInMeters =
        await Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
    double distanceInKiloMeters = distanceInMeters / 1000;
    double DistanceInKM =
        double.parse((distanceInKiloMeters).toStringAsFixed(2));
    print("$distanceInMeters");
    return DistanceInKM;
  }
}
