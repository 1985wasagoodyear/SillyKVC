//
//  KeyValueView.swift
//  SillyKVC
//
//  Created by K Y on 8/15/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit

class KeyValueView: UIView {
    
    // MARK: - Interface Builder Outlets
    
    @IBOutlet private var keyLabel: UILabel!
    @IBOutlet private var valueLabel: UILabel!
    
    // MARK: - Custom Getters & Setters
    
    var key: String? {
        set {
            keyLabel.text = newValue
        }
        get {
            return keyLabel.text
        }
    }
    
    var val: String? {
        set {
            valueLabel.text = newValue
        }
        get {
            return valueLabel.text
        }
    }
    
    // MARK: - Lifecycle Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        layer.borderColor = UIColor.red.cgColor
        layer.cornerRadius = 8.0
        layer.borderWidth = 2.0
    }
    
    @inline(__always) private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "KeyValueView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

}
