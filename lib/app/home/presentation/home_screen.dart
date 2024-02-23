import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roadmate/app/home/data/repository/repository.dart';
import 'package:roadmate/app/home/domain/entities/category.dart';
import 'package:roadmate/app/home/presentation/view_modal.dart';
import 'package:roadmate/app/products/presentation/page_products.dart';
import 'package:roadmate/app/products/presentation/view_modal.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    context.read<HomeViewModal>().getCategories();
    context.read<ProductsViewModal>().getHomeProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Good morning!"),
      // backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      floatingActionButton:  Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: GestureDetector(onTap: (){
          //
          // showModalBottomSheet(context: context, builder: (ctx){
          //   return const ProductsPage();
          // }
          //
          // );
          Navigator.push(context, CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context)=>const ProductsPage()));
        },
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 37,
            child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 33,
              child: Icon(
                Icons.shopping_bag,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer<HomeViewModal>(builder: (context, consumer, _) {
          if (consumer.categories.isEmpty) {
            return const Center(child: CupertinoActivityIndicator());
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Row(
                  children: [
                    Expanded(
                        child: ActionItem(
                      title: 'Booking',
                      actionString: 'View Booking',
                      titleIcon: Icons.arrow_forward_ios,
                      actionIcon: Icons.calendar_month,
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: ActionItem(
                      title: 'Offers',
                      actionString: 'Add/view offers',
                      titleIcon: Icons.arrow_forward_ios,
                      actionIcon: Icons.percent,
                    )),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  height: 115,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Product categories",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(3, (index) {
                          final item = consumer.categories[index];
                          return Column(
                            children: [
                              CategoryWidget(item: item, size: 85,),
                            ],
                          );
                        })
                          ..add(Container(
                              height: 85,
                              width: 85,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child:  TextButton(onPressed: () {
                                Navigator.push(context, CupertinoPageRoute(

                                    builder: (context)=>const ProductsPage()));
                              },
                              child: Text("View all")))),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Featured Products"),
                    TextButton(onPressed: () {
                      Navigator.push(context, CupertinoPageRoute(
                          fullscreenDialog: true,
                          builder: (context)=>const ProductsPage()));
                    }, child: const Text("View All"))
                  ],
                ),
                Expanded(
                  // height: 400,
                  child: Consumer<ProductsViewModal>(
                    builder: (BuildContext context, ProductsViewModal value,
                        Widget? child) {
                      return GridView.builder(
                          itemCount: value.products.length >= 6
                              ? 6
                              : value.products.length,
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
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                              "\$${item.offerPrice.toString()}",
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
                )
              ],
            ),
          );
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        backgroundColor: Colors.white,
        onTap: (i) {
          if (i == 2) return;
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.miscellaneous_services_sharp),
              label: 'Services'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.miscellaneous_services_sharp,
                color: Colors.transparent,
              ),
              label: 'Products'),
          BottomNavigationBarItem(
              icon: Icon(Icons.miscellaneous_services_sharp), label: 'Market'),
          BottomNavigationBarItem(
              icon: Icon(Icons.miscellaneous_services_sharp), label: 'My Shop'),
        ],
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.item,  this.title=true, required this.size,  this.selected=false,
  });
final bool title;
  final Category item;
  final double size;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
        padding: const EdgeInsets.all(12),
        height: size,
        width: size,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "https://roadmate.in/admin/public/market/${item.image}",
              height: 30,
              color: selected ? Colors.red:Colors.black,
            ),
            if(title)
            Text(
              item.categoryName,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        )));
  }
}

AppBar buildAppBar(BuildContext context, String title) {
  return AppBar(
    elevation: 0,
    backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
    title: Text(title, style: Theme.of(context).textTheme.headlineLarge),
    actions: [
      IconButton(
          onPressed: () {}, icon: const Icon(Icons.notifications_active)),
      IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart))
    ],
  );
}

class ActionItem extends StatelessWidget {
  const ActionItem({
    super.key,
    required this.title,
    required this.actionString,
    required this.titleIcon,
    required this.actionIcon,
  });
  final String title;
  final String actionString;
  final IconData titleIcon;
  final IconData actionIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      height: 130,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              CircleAvatar(
                  radius: 10,
                  backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
                  child: Icon(
                    titleIcon,
                    size: 14,
                  ))
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Icon(
                actionIcon,
                size: 36,
              ),
              Flexible(
                child: Text(
                  actionString,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
