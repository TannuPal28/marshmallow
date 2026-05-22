import 'package:flutter/material.dart';
import 'package:marshmallow/features/auth/presentation/widgets/bank_details_step.dart';
import 'package:marshmallow/features/auth/presentation/widgets/kyc_documents_step.dart';
import 'package:marshmallow/features/auth/presentation/widgets/tax_info_step.dart';

import '../widgets/address_step.dart';
import '../widgets/auth_header_widget.dart';
import '../widgets/basic_info_step.dart';
import '../widgets/seller_stepper_widget.dart';

class SellerRegisterPage extends StatefulWidget {
  const SellerRegisterPage({super.key});

  @override
  State<SellerRegisterPage> createState() =>
      _SellerRegisterPageState();
}

class _SellerRegisterPageState extends State<SellerRegisterPage> {

  bool showMenu = false;

  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> steps = [

      BasicInfoStep(
        onNext: () {
          setState(() {
            currentStep = 1;
          });
        },
      ),

      AddressStep(
        onNext: () {
          setState(() {
            currentStep = 2;
          });
        },
        onBack: () {
          setState(() {
            currentStep = 0;
          });
        },
      ),

      TaxInfoStep(onNext: () {
        setState(() {
          currentStep = 3;
        });
      }, onBack: () {
        setState(() {
          currentStep = 1;
        });
      }),

      BankDetailsStep(onNext: () {
        setState(() {
          currentStep = 4;
        });
      }, onBack: () {
        setState(() {
          currentStep= 2;
        });
      }),

      KycDocumentsStep(onBack: () {
        setState(() {
          currentStep= 3;
        });
      }, onSubmit: () {

      },),
    ];

    return Scaffold(
        backgroundColor: const Color(0xfff3f4f6),

        body: SafeArea(child: SingleChildScrollView(
          child: Column(
            children: [

              /// HEADER
              AuthHeaderWidget(
                showMenu: showMenu,
                onMenuTap: () {
                  setState(() {
                    showMenu = !showMenu;
                  });
                },
              ),

              Container(
                margin: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xffe5e7eb),
                  ),
                ),

                child: Column(
                  children: [

                    /// TOP HEADER
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 40,
                        horizontal: 20,
                      ),

                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),

                        gradient: LinearGradient(
                          colors: [
                            Color(0xffc10f47),
                            Color(0xff920733),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),

                      child: const Column(
                        children: [

                          Text(
                            "Become a Seller",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 18),

                          Text(
                            "Complete all 5 steps to register as a seller on our platform",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// STEPPER
                    SellerStepperWidget(
                      currentStep: currentStep,
                    ),

                    /// STEP SCREEN
                    steps[currentStep],
                  ],
                ),
              ),
            ],
          ),
        ),)

    );
  }
}