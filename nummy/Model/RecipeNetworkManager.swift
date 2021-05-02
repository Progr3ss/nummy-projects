//
//  RecipeNetworkManager.swift
//  nummy
//
//  Created by Martin Chibwe on 5/1/21.
//

import Foundation

protocol RecipeNetworkManagerDelegate: AnyObject {
    func didUpdateRecipe(recipe: [RecipeModel])
    func didFailWithError(error:Error)
}
class RecipeNetworkManager {
    weak var delegate: RecipeNetworkManagerDelegate?
    // MARK: - Methods Parameters fo Edamam api
    func methodParapeters(ingridents: Int, diet: String, health: String, calories: Int, from: Int, toPage: Int) -> [String: AnyObject] {
        let param = [Constants.EdamamParameterKeys.Ingridents: "\(ingridents)",
                     Constants.EdamamParameterKeys.Diet: diet,
                     Constants.EdamamParameterKeys.Health: health,
                     Constants.EdamamParameterKeys.Calories: "\(calories)",
                     Constants.EdamamParameterKeys.FromPage: "\(from)",
                     Constants.EdamamParameterKeys.ToPage: "\(toPage)"]
        return param as [String: AnyObject]
    }
    // MARK: - Create a link using Commponents
    func edamanURLFromParameters(query: String, parameters: [String: AnyObject]? = nil) -> URL {
        let components = NSURLComponents()
        components.scheme = Constants.Edamam.APIScheme
        components.host = Constants.Edamam.APIHost
        components.path = Constants.Edamam.APIPath
        components.queryItems = [NSURLQueryItem]() as [URLQueryItem]
        let queryItem0 = NSURLQueryItem(name: Constants.EdamamParameterKeys.Query, value: "\(query)")
        let queryItem1 = NSURLQueryItem(name: Constants.EdamamParameterKeys.AppID, value: Constants.APIKeys.appId)
        let queryItem2 = NSURLQueryItem(name: Constants.EdamamParameterKeys.Appkey, value: Constants.APIKeys.appKey)
        components.queryItems?.append(queryItem0 as URLQueryItem)
        components.queryItems?.append(queryItem1 as URLQueryItem)
        components.queryItems?.append(queryItem2 as URLQueryItem)
        for(key, value) in (parameters)! {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append( queryItem)
        }
        print("components \(components.url!)")
        return components.url!
    }
    //
    //
    func performRequest(urlString: URL?) {
        if let url = urlString {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: {(data, response, error) in
                if let error = error as NSError?, error.code == -999 {
                    print("performRequest Error")
                    self.delegate?.didFailWithError(error: error)
                    return
                } else if let httpRresponse = response as? HTTPURLResponse, httpRresponse.statusCode == 200 {
                    if let safeData = data {
                        if let recipeData =  self.parseJSON(recipeData: safeData) {
                            self.delegate?.didUpdateRecipe(recipe: recipeData)
                        }
                    }
                }
            })
            task.resume()
        }
    }
    func parseJSON(recipeData: Data) -> [RecipeModel]? {
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(RecipeData.self, from: recipeData)
            let recipeData = RecipeModel.recipeFromResults(result)
            return recipeData
        } catch {
            print("JSON Error: \(error)")
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
