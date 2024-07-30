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

There are many ways to automate this process, from simple scripting to git submodules to publishing Skip’s transpiled Android `travel-posters-model` output to a local Maven repository. Use whatever system fits your team's workflow best.

## Building & Running

Use Xcode to build and run the iOS app and the shared `travel-posters-model` package.

Use Android Studio to build and run the Android app. On the Android side, please note the following:

- You must “Sync Project with Gradle Files” in Android Studio after updating the exported libraries.
- Using an exported library function which has transitive dependencies on additional Android libraries can cause a runtime error. You must ensure that all transitive dependencies are in your own app's `build.gradle.kts`.

