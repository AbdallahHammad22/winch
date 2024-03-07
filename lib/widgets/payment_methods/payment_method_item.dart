import 'package:flutter/material.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/models/enums/payment_methods_types.dart';
class PaymentMethodItem extends StatelessWidget {
  final PaymentMethods paymentMethod;
  final PaymentMethods selectedPaymentMethod;
  final Function(PaymentMethods) onPressed;

  String getImage(){
    switch (paymentMethod){
      case PaymentMethods.card:
        return "assets/images/master_card.png";
      case PaymentMethods.meeza:
        return "assets/images/meeza.jpg";
      case PaymentMethods.viza:
        return "assets/images/visa.png";
      case PaymentMethods.fawry:
        return "assets/images/fawry.png";
      default: return "assets/images/visa.png";
    }
  }

  const PaymentMethodItem({
    Key key,
    this.paymentMethod,
    this.selectedPaymentMethod,
    this.onPressed
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 100 * AStyling.getScaleFactor(context),
      duration: Duration(milliseconds: 400),
      decoration: BoxDecoration(
        color: AColors.white,
        borderRadius: BorderRadius.circular(
          AStyling.getBorderRadius(context)
        ),
        border: Border.all(
          color: selectedPaymentMethod == paymentMethod
              ? Colors.black : Colors.transparent,
        ),
        boxShadow: [
          AStyling.boxShadow
        ]
      ),
      child: MaterialButton(
        padding: EdgeInsets.all(16),
        onPressed: (){
          onPressed(paymentMethod);
        },
        child: Image(
          image: AssetImage(getImage()),
        ),
      ),
    );
  }
}
