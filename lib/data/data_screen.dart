import 'dart:convert';
import 'package:developer_hub_week_3/data/product_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class data_screen extends StatefulWidget {
  const data_screen(
      {super.key,
      this.current_location,
      required this.long,
      required this.lat});

  final double long;
  final double lat;

  final current_location;

  @override
  State<data_screen> createState() => DataScreenState();
}

class DataScreenState extends State<data_screen> {
  String get current_location_user => widget.current_location;
  double get long => widget.long;
  double get lat => widget.lat;
  List<String> product_unique_id = [];
  List<String> product_image_link_sell_to_buyer = [];
  List<String> product_price_sell_to_buyer = [];
  List<String> product_warranty_sell_to_buyer = [];
  List<String> product_quality_sell_to_buyer = [];
  List<String> seller_name_sell_to_buyer = [];
  List<String> product_name_sell_to_buyer = [];
  List<String> seller_id123 = [];

  late Future<void> sellersDataFuture;

  @override
  void initState() {
    super.initState();
    sellersDataFuture = get_all_sellers_data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Screen'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: sellersDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.6,
              ),
              padding: const EdgeInsets.all(8),
              itemCount: product_name_sell_to_buyer.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => product_details(
                              product_name: product_name_sell_to_buyer[index],
                              product_price: product_price_sell_to_buyer[index],
                              product_quality:
                                  product_quality_sell_to_buyer[index],
                              product_warranty:
                                  product_warranty_sell_to_buyer[index],
                              seller_name: seller_name_sell_to_buyer[index],
                              product_image_link:
                                  product_image_link_sell_to_buyer[index],
                              current_location: current_location_user,
                              lat: lat,
                              long: long,
                            )));
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Image
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12)),
                            child: Image.network(
                              product_image_link_sell_to_buyer[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product_name_sell_to_buyer[index],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Seller: ${seller_name_sell_to_buyer[index]}",
                                style: const TextStyle(fontSize: 12),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Price: \$${product_price_sell_to_buyer[index]}",
                                style: const TextStyle(
                                    color: Colors.green, fontSize: 12),
                              ),
                              Text(
                                "Quality: ${product_quality_sell_to_buyer[index]}",
                                style: const TextStyle(fontSize: 12),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Warranty: ${product_warranty_sell_to_buyer[index]}",
                                style: const TextStyle(fontSize: 12),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> get_all_sellers_data() async {
    product_image_link_sell_to_buyer.clear();
    product_price_sell_to_buyer.clear();
    product_warranty_sell_to_buyer.clear();
    product_quality_sell_to_buyer.clear();
    seller_name_sell_to_buyer.clear();
    product_name_sell_to_buyer.clear();
    product_unique_id.clear();
    seller_id123.clear();

    final getSellersData =
        'https://ecommerce123-alpha.vercel.app/home/buyer/get_all_sellers_data';

    final requestToServer = await http.get(Uri.parse(getSellersData));

    if (requestToServer.statusCode == 200) {
      final List convertToJson = json.decode(requestToServer.body);
      for (var users in convertToJson) {
        seller_id123.add(users['seller_product_id']);
        product_unique_id.add(users['_id']);
        seller_name_sell_to_buyer.add(users['seller_name']);
        product_name_sell_to_buyer.add(users['product_name']);
        product_quality_sell_to_buyer.add(users['product_quality']);
        product_warranty_sell_to_buyer.add(users['product_warranty']);
        product_price_sell_to_buyer.add(users['product_price']);
        product_image_link_sell_to_buyer.add(users['image_url']);
      }
    } else {
      print('Error fetching data.');
    }
  }
}
