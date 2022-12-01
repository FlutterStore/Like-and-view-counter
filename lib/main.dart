import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:like_button/like_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

RxList viewcountlist=[].obs;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    countlike();
    super.initState();
  }

  countlike(){
    if(viewcountlist.isEmpty)
    {
      for(int i=0; i<=10; i++)
      {
        viewcountlist.add(99);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Like and View Counter",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25,left: 20,right: 20),
        child: Column(
          children: [
            Expanded(
              child: AnimationLimiter(
                child: ListView.builder(
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  itemCount: viewcountlist.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 2000),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(bottom: 20),
                                width: MediaQuery.of(context).size.width/1.2,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(35)
                                ),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context, CupertinoPageRoute(builder: (context) => View(img: 'assets/images/pic.png', ind: index,)),);
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width/1.2,
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30)
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: const Image(image: AssetImage('assets/images/pic.png',))
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: ()async{
                                          },
                                          child: CircleAvatar(
                                            radius: 22,
                                            backgroundColor: Colors.white,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                LikeButton(
                                                  padding: const EdgeInsets.only(right: 2),
                                                  size: 15,
                                                  circleColor: const CircleColor(start: Colors.red, end: Colors.red,),
                                                  bubblesColor: const BubblesColor(
                                                    dotPrimaryColor: Colors.red,
                                                    dotSecondaryColor: Colors.red,
                                                  ),
                                                  likeBuilder: (bool isLiked) {
                                                    return Icon(
                                                      isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                                      color: isLiked ? Colors.red : Colors.black,
                                                      size: 18,
                                                    );
                                                  },
                                                  likeCount: 99,
                                                  likeCountPadding: EdgeInsets.only(left: 5, top: 3),
                                                  likeCountAnimationType: LikeCountAnimationType.all,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  countBuilder: (likeCount, isLiked, text) {
                                                    var color = isLiked ? Colors.red : Colors.black;
                                                    Widget result;
                                                    if (likeCount == 0) {
                                                      result = Text(
                                                        text,
                                                        style: TextStyle(color: color, fontSize: 10),
                                                      );
                                                    } else {
                                                      result = Text(
                                                        text,
                                                        style: TextStyle(color: color, fontSize: 10),
                                                      );
                                                    }
                                                    return result;
                                                  },
                                                ),
                                              ],
                                            ),
                                          )
                                        ),
                                        Obx(()=> InkWell(
                                          child: CircleAvatar(
                                            radius: 22,
                                            backgroundColor: Colors.white,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                const FaIcon(FontAwesomeIcons.eye,size: 15,color: Colors.black),
                                                SizedBox(width: 5,),
                                                Text(
                                                  viewcountlist[index].toString(),
                                                  style: const TextStyle(color: Colors.black, fontSize: 10),
                                                ),
                                              ],
                                            ),
                                          )
                                        )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20,)
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class View extends StatefulWidget {
  String img;
  int ind;
  View({Key? key,required this.img, required this.ind}) : super(key: key);

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      int c=0;
      for (int element in viewcountlist) { 
        if(c==widget.ind)
        {
          element=element+1;
          viewcountlist.replaceRange(c, c+1, [element]);
        }
        c++;
      }
    });
    super.initState();
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Like and View Counter",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InteractiveViewer(
                    maxScale: 4.0,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(image: AssetImage(widget.img,))
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}