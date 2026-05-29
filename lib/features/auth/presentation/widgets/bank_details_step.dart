import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marshmallow/features/auth/presentation/bloc/seller_register_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/utils.dart';
import 'build_label_widget.dart';
import 'custom_auth_textfield.dart';

class BankDetailsStep extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const BankDetailsStep({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<BankDetailsStep> createState() => _BankDetailsStepState();
}

class _BankDetailsStepState extends State<BankDetailsStep> {
  String _selectedAccountType = 'Savings Account';

  XFile? cancelledCheque;
  Future<void> _pickCheque() async {
    final provider = Provider.of<SellerRegisterProvider>(
      context,
      listen: false,
    );

    final XFile? file = await Utils.pickImage(context);

    if (file != null) {
      setState(() {
        cancelledCheque = file;
      });

      provider.cancelledCheque = File(file.path);
      print("Cheque Path => ${provider.cancelledCheque?.path}");

      provider.notifyListeners();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SellerRegisterProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Bank Account Details",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xffa50034),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Where should we send your payments?",
            style: TextStyle(fontSize: 16, color: Color(0xff6b7280)),
          ),
          const SizedBox(height: 36),
          BuildLabelWidget(title: "Account Holder Name *"),
          const SizedBox(height: 14),
          CustomAuthTextfield(
            controller: provider.accountHolderController,
            hintText: "As per bank records",
            prefixIcon: Icons.person,
          ),
          const SizedBox(height: 34),

          BuildLabelWidget(title: "Account Number *"),
          const SizedBox(height: 14),

          CustomAuthTextfield(
            controller: provider.accountNumberController,
            hintText: "Enter bank account number",
            prefixIcon: Icons.account_balance,
          ),
          const SizedBox(height: 34),

          BuildLabelWidget(title: "IFSC Code *"),
          const SizedBox(height: 14),

          CustomAuthTextfield(
            controller: provider.ifscController,
            hintText: "Enter IFSC code (e.g., SBIN0001234)",
            prefixIcon: Icons.account_balance,
          ),
          const SizedBox(height: 34),

          BuildLabelWidget(title: "Bank Name *"),
          const SizedBox(height: 14),
          CustomAuthTextfield(
            controller: provider.bankNameController,
            hintText: "Enter bank name",
            prefixIcon: Icons.account_balance,
          ),
          const SizedBox(height: 34),

          BuildLabelWidget(title: "Branch *"),
          const SizedBox(height: 14),

          CustomAuthTextfield(
            controller: provider.branchController,
            hintText: "Enter branch name",
            prefixIcon: Icons.account_balance,
          ),
          const SizedBox(height: 34),
          BuildLabelWidget(title: "Account Type"),
          const SizedBox(height: 14),
          DropdownButtonFormField<String>(
            value: _selectedAccountType,
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.account_balance,
                color: Color(0xffa50034),
              ),

              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xffd1d5db)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xffd1d5db)),
              ),
              fillColor: Colors.white,
              filled: true,
            ),
            items: <String>['Savings Account', 'Current Account'].map((
              String value,
            ) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _selectedAccountType = newValue!;
              });
            },
          ),
          const SizedBox(height: 34),
          BuildLabelWidget(title: "Branch Code"),
          const SizedBox(height: 14),
          CustomAuthTextfield(
            controller: provider.branchCodeController,
            hintText: "Enter branch code",
            prefixIcon: Icons.account_balance,
          ),
          const SizedBox(height: 34),

          BuildLabelWidget(title: "SWIFT Code (for International)"),
          const SizedBox(height: 14),
          CustomAuthTextfield(
            controller: provider.swiftController,
            hintText: "Enter SWIFT code",
            prefixIcon: Icons.account_balance,
          ),
          const SizedBox(height: 34),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xfffdf2f4),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xfffbcfe8)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Cancelled Cheque *",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffa50034),
                  ),
                ),
                const SizedBox(height: 20),

                InkWell(
                  onTap: _pickCheque,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: double.infinity,
                    height: 170,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: cancelledCheque != null
                            ? const Color(0xffa50034)
                            : const Color(0xffcbd5e1),
                        width: cancelledCheque != null ? 2 : 1,
                      ),
                    ),
                    child: cancelledCheque != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(cancelledCheque!.path),
                              fit: BoxFit.cover,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: const Color(0xffa50034),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Icon(
                                  Icons.file_upload,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                "Upload Cancelled Cheque",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff374151),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "Tap to upload image",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xff9ca3af),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xfff0f7ff),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xffd0e2ff)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.credit_card,
                  color: Color(0xff1d4ed8),
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: Color(0xff1e40af),
                        fontSize: 13,
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(
                          text: "Note: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              "Payments will be transferred to this bank account. Ensure details match your business name. A cancelled cheque is required for verification.",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 34),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton(
              onPressed: widget.onBack,
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xfff3f4f6),
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Previous",
                style: TextStyle(
                  color: Color(0xff374151),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                if (provider.validateBank(context)) {
                  widget.onNext();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffa50034),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Next: KYC Documents",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
