//
//  PickerButton.swift
//  PickerButton
//
//  Created by marty-suzuki on 2019/02/18.
//  Copyright © 2019 marty-suzuki. All rights reserved.
//

import UIKit

open class PickerButton: UIButton {

    private var _value: String = ""
    private let picker = UIPickerView()

    private var delegateProxy: UIPickerViewDelegateProxy?
    public var delegate: UIPickerViewDelegate? {
        set {
            let delegateProxy = UIPickerViewDelegateProxy(newValue)
            delegateProxy.titleChanged = { [weak self] in
                self?.insertText($0)
            }
            picker.delegate = delegateProxy
            self.delegateProxy = delegateProxy
        }
        get {
            return delegateProxy
        }
    }

    public var dataSource: UIPickerViewDataSource? {
        set {
            picker.dataSource = newValue
        }
        get {
            return picker.dataSource
        }
    }

    open var showsSelectionIndicator: Bool {
        set {
            picker.showsSelectionIndicator = newValue
        }
        get {
            return picker.showsSelectionIndicator
        }
    }

    open var closeButtonTitle: String = "Done"

    override open var canBecomeFirstResponder: Bool {
        return true
    }

    override open var inputView: UIView? {
        return picker
    }

    override open var inputAccessoryView: UIView? {
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 44)
        let closeButton = UIBarButtonItem(title: closeButtonTitle,
                                          style: .done,
                                          target: self,
                                          action: #selector(PickerButton.didTapClose(_:)))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                    target: nil,
                                    action: nil)
        let items = [space, closeButton]
        toolbar.setItems(items, animated: false)
        toolbar.sizeToFit()

        return toolbar
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    private func initialize() {
        addTarget(self,
                  action: #selector(PickerButton.didTap(_:)),
                  for: .touchUpInside)
    }

    @objc private func didTapClose(_ button: UIBarButtonItem) {
        resignFirstResponder()
    }

    @objc private func didTap(_ button: PickerButton) {
        becomeFirstResponder()
    }
}

extension PickerButton: UIKeyInput {

    public var hasText: Bool {
        return !_value.isEmpty
    }

    public func insertText(_ text: String) {
        _value = text
        setTitle(text, for: [])
    }

    public func deleteBackward() {}
}
