// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "IceCream",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "IceCream",
            targets: ["IceCream"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/realm/realm-swift",
            from: "10.43.0"
        )
    ],
    targets: [
        .target(
            name: "IceCream",
            dependencies: [
                .product(name: "RealmSwift", package: "realm-swift"),
                .product(name: "Realm", package: "realm-swift")
            ],
            path: "IceCream",
            sources: ["Classes"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
