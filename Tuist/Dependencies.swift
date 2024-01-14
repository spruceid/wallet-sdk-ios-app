import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: .init(
        productTypes: [
            "WalletSdk": .framework, // default is .staticFramework
        ]
    ),
    platforms: [.iOS]
)
