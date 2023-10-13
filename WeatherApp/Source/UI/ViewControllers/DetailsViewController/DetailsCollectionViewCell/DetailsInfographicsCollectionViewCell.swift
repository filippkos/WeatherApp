//
//  DetailsCollectionViewCell.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 18.08.2023.
//

import UIKit
import SnapKit

final class DetailsInfographicsCollectionViewCell: BaseDetailsCollectionViewCell {
    
    // MARK: -
    // MARK: Private
    
    override func setupLayout() {
        super.setupLayout()
        
        self.addViews()
        self.addConstraints()
    }

    private func addViews() {
        self.mainStackView.axis = .vertical
        self.titleStackView.axis = .horizontal
        self.mainStackView.distribution = .fillProportionally
        self.titleStackView.distribution = .fillProportionally
        self.mainStackView.spacing = 8
        self.titleStackView.spacing = 8
        self.addSubview(self.mainStackView)
        self.mainStackView.addArrangedSubview(self.titleStackView)
        self.mainStackView.addArrangedSubview(self.container)
        self.titleStackView.addArrangedSubview(self.titleImageBackground)
        self.titleImageBackground.addSubview(self.titleImage)
        self.titleStackView.addArrangedSubview(self.titleLabel)
    }
    
    private func addConstraints() {
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
}
