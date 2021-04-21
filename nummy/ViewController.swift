//
//  ViewController.swift
//  nummy
//
//  Created by Martin Chibwe on 3/26/21.
//

import UIKit

class ViewController: UIViewController {
    var edamamResults: EdamamResults?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
// MARK: Network Helper Methods
extension ViewController {
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
    // MARK: - getRecipe with query search
    func getRecipe(query: String) {
        let param =  methodParapeters(ingridents: 5, diet: "balanced", health: "soy-free", calories: 500, from: 0, toPage: 200)
        let url3 = edamanURLFromParameters(query: query, parameters: param)
        let task = URLSession.shared.dataTask(with: url3) { (data, response, error) in
            guard error == nil else{
                print("There was an error with your request: ", error!.localizedDescription)
                return
            }
            guard data != nil else{
                print("No data was returned by the request")
                return
            }
            do {
                if let jsonObject = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                    self.edamamResults = EdamamResults(jsonObject)
                    DispatchQueue.main.async {
//                        self.forYouTableView.reloadData()
                    }
                }
            }catch {
                print("Could not parse the data as JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}

