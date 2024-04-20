import 'dart:async';

import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class InAppPurchaseView extends StatefulWidget {
  const InAppPurchaseView({super.key});

  @override
  State<InAppPurchaseView> createState() => _InAppPurchaseViewState();
}

class _InAppPurchaseViewState extends State<InAppPurchaseView> {
  late Future<List<ProductDetails>> products;

  Future<List<ProductDetails>> getProductsList() async {
    final ProductDetailsResponse response = await InAppPurchase.instance
        .queryProductDetails(IAPProducts.productIds);
    if (response.notFoundIDs.isNotEmpty) {
      print('No products found.');
    }
    return response.productDetails;
  }

  @override
  void initState() {
    super.initState();
    products = getProductsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upgrade'.i18n)),
      body: FutureBuilder(
          future: products,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Text("Product list is not available now, try again later.".i18n);
                } else {
                  snapshot.data?.sort((a,b) => a.price.compareTo(b.price));
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data![index].title),
                          subtitle: Text(snapshot.data![index].description),
                          trailing: FilledButton(
                            onPressed: () async {
                              await _makePurchase(
                                  productDetails: snapshot.data![index]);
                            },
                            child: Text(snapshot.data![index].price),
                          ),
                        );
                      });
                }
            }
          }),
    );
  }

  Future<void> _makePurchase({required ProductDetails productDetails}) async {
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: productDetails);
    //if (_isConsumable(productDetails)) {
    InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
    //} else {
    //InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
    //}
  }
}
