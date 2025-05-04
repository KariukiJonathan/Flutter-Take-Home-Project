import 'package:cached_network_image/cached_network_image.dart';
import 'package:cylinder_app/data/models/cylinder_model.dart';
import 'package:flutter/material.dart';

class CylinderCard extends StatelessWidget {
  final Cylinder cylinder;
  final VoidCallback onAddToCart;

  const CylinderCard({
    required this.cylinder,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: cylinder.imageUrl,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Text('${cylinder.name}kg'),
          Text('${cylinder.currency} ${cylinder.price}'),
          ElevatedButton(
            onPressed: onAddToCart,
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
