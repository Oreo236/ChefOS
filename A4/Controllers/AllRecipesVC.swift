//
//  AllRecipesVC.swift
//  A4
//

import UIKit

class AllRecipesVC: UIViewController {
    
    // MARK: - Properties (view)
    private var collectionViewOne: UICollectionView!
    private var collectionViewTwo: UICollectionView!

    
    
    // MARK: - Properties (data)
    private var recipes: [Recipe] = []
    private var filters: Array = ["All", "Beginner", "Intermediate", "Advanced"]
    private var filtered_recipes: [Recipe] = []
    private var clicked: Bool = false
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
        setupCollectionViewTwo()
        fetchRecipes()
    }
    
    // MARK: - Networking
    @objc private func fetchRecipes()  {
        NetworkManager.shared.getRecipes { [weak self] recipes in
            guard let self = self else { return }
            self.recipes = recipes
            self.filtered_recipes = recipes
            
            DispatchQueue.main.async {
                self.collectionViewOne.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }

    // MARK: - Set Up Views
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 24
        layout.minimumInteritemSpacing = 10
        
        collectionViewOne = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewOne.register(RecipeUICollectionViewCell.self, forCellWithReuseIdentifier: RecipeUICollectionViewCell.reuse)
        
        collectionViewOne.delegate = self
        collectionViewOne.dataSource = self
                
        refreshControl.addTarget(self, action: #selector(fetchRecipes), for: .valueChanged)
        collectionViewOne.refreshControl = refreshControl
        
        view.addSubview(collectionViewOne)
        collectionViewOne.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 33
        NSLayoutConstraint.activate ([
            collectionViewOne.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32 + padding),
            collectionViewOne.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            collectionViewOne.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            collectionViewOne.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
        ])
    }
    
    private func setupCollectionViewTwo() {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        
        collectionViewTwo = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewTwo.register(FilterUICollectionViewCell.self, forCellWithReuseIdentifier: FilterUICollectionViewCell.reuse)
        
        collectionViewTwo.delegate = self
        collectionViewTwo.dataSource = self
        collectionViewTwo.showsHorizontalScrollIndicator = false
//        collectionViewTwo.contentInset = UIEdgeInsets(top: 32, left: 0, bottom: 32, right: 0)
        
        view.addSubview(collectionViewTwo)
        collectionViewTwo.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 0
        NSLayoutConstraint.activate ([
            collectionViewTwo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            collectionViewTwo.heightAnchor.constraint(equalToConstant: 32),
            collectionViewTwo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            collectionViewTwo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
        ])
    }
}


    // MARK: - UICollectionViewDelegate

extension AllRecipesVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewOne{
            let filtered_recipes = recipes[indexPath.row]
            
            var bookmarkedRecipes = UserDefaults.standard.array(forKey: "bookmarked") as? [String] ?? []
            if bookmarkedRecipes.contains(filtered_recipes.id) {
                bookmarkedRecipes.removeAll { id in
                    id == filtered_recipes.id
                }
            } else {
                bookmarkedRecipes.append(filtered_recipes.id)
            }
            UserDefaults.standard.setValue(bookmarkedRecipes, forKey: "bookmarked")
            
            let detailedVC = DetailedRecipeVC(recipeImage: filtered_recipes.imageUrl, name: filtered_recipes.name, recipeDescription: filtered_recipes.description)
            navigationController?.pushViewController(detailedVC, animated: true)
        }
        
        if collectionView == collectionViewTwo{
            let filter = filters[indexPath.row]
            if filter == "All"{
                filtered_recipes = recipes
                clicked = true

            }
            else{
                filtered_recipes = recipes.filter({ recipe in
                    clicked = true
                    return recipe.difficulty == filter
                })
            }
            collectionViewOne.reloadData()
        }
        
    }
}
    
    // MARK: - UICollectionViewDataSource
    
    extension AllRecipesVC: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == collectionViewOne{
                return filtered_recipes.count}
            else{
                return filters.count}
            
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == collectionViewTwo {

                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterUICollectionViewCell.reuse, for: indexPath) as? FilterUICollectionViewCell else { return UICollectionViewCell() }
                let filter = filters[indexPath.row]
                cell.configure(filter:filter, clicked: clicked)
                return cell
                
            } else if collectionView == collectionViewOne {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeUICollectionViewCell.reuse, for: indexPath) as? RecipeUICollectionViewCell else { return UICollectionViewCell() }
                
                let filtered_recipes = filtered_recipes[indexPath.row]
                cell.configure(recipe: filtered_recipes)
                return cell
            }
            return UICollectionViewCell()
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    extension AllRecipesVC: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            if collectionView == collectionViewOne{
                return CGSize(width: collectionView.frame.width / 2 - 16, height: 216)
        }
            return CGSize(width: 116, height: 32)
        }
    }


    

    
// pop/push code

//@objc private func pushVC() {
//    let editProfileVC = EditProfileVC(hometownText: hometownText, majorText: majorText, delegate: self)
//    backIcon = backIcon?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
//    navigationController?.navigationBar.backIndicatorTransitionMaskImage = backIcon
//    navigationController?.navigationBar.backIndicatorImage = backIcon
//    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
//}
