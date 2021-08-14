import 'package:flutter/material.dart';

class GetStarted extends StatefulWidget {

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {

  @override
  Widget build(BuildContext context) {
    // MediaQueryData mediaQueryData = MediaQuery.of(context);
    // double screenWidth = mediaQueryData.size.width;
    // double screenHeight = mediaQueryData.size.height;
    // double blockSizeHorizontal = screenWidth / 100;
    // double blockSizeVertical = screenHeight / 100;
    return Scaffold(
      body: Stack(

        children: [
          AnimatedContainer(
            curve: Curves.easeIn,
            duration: Duration(milliseconds: 400),
            color: Colors.orange[100],
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
            Container(

            child: Column(
            children: [
                GestureDetector(
                onTap: (){
          setState(() {
          });
          },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: AnimatedContainer(
                margin: EdgeInsets.only(top: 150),
                duration: Duration(milliseconds: 400),
                curve: Curves.easeIn,
                child: Center(child: Column(
                  children: [
                    Text("Hey There!",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                    Text("Order Fruits Online!",style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),)
                  ],
                )),

              ),
            ),
          ),
        ],

      ),
      ),
      Container(
      padding: EdgeInsets.all(70),
      child: AnimatedImage()
      )]))]),
    );
  }
}
class AnimatedImage extends StatefulWidget {
  @override
  _AnimatedImageState createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this,
      duration: const Duration(seconds: 3))..repeat(reverse: true);
  late Animation<Offset> _animation= Tween(
      begin: Offset.zero,
      end: Offset(0,0.1)
  ).animate(_controller);



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _animation,
      child: Image.asset("lib/img.png"),);
  }
}
