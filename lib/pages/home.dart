import 'package:flutter/material.dart';
import 'tashkhis.dart';
import 'motarjem.dart';
import 'package:binarytranslate/style/style.dart';



class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: DefaultTabController(length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text('مترجم انلاین',style: TextStyle(color: Colors.white),),
              actions: [
                IconButton(onPressed: (){},icon: Icon(Icons.more_vert,color: Colors.white,),),
              ],
              leading: Builder(builder: (BuildContext context){
                return IconButton(onPressed: (){
                  Scaffold.of(context).openDrawer();
                }, icon:  Icon(Icons.menu,color: Colors.white,));
              },),bottom: TabBar(
              labelStyle: TextStyle(color: Colors.white),
              labelColor: Colors.white,

              tabs: [
                Tab(child:Text('مترجم متن',style: TextStyle(color: Colors.white),),icon: Icon(Icons.home,color: Colors.white,),),
                Tab(child:Text('تشخیص کلمات',style: TextStyle(color: Colors.white),),icon: Icon(Icons.visibility,color: Colors.white,),),
              ],),
            ),
            body: TabBarView(children: [
              motarjem(),tashkhis(),
            ]),
            drawer: Drawer(
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(accountName: Text('مترجم انلاین'), accountEmail: Text(''),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage("assets/logo.jpg"),
                      backgroundColor: Colors.blue,
                    ),
                  ),
                  InkWell(onTap: (){},
                    child: ListTile(title: Text('سایر برنامه ها',style: tabe_style),
                      leading: Icon(Icons.app_shortcut_sharp),
                    ),
                  ),
                  InkWell(onTap: (){},
                    child: ListTile(title: Text('ثبت نظر',style: tabe_style,),
                      leading: Icon(Icons.star_rate),
                    ),
                  ),
                  InkWell(onTap: (){},
                    child: ListTile(title: Text('اشتراک گذاری',style: tabe_style,),
                      leading: Icon(Icons.share),
                    ),
                  ),
                  InkWell(onTap: (){},
                    child: ListTile(title: Text('خروج از برنامه',style: tabe_style,),
                      leading: Icon(Icons.exit_to_app),
                    ),
                  ),
                  InkWell(onTap: (){},
                    child: ListTile(title: Text('درباره ما',style: tabe_style,),
                      leading: Icon(Icons.info),
                    ),
                  ),
                ],
              ),
            ),

          ),
        ),
      ),
    );
  }
}
