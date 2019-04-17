//
//  ProductTableViewCell.swift
//  TestJSON
//
//  Created by Александр on 4/15/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell, UICollectionViewDelegate,UICollectionViewDataSource {
    
    let indenfy = "imageCell"
    var product: Product? {
        didSet {
            if let product = product {
                update(product)
            }
        }
    }
    var images: [UIImage] = []
    let url = "https://gist.githubusercontent.com/u-android/41ade05b6ae1133e7e86e9dfd55f1794/raw/bab1c383b0384d1a4c889b399ad7b13ae05634fa/ios%20challenge%20json"
    
    
    
    @IBOutlet weak var prodName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    func update(_ product: Product) {
        prodName.text = product.title
        for url in product.images {
            url.downloadImg { [weak self] image in
                guard let self = self, let image = image else { return }
                self.images.append(image)
                self.reloadCollectionView()
            }
        }
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellImage = collectionView.dequeueReusableCell(withReuseIdentifier: indenfy, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }

        cellImage.phoneImage.image = images[indexPath.row]
        
        return cellImage
    }
}
