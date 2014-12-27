//
//  ViewController.swift
//  Homework
//
//  Created by Carlos Beltran on 12/26/14.
//  Copyright (c) 2014 Carlos. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchedResultsController = getFetchedResultsController()
    
        fetchedResultsController.delegate = self
        
        fetchedResultsController.performFetch(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showDetail") {
            let detailController:DetailViewController = segue.destinationViewController as DetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            let hw = fetchedResultsController.objectAtIndexPath(indexPath!) as HomeworkModel
            detailController.homework = hw
        }
        else {
            println("Error: prepareForSegue")
        }
    }

    @IBAction func addHomework(sender: UIBarButtonItem) {
        performSegueWithIdentifier("showDetail", sender: self)
    }
    
    //UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:HomeworkCell = tableView.dequeueReusableCellWithIdentifier("myCell") as HomeworkCell
        var thisEntry = fetchedResultsController.objectAtIndexPath(indexPath) as HomeworkModel
        
        cell.homeWorkLabel.text = thisEntry.title
        
        return cell
    }
    
    // UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showDetail", sender: self)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "To Do"
        }
        else {
            return "Error"
        }
    }
    
    // NSFetchResultsController
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    func homeworkRequest() -> NSFetchRequest {
        let request = NSFetchRequest(entityName: "HomeworkModel")
        return request
    }

    func getFetchedResultsController() -> NSFetchedResultsController {
        fetchedResultsController = NSFetchedResultsController(fetchRequest: homeworkRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController
    }

}



