# What is a sliver?

A sliver is a portion of a scrollable area, which means anything that scrolls in
Flutter is a sliver. If you've used `ListView` or `GridView`, congratulations!
You've already used a sliver in your Flutter app. Most often, slivers are
wrapped in convenience classes such as these. This is because slivers use a
different layout protocol from most other widgets in the Flutter framework.
We'll discuss layout protocol later in the workshop. For now, let's take a
tour of our starter code.

There are a lot more slivers to explore, like SliverGrid and SliverPadding.
Many are the sliver versions of common box widgets, like:

| Box Widget | Sliver Widget |
| --- | --- |
| ListView | SliverList |
| GridView | SliverGrid |
| Padding | SliverPadding |
| AnimatedList | SliverAnimatedList |
| FadeTransition | SliverFadeTransition |
| IgnorePointer | SliverIgnorePointer |

All sliver widgets are prefixed with `Sliver`.

To learn more about these widgets, and all the Flutter widgets, you can

- visit **[flutter.dev](https://flutter.dev/)**
- dive in to our **[API documentation](https://api.flutter.dev/flutter/search.html?q=sliver)**
- and check out the
  **[Flutter Youtube channel](https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw)**
  for more tutorials & tips on creating your next great user experience.
