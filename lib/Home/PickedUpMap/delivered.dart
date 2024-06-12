import 'package:cleaneo_driver_app/Home/BotNav.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderDeliveredPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display the animated GIF using Lottie
              Lottie.asset(
                'assets/images/deliverd.json',
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: mQuery.size.height * 0.07,
              ),
              Text(
                'Order Delivered Successfully!',
                style: TextStyle(fontSize: 24, fontFamily: 'SatoshiBold'),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              // Subtext
              Text(
                'Thank you for shopping with us. We hope you enjoy your purchase.',
                style: TextStyle(fontSize: 16, fontFamily: 'SatoshiMedium'),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: mQuery.size.height * 0.043,
              ),
              GestureDetector(
                onTap: () {
                  //   authentication.write('Authentiation', 'Guest');
                  //   HapticFeedback
                  //       .heavyImpact(); // Heavy haptic feedback
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BotNav();
                  }));
                },
                child: Container(
                  width: double.infinity,
                  height: mQuery.size.height * 0.06,
                  decoration: BoxDecoration(
                      color: const Color(0xff29b2fe),
                      borderRadius: BorderRadius.circular(6)),
                  child: Center(
                    child: Text(
                      "Back To Home",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: mQuery.size.height * 0.02,
                        fontFamily: 'SatoshiBold',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
