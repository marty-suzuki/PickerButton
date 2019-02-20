//
//  UIPickerViewDelegateProxy.swift
//  PickerButton
//
//  Created by marty-suzuki on 2019/02/18.
//  Copyright © 2019 marty-suzuki. All rights reserved.
//

import Foundation

final class UIPickerViewDelegateProxy: DelegateProxy<UIPickerViewDelegate>, UIPickerViewDelegate {

    var titleChanged: ((TitleChangedInfo) -> Void)?

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let title = delegate?.pickerView?(pickerView, titleForRow: row, forComponent: component) {
            titleChanged?(TitleChangedInfo(title: title,
                                           row: row,
                                           component: component) )
        }
        delegate?.pickerView?(pickerView, didSelectRow: row, inComponent: component)
    }
}

extension UIPickerViewDelegateProxy {
    struct TitleChangedInfo {
        let title: String
        let row: Int
        let component: Int
    }
}
