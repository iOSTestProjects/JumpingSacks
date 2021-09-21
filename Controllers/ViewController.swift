//
//  ViewController.swift
//  InterviewTasks
//
//  Created by Thejas K on 21/09/21.
//

import UIKit

class ViewController: UIViewController  , UITextFieldDelegate {
    @IBOutlet weak var setRepsLabel: UILabel?
    @IBOutlet weak var searchField: UITextField?
    
    var jumpingSacksSetReps = ""
    var lumpingJacksSetReps = ""
    
    var exercise : ExerciseList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchField?.delegate = self
        getDataFromJson()
        
        let tapper = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        self.view.addGestureRecognizer(tapper)
        self.view.isUserInteractionEnabled = true
    }
    
    func getDataFromJson() {
        guard let path = Bundle.main.path(forResource: "jsonData", ofType: "json") else {return}
        
        let url = URL(fileURLWithPath: path)
        
        do {
            let jsonData = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let data = try decoder.decode(Exercise.self, from: jsonData)
            
            lumpingJacksSetReps = data.data[0].data[0].workouts.stages[0].exerciseList[0].setReps
            jumpingSacksSetReps = data.data[0].data[0].workouts.stages[0].exerciseList[1].setReps
            
            return
        } catch {
            print("Error decoding JSON : \(error)")
        }
    }
    
    @IBAction func showSetReps(_ sender: UIButton) {
        
        view.endEditing(true)
        
        if(searchField?.text == "Lumping Jacks") {
            setRepsLabel?.text = lumpingJacksSetReps
        } else if (searchField?.text == "Jumping Sacks") {
            setRepsLabel?.text = jumpingSacksSetReps
        } else {
            showAlert()
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Invalid Exercise", message: "Please enter Lumping Jacks or Jumping Sacks", preferredStyle: .alert)
        let done = UIAlertAction(title: "Done", style: .default) { _ in
            self.searchField?.placeholder = "Please enter valid exercise names"
        }
        
        alert.addAction(done)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func dissmissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: Textfield Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(searchField?.text == "Lumping Jacks") {
            setRepsLabel?.text = lumpingJacksSetReps
        } else if (searchField?.text == "Jumping Sacks") {
            setRepsLabel?.text = jumpingSacksSetReps
        } else {
            showAlert()
        }
        return true
    }
}

