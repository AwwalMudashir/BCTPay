
import 'package:bctpay/globals/index.dart';
import 'package:bctpay/data/models/kyc/kyc_response.dart' as kyc_models;
import 'package:bctpay/data/repository/kyc_repo/kyc_repository.dart';

class KycScreen extends StatefulWidget {
  static const String routeName = 'kyc-screen';
  const KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  kyc_models.KYCResponse? _kycResponse;
  bool _isLoading = true;
  String? _errorMessage;

  final KycRepository _kycRepository = KycRepository();

  @override
  void initState() {
    super.initState();
    _loadKycData();
  }

  Future<void> _loadKycData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final kycResponse = await _kycRepository.fetchKycData();
      setState(() {
        _kycResponse = kycResponse;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: themeLogoColorBlue,
        title: Text(
          appLocalizations(context).kyc,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: themeLogoColorBlue,
          ),
        ),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            16.height,
            Text(
              'Failed to load KYC information',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            8.height,
            Text(
              _errorMessage!,
              style: TextStyle(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            16.height,
            ElevatedButton(
              onPressed: _loadKycData,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_kycResponse != null) {
      return _buildKycContent(context, _kycResponse!);
    }

    return const Center(child: Text('No data available'));
  }

  Widget _buildKycContent(BuildContext context, kyc_models.KYCResponse kycResponse) {
    final summary = kyc_models.KYCHelper.generateSummary(kycResponse);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with progress
          _buildHeader(context, kycResponse, summary),
          const SizedBox(height: 40),

          // Verification steps
          if (kycResponse.kycList != null)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    ...kycResponse.kycList!.map(
                      (kycItem) =>
                          _buildVerificationStepFromData(context, kycItem),
                    ),
                    if (summary.isFullyVerified ?? false) ...[
                      const SizedBox(height: 32),
                      _buildSuccessCard(context),
                    ],
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

          // Action buttons
          _buildActionButtons(context, summary),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    kyc_models.KYCResponse kycResponse,
    kyc_models.KYCSummary summary,
  ) {
    final isFullyVerified = summary.isFullyVerified ?? false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(appLocalizations(context).kyc, style: Theme.of(context).textTheme.headlineLarge),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color:
                    isFullyVerified ? Colors.green : themeLogoColorBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    kycResponse.tier?.value ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    isFullyVerified
                        ? Icons.check_circle
                        : Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 18,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          isFullyVerified
              ? 'Your identity verification is complete!'
              : 'We require all users to complete identity verification',
          style: TextStyle(
            fontSize: 16,
            color: isFullyVerified ? Colors.green[700] : Colors.grey[600],
            height: 1.4,
            fontWeight: isFullyVerified ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildVerificationStepFromData(BuildContext context, kyc_models.KYCItem kycItem) {
    return _buildVerificationStep(
      onPressed:
          () =>
              kycItem.status != KYCStatus.approved
                  ? _handleKycItemTap(context, kycItem)
                  : null,
      icon: _getIconForDocumentCode(kycItem.code),
      title: kycItem.title,
      subtitle: kycItem.subTitle,
      status: _mapKycStatusToVerificationStatus(kycItem.status),
      isRequired: kycItem.isRequired,
      hasDocument: kycItem.hasDocument,
    );
  }

  void _handleKycItemTap(BuildContext context, kyc_models.KYCItem kycItem) {
    log(kycItem.code.toString());
    switch (kycItem.code) {
      case kyc_models.KYCDocumentCode.personalDetail:
        // Navigate to personal info screen
        break;
      case kyc_models.KYCDocumentCode.incomeData:
        // Navigate to income screen
        break;
      case kyc_models.KYCDocumentCode.idDocument:
        Navigator.pushNamed(
          context,
          AppRoutes.kycDocumentUpload,
          arguments: kycItem,
        );
        break;
      case kyc_models.KYCDocumentCode.nin:
        // Navigate to text upload screen
        break;
      case kyc_models.KYCDocumentCode.utilityBill:
        // Navigate to file upload screen
        break;
      case kyc_models.KYCDocumentCode.livenessCheck:
        // Navigate to face detection screen
        break;
      case kyc_models.KYCDocumentCode.bvn:
        // Navigate to BVN screen
        break;
      default:
        break;
    }
  }

  IconData _getIconForDocumentCode(kyc_models.KYCDocumentCode code) {
    switch (code) {
      case kyc_models.KYCDocumentCode.personalDetail:
        return Icons.person_outline;
      case kyc_models.KYCDocumentCode.incomeData:
        return Icons.account_balance_wallet_outlined;
      case kyc_models.KYCDocumentCode.idDocument:
        return Icons.credit_card_outlined;
      case kyc_models.KYCDocumentCode.nin:
        return Icons.badge_outlined;
      case kyc_models.KYCDocumentCode.utilityBill:
        return Icons.description_outlined;
      case kyc_models.KYCDocumentCode.bvn:
        return Icons.account_balance_outlined;
      default:
        return Icons.upload_file_outlined;
    }
  }

  VerificationStatus _mapKycStatusToVerificationStatus(kyc_models.KYCStatus status) {
    switch (status) {
      case kyc_models.KYCStatus.approved:
        return VerificationStatus.completed;
      case kyc_models.KYCStatus.rejected:
        return VerificationStatus.failed;
      case kyc_models.KYCStatus.pending:
        return VerificationStatus.pending;
      case kyc_models.KYCStatus.none:
        return VerificationStatus.notStarted;
      case kyc_models.KYCStatus.expired:
        return VerificationStatus.failed;
    }
  }

  Widget _buildSuccessCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade400, Colors.green.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.white, size: 48),
          const SizedBox(height: 16),
          const Text(
            'Verification Complete!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Congratulations! Your identity has been successfully verified.',
            style: TextStyle(color: Colors.white70, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, kyc_models.KYCSummary summary) {
    if (summary.isFullyVerified ?? false) {
      return CustomBtn(
        text: "To Dashboard",
        onTap: () {
          // Navigate to dashboard
        },
        color: themeLogoColorBlue,
      );
    }

    if (summary.nextRequiredDocument != null) {
      return Column(
        children: [
          CustomBtn(
            text: "Continue with ${summary.nextRequiredDocument!.title}",
            onTap:
                () => _handleKycItemTap(context, summary.nextRequiredDocument!),
            color: themeLogoColorBlue,
          ),
        ],
      );
    }

    return CustomBtn(
      text: "Upgrade Tier",
      onTap: () {
        // Handle upgrade tier action
      },
      color: themeLogoColorBlue,
    );
  }

  Widget _buildVerificationStep({
    required IconData icon,
    required String title,
    required String subtitle,
    required VerificationStatus status,
    required VoidCallback onPressed,
    bool isRequired = true,
    bool hasDocument = false,
  }) {
    Color borderColor = Colors.grey[200]!;
    Widget statusIcon;

    switch (status) {
      case VerificationStatus.completed:
        borderColor = Colors.green.withOpacity(0.3);
        statusIcon = Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 18),
        );
        break;
      case VerificationStatus.failed:
        borderColor = Colors.red.withOpacity(0.3);
        statusIcon = Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.close, color: Colors.white, size: 18),
        );
        break;
      case VerificationStatus.pending:
        borderColor = Colors.orange.withOpacity(0.3);
        statusIcon = Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.schedule, color: Colors.white, size: 18),
        );
        break;
      case VerificationStatus.notStarted:
        statusIcon = Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Text(
            '${status.index + 1}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        );
        break;
    }

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color:
              status == VerificationStatus.completed
                  ? Colors.green.withOpacity(0.05)
                  : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 1),
          boxShadow:
              status == VerificationStatus.completed
                  ? []
                  : [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.08),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
        ),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color:
                    status == VerificationStatus.completed
                        ? Colors.green.withOpacity(0.1)
                        : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color:
                    status == VerificationStatus.completed
                        ? Colors.green
                        : Colors.grey[600],
                size: 24,
              ),
            ),
            const SizedBox(width: 16),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color:
                                status == VerificationStatus.completed
                                    ? Colors.green[800]
                                    : Colors.black,
                          ),
                        ),
                      ),
                      if (isRequired)
                        const Text(
                          ' *',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.3,
                    ),
                  ),
                  if (hasDocument &&
                      status != VerificationStatus.completed) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.attach_file,
                          size: 16,
                          color: Colors.blue[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Document uploaded',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Status icon
            statusIcon,
          ],
        ),
      ),
    );
  }
}

enum VerificationStatus { notStarted, pending, completed, failed }