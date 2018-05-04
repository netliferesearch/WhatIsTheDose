//
//  FirstViewController.swift
//  WhatIsTheDose3
//
//  Created by Nils Norman Haukås on 02/05/2018.
//  Copyright © 2018 Nils Norman Haukås. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var bloodSugarInput: UITextField! {
        didSet { bloodSugarInput?.addDoneCancelToolbar(onDone: (target: self, action: #selector(bloodSugarDoneTapped))) }
    }
    
    @IBOutlet weak var carbohydratesInput: UITextField! {
        didSet { carbohydratesInput?.addDoneCancelToolbar() }
    }
    
    @IBOutlet weak var calculationResult: UILabel!
    
    @IBOutlet weak var calculationFullResult: UILabel!
    
    @IBOutlet weak var saveDoseButton: UIButton!
    
    let delay = 0.05
    var timer = Timer()
    
    // if first input field is filled out we jump to the next
    @objc func bloodSugarDoneTapped() {
        carbohydratesInput.becomeFirstResponder()
    }
    
    @IBAction func saveDoseButton(_ sender: UIButton) {
        print("Save button was pressed")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        timer.invalidate()
        //This function is called before the value hits the textField, thus we use a timer to wait just a smidge.
        timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false, block: { (timer: Timer) -> Void in self.doCalculation() })
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        doCalculation()
    }
    
    private func doCalculation () {
        let measuredBloodSugarLevel = parseTextAsDouble(bloodSugarInput.text)
        let plannedCarbIntake = parseTextAsDouble(carbohydratesInput.text)
        let recommendedDosage = calculateRecommendedDosage(measuredBloodSugar: measuredBloodSugarLevel, plannedCarbIntake: plannedCarbIntake)
        calculationFullResult.text = "\(recommendedDosage)"
        calculationResult.text = "\(roundToNearesHalf(recommendedDosage))"
    }
    
    func calculateRecommendedDosage(measuredBloodSugar: Double, plannedCarbIntake: Double) -> Double {
        let bloodSugarGoal = 5.0
        // Insulin sensitivity related to carbohydrates
        let IK = 7.0
        // Insulin sensitivity
        let IF = 1.5
        return plannedCarbIntake / IK + (measuredBloodSugar - bloodSugarGoal) / IF
    }
    
    func parseTextAsDouble (_ text: String?) -> Double {
        return Double((text ?? "").replacingOccurrences(of: ",", with: ".")) ?? 0.0
    }
    
    private func roundToNearesHalf(_ num: Double) -> Double {
        let decimals = num.truncatingRemainder(dividingBy: 1)
        var adjustment = 0.0
        if decimals >= 0.3 && decimals <= 0.75 {
            adjustment = 0.5
        } else if decimals > 0.75 {
            adjustment = 1.0
        } else if decimals < 0.3 {
            adjustment = 0.0
        }
        return (num - decimals) + adjustment
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bloodSugarInput.keyboardType = .decimalPad
        carbohydratesInput.keyboardType = .decimalPad
        bloodSugarInput.delegate = self
        carbohydratesInput.delegate = self
        calculationResult.text = ""
        calculationFullResult.text = ""
        // we want the first input to be active right away
        bloodSugarInput.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

