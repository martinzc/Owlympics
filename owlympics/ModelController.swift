//
//  ModelController.swift
//  pageTest
//
//  Created by Martin Zhou on 9/11/15.
//  Copyright (c) 2015 Martin Zhou. All rights reserved.
//

import UIKit

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


class ModelController: NSObject, UIPageViewControllerDataSource {

    var pageData = NSArray()


    override init() {
        super.init()
        // Create the data model.
        let dateFormatter = NSDateFormatter()
        pageData = dateFormatter.monthSymbols
    }

    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> SummaryViewController? {
        // Return the data view controller for the given index.
        if (self.pageData.count == 0) || (index >= self.pageData.count) {
            return nil
        }

        // Create a new view controller and pass suitable data.
        let dataViewController = storyboard.instantiateViewControllerWithIdentifier("SummaryViewController") as! SummaryViewController
        
//        Set the title to be the proper month
        dataViewController.dataObject = self.pageData[index]
//        Load local data and count visits, activities and hours
        let exerciseList = loadFromLocal()
//        Get to know which month it is
        let month = index + 1
        var visit = 0
        var activity = 0
        var duration = 0
        var arrivalTimeTracker:Array = [NSDate]()
        
//        Update all entires
        for eachExercise in exerciseList {
//            Change things if it is in current month
            if getMonthOfYear(NSDate()) == getMonthOfYear(eachExercise.arrivaltime) {
//                Update the exercise data
                dataViewController.exerciseArray.append(eachExercise)
//                Update the visit
                if !contains(arrivalTimeTracker, eachExercise.arrivaltime) {
                    arrivalTimeTracker.append(eachExercise.arrivaltime)
                    visit += 1
                }
//                Update the activity
                activity += 1
//                Update the hour
                duration += eachExercise.duration.toInt()!
            }
        }
        
//        Update the entries in SummaryViewController
        dataViewController.activityText = "\(activity)"
        dataViewController.visitText = "\(visit)"
        dataViewController.minText = "\(duration)"
        
        
        
        return dataViewController
    }

    func indexOfViewController(viewController: SummaryViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        if let dataObject: AnyObject = viewController.dataObject {
            return self.pageData.indexOfObject(dataObject)
        } else {
            return NSNotFound
        }
    }

    // MARK: - Page View Controller Data Source

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! SummaryViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! SummaryViewController)
        if index == NSNotFound {
            return nil
        }
        
        index++
        if index == self.pageData.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

}

