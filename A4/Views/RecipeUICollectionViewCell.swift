//
//  RecipeUICollectionViewCell.swift
//
//

import UIKit
//import SnapKit
import SDWebImage

class RecipeUICollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties (view)
    private let recipePictureImageView = UIImageView()
    private let recipeNameLabel = UILabel()
    private let recipeRatingLabel = UILabel()
    private let recipeDifficultyLabel = UILabel()
    private let bulletLabel = UILabel()
    
    static let reuse = "RecipeUICollectionViewCellReuse"
    
    // MARK: - Properties (data)
    private var recipeImage: String = ""
    private var recipeName: String = ""
    private var recipeDescription: String = ""
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.a4.white
        //layer.cornerRadius = 16

        setuprecipePictureImageView()
        setuprecipeNameLabel()
        setuprecipeRatingLabel()
        setuprecipeDifficultyLabel()
        setupBulletLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    func configure(recipe: Recipe) {
        // do we need a configure for the recipe ID?
        recipeImage = recipe.imageUrl
        recipePictureImageView.sd_setImage(with: URL(string: recipeImage))
        
        recipeName = recipe.name
        recipeNameLabel.text = recipeName
        
        recipeRatingLabel.text = String(recipe.rating)
        
        recipeDifficultyLabel.text = recipe.difficulty
        
        recipeDescription = recipe.description

    }
    
    // MARK: - Set Up Views

    private func setuprecipePictureImageView() {
        recipePictureImageView.sd_setImage(with: URL(string: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F8368708.jpg&q=60&c=sc&orient=true&poi=auto&h=512"))
        
        recipePictureImageView.layer.cornerRadius = 16
        recipePictureImageView.layer.masksToBounds = true
        
        contentView.addSubview(recipePictureImageView)
        recipePictureImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipePictureImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipePictureImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipePictureImageView.widthAnchor.constraint(equalToConstant: 148),
            recipePictureImageView.heightAnchor.constraint(equalToConstant: 135),
        ])
    }
    
    private func setuprecipeNameLabel() {
        recipeNameLabel.text = "Cuban Ropa Vieja"
        recipeNameLabel.textColor = UIColor.a4.black
        recipeNameLabel.font = .systemFont(ofSize: 16, weight: .bold).rounded
        recipeNameLabel.numberOfLines = 2
        
        contentView.addSubview(recipeNameLabel)
        recipeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeNameLabel.topAnchor.constraint(equalTo: recipePictureImageView.bottomAnchor, constant: 8),
            recipeNameLabel.widthAnchor.constraint(equalToConstant: 148),
        ])
    }
    
    private func setuprecipeRatingLabel() {
        recipeRatingLabel.text = "4.4"
        recipeRatingLabel.textColor = UIColor.a4.silver
        recipeRatingLabel.font = .systemFont(ofSize: 12, weight: .medium).rounded
        
        contentView.addSubview(recipeRatingLabel)
        recipeRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeRatingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeRatingLabel.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 4),
        ])
    }
    
    private func setuprecipeDifficultyLabel() {
        recipeDifficultyLabel.text = "Intermediate"
        recipeDifficultyLabel.textColor = UIColor.a4.silver
        recipeDifficultyLabel.font = .systemFont(ofSize: 12, weight: .medium).rounded
        
        contentView.addSubview(recipeDifficultyLabel)
        recipeDifficultyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeDifficultyLabel.leadingAnchor.constraint(equalTo: recipeRatingLabel.leadingAnchor, constant: 35),
            recipeDifficultyLabel.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 4),
        ])
    }
    
    private func setupBulletLabel() {
        bulletLabel.text = "∙"
        bulletLabel.textColor = UIColor.a4.silver
        bulletLabel.font = .systemFont(ofSize: 12, weight: .medium).rounded
        
        contentView.addSubview(bulletLabel)
        bulletLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bulletLabel.leadingAnchor.constraint(equalTo: recipeRatingLabel.trailingAnchor, constant: 4),
            bulletLabel.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 4),
        ])
        
    }
    
}






