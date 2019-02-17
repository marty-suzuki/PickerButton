//
//  DelegateProxy.swift
//  PickerButton
//
//  Created by marty-suzuki on 2019/02/18.
//  Copyright © 2019 marty-suzuki. All rights reserved.
//

import Foundation

class DelegateProxy<Delegate: NSObjectProtocol>: NSObject {

    var delegate: Delegate? {
        return _delegate
    }
    private weak var _delegate: Delegate?

    init(_ delegate: Delegate?) {
        self._delegate = delegate
    }

    override func responds(to aSelector: Selector!) -> Bool {
        return super.responds(to: aSelector) || _delegate?.responds(to: aSelector) == true
    }

    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        if _delegate?.responds(to: aSelector) == true {
            return _delegate
        } else {
            return super.forwardingTarget(for: aSelector)
        }
    }
}
