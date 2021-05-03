//
//  RecipeCell.swift
//  nummy
//
//  Created by Martin Chibwe on 5/3/21.
//

import UIKit

class RecipeCell: UITableViewCell {

    @IBOutlet weak var mainTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(recipe: RecipeModel) {
        self.mainTitleLabel.text = "martin"
        print("recpieCell ", recipe)
    }
}
