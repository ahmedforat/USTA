import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TravelDiary extends StatefulWidget {
  @override
  TravelDiaryState createState() => TravelDiaryState();
}

class TravelDiaryState extends State<TravelDiary> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    new Text(
                      'TravelsGuide',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).orientation.toString() ==
                          'Orientation.portrait'
                          ? 120.0
                          : 480.0,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.notifications,
                        size: 28.0,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        debugPrint(
                            MediaQuery.of(context).orientation.toString());
                      },
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(35),
                        image: DecorationImage(
                            image: AssetImage('images/karrar.jpg.jpg'),
                            fit: BoxFit.fill),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.send,
                      size: 35.0,
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Turkey Trip 2019',
                          style: TextStyle(
                              fontSize: 19.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.withOpacity(0.9)),
                        ),
                        Text(
                          'Add an update',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.9)),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 130.0,
                    ),
                    Icon(FontAwesomeIcons.plane)
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'From the Community',
                    style: TextStyle(
                        color: Colors.grey.withOpacity(0.99),
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10.0),
                    child: IconButton(
                      iconSize: 90.0,
                      alignment: Alignment.centerRight,
                      icon: Text(
                        'View All',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 6.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(35),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://www.almrsal.com/wp-content/uploads/2017/01/%D8%B9%D8%A7%D9%84%D9%85-%D8%A7%D9%84%D8%B3%D8%B9%D9%88%D8%AF%D9%8A%D8%A9-%D9%84%D9%84%D8%B3%D9%8A%D8%A7%D8%AD%D8%A9.jpg'),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Text(
                    '  زهرة القنديل',
                    style: TextStyle(fontSize: 20.0),
                  )
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 250,
                    width: 260,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0)),
                        image: DecorationImage(
                            image: NetworkImage(
                                'http://walidtour.com.tr/uploads/images/offers/121155_vacation.jpg'),
                            fit: BoxFit.fill)),
                  ),
                  SizedBox(
                    width: 3.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 125,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.0)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://securecdn.pymnts.com/wp-content/uploads/2018/05/family-vaca.jpg'),
                                fit: BoxFit.fill)),
                      ),
                      Container(
                        height: 125,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10.0)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://static.independent.co.uk/s3fs-public/thumbnails/image/2015/06/15/11/Children%20on%20beach.jpg?w968h681'),
                                fit: BoxFit.fill)),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 18.0,
              ),
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Group Rafting',
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      Text('Turkey-Antalya',
                          style: TextStyle(color: Colors.grey, fontSize: 14.0))
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).orientation.toString() ==
                        'Orientation.portrait'
                        ? 120.0
                        : 480.0,
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.thumbsUp),
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.comment),
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.bookmark),
                    onPressed: () {},
                  )
                ],
              ),
              SizedBox(
                height: 40.0,
              ),
              Divider(
                color: Colors.blueAccent,
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 6.0,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(35),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              'https://www.google.com/url?sa=i&source=images&cd=&cad=rja&uact=8&ved=2ahUKEwj0lobOuvLhAhXMDOwKHdpvAWIQjRx6BAgBEAU&url=%2Furl%3Fsa%3Di%26source%3Dimages%26cd%3D%26ved%3D%26url%3Dhttps%253A%252F%252Fwww.facebook.com%252F%2525D8%2525B4%2525D8%2525B1%2525D9%252583%2525D8%2525A9-%2525D8%2525A7%2525D9%252584%2525D8%2525A8%2525D9%252584%2525D8%2525AF-%2525D8%2525A7%2525D9%252584%2525D8%2525A7%2525D9%252585%2525D9%25258A%2525D9%252586-%2525D9%252584%2525D9%252584%2525D8%2525B3%2525D9%25258A%2525D8%2525A7%2525D8%2525AD%2525D8%2525A9-%2525D9%252588%2525D8%2525A7%2525D9%252584%2525D8%2525B3%2525D9%252581%2525D8%2525B1-%2525D9%252588%2525D8%2525A7%2525D9%252584%2525D8%2525AD%2525D8%2525AC-%2525D9%252588%2525D8%2525A7%2525D9%252584%2525D8%2525B9%2525D9%252585%2525D8%2525B1%2525D8%2525A9-%2525D9%252581%2525D8%2525B1%2525D8%2525B9-%2525D8%2525B5%2525D9%252588%2525D9%25258A%2525D9%252584%2525D8%2525AD-1121489714542627%252Fposts%26psig%3DAOvVaw2y2SyVpWWyV7Go_PlY-xdD%26ust%3D1556529052751231&psig=AOvVaw2y2SyVpWWyV7Go_PlY-xdD&ust=1556529052751231')),
                    ),
                  ),
                  Text(
                    '  البلد الامين للسياحة والسفر',
                    style: TextStyle(fontSize: 20.0),
                  )
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 250,
                    width: 260,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0)),
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://image.cnbcfm.com/api/v1/image/105869785-1556133344112woman-in-summer-fashion-on-vacation_t20_x68ldx.jpg?v=1556133579&w=1400&h=950'),
                            fit: BoxFit.fill)),
                  ),
                  SizedBox(
                    width: 3.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 125,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.0)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGAdvl20krF5NzVCPpR-NdcK_89EYP6TjTyNZCC1riWmm_ss6HqQ'),
                                fit: BoxFit.fill)),
                      ),
                      Container(
                        height: 125,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10.0)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1DysaZeoanz4p6DOvsbgQwz7HVUm1Bd93hhmr4-PCSrNjbh4m8A'),
                                fit: BoxFit.fill)),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 18.0,
              ),
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Group Rafting',
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      Text('Turkey-Antalya',
                          style: TextStyle(color: Colors.grey, fontSize: 14.0))
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).orientation.toString() ==
                        'Orientation.portrait'
                        ? 120.0
                        : 480.0,
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.thumbsUp),
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.comment),
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.bookmark),
                    onPressed: () {},
                  )
                ],
              ),
              SizedBox(
                height: 80.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 250,
                    width: 260,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0)),
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://3apq7g38q3kw2yn3fx4bojii-wpengine.netdna-ssl.com/wp-content/uploads/2019/04/family-vacation-750x500.jpeg'),
                            fit: BoxFit.fill)),
                  ),
                  SizedBox(
                    width: 3.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 125,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.0)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1NR_xwa6a73nVxGvNL85-qPb-10Okf0AFn-BDCp_4OgEIK5F_'),
                                fit: BoxFit.fill)),
                      ),
                      Container(
                        height: 125,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10.0)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://media4.s-nbcnews.com/j/newscms/2019_17/2836591/190426-summer-vacation-mn-1245_de1246e726f821d479ad429d492be234.fit-760w.jpg'),
                                fit: BoxFit.fill)),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 18.0,
              ),
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Group Rafting',
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      Text('Turkey-Antalya',
                          style: TextStyle(color: Colors.grey, fontSize: 14.0))
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).orientation.toString() ==
                        'Orientation.portrait'
                        ? 120.0
                        : 480.0,
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.thumbsUp),
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.comment),
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.bookmark),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(
                height: 80.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 250,
                    width: 260,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0)),
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://3apq7g38q3kw2yn3fx4bojii-wpengine.netdna-ssl.com/wp-content/uploads/2019/04/family-vacation-750x500.jpeg'),
                            fit: BoxFit.fill)),
                  ),
                  SizedBox(
                    width: 3.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 125,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.0)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1NR_xwa6a73nVxGvNL85-qPb-10Okf0AFn-BDCp_4OgEIK5F_'),
                                fit: BoxFit.fill)),
                      ),
                      Container(
                        height: 125,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10.0)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://media4.s-nbcnews.com/j/newscms/2019_17/2836591/190426-summer-vacation-mn-1245_de1246e726f821d479ad429d492be234.fit-760w.jpg'),
                                fit: BoxFit.fill)),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 18.0,
              ),
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Group Rafting',
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      Text('Turkey-Antalya',
                          style: TextStyle(color: Colors.grey, fontSize: 14.0))
                    ],
                  ),
                  SizedBox(
                    width: 120.0,
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.thumbsUp),
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.comment),
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.bookmark),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}