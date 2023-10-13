//
//  DetailsQuantityCollectionViewCell.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 26.09.2023.
//

import UIKit
import SnapKit

final class DetailsConditionCollectionViewCell: BaseDetailsCollectionViewCell {
    
    // MARK: -
    // MARK: Variables
    
    var titleImageContainer = UIView()
    
    // MARK: -
    // MARK: Private
    
    override func setupLayout() {
        super.setupLayout()
        
        self.addViews()
        self.addConstraints()
    }
    
    private func addViews() {
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
    
    private func addConstraints() {
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
}
