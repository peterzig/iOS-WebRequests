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
        let session = NSURLSession.sharedSession() // in Swift 2 it was NSURLSession
        let url = NSURL(string:urlString)!
        
        session.dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            if let responseData = data {
                
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments)
                    
                    if let dict = json as? Dictionary<String, AnyObject> {
                        if let name = dict["name"] as? String, let height = dict["height"] as? String, let birth = dict["birth_year"] as? String, let hair = dict["hair_color"] as? String {
                            
                            var person = SWPerson(name: name, height: height, birthYear: birth, hairColor: hair)
                            
                            print(person.name)
                            print(person.height)
                            print(person.birthYear)
                            print(person.hairColor)
                        
                        }
                    }
                    
                    print(json)
                } catch {
                    print("Could not serialize")
                }
            } //take data and convert to JSON
        }.resume()
    }
}
