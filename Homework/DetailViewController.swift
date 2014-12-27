//
//  DetailViewController.swift
//  Homework
//
//  Created by Carlos Beltran on 12/26/14.
//  Copyright (c) 2014 Carlos. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    var homework:HomeworkModel!
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if homework != nil {
            titleField.text = homework.title
            descriptionField.text = homework.details
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        if homework != nil {
            homework.title = titleField.text
            homework.details = descriptionField.text
            
            let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
            appDelegate.saveContext()
            
        }
        else {
            let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
            
            let managedObjectContext = appDelegate.managedObjectContext
            
            let entityDescription = NSEntityDescription.entityForName("HomeworkModel", inManagedObjectContext: managedObjectContext!)
            
            let newHomework = HomeworkModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
            
            newHomework.title = titleField.text
            newHomework.details = descriptionField.text
            
            appDelegate.saveContext()
            
            // Request all instances of TaskModel entity
            var request = NSFetchRequest(entityName: "HomeworkModel")
            var error:NSError? = nil
            
            // Execute the fetch request 'request', store what we get back in array 'results'
            var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
            
            for res in results {
                println(res)
            }
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
}
