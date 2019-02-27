//
//  PickerButton.swift
//  PickerButton
//
//  Created by marty-suzuki on 2019/02/18.
//  Copyright © 2019 marty-suzuki. All rights reserved.
//

import UIKit

public protocol PickerButtonDelegate: UIPickerViewDelegate {
    func pickerButtonDidClose(_ pickerButton: PickerButton)
}

extension PickerButtonDelegate {
    public func pickerButtonDidClose(_ pickerButton: PickerButton) {}
}

open class PickerButton: UIButton {

    public private(set) var selectedValues: [String] = []
    private let picker = UIPickerView()

    private var delegateProxy: UIPickerViewDelegateProxy?
    public var delegate: UIPickerViewDelegate? {
        set {
            let delegateProxy = UIPickerViewDelegateProxy(newValue)
            delegateProxy.titleChanged = { [weak self] in
                guard let me = self else {
                    return
                }
                me.selectedValues[$0.component] = $0.title
                me.updateTitle()
            }
            picker.delegate = delegateProxy
            self.delegateProxy = delegateProxy

            let components = picker.numberOfComponents
            guard components > 0 else {
                return
            }

            self.selectedValues = (0..<components).map {
                guard picker.numberOfRows(inComponent: $0) > 0 else {
                    return ""
                }
                return picker.delegate?.pickerView?(picker, titleForRow: 0, forComponent: $0) ?? ""
            }
            updateTitle()
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

    /// If set true, title is updated automatically when a picker item is selected
    ///
    /// - note: Default is true
    open var shouldUpdateTitleAutomatically = true

    override open var canBecomeFirstResponder: Bool {
        return true
    }

    /// - note: always returns UIPickerView instalce
    override open var inputView: UIView? {
        return picker
    }

    /// - note: always returns UIToolbar instalce that contains close button
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
        (delegateProxy?.delegate as? PickerButtonDelegate)?.pickerButtonDidClose(self)
    }

    @objc private func didTap(_ button: PickerButton) {
        becomeFirstResponder()
    }

    private func updateTitle() {
        guard shouldUpdateTitleAutomatically else {
            return
        }

        let title = selectedValues.reduce(into: "") { result, title in
            if result.isEmpty {
                result += title
            } else {
                result += (" " + title)
            }
        }
        setTitle(title, for: [])
    }

    /// scrolls the specified row to center.
    open func selectRow(_ row: Int, inComponent component: Int, animated: Bool) {
        let components = picker.numberOfComponents
        guard components > 0, picker.numberOfRows(inComponent: component) > row else {
            return
        }

        picker.selectRow(row, inComponent: component, animated: animated)

        self.selectedValues = (0..<components).map {
            guard picker.numberOfRows(inComponent: $0) > 0 else {
                return ""
            }
            if $0 == component {
                return picker.delegate?.pickerView?(picker, titleForRow: row, forComponent: $0) ?? ""
            } else {
                return picker.delegate?.pickerView?(picker, titleForRow: 0, forComponent: $0) ?? ""
            }
        }
        updateTitle()
    }

    /// returns selected row. -1 if nothing selected
    open func selectedRow(inComponent component: Int) -> Int {
        return picker.selectedRow(inComponent: component)
    }
}

// MARK: - UIKeyInput

extension PickerButton: UIKeyInput {

    public var hasText: Bool {
        return !selectedValues.isEmpty
    }

    public func insertText(_ text: String) {}

    public func deleteBackward() {}
}
