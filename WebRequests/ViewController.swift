//
//  ViewController.swift
//  WebRequests
//
//  Created by Peter Zaporowski on 06.04.2017.
//  Copyright © 2017 Peter Zaporowski. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "http://swapi.co/api/people/1/"
        let session = URLSession.shared // in Swift 2 it was NSURLSession
        let url = URL(string:urlString)!
        
        session.dataTask(with: url, completionHandler: { (data: Data?,response: URLResponse?,error: NSError?) -> Void in
            
            if let responseData = data {
                
                do{
                    let json = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.allowFragments)
                    
                    if let dict = json as? Dictionary<String, AnyObject> {
                        if let name = dict["name"] as? String, let height = dict["height"] as? String, let birth = dict["birth_year"] as? String, let hair = dict["hair_color"] as? String {
                            
                            var person = SWPerson(name: name, height: height, birthYear: birth, hairColor: hair)
                            
                            print(person.name)
                            print(person.height)
                            print(person.birthYear)
                            print(person.hairColor)
                        
                        }
                    }
                    
                    //print(json)
                } catch {
                    print("Could not serialize")
                }
            } //take data and convert to JSON
            } as? (Data?, URLResponse?, Error?) -> Void)
    }
}
