import 'package:flutter/material.dart';
import 'package:morimori/pages/EventMakingPage.dart';
import 'package:morimori/pages/LoginPage.dart';
import 'package:morimori/pages/SearchingScreen.dart';
import 'package:morimori/pages/email_nickname_screen.dart';
import 'package:morimori/pages/terms_screen.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../ui/features/widgets/custom/need_login_dialog.dart';
import 'EventHostPage.dart';
import 'EventPage.dart';
import 'ProfilePage.dart';
import 'SettingPage.dart';
import 'package:http/http.dart' as http;



class MainPage extends StatefulWidget{
  const MainPage({Key? key}) : super(key: key);
  @override
  MainPageHome createState() => MainPageHome();
}


class MainPageHome extends State<MainPage> with TickerProviderStateMixin{
  static final GlobalKey<ScaffoldState> mainPageGlobalKey = GlobalKey();
  final PageController pageController = PageController(initialPage: 1);
  late final TabController tabController;
  var TextEditController = TextEditingController();


  var sampleImageText = List.filled(0, '0', growable: true);
  var sampleTitleText = List.filled(0, '0', growable: true);
  var sampleDays = List.filled(0,'0',growable: true);
  var tagData = List.filled(0,'0', growable: true);
  var tagData2 = List.filled(0,'0', growable: true);







  @override
  void initState(){
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    sampleImageText.add('assets/1.png');
    sampleImageText.add('assets/2.png');
    sampleImageText.add('assets/3.png');
    sampleImageText.add('assets/4.png');
    sampleImageText.add('assets/112726025_p0.png');
    sampleImageText.add('assets/112909957_p0.png');
    sampleImageText.add('assets/113495932_p0.png');
    sampleImageText.add('assets/113719302_p0.png');


    sampleTitleText.add('겨울 일러스트 대회');
    sampleTitleText.add('야경 & 시티팝');
    sampleTitleText.add('학교 & 청춘 & 여름 대회');
    sampleTitleText.add('green and pink');
    sampleTitleText.add('punch punch');
    sampleTitleText.add('blue stone');
    sampleTitleText.add('Gourmet research');
    sampleTitleText.add('friend who fell');

    sampleDays.add('24');
    sampleDays.add('30');
    sampleDays.add('2');
    sampleDays.add('14');
    sampleDays.add('7');
    sampleDays.add('6');
    sampleDays.add('3');
    sampleDays.add('36');

    tagData.add('겨울');
    tagData.add('시티팝');
    tagData.add('청춘');
    tagData.add('엑');
    tagData.add('ㅋ');
    tagData.add('ㅋ');
    tagData.add('ㅋ');
    tagData.add('ㅋ');
    tagData.add('ㅋ');
    tagData.add('ㅋ');

    tagData2.add('눈');
    tagData2.add('포장마차');
    tagData2.add('청춘');
    tagData2.add('눈');
    tagData2.add('눈');
    tagData2.add('눈');
    tagData2.add('눈');
    tagData2.add('눈');
    tagData2.add('눈');
    tagData2.add('눈');






  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: mainPageGlobalKey,
      drawer: MenuDrawer(context),
      body: NestedScrollView(
    floatHeaderSlivers: true,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
      return <Widget>[
        SliverAppBar(
          leading: GestureDetector(
            onTap: (){
              mainPageGlobalKey.currentState!.openDrawer();
            },
            child: const Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Icon(Icons.menu),
            ),
          ),
          centerTitle: true,
          title: Image.asset(
              'assets/morilogo.png',
            width: 60,
          ),
          backgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchingScreen()));
              }, icon: const Icon(Icons.search)),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: Material(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.black,
              child: Theme(
                //<-- SEE HERE
                data: ThemeData().copyWith(splashColor: Colors.grey),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  // indicator: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(20), // Creates border
                  //     color: Colors.greenAccent),
                  controller: tabController,
                  //이것같음.
                  tabs: const [
                    Tab(
                        child: Text("Open",
                            style: TextStyle(color: Colors.grey))),
                    Tab(
                        child: Text("Upcoming",
                            style: TextStyle(color: Colors.grey))),
                    Tab(
                        child: Text("Past",
                            style: TextStyle(color: Colors.grey))),

                  ],
                ),
              ),
            ),
          ),
        ),
      ];
      }, body: TabBarView(

    controller: tabController,

    children: <Widget>
    [
      SizedBox(
        height: MediaQuery.of(context).size.height - 60,
        child: RefreshIndicator(child: listViewer(sampleImageText,sampleTitleText,sampleDays,tagData,tagData2), onRefresh: () async{

        }),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height - 60,
        child: RefreshIndicator(child: listViewer(sampleImageText,sampleTitleText,sampleDays,tagData,tagData2), onRefresh: () async{

        }),
      ),

      SizedBox(
        height: MediaQuery.of(context).size.height - 60,
        child: RefreshIndicator(child: listViewer(sampleImageText,sampleTitleText,sampleDays,tagData,tagData2), onRefresh: () async{

        }),
      ),
    ],
      )
      ),

    //   floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    //   floatingActionButton: FloatingActionButton(
    // backgroundColor: Colors.blue,
    // onPressed: () {
    //   Provider.of<UserModel>(context, listen: false).printData();
    //   var userAddress = Provider.of<UserModel>(context, listen: false).address;
    //   print('userAddress : $userAddress');
    //   if (userAddress == null) {
    //     showHackathonLoginDialog(context);
    //   } else {
    //     Navigator.push(context, MaterialPageRoute(builder: (context) => const EventMakingPage()));
    //   }
    // },
    // child: const Icon(
    //   Icons.add,
    // ),
    //   ),
    );
  }
}


Widget MenuDrawer(BuildContext context){
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        ///프로필
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: UserAccountsDrawerHeader(
            //Drawer 헤드부분 생성 후 설정부분

            currentAccountPicture: Row(

              children: <Widget>[

                GestureDetector(
                  onTap: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context) =>ProfilePage()));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(180),
                    child:  Image.asset('assets/113495932_p0.png'),
                  ),

                ),


              ],
            ),




            accountName: Text('hello'),
            accountEmail: Text('@helloMail'),
            // onDetailsPressed: () {
            //   print('arrow is clicked');
            // },
            // 지금 Drawer 헤드부분 안에 있으니 -> 헤드부분 디자인 변경
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff8AEBF2), Color(0xff9887FE)]),
              borderRadius: BorderRadius.only(
                //borderRadius -> 모서리 디자인 변경
                  bottomLeft: Radius.circular(16.0),
                  //Radius.circular -> 모서리 둥글게
                  bottomRight: Radius.circular(16.0)),
            ),
          ),
        ),
        ///프로필 버튼
        ListTile(
          leading: Icon(
            Icons.account_circle_outlined,
          ),
          title: const Text('Profile'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>ProfilePage()));
          },
        ),
        ///설정 버튼
        ListTile(
          leading: Icon(
           Icons.settings
          ),
          title: const Text('setting'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingPage()));
          },
        ),
      ],
    ),
  );

}



Future<String> postUserRegister(String address) async {
  http.Response response = await http.get(
    Uri.parse('https://nftmori.shop/api/users/$address'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    },
  );
  //print(response.body);
  return response.body;
}

TabBar get _tabBar => const TabBar(
  tabs: [
    Tab(icon: Icon(Icons.flight)),
    Tab(icon: Icon(Icons.directions_transit)),
    Tab(icon: Icon(Icons.directions_car)),
  ],
);


Widget listViewer(sampleImageText,sampleTitleText, sampleDays,tagData, tagData2){
  return ListView.separated(
    scrollDirection: Axis.vertical,

    //shrinkWrap: true,
    padding: const EdgeInsets.all(2.0),
    itemCount: sampleImageText.length,
    itemBuilder: (BuildContext context, int index){
      var widths = MediaQuery.of(context).size.width;
      var heights = MediaQuery.of(context).size.height;

      return GestureDetector(
          onTap: () {

            if(index == 0 ){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const EventHostPage()));
            }else{
              Navigator.push(context, MaterialPageRoute(builder: (context) => const EventPage()));
            }

          },
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            child:  Padding(
              padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[




                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[


                      Text(sampleTitleText[index],style: const TextStyle(fontSize: 30), overflow: TextOverflow.ellipsis,),
                      //여기다가



                      SizedBox(
                        //width: widths - 300,
                      ),
                      Text('${sampleDays[index]} days left'),
                      //=> 시간 들어가는 부분(영국 표준 협정시 기준으로 로직을 계산해서 넣을것)
                    ],
                  ),







                  //서버에서 받아온 내용에서, 사진이 없으면, 따로 쳐내는 코드 넣을것.

                  Container(),

                  Padding(padding:  const EdgeInsets.all(5.0),

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(sampleImageText[index]),
                    ),

                  ),





                  Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[


                      Row(children: <Widget>[



                        Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(
                                    color: Colors.black87.withOpacity(0.5),
                                    width: 1)
                            ),
                            elevation: 0,
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                                child:
                                Text('#${tagData[index]}',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12
                                    ))

                            )
                        ),

                        Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(
                                    color: Colors.black87.withOpacity(0.5),
                                    width: 1)
                            ),
                            elevation: 0,
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                                child:
                                Text('#${tagData2[index]}',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12
                                    ))

                            )
                        ),


                      ],
                      ),


                      Card(
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(
                                  color: Colors.black87.withOpacity(0.5),
                                  width: 1)
                          ),
                          elevation: 0,
                          child: const Padding(
                              padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                              child:
                              Text('Apply',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12
                                  ))

                          )
                      ),








                    ],

                  ),

                ],
              ),
            ),
          )
      );



    },
    separatorBuilder: (BuildContext context, int index) {
      return Container();
    },


  );
}