/* Widget shimmerEffect(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      bottom: false,
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: secondary,
            child: Container(
              margin: const EdgeInsets.all(20),

              // back container dimensions
              width: width * 0.85,
              height: width * 0.1,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(width * 0.05),
                ),
              ),
            ),
          ),
          ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              itemBuilder: (context, indx) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Row(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: secondary,
                        child: Container(
                          height: 70,
                          width: 70,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: secondary,
                            child: Container(
                              height: 20,
                              width: width * 0.35,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: secondary,
                            child: Container(
                              height: 30,
                              width: width * 0.55,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
          const Spacer(),
          Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: secondary,
              child: Container(
                color: Colors.white,
                height: 100,
                width: double.infinity,
              ))
        ],
      ),
    ));
  } */