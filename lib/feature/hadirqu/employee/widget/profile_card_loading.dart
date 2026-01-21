import 'package:flutter/material.dart';
import 'package:shelter_super_app/design/shimmer.dart';

class ProfileCardLoading extends StatelessWidget {
  const ProfileCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Shimmer(
          isLoading: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Avatar
                  _circle(size: 50),
                  const SizedBox(width: 12),

                  /// Nama & info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _line(width: 160, height: 16),
                        const SizedBox(height: 8),
                        _line(width: 120),
                        const SizedBox(height: 6),
                        _line(width: 180),
                        const SizedBox(height: 6),
                        _line(width: 200),
                        const SizedBox(height: 6),
                        _line(width: 150),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// EXPANDED CONTENT PLACEHOLDER
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _line(width: 120, height: 14),
                    const SizedBox(height: 12),
                    _rowLine(),
                    const SizedBox(height: 8),
                    _rowLine(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Helpers
  Widget _line({double width = double.infinity, double height = 12}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  Widget _circle({double size = 40}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _rowLine() {
    return Row(
      children: [
        _line(width: 80),
        const SizedBox(width: 12),
        Expanded(child: _line()),
      ],
    );
  }
}
