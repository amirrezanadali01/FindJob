import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CandidateProfileScreen extends StatefulWidget {
  const CandidateProfileScreen({Key? key}) : super(key: key);

  @override
  State<CandidateProfileScreen> createState() => _CandidateProfileScreenState();
}

class _CandidateProfileScreenState extends State<CandidateProfileScreen> {
  // Skills data
  final List<Map<String, dynamic>> skills = [
    {
      'image': 'assets/images/figma.png',
      'name': 'figma',
      'score': '10 / 10',
    },
    {
      'image': 'assets/images/after.png',
      'name': 'after effects',
      'score': '8 / 10',
    },
    {
      'image': 'assets/images/ilstrator.png',
      'name': 'illustrator',
      'score': '7 / 10',
    },
  ];

  // Experience data
  final List<Map<String, String>> experiences = [
    {
      'image': 'assets/images/google.png',
      'position': 'lead ux/ui',
      'company': 'google inc',
      'date': '02/2021 -now',
    },
    {
      'image': 'assets/images/snapchat.png',
      'position': 'senior ux/ui',
      'company': 'snap inc',
      'date': '07/2020 - 01/2021',
    },
    {
      'image': 'assets/images/twitter.png',
      'position': 'middle ux/ui',
      'company': 'twitter',
      'date': '08/2018 - 05/2020',
    },
    {
      'image': 'assets/images/pocket.png',
      'position': 'junior ux/ui',
      'company': 'pocket inc',
      'date': '03/2017 - 07/2018',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildAboutMe(),
              _buildSkills(),
              _buildExperience(),
            ]),
          ),
        ],
      ),
    );
  }

  // Profile app bar

  Widget _buildAppBar() {
    return const SliverAppBar(
      snap: false,
      pinned: true,
      floating: false,
      stretch: true,
      centerTitle: true,
      expandedHeight: 200,
      backgroundColor: Colors.black,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('Hanna Dias'),
        centerTitle: true,
        stretchModes: [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
          StretchMode.fadeTitle,
        ],
        background: Image(
          image: AssetImage('assets/images/b1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // About me section

  Widget _buildAboutMe() {
    return Padding(
      padding: EdgeInsets.only(left: 15.sp, right: 10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5.h),
          const Text(
            'about me',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 2.h),
          const Text(
            'i have been working as a i/ux designer for more than 3 years. i am engaged in the... more',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          const Text(
            'skills',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  // Skills section

  Widget _buildSkills() {
    return Column(
      children: [
        SizedBox(height: 2.h),
        Row(
          children: skills.map((skill) {
            return Expanded(
              child: _buildSkillCard(
                image: skill['image'],
                name: skill['name'],
                score: skill['score'],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSkillCard({
    required String image,
    required String name,
    required String score,
  }) {
    return Container(
      margin: EdgeInsets.only(left: 1.sp, right: 1.sp),
      height: 16.h,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Expanded(
            flex: 2,
            child: Image.asset(image),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              score,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  // Experience section

  Widget _buildExperience() {
    return Column(
      children: [
        SizedBox(height: 2.h),
        Padding(
          padding: EdgeInsets.only(left: 15.sp, bottom: 15.sp),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'experience',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        ...List.generate(experiences.length, (index) {
          final experience = experiences[index];

          return _buildExperienceCard(
            image: experience['image']!,
            position: experience['position']!,
            company: experience['company']!,
            date: experience['date']!,
            isCurrent: index == 0,
          );
        }),
      ],
    );
  }

  Widget _buildExperienceCard({
    required String image,
    required String position,
    required String company,
    required String date,
    required bool isCurrent,
  }) {
    return Container(
      margin: EdgeInsets.only(
        left: 3.sp,
        right: 3.sp,
        bottom: 3.sp,
      ),
      decoration: BoxDecoration(
        color: isCurrent ? Colors.white : const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(20),
      ),
      width: double.infinity,
      height: 13.h,
      child: Padding(
        padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  width: 16.w,
                  height: 7.h,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    color: Color(0xFFF6F6F6),
                  ),
                  child: Image.asset(image),
                ),
                SizedBox(width: 10.sp),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      position,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.sp),
                    Text(
                      company,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              date,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isCurrent ? Colors.black : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
