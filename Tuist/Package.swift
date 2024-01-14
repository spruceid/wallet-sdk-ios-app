// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "PackageName",
    dependencies: [
        .package(url: "https://github.com/spruceid/wallet-sdk-swift", from: "0.0.2"),
        // .package(path: "../../../../wallet-sdk-swift")
    ]
)
