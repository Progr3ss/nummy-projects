//
//  ViewController.swift
//  nummy
//
//  Created by Martin Chibwe on 3/26/21.
//
// swiftlint:disable superfluous_disable_command trailing_newline
import UIKit

class MainRecipeViewController: UIViewController {
    var recipeResult: [RecipeModel] = [RecipeModel]()
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var slideBarButton: UIButton!
    @IBOutlet weak var  foodTableView: UITableView!
    @IBOutlet weak var recipeTableView: UITableView!
    var recipeNetworkManager = RecipeNetworkManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNetwork()
    }
    func setupUI() {
        let fontConfig = UIFont(name: "FontAwesome5Free-Solid", size: 25 )
        slideBarButton.titleLabel?.font = fontConfig
        searchButton.titleLabel?.font = fontConfig
        self.recipeTableView.delegate = self
        self.recipeTableView.dataSource = self
        recipeTableView.register(UINib(nibName: "RecipeCell", bundle: nil), forCellReuseIdentifier: "foodCell")
    }
    func setupNetwork() {
        recipeNetworkManager.delegate = self
        let param =  recipeNetworkManager.methodParapeters(ingridents: 5,
                                                           diet: "balanced",
                                                           health: "soy-free",
                                                           calories: 500,
                                                           from: 0,
                                                           toPage: 50)
        let url3 = recipeNetworkManager.edamanURLFromParameters(query: "chicken", parameters: param)
        recipeNetworkManager.performRequest(urlString: url3)
    }
}
extension MainRecipeViewController: RecipeNetworkManagerDelegate {
    func didFailWithError(error: Error) {
        print("RecipeNetworkError ", error)
    }
    func didUpdateRecipe(recipe: [RecipeModel]) {
        self.recipeResult = recipe
        DispatchQueue.main.async {
            self.recipeTableView.reloadData()
        }
    }
}
extension MainRecipeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeResult.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeTableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as! RecipeCell
        let recipes = self.recipeResult[indexPath.row]
        cell.configureCell(recipe: recipes)
        return cell
    }
}
