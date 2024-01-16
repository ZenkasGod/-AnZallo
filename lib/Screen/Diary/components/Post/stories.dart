import 'package:flutter/material.dart';

class Stories extends StatelessWidget {
  const Stories({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 155,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Khoảnh khắc',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildRoundedContainer(),
                // Thêm các _buildRoundedContainer khác tương tự cho các khoảnh khắc khác
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundedContainer() {
    return Container(
      width: 75,
      height: 50,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadius.all(
          Radius.circular(2), // Đặt bán kính là 2
        ),
      ),
    );
  }
}
