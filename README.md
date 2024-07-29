# TravelPosters

This is a demonstration of using a shared [Skip](https://skip.tools) dual-platform Swift model library to power both an iOS and an Android app.

## Workflow

Iterate on both the `travel-posters-model` shared model package and the iOS app by opening the `TravelPosters.xcworkspace` Xcode workspace.

Iterate on the Android app by opening the `Android/settings.gradle.kts` file in Android Studio.

To donate the latest `travel-posters-model` shared model code to the Android app:

```shell
$ cd travel-posters-model
$ skip export
$ cp .build/skip-export/*-release* ../Android/lib/release/
$ cp .build/skip-export/*-debug* ../Android/lib/debug/
```

There are many ways to automate this process, from simple scripting to publishing Skip's transpiled Android model output to your a local Maven repository. Use a system that fits you best.

## Building & Running

Use Xcode to build and run the iOS app and the shared `travel-posters-model` package.

Use Android Studio to build and run the Android app. On the Android side, please note the following:

- You must "Sync Project with Gradle Files" in Android Studio after updating the exported Skip and model libraries.
- Using a Skip or exported library function which requires an Android library that isn't listed as a dependency in your Android app's `build.gradle.kts` will cause a runtime error. You must add the necessary dependencies to `build.gradle.kts`.

