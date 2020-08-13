# movie_time_selection

This interface is designed by Cuberto ([Dribbble](https://dribbble.com/cuberto)).<br>
[https://dribbble.com/shots/5694244-Scroll-and-Selected-Tab](https://dribbble.com/shots/5694244-Scroll-and-Selected-Tab)

This is created as a Flutter Web project, so you can play around with the design and help me find bugs.<br>
[https://mslalith.github.io/movie_time_selection/](https://mslalith.github.io/movie_time_selection/ "Movie Time Selection")

## Packages:

- provider: ^4.3.2 (State Management)

## Further Optimizations:

It can be achieved using [Slivers](https://medium.com/flutter/slivers-demystified-6ff68ab0296f) (great article by Emily). I initially started to develop with Slivers, but I couldn't offset the Time Selection grid above the [SliverPersistentHeader](https://api.flutter.dev/flutter/widgets/SliverPersistentHeader-class.html). So I went with using a single Stack.<br>
If this can be achieved using Slivers, please fork this repo and send me PR.

<br>

You can support me by buying me a coffee.

<a href="https://www.buymeacoffee.com/msLalith" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>
