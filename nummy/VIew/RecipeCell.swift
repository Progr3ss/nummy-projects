//
//  RecipeCell.swift
//  nummy
//
//  Created by Martin Chibwe on 5/3/21.
//

import UIKit

class RecipeCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var contentBackgroundView: UIView!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    var downloadTask: URLSessionDownloadTask?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        contentBackgroundView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //set the values for top,left,bottom,right margins
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(recipe: RecipeModel) {
        self.mainTitleLabel.text = recipe.label
        self.subTitleLabel.text = recipe.source
        if let smallURL = URL(string: recipe.image!) {
          downloadTask = mainImageView.loadImage(url: smallURL)
        }
    }
}
