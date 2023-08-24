//
//  DetailsCollectionViewCell.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 18.08.2023.
//

import UIKit
import SnapKit

class DetailsCollectionViewCell: UICollectionViewCell {
    
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
        self.titleImage.image = UIImage(systemName: "wind")
        self.titleImage.tintColor = .black
        
        self.addViews()
        self.addConstraints()
    }
    
    func addViews() {
        self.mainStackView.axis = .vertical
        self.titleStackView.axis = .horizontal
        self.mainStackView.distribution = .fillProportionally
        self.titleStackView.distribution = .fillProportionally
        self.titleStackView.spacing = 8
        self.addSubview(self.mainStackView)
        self.mainStackView.addArrangedSubview(self.titleStackView)
        self.mainStackView.addArrangedSubview(self.container)
        self.titleStackView.addArrangedSubview(self.titleImageBackground)
        self.titleImageBackground.addSubview(self.titleImage)
        self.titleStackView.addArrangedSubview(self.titleLabel)

        self.titleImageBackground.setContentCompressionResistancePriority(.defaultHigh,for: .vertical)
        self.container.setContentCompressionResistancePriority(.defaultLow,for: .vertical)
    }
    
    func addConstraints() {
        self.mainStackView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(18)
            $0.top.bottom.equalToSuperview().inset(15)
        }
        self.titleImageBackground.snp.makeConstraints {
            $0.width.height.equalTo(28)
        }
        
        self.titleStackView.snp.makeConstraints {
            $0.height.equalTo(28)
        }
        
        self.container.snp.makeConstraints {
            $0.height.equalTo(30)
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
