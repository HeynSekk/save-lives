import 'package:flutter/material.dart';
import 'package:save_lives/common/common.dart';

class Purpose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: DrawerUi(),
      body: Padding(
        padding: EdgeInsets.all(sw * 0.05),
        child: Column(
          children: <Widget>[
            //dr button
            SizedBox(
              width: sw * 0.90,
              child: Padding(
                padding: EdgeInsets.only(right: sw * 0.90 * 0.85),
                child: drawerButton(),
              ),
            ),
            SizedBox(
              height: sw * 0.1,
            ),
            //scroll view
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: SizedBox(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      //title
                      LeadingTxt('Purpose of this app', false),
                      SizedBox(
                        height: sw * 0.089,
                      ),
                      DescTxt(
                          'This app\'s purpose is to make people have health knowledges. This app has a collection of essential health knowledges that everyone should know. You can get valuable health knowledges just by spending a few minutes a day in this app.\n\nHealth Knowledges are very useful in life. Some knowledges are so powerful that they can even save your life.\n\nA few months ago, a sixteen years old boy who lives near my house died from an electric shock. Although his family transported him to the nearest hospital, his heart stopped beating when they arrived the hospital.',
                          false),
                      DescTxt(
                          '\nWhen someone get a severe electric shock, his heart stop beating. We must perform a task that resuscitates his heart, called CPR, immediately. Only if so, he has the chance to get his life back.\n\nIn his case, no one performed CPR for immediate resuscitation and he lost his life although there was an obvious possibility to get back his life. If someone performed the CPR immediately, he will not die. But now, he didn\'t get CPR at the time he needed and he lost his life.\n\nWe can say that such knowledge are crucial. Those knowledges can even save the lives. Those are called \"First Aids\". Giving first aids when one really needs it, can surely save his life. ',
                          false),
                      DescTxt(
                          '\nFirst aid is the first and immediate assistance given to any person suffering from either a minor or serious illness or injury. \n\nWe must give the casuality the first aids immediately in some illnesses or injuries such as choking, snake bite, electric shock, severe bleeding etc.\n\nWhen a baby is choking and his mom don\'t know how to make him get relief, he will stop breathing within a few minutes if the thing that is choked didn\'t come out. Even if he can get to the hospital within 5 minutes, he might even die because no babies can\'t live for 5 minutes without breathing.\n\nIn those cases, immediate first aid is a must. Otherwise, the casuality has a very little chance to get his life back. \n\nA Red Cross survey showed a staggering 59% of deaths from injuries would have been preventable had first aid been given before the emergency services arrived. So having First aid knowledge can save many lives. It is worth learning.',
                          false),
                      DescTxt(
                          '\nWe might encounter some illnesses or injuries in our life. We can\'t definitely say we will not do so. According to a survey, commissioned by the British Red Cross, one in five teenagers have had to help someone who is choking.\n\nOurselves, our family members, or other people around us might encounter a health emergency conditions in life. When encountered, we must have First aids knowledges in order to be able to save the lives.\n\nSurely, we don\'t want that we were panicked and didn\'t know what to do when our loved ones were in an injury. And we will not want to see our loved ones losing their lives just because of small accidental injuries like choking. Therefore, we should have essential first aids knowledges, at least for our loved ones.\n\nSo where can we learn first aid? \n\nIt is the best to join an offline course with practical lessons and trainings. But, if you can\'t make time for joining a course, you can learn from videos and websites on internet.',
                          false),
                      DescTxt(
                          '\nThere are mobile apps that can help you in learning first aids like this app. This app has a collection of common first aids that everyone should know. And you can learn the first aids by watching YouTube videos or reading articles from websites.\n\nLately most people on internet don\'t pay much attention to health knowledges. So this app will show you something to learn from notification, everyday. Having this app installed, will trigger you to make commitments on getting health knowledges. \n\nFirst aids are easily forgotten when we are away from them for a while. So we need to revise when we forget. You can easily revise the first aids informations without needing to type and search again, if you have a mobile app like Save Lives installed on your phone.\n\nAnd, we need to share the first aids that we have learned, to other people. It is better that many people have the knowledges of first aid. So people can help each other if they know how to give first aids. Sharing directly to our family family members in leisure times, or if we want our sharing to reach to more people, sharing on social media will help it.',
                          false),
                      DescTxt(
                          '\nAs summary, we might encounter health emergency conditions in our life. And in some case, the casuality would die if he didn\'t get the first aid immediately. Only if he get the first aid immediately, he would not lose his life.\n\nHaving first aids knowledge can save many lives. Those knowledge can be useful one day. Therefore, we all should learn first aids.\n',
                          false),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
