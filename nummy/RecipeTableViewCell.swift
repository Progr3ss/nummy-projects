//
//  RecipeTableViewCell.swift
//  nummy
//
//  Created by Martin Chibwe on 4/22/21.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainFoodTitleLabel: UILabel!
    @IBOutlet weak var subTitleSourceLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    var edamamResults: EdamamResults?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureCell(with foodRecipe: EdamamResults, indexPath: IndexPath) {
        let recipeIndex = foodRecipe.hits[indexPath.row].recipe
        self.mainFoodTitleLabel.text = recipeIndex?.label
        self.subTitleSourceLabel.text = recipeIndex?.source
    }
}
