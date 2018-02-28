The Movie Database (TMDb)
===================

Hello there!

TMDb is simple app for cinephiles and movie hobbyists. This version of the app will is very simple and limited to show the list and details of upcoming movies fed with content from The Movie Database (TMDb). Also it includes a simples name search for looking in all TMDb's movies by name.

Build instructions
-------------
- Dependencies are managed by [Pods](https://cocoapods.org/), after install it, just type **pod install** on the root folder and open the generated **TMDb.xcworkspace** project file with Xcode

Third-party Libraries
-------------
As goal i've decided to use only a few libraries for demonstrating the usage of the dependency management with Pods by itself.  Those where used strictly for communication with TMDb APIs:

- [Alamofire](https://github.com/Alamofire/Alamofire) - Used for make URL requests providing more control about all requests done.
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) - Makes it easy to deal with JSON data.

