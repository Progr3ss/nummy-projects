//
//  RecipeModel.swift
//  nummy
//
//  Created by Martin Chibwe on 5/1/21.
//

import Foundation

struct RecipeModel {
    let url: String?
    let image: String?
    let source: String?
    let label: String?
    init(url: String, image: String, source: String, label: String) {
        self.url = url
        self.image = image
        self.source = source
        self.label = label
    }
    static func recipeFromResults(_ results: RecipeData) -> [RecipeModel] {
        var recipes = [RecipeModel]()
        if let resultData = results.hits {
            for (_, result) in resultData.enumerated() {
                recipes.append(RecipeModel(url: result.recipe?.url ?? "None", image:
                                                result.recipe?.image ?? "None", source:
                                                result.recipe?.source ?? "None", label:
                                                result.recipe?.label ?? "None"))
            }
        }
        return recipes
    }
}
