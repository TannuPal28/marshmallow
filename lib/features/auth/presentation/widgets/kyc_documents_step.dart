import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class KycDocumentsStep extends StatefulWidget {
  final VoidCallback onSubmit;
  final VoidCallback onBack;

  const KycDocumentsStep({
    super.key,
    required this.onSubmit,
    required this.onBack,
  });

  @override
  State<KycDocumentsStep> createState() => _KycDocumentsStepState();
}

class _KycDocumentsStepState extends State<KycDocumentsStep> {
  bool _isAgreed = false;
  final ImagePicker _picker = ImagePicker();

  final Map<String, String?> _uploadedFiles={
    "PAN Card Copy *": null,
    "Aadhaar Card *": null,
    "Business Proof *": null,
    "Address Proof *": null,
  };

  Future<void> _pickDocument(String docType) async{
    try{
      final XFile? pickedFile= await _picker.pickImage(source: ImageSource.gallery,
      imageQuality: 80);

      if(pickedFile != null){
        setState(() {
          _uploadedFiles[docType] = pickedFile.path;
        });
      }
    }catch (e) {
      debugPrint("Error picking file: $e");
    }
  }
  void _removeDocument(String docType) {
    setState(() {
      _uploadedFiles[docType] = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    int uploadedCount= _uploadedFiles.values.where((path) => path!= null).length;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "KYC Documents",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xffa50034),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Upload required documents for verification",
            style: TextStyle(fontSize: 16, color: Color(0xff6b7280)),
          ),
          const SizedBox(height: 36),
          Row(
            children: [
              Expanded(
                child: _buildKycUploadCard(
                  title: "PAN Card Copy *",
                  subtitle: "Clear scanned copy of PAN card",
                  docKey: "PAN Card Copy *",
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildKycUploadCard(
                  title: "Aadhaar Card *",
                  subtitle: "Front and back in single image",
                  docKey: "Aadhaar Card *",
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildKycUploadCard(
                  title: "Business Proof *",
                  subtitle: "Certificate of Incorporation/Registration",
                  docKey: "Business Proof *",
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildKycUploadCard(
                  title: "Address Proof *",
                  subtitle: "Utility bill, rental agreement, etc.",
                  docKey: "Address Proof *",
                ),
              ),
            ],
          ),
          const SizedBox(height: 34),

          if (uploadedCount > 0) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xffe5e7eb)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Uploaded Documents ($uploadedCount/4):",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xffa50034)),
                  ),
                  const SizedBox(height: 16),


                  ..._uploadedFiles.entries.where((entry) => entry.value != null).map((entry) {

                    String fileName = entry.value!.split('/').last;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildUploadedFileRow(entry.key, fileName),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 34),
          ],
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xfff0f7ff),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xffd0e2ff)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Document Requirements:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff1e40af)),
                ),
                const SizedBox(height: 16),
                _buildRequirementRow("All documents must be clear and readable"),
                const SizedBox(height: 12),
                _buildRequirementRow("Maximum file size: 5MB per document"),
                const SizedBox(height: 12),
                _buildRequirementRow("Accepted formats: JPG, JPEG, PNG"),
                const SizedBox(height: 12),
                _buildRequirementRow("Documents should be in English or Hindi"),
              ],
            ),
          ),
          const SizedBox(height: 34),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xffe5e7eb)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: _isAgreed,
                    activeColor: const Color(0xffa50034),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    side: const BorderSide(
                      color: Color(0xff9ca3af),
                      width: 1.5,
                    ),
                    onChanged: (bool? value) {
                      setState(() {
                        _isAgreed = value ?? false;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    "I agree to the Terms of Service, Privacy Policy, and Seller Agreement. I confirm that all information provided is accurate and I understand that false information may lead to application rejection.",
                    style: TextStyle(
                      color: Color(0xff374151),
                      fontSize: 13,
                      height: 1.5,
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Previous", style: TextStyle(color: Color(0xff374151), fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: (_isAgreed && uploadedCount >= 1) ? widget.onSubmit : null, // कम से कम 1 अपलोड और टिक होना ज़रूरी है
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffa50034),
                disabledBackgroundColor: const Color(0xffa50034).withOpacity(0.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Submit Application", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKycUploadCard({
    required String title,
    required String subtitle,
    required String docKey,
  }) {

    bool hasFile = _uploadedFiles[docKey] != null;

    return InkWell(
      onTap: () => _pickDocument(docKey),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 160,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),

          border: Border.all(
            color: hasFile ? const Color(0xffa50034) : const Color(0xffe5e7eb),
            width: hasFile ? 2.0 : 1.0,
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
              child: Icon(hasFile ? Icons.check : Icons.file_upload, color: Colors.white, size: 20),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff1f2937)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              hasFile ? "Click to change file" : subtitle,
              style: TextStyle(fontSize: 12, color: hasFile ? Colors.green[700] : const Color(0xff6b7280), height: 1.3),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildUploadedFileRow(String docType, String fileName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffe5e7eb)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "$docType: $fileName",
              style: const TextStyle(color: Color(0xff374151), fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: 32,
            child: OutlinedButton(
              onPressed: () => _removeDocument(docType),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xfffca5a5)),
                backgroundColor: const Color(0xfffef2f2),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              child: const Text("Remove", style: TextStyle(color: Color(0xffef4444), fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRequirementRow(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check, color: Color(0xff2563eb), size: 18),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: const TextStyle(color: Color(0xff1e3a8a), fontSize: 13))),
      ],
    );
  }
}
