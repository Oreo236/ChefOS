//
//  DetailedRecipeVC.swift
//  A4
//

import UIKit

class DetailedRecipeVC: UIViewController {
    // MARK: - Properties (view)
    private let recipeImageView = UIImageView()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()

    // MARK: - Properties (data)
    private var recipeImage: String
    private var name: String
    private var recipeDescription: String

    // MARK: - viewDidLoad and init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        setuprecipeImageView()
        setupNameLabel()
        setupdescriptionLabel()
    }
    
    init(recipeImage:String, name:String, recipeDescription: String) {
        self.recipeImage = recipeImage
        self.name = name
        self.recipeDescription = recipeDescription
        //self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Up Views
    func setuprecipeImageView () {
        recipeImageView.sd_setImage(with: URL(string: recipeImage))
        
        recipeImageView.layer.cornerRadius = 16
        recipeImageView.layer.masksToBounds = true
        
        view.addSubview(recipeImageView)
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -32),
            recipeImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            recipeImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            recipeImageView.widthAnchor.constraint(equalToConstant: 270),
            recipeImageView.heightAnchor.constraint(equalToConstant: 270),
        ])
    }
    
    private func setupNameLabel() {
        nameLabel.font = .systemFont(ofSize: 24, weight: .semibold).rounded
        nameLabel.textColor = UIColor.a4.black
        nameLabel.text = name
        nameLabel.numberOfLines = 0

        
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 32),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
//            nameLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
        ])

    }
    
    func setupdescriptionLabel () {
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular).rounded
        descriptionLabel.textColor = UIColor.a4.silver
        descriptionLabel.text = recipeDescription
        descriptionLabel.numberOfLines = 0
        
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
//            descriptionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 32),
            
            
        ])
    }
    
    
    // pop/push VC
//    @objc private func popVC() {
//        navigationController?.popViewController(animated: true)
//        delegate?.updateText(newHometown: hometownTextField.text ?? "", newMajor: majorTextField.text ?? "")
//
//    }
}
