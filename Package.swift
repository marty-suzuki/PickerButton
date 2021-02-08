// swift-tools-version:5.0
import PackageDescription

let package = Package(
  name: "PickerButton",
  products: [
    .library(name: "PickerButton", targets: ["PickerButton"]),
  ],
  targets: [
    .target(
      name: "PickerButton",
      dependencies: [],
      path: "PickerButton"),
  ]
)
