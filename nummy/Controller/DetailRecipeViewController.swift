//
//  DetailRecipeViewController.swift
//  nummy
//
//  Created by Martin Chibwe on 5/17/21.
//

import SwiftUI

struct DetailRecipeViewController: View {
   @State  var recipe: RecipeModel
    var body: some View {
        Text(recipe.label!)
    }
}
struct DetailRecipeViewController_Previews: PreviewProvider {
    static var previews: some View {
        DetailRecipeViewController(recipe: RecipeModel(url: "", image: "", source: "Hello", label: "Test"))
    }
}
