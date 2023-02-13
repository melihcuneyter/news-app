//
//  NewsCVC.swift
//  news-app
//
//  Created by Melih Cüneyter on 8.02.2023.
//

import UIKit
import Kingfisher

class NewsCVC: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 10
        imageView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = .init(red: 255, green: 255, blue: 255, alpha: 1)
    }
    
    func configureCell(arr: [String]) {
        let url = URL(string: arr[3])
        // TODO: - fix font charachter
        titleLabel.text = arr[1].uppercased()
        descLabel.text = arr[2]
        imageView.kf.setImage(with: url)
    }
}
