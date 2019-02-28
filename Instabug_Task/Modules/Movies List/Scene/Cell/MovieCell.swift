//
//  MovieCell.swift
//  Instabug_Task
//
//  Created by Islam Soliman on 2/25/19.
//  Copyright © 2019 Islam Soliman. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with movie: MovieViewModel) {
        
        layoutIfNeeded()
        
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        dateLabel.text = movie.date
        
        setPoster(with: movie.posterPath, or: movie.poster)
        
    }
    
    private func setPoster(with posterPath: String, or poster:UIImage?) {
        
        guard poster == nil else {
            
            posterImage.image = poster!
            return
        }
        
        posterImage.image = UIImage(named: "movie_placeholder")
        ImageDownloader.getImage(at: posterPath, success: { [weak self] (image) in
            
            self?.posterImage.image = image
        }) { [weak self] in
            
            self?.posterImage.image = UIImage(named: "movie_placeholder")
        }
    }

}
