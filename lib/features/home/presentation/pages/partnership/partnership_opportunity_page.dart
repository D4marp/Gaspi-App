import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaspi_app/core/gen/assets.gen.dart';
import 'package:gaspi_app/core/theme/app_theme.dart';

/// Halaman Peluang Kemitraan
class PartnershipOpportunityPage extends StatelessWidget {
  const PartnershipOpportunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.08;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Peluang Kemitraan'),
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              /// Contact Us Section
              _buildContactSection(),
              const SizedBox(height: 48),

              /// Partnership Opportunity Section
              _buildOpportunitySection(),
              const SizedBox(height: 48),

              /// Partnership Support Section
              _buildSupportSection(),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  /// Contact Us Section
  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Decorative icon/asset
        Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SvgPicture.asset(
            Assets.logos.logo,
            fit: BoxFit.scaleDown,
          ),
        ),
        const SizedBox(height: 24),

        /// Title
        const Text(
          'Contact us For Partnership',
          style: TextStyle(
            color: Color(0xFF101828),
            fontSize: 16,
            fontFamily: 'Nunito Sans',
            fontWeight: FontWeight.w700,
            height: 1.20,
            letterSpacing: -0.32,
          ),
        ),
        const SizedBox(height: 24),

        /// Contact Details
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Email
            _buildContactItem(
              icon: Icons.email_outlined,
              label: 'enquiry.gwn@gaspi.id',
              onTap: () {
                // TODO: Open email client
              },
            ),
            const SizedBox(height: 12),

            /// Phone
            _buildContactItem(
              icon: Icons.phone_outlined,
              label: '(0778) 392900',
              onTap: () {
                // TODO: Open phone dialer
              },
            ),
            const SizedBox(height: 12),

            /// Address
            _buildContactItem(
              icon: Icons.location_on_outlined,
              label: 'Jl. Brigjen Katamso No.76 - 78, Tj. Uncang,\nKec. Batu Aji, Kota Batam, Kepulauan Riau',
              onTap: () {
                // TODO: Open maps
              },
            ),
          ],
        ),
      ],
    );
  }

  /// Contact Item Widget
  Widget _buildContactItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF393D4E),
                fontSize: 12,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w400,
                height: 1.60,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Partnership Opportunity Section
  Widget _buildOpportunitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        const Text(
          'Partnership Opportunity',
          style: TextStyle(
            color: Color(0xFF101828),
            fontSize: 16,
            fontFamily: 'Nunito Sans',
            fontWeight: FontWeight.w700,
            height: 1.20,
            letterSpacing: -0.32,
          ),
        ),
        const SizedBox(height: 24),

        /// Description
        const Text(
          'PT. Gaspi Waralaba Nusantara offers a unique partnership opportunity for shipyard owners seeking to optimize their industrial gas operations. By partnering with us, you can benefit from our extensive experience, proven track record, and comprehensive support system.',
          style: TextStyle(
            color: Color(0xFF393D4E),
            fontSize: 12,
            fontFamily: 'Nunito Sans',
            fontWeight: FontWeight.w400,
            height: 1.60,
            letterSpacing: -0.24,
          ),
        ),
        const SizedBox(height: 24),

        /// Benefits List
        Column(
          children: [
            _buildBenefitItem(
              'Proven Business Model: Leverage our successful model and industry expertise.',
            ),
            const SizedBox(height: 12),
            _buildBenefitItem(
              'Reduced Operational Costs: Significantly lower gas costs, reduced labor, and optimized resource utilization.',
            ),
            const SizedBox(height: 12),
            _buildBenefitItem(
              'Enhanced Efficiency: Streamlined gas management processes and increased productivity.',
            ),
            const SizedBox(height: 12),
            _buildBenefitItem(
              'Strong Brand Recognition: Benefit from our established reputation as a leader in the industrial gas industry.',
            ),
            const SizedBox(height: 12),
            _buildBenefitItem(
              'Comprehensive Support: Receive expert training, technical assistance, and ongoing support.',
            ),
            const SizedBox(height: 12),
            _buildBenefitItem(
              'Exclusive Supply: Secure a reliable and cost-effective supply of industrial gases through our group\'s vertical integration.',
            ),
            const SizedBox(height: 12),
            _buildBenefitItem(
              'High Safety Standards: Adhere to stringent safety protocols and best practices.',
            ),
          ],
        ),
      ],
    );
  }

  /// Benefit Item Widget
  Widget _buildBenefitItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(top: 6),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF2F2C2C),
              fontSize: 12,
              fontFamily: 'Nunito Sans',
              fontWeight: FontWeight.w400,
              height: 1.60,
            ),
          ),
        ),
      ],
    );
  }

  /// Partnership Support Section
  Widget _buildSupportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        const Text(
          'Partnership Support',
          style: TextStyle(
            color: Color(0xFF101828),
            fontSize: 16,
            fontFamily: 'Nunito Sans',
            fontWeight: FontWeight.w700,
            height: 1.20,
            letterSpacing: -0.32,
          ),
        ),
        const SizedBox(height: 24),

        /// Description
        const Text(
          'We provide comprehensive support to our partners, including:',
          style: TextStyle(
            color: Color(0xFF393D4E),
            fontSize: 12,
            fontFamily: 'Nunito Sans',
            fontWeight: FontWeight.w400,
            height: 1.60,
          ),
        ),
        const SizedBox(height: 24),

        /// Support List
        Column(
          children: [
            _buildSupportItem(
              'Site Selection and Design: Assistance in identifying suitable locations and designing the refill facility.',
            ),
            const SizedBox(height: 12),
            _buildSupportItem(
              'Equipment Procurement: Sourcing and procurement of high-quality equipment at competitive prices.',
            ),
            const SizedBox(height: 12),
            _buildSupportItem(
              'Installation and Commissioning: Expert installation and commissioning of the refill system.',
            ),
            const SizedBox(height: 12),
            _buildSupportItem(
              'Training and Development: Comprehensive training programs for your staff.',
            ),
            const SizedBox(height: 12),
            _buildSupportItem(
              'Marketing and Sales Support: Assistance with developing marketing plans and sales strategies.',
            ),
            const SizedBox(height: 12),
            _buildSupportItem(
              'Operational Guidance: Ongoing support and advice on day-to-day operations.',
            ),
            const SizedBox(height: 12),
            _buildSupportItem(
              'Quality Control: Ensuring adherence to quality standards and safety regulations.',
            ),
            const SizedBox(height: 12),
            _buildSupportItem(
              'Cylinder Control: Management and monitoring of gas cylinders to ensure efficiency, safety, and reliable supply.',
            ),
            const SizedBox(height: 12),
            _buildSupportItem(
              'Professional Maintenance: Routine maintenance and equipment repairs by experienced technicians to ensure optimal system performance.',
            ),
          ],
        ),
      ],
    );
  }

  /// Support Item Widget
  Widget _buildSupportItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(top: 6),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF2F2C2C),
              fontSize: 12,
              fontFamily: 'Nunito Sans',
              fontWeight: FontWeight.w400,
              height: 1.60,
            ),
          ),
        ),
      ],
    );
  }
}
