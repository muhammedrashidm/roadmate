import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roadmate/app/home/presentation/home_screen.dart';
import 'package:roadmate/app/home/presentation/view_modal.dart';
import 'package:roadmate/app/products/presentation/view_modal.dart';

ValueNotifier<int> _selectedCategory = ValueNotifier(0);

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Featured Products"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            const CupertinoSearchTextField(),
            const SizedBox(
              height: 18,
            ),
            Consumer<HomeViewModal>(
              builder: (BuildContext context, value, Widget? child) {
                return ValueListenableBuilder<int>(
                  builder: (context, v, _) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _selectedCategory.value = 0;
                            },
                            child: Card(
                              color: Colors.white,
                              surfaceTintColor: Colors.white,
                              elevation: v == 0 ? 10 : 0,
                              child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  child:  Center(
                                      child: Text("View all",
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: v == 0 ? Colors.red:Colors.black
                                        ),
                                      ))),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                            scrollDirection:Axis.horizontal,
                              child: Row(
                                  children: List.generate(value.categories.length,
                                      (index) {
                                final item = value.categories[index];
                                final selected = v == index + 1;
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _selectedCategory.value = index + 1;
                                      },
                                      child: Card(
                                        color: Colors.white,
                                        surfaceTintColor: Colors.white,
                                        elevation: selected ? 10 : 0,
                                        child: CategoryWidget(
                                          item: item,
                                          title: false,
                                          size: 60,
                                          selected: selected,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              })
                                    ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  valueListenable: _selectedCategory,
                );
              },
            ),
            const SizedBox(height: 50,),
            Expanded(
              child: Consumer<ProductsViewModal>(
                builder: (BuildContext context, ProductsViewModal value,
                    Widget? child) {
                  return GridView.builder(
                      itemCount: value.products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: .7, crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        final item = value.products[index];
                        return Container(
                          // height: 145,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.all(4),
                          padding: const EdgeInsets.all(6),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                    "https://roadmate.in/admin/public/market/${item.images}"),
                              ),
                              Column(
                                children: [
                                  Text(
                                    item.productName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        item.price.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                decoration:
                                                    TextDecoration.lineThrough),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text("\$${item.offerPrice.toString()}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                      const Spacer(),
                                      const Text("4"),
                                      const Icon(
                                        Icons.star,
                                        size: 12,
                                        color: Color(0xffB7DD29),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
