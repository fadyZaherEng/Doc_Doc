import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_banners/super_banners.dart';

class PaymentsWidget extends StatelessWidget {
  final List<Payment> payments;
  final void Function(Payment payment) onTapPayNowAction;
  final Function() onPullToRefresh;
  final CompoundCurrency compoundCurrency;
  final void Function(Payment payment) onPaymentCardTap;

  const PaymentsWidget({
    super.key,
    required this.payments,
    required this.onTapPayNowAction,
    required this.onPullToRefresh,
    required this.compoundCurrency,
    required this.onPaymentCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: RefreshIndicator(
          onRefresh: () => onPullToRefresh(),
          child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: payments.length,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: InkWell(
                    onTap: () => onPaymentCardTap(payments[index]),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorSchemes.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                              color: ColorSchemes.lightGray,
                              offset: Offset(0, 1),
                              blurRadius: 50,
                              spreadRadius: 0)
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: ColorSchemes.gray,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: Text(
                                      payments[index].title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: ColorSchemes.primary,
                                              letterSpacing: -0.13),
                                    ),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  Text(
                                    payments[index].createDate,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                            color: ColorSchemes.black,
                                            letterSpacing: -0.13),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Stack(
                            alignment:
                                Directionality.of(context) == TextDirection.ltr
                                    ? Alignment.topLeft
                                    : Alignment.topRight,
                            children: [
                              Directionality(
                                textDirection: Directionality.of(context),
                                child: CornerBanner(
                                  bannerPosition: Directionality.of(context) ==
                                          TextDirection.ltr
                                      ? CornerBannerPosition.topLeft
                                      : CornerBannerPosition.topRight,
                                  bannerColor: payments[index]
                                      .paymentStatus
                                      .extraValue1
                                      .toColor(),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2,
                                    ),
                                    child: Text(
                                        payments[index].paymentStatus.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: ColorSchemes.white,
                                              fontSize: 12,
                                              letterSpacing: -0.24,
                                            )),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "${payments[index].amount.toString()} ${payments[index].currency.code}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                    color: ColorSchemes.black,
                                                    letterSpacing: -0.16,
                                                  ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Text(
                                                  "  S.of(context).dueDate",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge!
                                                      .copyWith(
                                                        color: ColorSchemes
                                                            .secondary,
                                                        letterSpacing: -0.12,
                                                      ),
                                                ),
                                                const SizedBox(width: 20),
                                                Text(
                                                  payments[index].dueDate,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge!
                                                      .copyWith(
                                                        color: ColorSchemes
                                                            .secondary,
                                                        letterSpacing: -0.12,
                                                      ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                      payments[index].description,
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: ColorSchemes.gray,
                                            letterSpacing: -0.24,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          payments[index].paymentStatus.code ==
                                  PaymentsKey.needPayment
                              ? InkWell(
                                  onTap: () =>
                                      onTapPayNowAction(payments[index]),
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 1,
                                          color: ColorSchemes.lightGray),
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              ImagePaths.payment,
                                              fit: BoxFit.scaleDown,
                                              matchTextDirection: true,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              "  S.of(context).payNow",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    color: ColorSchemes.black,
                                                    letterSpacing: -0.24,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class CompoundCurrency {
  final String currency;
  final double amount;

  const CompoundCurrency({
    required this.currency,
    required this.amount,
  });
}

extension ColorExtension on String {
  toColor() {
    if (isEmpty) return ColorSchemes.primary;
    // var hexString = this;
    // int hexValue = int.parse(hexString, radix: 16); // Convert hexadecimal to integer
    //
    // int red = (hexValue >> 24) & 0xFF; // Extract red value
    // int green = (hexValue >> 16) & 0xFF; // Extract green value
    // int blue = (hexValue >> 8) & 0xFF; // Extract blue value
    // double opacity = (hexValue & 0xFF) / 255.0; // Extract opacity value and normalize to 0.0-1.0
    // return Color(int.parse(this.replaceAll("#", "0xFF"), radix: 16));
    return Color(int.parse(replaceAll("#", "ff"), radix: 16) | 0xFF000000);

    //return Color.fromRGBO(red, green, blue, opacity);
  }
}

class PaymentsKey {
  static const String needPayment = "needPayment";
  static const String paid = "paid";
}

class Payment extends Equatable {
  final int id;
  final String title;
  final String description;
  final double amount;
  final double discount;
  final double totalAmount;
  final String paymentDate;
  final String paymentRef;
  final String paymentResponse;
  final String paymentTransactionId;
  final bool isPaid;
  final String paymentResponseDate;
  final String createDate;
  final String invoiceNumber;
  final String dueDate;
  final bool isIncludeTax;
  final bool isIncludeVat;
  final double tax;
  final double vat;
  final double taxValue;
  final double vatValue;
  final PaymentSourceType paymentSourceType;
  final Currency currency;
  final PaymentMethod paymentMethod;
  final PaymentStatus paymentStatus;
  final List<PaymentDetails> paymentDetails;
  final List<PaymentRequestPaymentMethods> paymentRequestPaymentMethods;

  const Payment({
    this.id = 0,
    this.title = "",
    this.description = "",
    this.invoiceNumber = "",
    this.amount = 0.0,
    this.discount = 0.0,
    this.totalAmount = 0.0,
    this.paymentDate = "",
    this.paymentRef = "",
    this.paymentResponse = "",
    this.paymentTransactionId = "",
    this.isPaid = false,
    this.paymentResponseDate = "",
    this.createDate = "",
    this.dueDate = "",
    this.isIncludeTax = false,
    this.isIncludeVat = false,
    this.tax = 0.0,
    this.vat = 0.0,
    this.taxValue = 0.0,
    this.vatValue = 0.0,
    this.paymentSourceType = const PaymentSourceType(),
    this.currency = const Currency(),
    this.paymentMethod = const PaymentMethod(),
    this.paymentStatus = const PaymentStatus(),
    this.paymentDetails = const [],
    this.paymentRequestPaymentMethods = const [],
  });

  @override
  List<Object> get props => [
        id,
        title,
        description,
        amount,
        discount,
        totalAmount,
        paymentDate,
        paymentRef,
        paymentResponse,
        paymentTransactionId,
        isPaid,
        paymentResponseDate,
        createDate,
        dueDate,
        isIncludeTax,
        isIncludeVat,
        tax,
        vat,
        taxValue,
        vatValue,
        paymentSourceType,
        currency,
        paymentMethod,
        paymentStatus,
        paymentDetails,
        paymentRequestPaymentMethods,
      ];
}

class PaymentRequestPaymentMethods {}

class PaymentDetails {
  const PaymentDetails();
}

class PaymentStatus {
  final String code;
  final String name;
  final String extraValue1;

  const PaymentStatus({
    this.code = "",
    this.name = "",
    this.extraValue1 = "",
  });
}

class PaymentMethod {
  const PaymentMethod();
}

class Currency {
  final String code;

  const Currency({
    this.code = "",
  });
}

class PaymentSourceType {
  final String name;
  final String extraValue1;

  const PaymentSourceType({
    this.name = "",
    this.extraValue1 = "",
  });
}
