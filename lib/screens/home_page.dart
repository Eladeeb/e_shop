import 'dart:math';

import 'package:e_shopp/product/product.dart';
import 'package:e_shopp/product/product_category.dart';
import 'package:e_shopp/screens/singe_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'cart_screen.dart';
import 'utlities/screen_utilities.dart';
import 'utlities/size_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:e_shopp/api/helpers_api.dart';
import 'utlities/helpers_widget.dart';
import 'package:e_shopp/product/home_product.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController tabController ;
  PageController _pageController;
  ScreenConfig screenConfig ;
  List<int> a = [];
  bool lastPage = false;
  HelperApi helperApi = HelperApi();
  ValueNotifier<int> dosIndex = ValueNotifier(1);
  int currentIndex =0 ;
  List<ProductCategory> productCategories ;
  HomeProductsBloc homeProductsBloc = HomeProductsBloc();
  @override
  void initState() {
    super.initState();
    _pageController =PageController(
      initialPage: 1 ,
      viewportFraction: .75,
    );

  }


  @override
  void dispose() {
    super.dispose();
    homeProductsBloc.dispose();
    _pageController.dispose();
    tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    screenConfig=ScreenConfig(context);
    return FutureBuilder(
      future: helperApi.fetchCategories(),
      builder:(BuildContext context ,AsyncSnapshot<List<ProductCategory>> snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.none:
            return error("No connection made");
            break;
          case ConnectionState.active :
          case ConnectionState.waiting:
            return loading();
            break ;
          case ConnectionState.done:
            if(snapshot.hasError){
              return error(snapshot.error.toString());
             }else{
              if( !snapshot.hasData){
                return error("No Data Found");
              } else{
                this.productCategories=snapshot.data;
                homeProductsBloc.fetchProducts.add(this.productCategories[0].category_id);
                return _screen(snapshot.data,context);
              }
            }
        }
        return null;
      },
    );
  }
  List<Tab> _tabs(List<ProductCategory> cat) {
    tabController =TabController(
      initialIndex: currentIndex,
      vsync: this,
      length: cat.length ,
    );
    List<Tab> tabs =[];
    for(ProductCategory category in cat)
      {
        tabs.add(
          Tab(text: category.category_name
          ),
        );
      }
    return tabs ;
  }
  List<Product> _randomTopProducts(List<Product> products){
    List<int> indexes =[];
    Random random =Random();
    int counter ;
    List<Product> newProducts=[];
    if(products.length < 5)
      {
        counter =products.length ;
      }else{
      counter = 5 ;
    }
    do{
      int rnd = random.nextInt(products.length);
      if( !indexes.contains(rnd)){
        indexes.add(rnd);
        counter-- ;
      }
    }while(counter != 0);
    for(int index in indexes)
      {
        newProducts.add(products[index]);
      }
    return newProducts ;
  }
  Widget _drawProducts(List<Product> products,BuildContext context) {
    List<Product> topProducts = _randomTopProducts(products);
    return Container(
      child: Column(
          children: <Widget>[
               SizedBox(
                height: MediaQuery.of(context).size.height*.3,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: topProducts.length,
                    onPageChanged: (int index){
                    dosIndex.value = index;
                    },
                    itemBuilder: (context,position){
                    return InkWell(
                      onTap: (){
                        _gotoSingleProduct(topProducts[position]);
                      },
                      child: Card(
                        margin: EdgeInsets.only(left: 4,right: 4,top: 2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        clipBehavior: Clip.hardEdge,
                        child: Container(
                            child: Image(
                              loadingBuilder: (context,image,ImageChunkEvent loadingProgress){
                                if(loadingProgress == null){
                                  return image ;
                                }
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              fit: BoxFit.cover,
                              image: NetworkImage(topProducts[position].featuredImage()),
                            ),
                          ),
                      ),
                    );
                    }


                ),
              ),
            ValueListenableBuilder(
              valueListenable: dosIndex,
              builder: (context,value,_){
                return Container(
                  padding: EdgeInsets.only(top:16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _drawDots(topProducts.length, value),
                  ),
                );
              },
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    crossAxisCount: 2,
                    childAspectRatio: .5,
                  ),
                 itemBuilder: (context ,position){
                    return InkWell(
                      onTap: (){
                        _gotoSingleProduct(products[position]);
                      },
                      child: Container (
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                clipBehavior: Clip.hardEdge,
                                child: Image(
                                  loadingBuilder: (context,image,ImageChunkEvent loadingProgress){
                                    if(loadingProgress == null){
                                      return image ;
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  image: NetworkImage(
                                    products[position].featuredImage()
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              height: MediaQuery.of(context).size.height*.25,
                            ),
                            SizedBox(
                              height: 10,

                            ),
                            Text(products[position].product_title ,style: Theme.of(context).textTheme.headline,
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Text('\$ ${products[position].product_price.toString()}',style: Theme.of(context).textTheme.subhead,
                              textAlign: TextAlign.center,
                            ),

                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),


          ],
        ),


    );
  }
  List<Widget> _drawDots(int qty,int index){
    List<Widget> widgets =[];
    for(int i =0 ;i<qty;i++)
    {
      widgets.add(
       Container(
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(5),
           color: (i == index)?
               ScreenUtilities.mainBlue :
               ScreenUtilities.lightGrey ,
         ),
         width: 10,
         height: 10,
         margin: (i == qty )?
         EdgeInsets.only(right: 0):
         EdgeInsets.only(right: 10),
       ),
      );
    }
    return widgets ;
  }

  Widget _screen(List<ProductCategory> cat,BuildContext context){
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('My Name'),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
              ),
            ),
            ListTile(
              title: Text('Cart'),
              leading: Icon(Icons.card_travel),
              trailing:Icon(Icons.arrow_forward) ,
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home',style:TextStyle(
          fontSize: 28,
          color: ScreenUtilities.textColor,
          fontFamily: 'QuicKsand',
          fontWeight: FontWeight.w700,
        ),

        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Icon(
                FontAwesomeIcons.search,
              ),
              onPressed: (){

              },
            ),
          ),
        ],
        bottom: TabBar(
          indicatorWeight: 3,
          indicatorColor: ScreenUtilities.mainBlue,
          indicatorPadding: EdgeInsets.only(bottom: 10),
          tabs: _tabs(cat),
          isScrollable: true,
          controller: tabController,
          onTap: (int index){
            homeProductsBloc.fetchProducts.add(this.productCategories[index].category_id) ;
          },



        ),

      ),
      body: Container(
          child: StreamBuilder(
            stream: homeProductsBloc.productStream ,
            builder: (BuildContext context,AsyncSnapshot<List<Product>> snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.none:
                  return error("No connection made");
                  break;
                case ConnectionState.waiting:
                  return loading();
                  break ;
                case ConnectionState.done:
                case ConnectionState.active :
                  if(snapshot.hasError){
                    return error(snapshot.error.toString());
                  }else{
                    if( !snapshot.hasData){
                      return error("No Data Found");
                    } else{
                      return _drawProducts(snapshot.data,context);
                    }
                  }
              }
              return null;
            },
          ),
        ),
    );

  }
  void _gotoSingleProduct(Product product){
    Navigator.push(context,
    MaterialPageRoute(
      builder: (context){
        return SingleProduct(product);
      }
    ),
    );
  }
}
