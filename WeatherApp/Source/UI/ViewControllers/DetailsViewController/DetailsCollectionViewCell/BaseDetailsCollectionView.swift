//
//  BaseDetailsContentView.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 13.10.2023.
//

import UIKit
import SnapKit

class BaseDetailsCollectionViewCell: UICollectionViewCell {
    
    // MARK: -
    // MARK: Variables
    
    var mainStackView = UIStackView()
    var titleStackView = UIStackView()
    var titleImageBackground = UIView()
    var titleImage = UIImageView()
    var titleLabel = UILabel()
    var container = UIView()
    
    // MARK: -
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupLayout()
    }
    
    // MARK: -
    // MARK: Public
    
    public func configure(with view: UIView) {
        self.container.subviews.forEach({ $0.removeFromSuperview() })
        self.container.addSubview(view)
        view.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
    }
    
    // MARK: -
    // MARK: Public
    
    func configure(with title: String, image: String) {
        self.titleLabel.text = title
        self.titleImage.image = UIImage(systemName: image)
    }
    
    public func setupLayout() {
        self.backgroundColor = Colors.cellBackgroundGreen.color
        self.layer.cornerRadius = 18
        self.titleLabel.font = Fonts.SFProDisplay.regular.font(size: 14)
        self.titleImage.tintColor = .black
    }
    
    // MARK: -
    // MARK: Private

    private func createSpacer() -> UIView {
        let spacer = UIView()
        
        return spacer
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.titleImageBackground.backgroundColor = .white
        self.titleImageBackground.layer.cornerRadius = 14
    }
    
    override func prepareForReuse() {
        self.container.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
}
