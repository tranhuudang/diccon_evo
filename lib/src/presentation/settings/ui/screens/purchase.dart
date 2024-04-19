import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class InAppPurchaseView extends StatefulWidget {
  const InAppPurchaseView({super.key});

  @override
  State<InAppPurchaseView> createState() => _InAppPurchaseViewState();
}

class _InAppPurchaseViewState extends State<InAppPurchaseView> {
  late StreamSubscription _subscription;

  @override
  void initState() {
    final Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    super.initState();
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        //_showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          //_handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          // bool valid = await _verifyPurchase(purchaseDetails);
          // if (valid) {
          //   _deliverProduct(purchaseDetails);
          // } else {
          //   _handleInvalidPurchase(purchaseDetails);
          // }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(purchaseDetails);
        }
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upgrade')),
      body: Column(
        children: [
          ListTile(
            title: Text('Stater Trial Pack'),
            subtitle: Text(
                'Experience premium features for a limited time. Try now and unlock a new level of functionality!'),
            trailing: FilledButton(
              onPressed: () async {
                await _makePurchase(productIdIndex: 0);

              },
              child: Text('đ 19.000'),
            ),
          ),
          ListTile(
            title: Text('Stater Pack'),
            subtitle: Text(
                'Unlock exclusive features and enhance productivity. Upgrade now for a streamlined experience!'),
            trailing: FilledButton(
              onPressed: () {},
              child: Text('đ 199.000'),
            ),
          ),
          ListTile(
            title: Text('Lifetime Pack'),
            subtitle: Text(
                'Enjoy lifetime access to premium features. Make a one-time purchase for uninterrupted benefits!'),
            trailing: FilledButton(
              onPressed: () {},
              child: Text('đ 4.990.000'),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _makePurchase({required int productIdIndex}) async {
    const Set<String> _kIds = <String>{
      'stater_try',
      'stater',
      'life_time'
    };
    final ProductDetailsResponse response =
        await InAppPurchase.instance.queryProductDetails(_kIds);
    if (response.notFoundIDs.isNotEmpty) {
      print('No products found.');
    }
    List<ProductDetails> products = response.productDetails;
    final ProductDetails productDetails = products[0];
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: productDetails);
    //if (_isConsumable(productDetails)) {
    InAppPurchase.instance
        .buyConsumable(purchaseParam: purchaseParam);
    //} else {
    //InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
    //}
  }
}
