//
//  ViewController.swift
//  A4
//
//  Created by Vin Bui on 10/31/23.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties (view)
    private var collectionView: UICollectionView!
    
    // MARK: - Properties (data)
    private var recipes: [Recipe] = []
    
    // MARK: - View Cycles
    private let refreshControl = UIRefreshControl()
    // need to add more here!! assign a function to be called for refresh to update the data on screen
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "ChefOS"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor.a4.white

        setupCollectionView()
        fetchRecipes()
    }
    
    // MARK: - Networking
    @objc private func fetchRecipes()  {
        NetworkManager.shared.getRecipes { [weak self] posts in
            guard let self = self else { return }
            self.recipes = recipes
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }

    // MARK: - Set Up Views
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 43
        layout.minimumInteritemSpacing = 33
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RecipeUICollectionViewCell.self, forCellWithReuseIdentifier: RecipeUICollectionViewCell.reuse)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        refreshControl.addTarget(self, action: #selector(fetchRecipes), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 24   // Use this constant when configuring constraints
        NSLayoutConstraint.activate ([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}


    // MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
    }
}
    
    
    // MARK: - UICollectionViewDataSource
    
    extension ViewController: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return recipes.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeUICollectionViewCell.reuse, for: indexPath) as? RecipeUICollectionViewCell else { return UICollectionViewCell() }
            return cell
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    extension ViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            return CGSize(width: collectionView.frame.width / 2 - 16, height: 216)
        }
    }
