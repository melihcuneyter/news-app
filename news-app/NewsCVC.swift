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
        contentView.backgroundColor = .red
    }
    
    func configureCell(arr: [String]) {
        let url = URL(string: arr[3])
        // TODO: - fix font charachter
        titleLabel.text = arr[1].uppercased()
        descLabel.text = arr[2]
        imageView.kf.setImage(with: url)
    }
}
