import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:user_app/data/model/response/product_model.dart';
import 'package:user_app/helper/product_type.dart';
import 'package:user_app/provider/product_provider.dart';
import 'package:user_app/utill/dimensions.dart';
import 'package:user_app/view/basewidget/product_shimmer.dart';
import 'package:user_app/view/basewidget/product_widget.dart';

class ProductView extends StatelessWidget {
  final ProductType productType;
  final ScrollController scrollController;
  final String sellerId;
  ProductView(
      {@required this.productType, this.scrollController, this.sellerId});

  @override
  Widget build(BuildContext context) {
    int offset = 1;
    scrollController?.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.position.pixels &&
          Provider.of<ProductProvider>(context, listen: false)
                  .latestProductList
                  .length !=
              0 &&
          !Provider.of<ProductProvider>(context, listen: false).isLoading) {
        int pageSize;
        if (productType == ProductType.LATEST_PRODUCT) {
          pageSize = Provider.of<ProductProvider>(context, listen: false)
              .latestPageSize;
        } else if (productType == ProductType.SELLER_PRODUCT) {
          pageSize = Provider.of<ProductProvider>(context, listen: false)
              .sellerPageSize;
        }
        if (offset < pageSize) {
          offset++;
          print('end of the page');
          Provider.of<ProductProvider>(context, listen: false)
              .showBottomLoader();
          Provider.of<ProductProvider>(context, listen: false)
              .getLatestProductList(offset.toString(), context);
        }
      }
    });

    return Consumer<ProductProvider>(
      builder: (context, prodProvider, child) {
        List<Product> productList;
        if (productType == ProductType.LATEST_PRODUCT) {
          productList = prodProvider.latestProductList;
        } else if (productType == ProductType.SELLER_PRODUCT) {
          productList = prodProvider.sellerProductList;
        }

        return Column(children: [
          !prodProvider.firstLoading
              ? productList.length != 0
                  ? StaggeredGridView.countBuilder(
                      itemCount: productList.length,
                      crossAxisCount: 2,
                      padding: EdgeInsets.all(0),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                      itemBuilder: (BuildContext context, int index) {
                        return ProductWidget(
                          productModel: productList[index],
                          loginCheck: prodProvider.logincheck,
                        );
                      },
                    )
                  : SizedBox.shrink()
              : ProductShimmer(isEnabled: prodProvider.firstLoading),
          prodProvider.isLoading
              ? Center(
                  child: Padding(
                  padding: EdgeInsets.all(Dimensions.ICON_SIZE_EXTRA_SMALL),
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor)),
                ))
              : SizedBox.shrink(),
        ]);
      },
    );
  }
}
