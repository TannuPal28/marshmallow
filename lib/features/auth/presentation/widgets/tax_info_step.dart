import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marshmallow/features/auth/presentation/bloc/seller_register_provider.dart';
import 'package:marshmallow/features/auth/presentation/widgets/build_label_widget.dart';
import 'package:marshmallow/features/auth/presentation/widgets/custom_auth_textfield.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/utils.dart';

class TaxInfoStep extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const TaxInfoStep({super.key, required this.onNext, required this.onBack});

  @override
  State<TaxInfoStep> createState() => _TaxInfoStepState();
}

class _TaxInfoStepState extends State<TaxInfoStep> {
  XFile? gstCertificate;
  XFile? panCardCopy;

  Future<void> _pickGstCertificate() async {
    final provider = Provider.of<SellerRegisterProvider>(
      context,
      listen: false,
    );

    final XFile? file = await Utils.pickImage(context);

    if (file != null) {
      setState(() {
        gstCertificate = file;
      });

      provider.gstCertificate = File(file.path);

      provider.taxDocs.removeWhere((element) => element.path == file.path);

      provider.taxDocs.add(File(file.path));
    }
  }

  Future<void> _pickPanCard() async {
    final provider = Provider.of<SellerRegisterProvider>(
      context,
      listen: false,
    );

    final XFile? file = await Utils.pickImage(context);

    if (file != null) {
      setState(() {
        panCardCopy = file;
      });
      provider.panCardCopy = File(file.path);
      provider.taxDocs.removeWhere((element) => element.path == file.path);

      provider.taxDocs.add(File(file.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SellerRegisterProvider>(
      context,
      listen: false,
    );
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Tax Information",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xffa50034),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Enter your business tax details",
            style: TextStyle(fontSize: 16, color: Color(0xff6b7280)),
          ),
          const SizedBox(height: 36),
          BuildLabelWidget(title: "PAN Number *"),
          const SizedBox(height: 14),

          CustomAuthTextfield(
            controller: provider.panController,
            hintText: "Enter PAN (e.g., ABCDE1234F)",
            prefixIcon: Icons.credit_card,
          ),
          const SizedBox(height: 6),
          const Text(
            "10-character Permanent Account Number",
            style: TextStyle(color: Color(0xff6b7280), fontSize: 13),
          ),
          const SizedBox(height: 34),
          BuildLabelWidget(title: "GST Number *"),
          const SizedBox(height: 14),
          CustomAuthTextfield(
            controller: provider.gstController,
            hintText: "Enter 15-digit GST number",
            prefixIcon: Icons.assignment,
          ),
          const SizedBox(height: 6),
          const Text(
            "15-character GST Identification Number",
            style: TextStyle(color: Color(0xff6b7280), fontSize: 13),
          ),
          const SizedBox(height: 34),
          BuildLabelWidget(title: "Tax ID (TIN/VAT)"),
          const SizedBox(height: 14),
          CustomAuthTextfield(
            controller: provider.taxIdController,
            hintText: "Enter Tax ID",
            prefixIcon: Icons.assignment,
          ),
          const SizedBox(height: 34),
          BuildLabelWidget(title: "Business Registration No."),
          const SizedBox(height: 14),

          CustomAuthTextfield(
            controller: provider.businessRegController,
            hintText: "Business registration number",
            prefixIcon: Icons.assignment,
          ),
          const SizedBox(height: 34),
          BuildLabelWidget(title: "Company CIN (for Companies)"),
          const SizedBox(height: 14),

          CustomAuthTextfield(
            controller: provider.cinController,
            hintText: "Corporate Identification Number",
            prefixIcon: Icons.assignment,
          ),
          const SizedBox(height: 34),
          BuildLabelWidget(title: "TAN Number"),
          const SizedBox(height: 14),

          CustomAuthTextfield(
            controller: provider.tanController,
            hintText: "Tax Deduction Account Number",
            prefixIcon: Icons.assignment,
          ),
          const SizedBox(height: 34),
          BuildLabelWidget(title: "Date of Incorporation"),
          const SizedBox(height: 14),
          TextFormField(
            controller: provider.incorporationDateController,
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null) {
                provider.incorporationDateController.text =
                    "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
              }
            },
            decoration: InputDecoration(
              hintText: "YYYY-MM-DD",
              hintStyle: const TextStyle(color: Color(0xff9ca3af)),
              prefixIcon: const Icon(
                Icons.calendar_month,
                color: Color(0xffa50034),
              ),
              suffixIcon: const Icon(
                Icons.calendar_today_outlined,
                color: Colors.black,
                size: 18,
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
            ),
          ),
          const SizedBox(height: 34),

          //optional box
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
                  "Tax Documents (Optional)",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffa50034),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _buildUploadCard(
                        title: "GST Certificate",
                        subtitle: "Upload GST certificate",
                        onTap: _pickGstCertificate,
                        file: gstCertificate,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: _buildUploadCard(
                        title: "PAN Card Copy",
                        subtitle: "Upload PAN card copy",
                        onTap: _pickPanCard,
                        file: panCardCopy,
                      ),
                    ),
                  ],
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
                if (provider.validateTax(context)) {
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
                "Next: Bank Details",
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

  Widget _buildUploadCard({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    XFile? file,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: file != null
                ? const Color(0xffa50034)
                : const Color(0xffcbd5e1),
            width: file != null ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xffa50034),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                file != null ? Icons.check : Icons.file_upload,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(height: 12),

            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xff374151),
              ),
            ),

            const SizedBox(height: 4),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                file != null ? file.path.split('/').last : subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: file != null ? Colors.green : const Color(0xff9ca3af),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
