//
//  FilterUICollectionViewCell.swift
//

import Foundation
import UIKit
import SnapKit

class FilterUICollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties (view)
    

    private let recipeDifficultyLabel = UILabel()
    
    static let reuse = "FilterUICollectionViewCellReuse"
    
    // MARK: - Properties (data)
//    private var clicked:Bool = false
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setuprecipeDifficultyLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    func configure(filter: String, clicked: Bool) {
        recipeDifficultyLabel.text = filter
        if clicked == false{
            recipeDifficultyLabel.backgroundColor = UIColor.a4.offWhite
            recipeDifficultyLabel.textColor =  UIColor.a4.black
        }
        else{
            recipeDifficultyLabel.backgroundColor = UIColor.a4.yellowOrange
            recipeDifficultyLabel.textColor =  UIColor.a4.white
        }
    }
    // MARK: - Set Up Views
    
    private func setuprecipeDifficultyLabel() {
        recipeDifficultyLabel.font = .systemFont(ofSize: 12, weight: .medium).rounded
        
        recipeDifficultyLabel.layer.masksToBounds = true
        recipeDifficultyLabel.layer.cornerRadius = 12
        contentView.addSubview(recipeDifficultyLabel)
        recipeDifficultyLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeDifficultyLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            recipeDifficultyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            recipeDifficultyLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                       constant: 5),
            recipeDifficultyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
                    
            recipeDifficultyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        
            
            
        ])
    }

}


