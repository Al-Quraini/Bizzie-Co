import 'dart:developer';

import 'package:bizzie_co/business_logic/bloc/activity/activity_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/my_activity/my_activity_bloc.dart';
import 'package:bizzie_co/business_logic/cubit/comments/comments_cubit.dart';
import 'package:bizzie_co/data/models/activity.dart';
import 'package:bizzie_co/data/models/comment.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/data/service/storage_service.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import 'components/comment_item_list.dart';

class ActivityDetailPage extends StatefulWidget {
  static const String id = 'activity_detail_page';
  const ActivityDetailPage({
    Key? key,
    required this.activity,
  }) : super(key: key);

  final Activity activity;

  @override
  State<ActivityDetailPage> createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {
  final ScrollController _scrollController = ScrollController();

  late int numOfLikes;
  late int numOfComments;
  late bool isLiked;
  int? limit = 3;

  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    numOfLikes = widget.activity.likedBy.length;
    numOfComments = widget.activity.numOfComments;
    BlocProvider.of<CommentsCubit>(context)
        .emitCommentsLoading(activity: widget.activity, limit: limit);

    isLiked =
        widget.activity.likedBy.contains(FirestoreService.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    log('lakaka');
    double height = MediaQuery.of(context).size.height; //height of screen
    double width = MediaQuery.of(context).size.width; //width of screen
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                SafeArea(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 40,
                        child: IconButton(
                          // padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        clipBehavior: Clip.antiAlias,
                        child: widget.activity.userImagePath != null
                            ? Image.network(
                                widget.activity.userImage!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(placeholderPath),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      AutoSizeText(
                          '${widget.activity.userFirstName} ${widget.activity.userLastName} ',
                          style: GoogleFonts.quicksand(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          )),
                      AutoSizeText('- ${widget.activity.industry ?? '-'}',
                          style: GoogleFonts.quicksand(
                            fontSize: 11,
                            color: Colors.black45,
                            fontWeight: FontWeight.w500,
                          )),
                      const Spacer(),
                      if (widget.activity.isSponsored)
                        Text('AD',
                            style: GoogleFonts.quicksand(
                                fontSize: 12,
                                color: primary,
                                fontWeight: FontWeight.bold)),
                      if (widget.activity.isSponsored)
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            FontAwesomeIcons.ban,
                            size: 12,
                            color: Colors.black38,
                          ),
                        ),
                    ],
                  ),
                ),
                if (widget.activity.url != null)
                  Container(
                    height: width - 20,
                    width: width - 20,
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: AspectRatio(
                      aspectRatio: 2,
                      child: Image.network(
                        widget.activity.photoUrl!,
                        fit: BoxFit.cover,
                        height: 150,
                      ),
                    ),
                  ),
                if (widget.activity.description != null &&
                    widget.activity.description!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.activity.description!
                                .replaceAll('\\n', "\n"),
                            style: GoogleFonts.quicksand(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$numOfLikes likes',
                        style: GoogleFonts.quicksand(
                          color: Colors.black54,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        '$numOfComments comments',
                        style: GoogleFonts.quicksand(
                          color: Colors.black54,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 5,
                  indent: 15,
                  endIndent: 15,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          likeButton(),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'like',
                            style: GoogleFonts.quicksand(
                              color: Colors.black54,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(
                            FontAwesomeIcons.commentAlt,
                            color: iconColor,
                            size: 20,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'comment',
                            style: GoogleFonts.quicksand(
                              color: Colors.black54,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(
                            FontAwesomeIcons.solidShareSquare,
                            color: iconColor,
                            size: 20,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'share',
                            style: GoogleFonts.quicksand(
                              color: Colors.black54,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Row(
                    children: [
                      Text(
                        'Comments',
                        style: GoogleFonts.quicksand(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<CommentsCubit, CommentsState>(
                    // future: null,
                    builder: (context, state) {
                  if (state is CommentsLoaded) {
                    List<Comment> comments = state.comments;

                    return Column(
                      children: [
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              return CommentItemList(comment: comments[index]);
                            }),
                        const SizedBox(
                          height: 5,
                        ),
                        // if (numOfComments > 3)
                        if (limit != null && numOfComments > 3)
                          InkWell(
                            onTap: () async {
                              setState(() {
                                limit = null;
                              });
                              await BlocProvider.of<CommentsCubit>(context)
                                  .emitCommentsLoaded(
                                      activity: widget.activity, limit: limit);
                              // _scrollController.animateTo(
                              //   _scrollController.position.maxScrollExtent,
                              //   curve: Curves.easeOut,
                              //   duration: const Duration(milliseconds: 300),
                              // );
                            },
                            child: Text(
                              'Load more ${numOfComments - 3} comments',
                              style: GoogleFonts.quicksand(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    );
                  } else if (state is CommentsLoading) {
                    return const CircularProgressIndicator.adaptive();
                  }
                  return const SizedBox();
                }),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 29, 30),
              width: width,
              // height: 100,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(color: Colors.grey[300]!, blurRadius: 10)
              ]),
              child: LimitedBox(
                maxHeight: 75,
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      clipBehavior: Clip.antiAlias,
                      child: FirestoreService.currentUser!.imagePath != null
                          ? Image.network(
                              widget.activity.userImage!,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/Images/launcher_icon.png',
                              fit: BoxFit.cover,
                            ),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        onChanged: (value) => setState(() {}),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: GoogleFonts.poppins(fontSize: 12, height: 1.5),
                        decoration: InputDecoration(
                          hintText: 'Write about your self here...',
                          hintStyle:
                              GoogleFonts.poppins(fontSize: 11, height: 1.5),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10.0),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _commentController.text.isEmpty
                          ? null
                          : () async {
                              String path =
                                  '$ACTIVITIES/${widget.activity.activityUid}/$COMMENTS';

                              Comment comment = Comment(
                                  commentUid: const Uuid().v4(),
                                  postUid: widget.activity.activityUid,
                                  text: _commentController.text.trim(),
                                  industry: widget.activity.industry,
                                  timestamp: DateTime.now(),
                                  userFirstName:
                                      FirestoreService.currentUser!.firstName!,
                                  userLastName:
                                      FirestoreService.currentUser!.lastName!,
                                  userImagePath:
                                      FirestoreService.currentUser!.imagePath!,
                                  userUid: FirestoreService.currentUser!.uid);

                              _commentController.text = '';

                              await FirestoreService()
                                  .addComment(comment: comment, path: path);

                              BlocProvider.of<CommentsCubit>(context)
                                  .emitCommentsLoaded(
                                      activity: widget.activity, limit: limit);

                              setState(() {
                                numOfComments++;
                              });
                            },
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      child: Text('Add',
                          style: GoogleFonts.poppins(
                              color: _commentController.text.trim().isEmpty
                                  ? Colors.grey
                                  : primary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget likeButton() {
    return IconButton(
      splashColor: (Colors.transparent),
      highlightColor: (Colors.transparent),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      focusColor: Colors.transparent,
      onPressed: () async {
        setState(() {
          isLiked = !isLiked;
          isLiked ? numOfLikes++ : numOfLikes--;
        });

        FirestoreService().likeActivity(widget.activity);
      },
      icon: Icon(
        !isLiked ? FontAwesomeIcons.thumbsUp : FontAwesomeIcons.solidThumbsUp,
        color: iconColor,
        size: 20,
      ),
    );
  }
}
