//
//  LoadImage.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 24/08/23.
//

import UIKit

class CompositionalLayoutVC : UIViewController {
    
    @IBOutlet weak var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
}

//MARK: -Methods
extension CompositionalLayoutVC {
    func prepareUI(){
        collectionView.register(MyCollectionViewCell.nib, forCellWithReuseIdentifier:MyCollectionViewCell.myCell)
        collectionView.register(ProductCategoriesCell.nib, forCellWithReuseIdentifier:ProductCategoriesCell.categoriesCell)
        collectionView.register(ProductCell.nib, forCellWithReuseIdentifier:ProductCell.productCell)
        collectionView.register(ResturantHeaderCell.self, forSupplementaryViewOfKind: "headerCell", withReuseIdentifier: ResturantHeaderCell.headerCell)
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.decelerationRate = .fast

    }
    
    func createCompositionalLayout()  -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex,enviroment in
            switch sectionIndex {
            case 0 :
                return AppLayouts.shared.bannerSize()
            case 1 :
                return AppLayouts.shared.categoriesInfoSize()
            default:
                return AppLayouts.shared.productSizer()
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
        return layout
    }
}

//MARK: - CollectionViewDelegate And DataSource
extension  CompositionalLayoutVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return foodTopBannerMockData.count
        case 1 :
            return foodCategoryMockData.count
        default:
            return restaurantListMockData.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.myCell, for: indexPath) as! MyCollectionViewCell
            
            bannerCell.imageView.image = UIImage(named: foodTopBannerMockData[indexPath.row].image)
            return bannerCell
        case 1:
            let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCategoriesCell.categoriesCell, for: indexPath) as! ProductCategoriesCell
            
            productCell.imgOffer.image = UIImage(named: foodCategoryMockData[indexPath.row].categoryImage)
            productCell.lblCategories.text = foodCategoryMockData[indexPath.row].categoryName

            return productCell
        default:
            let offerCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.productCell, for: indexPath) as! ProductCell
            
            offerCell.setData = restaurantListMockData[indexPath.row]
            
            return offerCell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if kind == "headerCell" {
            switch indexPath.section {
            case 1 :
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ResturantHeaderCell.headerCell, for: indexPath) as! ResturantHeaderCell
                return header
            case 2 :
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ResturantHeaderCell.headerCell, for: indexPath) as! ResturantHeaderCell
                header.allRestaurants.text = "All Rasturans"
                return header
            default:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ResturantHeaderCell.headerCell, for: indexPath) as! ResturantHeaderCell
               
                return header
            }
        }
        else {
            return UICollectionReusableView()
        }
    }
    
}

//MARK: - Actions
extension CompositionalLayoutVC {
    
    @IBAction func  tapToBack( _ sender : UIButton){
        navigationController?.popViewController(animated: true)
    }
}
