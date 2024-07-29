// swift-tools-version: 5.9
// This is a Skip (https://skip.tools) package,
// containing a Swift Package Manager project
// that will use the Skip build plugin to transpile the
// Swift Package, Sources, and Tests into an
// Android Gradle Project with Kotlin sources and JUnit tests.
import PackageDescription

let package = Package(
    name: "travel-posters-model",
    defaultLocalization: "en",
    platforms: [.iOS(.v16), .macOS(.v13), .tvOS(.v16), .watchOS(.v9), .macCatalyst(.v16)],
    products: [
        .library(name: "TravelPostersModel", type: .dynamic, targets: ["TravelPostersModel"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "0.10.7"),
        .package(url: "https://source.skip.tools/skip-model.git", from: "0.0.0")
    ],
    targets: [
        .target(name: "TravelPostersModel", dependencies: [.product(name: "SkipModel", package: "skip-model")], resources: [.process("Resources")], plugins: [.plugin(name: "skipstone", package: "skip")]),
        .testTarget(name: "TravelPostersModelTests", dependencies: ["TravelPostersModel", .product(name: "SkipTest", package: "skip")], resources: [.process("Resources")], plugins: [.plugin(name: "skipstone", package: "skip")]),
    ]
)