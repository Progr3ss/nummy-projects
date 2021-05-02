//
//  Constants.swift
//  nummy
//
//  Created by Martin Chibwe on 4/19/21.
//

import Foundation
// MARK: - Constants
struct Constants {
    struct APIKeys {
        static let appKey = "4d45a9963d006ce6d48275df6482643b"
        static let appId = "b088da30"
    }
    struct Edamam {
        static let APIScheme = "https"
        static let APIHost = "api.edamam.com"
        static let APIPath = "/search"
    }
    struct EdamamParameterKeys {
        static let Query = "q"
        static let AppID = "app_id"
        static let Appkey = "app_key"
        static let Ingridents = "ingr"
        static let Diet = "diet"
        static let Health = "health"
        static let Calories = "calories"
        static let FromPage = "from"
        static let ToPage = "to"
        static let Exclused = "excluded"
        static let Time = "time"
    }
}
