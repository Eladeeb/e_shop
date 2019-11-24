import 'package:e_shopp/api/cart_api.dart';
import 'package:e_shopp/cart/cart.dart';
import 'package:e_shopp/screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_shopp/product/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utlities/screen_utilities.dart';

class SingleProduct extends StatefulWidget {
  final Product product ;

  SingleProduct(this.product);

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> with TickerProviderStateMixin {
  CartApi cartApi = CartApi();
  List<Tab> tabs = List();
  PageController _pageController;
  TabController tabController ;
  ValueNotifier<int> dosIndex = ValueNotifier(0);
  int currentIndex =0 ;
  bool _addingToCart =false;

  @override
  void initState() {
    super.initState();
    tabController =TabController(
      initialIndex: 0,
      vsync: this,
      length: 3 ,
    );
    _pageController =PageController(
      initialPage: 0 ,
      viewportFraction: .75,
    );

  }


  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _drawScreen(),
      appBar: AppBar(
        title: Text("Product Details"),
      ),
      floatingActionButton: FloatingActionButton(
        child: (_addingToCart)? CircularProgressIndicator() : Icon(Icons.add_shopping_cart),
        onPressed: ()async{
          SharedPreferences pref = await SharedPreferences.getInstance();
          int userId =pref.getInt('user_id');
          if(userId == null){
            Navigator.push(context,
                MaterialPageRoute(
                  builder: (context)=>LoginScreen()
                )
            );
          }else{
            setState(() {
              _addingToCart =true;
            });
            await cartApi.addProductToCart(widget.product.product_id);
            setState(() {
              _addingToCart =false;
            });
          }
        },
      ),

    );
  }

  Widget _drawScreen() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height*.3,
              child: _drawImageGallery(),
          ),
          SizedBox( height:  10 ,),
          ValueListenableBuilder(
            valueListenable: dosIndex,
            builder: (context,value,_){
              return Container(
                padding: EdgeInsets.only(top:16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _drawDots(widget.product.images.length, value),
                ),
              );
            },
          ),
          _drawTitle(),
          new TabBar(
            indicatorWeight: 3,
            indicatorColor: ScreenUtilities.mainBlue,
            controller: tabController,
            indicatorPadding: EdgeInsets.only(bottom: 10),
            tabs: <Widget>[
              Tab(text:'Description',),
              Tab(text:'Specification'),
              Tab(text:'More Info'),

            ],
            onTap: (int index){
              setState(() {
                currentIndex = index ;
                print(currentIndex);
              });
            },
          ),
          _drawDetails(),
        ],
      ),
    );
  }

  Widget _drawImageGallery() {
    return PageView.builder(
      onPageChanged: (int index){
        dosIndex.value = index;
      },
      itemCount: widget.product.images.length,
      itemBuilder: (context,position){
      return Padding(
        padding: const EdgeInsets.all(1.0),
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
                widget.product.images[position],
            ),
            fit: BoxFit.cover,
          ),
        ),
      );
    });
  }

  Widget _drawTitle() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  Text(widget.product.product_name ,style: Theme.of(context).textTheme.title),
                  Text("from "+widget.product.productCategory.category_name+" category ",style: Theme.of(context).textTheme.title),
                ],
            ),
            Column(
              children: <Widget>[
                Text('\$ ${widget.product.product_price.toString()}'),
                (widget.product.product_discount>0)?Text(_calculateDiscount()):Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _drawDetails() {
    if(currentIndex == 0)
      {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Text(widget.product.product_description,style: TextStyle(
              fontSize: 20,

            ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }else if(currentIndex == 1){
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Text(widget.product.product_specifications,style: TextStyle(
            fontSize: 17,
            fontFamily: "QuickSand",
            fontWeight: FontWeight.w700,
            color: Colors.grey.shade900,
            letterSpacing: 1.5,
              height: 1.5,

          ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    else if (currentIndex == 2){
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Text(widget.product.product_info,style: TextStyle(
              fontSize: 17,
              fontFamily: "QuickSand",
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade900,
              letterSpacing: 1.5,
              height: 1.5,


          ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }else {
      return Text("NoThing",style: TextStyle(
          fontSize: 17,
          fontFamily: "QuickSand",
          fontWeight: FontWeight.w700,
          color: Colors.grey.shade900,
          letterSpacing: 1.5,
        height: 1.5,


      ),
        textAlign: TextAlign.center,
      );
    }

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

  String _calculateDiscount() {
    double dis = widget.product.product_discount ;
    double p = widget.product.product_price;
    return (dis*p).toString();
  }
  void addProductToCart(){

  }
}
