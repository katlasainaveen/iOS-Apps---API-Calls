//
//  Manager.swift
//
//  Created by Sai Naveen Katla on 07/09/20.
//

import Foundation

protocol CoinManagerDelegate {
    func updateRte(_ manager: Manager, info: DataModel)
    func errorOccured(_ manage: Manager, error: Error)
}

struct Manager {
    
    var delegate: CoinManagerDelegate?
    
    func fetch(currency: String) {
        let fetchURL = "https://rest.coinapi.io/v1/exchangerate/BTC/\(currency)?apikey=KEY" 
        performRequest(url: fetchURL)
    }
    
    func performRequest(url: String) {
        //create a url
        if let Url = URL(string: url) {
            //create a session
            let session = URLSession(configuration: .default)
            //add task to session
            let task = session.dataTask(with: Url) { (data, response, error) in
                if error == nil {
                    if let safedata = data {
                        if let info = self.performJSON(data: safedata) {
                            self.delegate?.updateRte(self, info: info)
                        }
                    }
                }
                else {
                    print(error!)
                }
            }
            task.resume()
        }
        
    }
    
    func performJSON(data: Data) -> DataModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(DataModel.self, from: data)
            let rate = decodedData.rate
            let datamodel = DataModel(rate: rate)
            return datamodel
        }
        catch {
            delegate?.errorOccured(self, error: error)
            print(error)
            return nil
        }
        
    }
}
