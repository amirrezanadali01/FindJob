import 'package:findjob/candidate_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class JobSelectionScreen extends StatefulWidget {
  const JobSelectionScreen({Key? key}) : super(key: key);

  @override
  State<JobSelectionScreen> createState() => _JobSelectionScreenState();
}

class _JobSelectionScreenState extends State<JobSelectionScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controller2;

  late Animation<Offset> animSkip;
  late Animation<Offset> animArrow;
  late Animation<Offset> animText;
  late Animation<Offset> animJob;
  late Animation<Offset> animEmployee;
  late Animation<Offset> animProfile;
  late Animation<Offset> animTask;
  late Animation<Offset> animList;

  late Animation<double> animOpacity;
  late Animation<double> animOpacity2;

  bool isContinue = false;

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final List<String> items = [
    'interview with the candidate to ios developer position',
    'meeting new employees in the office',
    '1 on 1 with the head of the design department',
    'interview with the candidate to ios developer position',
    '1 on 1 with the head of the design department',
  ];

  @override
  void initState() {
    super.initState();

    _initializeControllers();
    _initializeAnimations();
    _startInitialAnimation();
  }

  void _initializeControllers() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  void _initializeAnimations() {
    animOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);

    animSkip = Tween<Offset>(
      begin: const Offset(0.80, 0),
      end: Offset.zero,
    ).animate(_controller);

    animArrow = Tween<Offset>(
      begin: const Offset(-0.80, 0),
      end: Offset.zero,
    ).animate(_controller);

    animText = Tween<Offset>(
      begin: const Offset(0, -0.30),
      end: Offset.zero,
    ).animate(_controller);

    animJob = Tween<Offset>(
      begin: const Offset(-0.1, 0),
      end: Offset.zero,
    ).animate(_controller);

    animEmployee = Tween<Offset>(
      begin: const Offset(0.1, 0),
      end: Offset.zero,
    ).animate(_controller);

    // Second animation

    animOpacity2 = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller2);

    animProfile = Tween<Offset>(
      begin: const Offset(0, 0.10),
      end: Offset.zero,
    ).animate(_controller2);

    animTask = Tween<Offset>(
      begin: const Offset(0, 0.30),
      end: Offset.zero,
    ).animate(_controller2);

    animList = Tween<Offset>(
      begin: const Offset(-0.10, 0),
      end: Offset.zero,
    ).animate(_controller2);
  }

  void _startInitialAnimation() {
    Future.delayed(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      _controller.forward();
    });
  }

  void _continue() {
    _controller.reverse();

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      setState(() {
        isContinue = true;
      });

      Future.delayed(const Duration(milliseconds: 200), () {
        if (!mounted) return;
        _controller2.forward();
      });
    });
  }

  void _removeItem(int index) {
    final removedItem = items[index];

    _listKey.currentState?.removeItem(
      index,
      duration: const Duration(milliseconds: 900),
      (context, animation) {
        return TemplateItems(
          text: removedItem,
          anim: animation,
          onClick: () {},
        );
      },
    );

    items.removeAt(index);
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Stack(
        children: [
          _buildProfile(),
          _buildTasksTitle(),
          _buildTaskList(),
          _buildMainContainer(),
          _buildApplications(),
        ],
      ),
    );
  }

  // Profile section

  Widget _buildProfile() {
    return Positioned(
      top: 10.h,
      child: SlideTransition(
        position: animProfile,
        child: FadeTransition(
          opacity: animOpacity2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image(
                        image: const AssetImage('assets/images/b2.jpg'),
                        fit: BoxFit.cover,
                        width: 50.sp,
                        height: 50.sp,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5.sp),
                        const Text(
                          'morning',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        const Text(
                          'Mira',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 40.w),
                Icon(
                  Icons.notifications_active_outlined,
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Tasks title

  Widget _buildTasksTitle() {
    return Positioned(
      left: 7.w,
      top: 40.h,
      child: FadeTransition(
        opacity: animOpacity2,
        child: SlideTransition(
          position: animTask,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'tasks',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.sp,
                ),
              ),
              SizedBox(width: 65.w),
              Icon(Icons.add, size: 20.sp),
            ],
          ),
        ),
      ),
    );
  }

  // Animated task list

  Widget _buildTaskList() {
    return Positioned(
      top: 40.h,
      left: 2.w,
      right: 2.w,
      child: FadeTransition(
        opacity: animOpacity2,
        child: SlideTransition(
          position: animList,
          child: SizedBox(
            height: 90.h,
            width: 100.w,
            child: AnimatedList(
              key: _listKey,
              initialItemCount: items.length,
              itemBuilder: (context, index, animation) {
                return TemplateItems(
                  anim: animation,
                  text: items[index],
                  onClick: () => _removeItem(index),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // Main animated container

  Widget _buildMainContainer() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 800),
      top: isContinue ? 20.h : 0.h,
      left: isContinue ? 3 : 0,
      right: isContinue ? 3 : 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        width: 100.w,
        height: isContinue ? 15.h : 100.h,
        decoration: BoxDecoration(
          color: const Color(0xFF0F1214),
          borderRadius: BorderRadius.all(
            Radius.circular(isContinue ? 10.w : 0),
          ),
        ),
        child: Column(
          children: [
            _buildTopBar(),
            _buildHeader(),
            SizedBox(height: 15.sp),
            _buildJobOptions(),
            SizedBox(height: isContinue ? 0 : 25.h),
            _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  // Back and skip section

  Widget _buildTopBar() {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SlideTransition(
              position: animArrow,
              child: FadeTransition(
                opacity: animOpacity,
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            SlideTransition(
              position: animSkip,
              child: FadeTransition(
                opacity: animOpacity,
                child: Text(
                  'skip',
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Header section

  Widget _buildHeader() {
    return Expanded(
      flex: 1,
      child: SlideTransition(
        position: animText,
        child: FadeTransition(
          opacity: animOpacity,
          child: Column(
            children: [
              Text(
                'choose the job type',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.sp,
                ),
              ),
              SizedBox(height: 12.sp),
              Text(
                'are you looking for a new job or new employee?',
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Job selection cards

  Widget _buildJobOptions() {
    return Expanded(
      flex: 2,
      child: Row(
        children: [
          Expanded(
            child: SlideTransition(
              position: animJob,
              child: FadeTransition(
                opacity: animOpacity,
                child: _buildJobCard(
                  icon: Icons.work_outline,
                  title: 'find job',
                  description: 'we have a lot of job\nopenings',
                ),
              ),
            ),
          ),
          Expanded(
            child: SlideTransition(
              position: animEmployee,
              child: FadeTransition(
                opacity: animOpacity,
                child: _buildJobCard(
                  icon: Icons.man,
                  title: 'find an employee',
                  description:
                      'thousands of people are\nready to work with vou',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2124),
        borderRadius: BorderRadius.all(Radius.circular(8.w)),
      ),
      child: Column(
        children: [
          SizedBox(height: 4.h),
          Icon(
            icon,
            size: 25.sp,
            color: Colors.white54,
          ),
          SizedBox(height: 2.h),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            description,
            style: TextStyle(
              color: Colors.white38,
              fontSize: 11.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Continue button

  Widget _buildContinueButton() {
    return Expanded(
      flex: 0,
      child: GestureDetector(
        onTap: _continue,
        child: FadeTransition(
          opacity: animOpacity,
          child: Container(
            height: 10.h,
            margin: const EdgeInsets.only(
              bottom: 10,
              left: 5,
              right: 5,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(100.w),
              ),
            ),
            child: const Center(
              child: Text(
                'continue',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // New applications section

  Widget _buildApplications() {
    return Positioned(
      top: 24.h,
      left: 10.w,
      child: FadeTransition(
        opacity: animOpacity2,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CandidateProfileScreen(),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'you have 17 new applications',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'check them right now',
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Task item widget

class TemplateItems extends StatelessWidget {
  const TemplateItems({
    super.key,
    required this.text,
    required this.anim,
    required this.onClick,
  });

  final String text;
  final VoidCallback onClick;
  final Animation<double> anim;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(anim),
      child: Container(
        margin: const EdgeInsets.only(bottom: 2),
        width: 100.w,
        padding: EdgeInsets.all(20.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20.sp),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.access_time,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'today/2 pm - 4 pm',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.sp),
                  Text(
                    text,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onClick,
              icon: const Icon(Icons.done),
            ),
          ],
        ),
      ),
    );
  }
}
