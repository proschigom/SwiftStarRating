#SwiftStarRating
SwiftStarRating is a control to rating with stars in ios 8 / swift, it's simple to use and configurable. It's based on [ASStarRatingView](https://github.com/yanguango/ASStarRatingView)

##Screenshot
![screenshot](http://f.cl.ly/items/1j3p3T3T450V3b3Z260B/Screen%20Shot%202012-01-16%20at%20%E4%B8%8B%E5%8D%884.01.24.png "screenshot #1")
![screenshot](http://s23.postimg.org/4mxwc85cr/i_OS_Simulator_Screen_Shot_Nov_22_2014_11_00_41.png "screenshot #2")

##Config
``` swift
	starRatingView.canEdit = true;
	starRatingView.maxRating = 8.0;
	starRatingView.minAllowedRating = 4.0;
	starRatingView.maxAllowedRating = 6.0;
	starRatingView.rating = 5.0;
```
#HowToUse
0. Import the folder (be sure to copy it) into your project. You can do this by dragging the folder into your project in Xcode
1. Add a UIView to your storyboard
2. In the Identity Inspector, change the class to SwiftStarRating
2. Wala! You're done :) 

##License
SwiftStarRating is available under the MIT license. See the LICENSE file for more info.