import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/colors.dart';
import 'package:flutter_deer/util/toast_utils.dart';

class PersionCard  extends StatefulWidget {
  const PersionCard({Key? key,}) : super(key: key);

  @override
  _PersionCard createState() => _PersionCard();

}

class _PersionCard extends State<PersionCard>{

  List<Widget>? _topList;
  int _topListIndex =  2 ;


  void _handleTopListClick(int i) {
    this.setState(() {
      _topListIndex = i;
    });
    Toast.show("点击了${_topListIndex}");
    print("点击头像key：${i} 点击之后的_topListIndex ：$_topListIndex");
  }


  List<Widget>? _ContainerItem() {
    if(_topList == null){
      const _topListColumn = [
        {
          "image": 'https://gw.alicdn.com/tfscom/tuitui/O1CN01fTLmgB1llvRYfb6lG_!!0-rate.jpg',
          "title": "妈妈"
        },
        {
          "image": 'https://gw.alicdn.com/tfscom/tuitui/O1CN01fTLmgB1llvRYfb6lG_!!0-rate.jpg',
          "title": "爸爸"
        },
        {
          "image": 'https://gw2.alicdn.com/tfscom/tuitui/O1CN01T3iTQZ1tNCzU4kp0a_!!0-rate.jpg',
          "title": "姐姐"
        },
        {
          "image": 'https://gw1.alicdn.com/tfscom/tuitui/TB28FwAjFkoBKNjSZFEXXbrEVXa_!!0-rate.jpg',
          "title": "妹妹"
        }
      ];

      _topList = List.generate(_topListColumn.length, (i) {
        return GestureDetector(
          onTap: ()=>_handleTopListClick(i),
          child: Padding(padding: EdgeInsets.only(left: 15),child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: i == _topListIndex ? 36 : 32,
                height:  i == _topListIndex ? 36 : 32,
                decoration: BoxDecoration(
                    border: Border.all(color: Colours.app_main,width: i == _topListIndex ? 2 : 0),
                    borderRadius: BorderRadius.circular(42)
                ),
                child: ClipOval(
                  child: Image.network(_topListColumn[i]["image"] ?? ''),
                ),
              ),
              Text(_topListColumn[i]["title"] ?? '', style: TextStyle(
                  fontWeight:  i == _topListIndex ? FontWeight.w600 : FontWeight.w400,
                  fontSize:  i == _topListIndex ? 12 : 10,
                  color:  i == _topListIndex ? Colors.black : Colors.grey
              ),),
            ],
          )
          ),
        );
      });
    }
    return _topList;
  }




  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: _ContainerItem() ?? [] ,
    );
  }

}
