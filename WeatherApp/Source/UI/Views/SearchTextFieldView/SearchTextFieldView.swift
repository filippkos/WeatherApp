//
//  SearchTextFieldView.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 14.08.2023.
//

import UIKit
import SnapKit

@IBDesignable
class SearchTextFieldView: UIView {
    
    var textField = UITextField()
    var resultLabel = UILabel()
    var actionButton = UIButton()
    
    init() {
        super.init(frame: CGRect())
        
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setup()
    }
    
    func setup() {
        self.backgroundColor = .clear
        self.setupTextField()
        self.setupButton()
        self.addViews()
        self.addConstraints()
    }
    
    func addViews() {
        self.addSubview(self.textField)
        self.addSubview(self.actionButton)
    }
    
    func setupTextField() {
        self.textField.font = Fonts.SFProDisplay.regular.font(size: 22)
        self.textField.attributedPlaceholder = NSAttributedString(
            string: "Riga",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
    }
    
    func setupButton() {
        self.actionButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        self.actionButton.titleLabel?.text = ""
    }
    
    func addConstraints() {
        self.textField.snp.makeConstraints {
            $0.left.equalTo(16)
            $0.top.bottom.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        self.actionButton.snp.makeConstraints {
            $0.right.top.bottom.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(50)
        }
    }
}
