# Require
1. iOS 9 + supports Portrail and landscape
2. Network is Required, I did not implement examption & error.
3. Build with CocoaPod, added Afnetwork, YYModel and MJRefresh as external tools.


Design with MVVM, yet not fully take advantage of it since the Requirement is mostly about a Static Page.Still it is easy to evolve.
Meanwhile, some image seems not reachable according to the JSON data, therefore I applies some of my own images as placeholders.
GCD was simply used when implementing Image cache component as ECImageView.



what?

#Oringinal Requirement

The assignemnt is to build an iPhone app which looks like Wechat Moments
page.
Production requirements:
Wechat Moments is the ideal goal of the view layouts
The view consists of profile image, avatar and tweets list
For each tweet, there will be a sender, optional content, optional images
and comments, ignore the tweet which does not contain a content and
images
A tweet contains from 0 to 9 images, make sure the layout is aligning with
Wechat Moments
Load all tweets in memory at first time and only show first 5 of them at the
beginning and after refresh.
Show 5 more while user pulling up the view at the bottom of table view.
Pulling down tableview to refresh, only first 5 items are shown after
refreshing
Supports layout on all kinds of iOS device screen and orientation.
This is a static page, no more actions(tapping, pulling, multi-touching) are
required. Any extra interaction is welcome and will be serious considered in a
positive way. For any other unclear layout concerns, please reference current
Wechat implemetation. The more similarity your submission get, the more
score you earned.
The data json will be hosted in http://thoughtworks-ios.herokuapp.com/
Layout using storyboards or programmatically
Implement image cache mechanism by yourself (Don not use the thirdlibrary)
AutoLayout & SizeClasses is appreciated.
View of Wechat Moments



Technical requirements:
Unit tests is appreciated.
Functional programming is appreciated
Utilise Git for source control, for git log is the directly evidence of the
development process
Utilise GCD for multi-thread operation
Only binary, framework or cocopods dependency is allowed. do not copy
other developer's source code(*.h, *.m) into your project
Keep your code clean as much as possible Production and Technical
requirements are weighing equally in final result.
Request user info from url: http://thoughtworksios.herokuapp.com/user/jsmith
Request tweets from url: http://thoughtworksios.herokuapp.com/user/jsmith/tweets
Json data specification: