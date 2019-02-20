//
//  ViewController.swift
//  PickerButtonSample
//
//  Created by marty-suzuki on 2019/02/20.
//  Copyright © 2019 marty-suzuki. All rights reserved.
//

import UIKit
import PickerButton

class ViewController: UIViewController {

    @IBOutlet weak var singlePickerButton: PickerButton! {
        didSet {
            singlePickerButton.layer.masksToBounds = true
            singlePickerButton.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var doublePickerButton: PickerButton! {
        didSet {
            doublePickerButton.layer.masksToBounds = true
            doublePickerButton.layer.cornerRadius = 8
        }
    }

    let singleDataSource = SinglePickerDetaSource()
    let doubleDataSource = DoublePickerDetaSource()


    override func viewDidLoad() {
        super.viewDidLoad()

        singlePickerButton.delegate = singleDataSource
        singlePickerButton.dataSource = singleDataSource

        doublePickerButton.delegate = doubleDataSource
        doublePickerButton.dataSource = doubleDataSource
    }
}

final class SinglePickerDetaSource: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    let pickerValues: [String] = ["first", "second", "third"]

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerValues[row]
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerValues.count
    }
}

final class DoublePickerDetaSource: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    let pickerValues: [[String]] = [
        ["1-first", "1-second", "1-third"],
        ["2-first", "2-second", "2-third"]
    ]

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerValues[component][row]
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerValues.count
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerValues[component].count
    }
}
