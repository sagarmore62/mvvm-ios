//
//  MovieListCollectionViewCell.swift
//  MVVM-iOS
//
//  Created by Sagar More on 24/03/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgMovie : UIImageView!
    @IBOutlet weak var lblMoveName : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgMovie.layer.masksToBounds = true
        imgMovie.layer.cornerRadius = 5.0
    }
    
    func configureCell(_ data : MovieObject) {
        lblMoveName.text =  data.title
        ImageService.getImagen(name: data.poster_path, size: 300) { (img) in
            self.imgMovie.image = img
        }
        
    }
    
}
