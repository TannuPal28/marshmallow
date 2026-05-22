import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marshmallow/features/auth/presentation/widgets/build_label_widget.dart';
import 'package:marshmallow/features/auth/presentation/widgets/custom_auth_textfield.dart';

class TaxInfoStep extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const TaxInfoStep({super.key, required this.onNext, required this.onBack});

  @override
  Widget build(BuildContext context) {
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
            controller: TextEditingController(),
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
            controller: TextEditingController(),
            hintText: "Enter 15-digit GST number",
            prefixIcon: Icons.assignment, // रसीद/दस्तावेज़ आइकॉन
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
            controller: TextEditingController(),
            hintText: "Enter Tax ID",
            prefixIcon: Icons.assignment,
          ),
          const SizedBox(height: 34),
          BuildLabelWidget(title: "Business Registration No."),
          const SizedBox(height: 14),

          CustomAuthTextfield(
            controller: TextEditingController(),
            hintText: "Business registration number",
            prefixIcon: Icons.assignment,
          ),
          const SizedBox(height: 34),
          BuildLabelWidget(title: "Company CIN (for Companies)"),
          const SizedBox(height: 14),

          CustomAuthTextfield(
            controller: TextEditingController(),
            hintText: "Corporate Identification Number",
            prefixIcon: Icons.assignment,
          ),
          const SizedBox(height: 34),
          BuildLabelWidget(title: "TAN Number"),
          const SizedBox(height: 14),

          CustomAuthTextfield(
            controller: TextEditingController(),
            hintText: "Tax Deduction Account Number",
            prefixIcon: Icons.assignment,
          ),
          const SizedBox(height: 34),
          BuildLabelWidget(title: "Date of Incorporation"),
          const SizedBox(height: 14),
          TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              hintText: "dd/mm/yyyy",
              hintStyle: const TextStyle(color: Color(0xff9ca3af)),
              prefixIcon: const Icon(
                Icons.calendar_month,
                color: Color(0xffa50034),
              ),
              // लाल कैलेंडर आइकॉन
              suffixIcon: const Icon(
                Icons.calendar_today_outlined,
                color: Colors.black,
                size: 18,
              ),
              // आखिरी कैलेंडर आइकॉन
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
                    // GST Certificate Upload Card
                    Expanded(
                      child: _buildUploadCard(
                        title: "GST Certificate",
                        subtitle: "Upload GST certificate",
                      ),
                    ),
                    const SizedBox(width: 16),
                    // PAN Card Copy Upload Card
                    Expanded(
                      child: _buildUploadCard(
                        title: "PAN Card Copy",
                        subtitle: "Upload PAN card copy",
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
              onPressed: onBack,
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
              onPressed: onNext,
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
  Widget _buildUploadCard({required String title, required String subtitle}) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffcbd5e1), style: BorderStyle.solid),
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
            child: const Icon(Icons.file_upload, color: Colors.white, size: 20),
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
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xff9ca3af),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
