import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NetworkImageWithSSL extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const NetworkImageWithSSL({
    required this.imageUrl,
    this.height,
    this.width,
    this.fit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadImage(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Image.memory(
            snapshot.data!,
            height: height,
            width: width,
            fit: fit,
          );
        } else if (snapshot.hasError) {
          return _buildErrorWidget();
        }
        return _buildLoadingWidget();
      },
    );
  }

  Future<Uint8List> _loadImage() async {
    final HttpClient client = HttpClient();
    client.badCertificateCallback = (cert, host, port) => true;
    final HttpClientRequest request = await client.getUrl(Uri.parse(imageUrl));
    final HttpClientResponse response = await request.close();
    return await consolidateHttpClientResponseBytes(response);
  }

  Widget _buildErrorWidget() {
    return Container(
      color: Colors.grey[200],
      child: Center(child: Icon(Icons.error_outline, color: Colors.red)),
    );
  }

  Widget _buildLoadingWidget() {
    return Container(
      color: Colors.grey[200],
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
