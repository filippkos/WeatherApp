//
//  DetailsQuantityCollectionViewCell.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 26.09.2023.
//

import UIKit
import SnapKit

class DetailsConditionCollectionViewCell: UICollectionViewCell {
    
    // MARK: -
    // MARK: Variables
    
    var mainStackView = UIStackView()
    var titleStackView = UIStackView()
    var titleImageBackground = UIView()
    var titleImageContainer = UIView()
    var titleImage = UIImageView()
    var titleLabel = UILabel()
    var container = UIView()
    
    // MARK: -
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupUI()
    }
    
    // MARK: -
    // MARK: Public
    
    func setupUI() {
        self.backgroundColor = Colors.cellBackgroundGreen.color
        self.layer.cornerRadius = 18
        self.titleLabel.font = Fonts.SFProDisplay.regular.font(size: 14)

        self.titleImage.tintColor = .black
        
        self.addViews()
        self.addConstraints()
    }
    
    func configure(with title: String, image: String) {
        self.titleLabel.text = title
        self.titleImage.image = UIImage(systemName: image)
    }
    
    func addViews() {
        self.mainStackView.axis = .horizontal
        self.titleStackView.axis = .vertical
        self.mainStackView.distribution = .fill
        self.titleStackView.distribution = .fillProportionally
        self.mainStackView.spacing = 8
        self.titleStackView.spacing = 8
        self.addSubview(self.mainStackView)
        self.titleImageBackground.addSubview(self.titleImage)
        self.titleImageContainer.addSubview(self.titleImageBackground)
        self.mainStackView.addArrangedSubview(self.titleImageContainer)
        self.mainStackView.addArrangedSubview(self.titleStackView)
        self.titleStackView.addArrangedSubview(self.titleLabel)
        self.titleStackView.addArrangedSubview(self.container)
    }
    
    func addConstraints() {
        self.mainStackView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(18)
            $0.top.bottom.equalToSuperview().inset(15)
        }
        
        self.titleImageBackground.snp.makeConstraints {
            $0.width.height.equalTo(28)
            $0.centerY.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        self.titleImage.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview().inset(6)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.titleImageBackground.backgroundColor = .white
        self.titleImageBackground.layer.cornerRadius = 14
    }
    
    private func createSpacer() -> UIView {
        let spacer = UIView()
        
        return spacer
    }
    
    override func prepareForReuse() {
        self.container.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
}
