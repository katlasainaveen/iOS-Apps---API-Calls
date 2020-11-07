//
//  ViewController.swift
//  CoinAPI rate
//
//  Created by Sai Naveen Katla on 07/09/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var currencyLbl: UILabel!
    @IBOutlet weak var pickerview: UIPickerView!
    
    let manager = CoinManager()
    var manager2 = Manager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerview.dataSource = self
        pickerview.delegate = self
        
        manager2.delegate = self
    }


}

//MARK: - UIPickerViewDelegate

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return manager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return manager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyLbl.text = manager.currencyArray[row]
        manager2.fetch(currency: manager.currencyArray[row])
    }
    
    
}

//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    
    func updateRte(_ manager: Manager, info: DataModel) {
        DispatchQueue.main.async {
            self.rateLbl.text = String(format: "%.3f", info.rate)
        }
    }
    
    func errorOccured(_ manage: Manager, error: Error) {
        print(error)
    }
}

