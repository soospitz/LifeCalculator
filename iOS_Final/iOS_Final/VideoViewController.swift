//
//  VideoViewController.swift
//  iOS_Final
//
//  Created by Alex Jiang on 12/11/19.
//  Copyright © 2019 Michelle Choi. All rights reserved.
//

import UIKit
import CoreData
import WebKit

class VideoViewController: UIViewController {
    
    @IBOutlet weak var ytVidView: WKWebView!
    
    //Go back to home View Controller
    @IBAction func backHome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //function to fetch semester by name
    func fetchSemester(sem_name:String) -> NSManagedObject{
        let fetchRequestSemester = NSFetchRequest<NSFetchRequestResult>(entityName: "Sem")

        var semester: NSManagedObject?
        do {
            let result = try context!.fetch(fetchRequestSemester)
            for data in result as! [NSManagedObject] {
                if (data.value(forKey: "name") as! String) == sem_name {
                    semester = data //theSemester Object?
                    break;
                }            }
        } catch {
            
        }
        
        return semester!
    }
    
    //fetching semester by the key attribute of that semester
    //this solves the issue of tableview displaying semesters out of order
    func fetchSemesterByKey(key:Int) -> NSManagedObject{
        let fetchRequestSemester = NSFetchRequest<NSFetchRequestResult>(entityName: "Sem")

        var semester: NSManagedObject?
        do {
            let result = try context!.fetch(fetchRequestSemester)
            for data in result as! [NSManagedObject] {
                if (data.value(forKey: "key") as! Int) == key {
                    semester = data
                    break;
                }
            }
        } catch {
            
        }
        

        return semester!
    }
    
    //*******
    //extra function to return a list of all semester objects
    //use this for setting up the tableview
    //*******
    func semestersList() -> [NSManagedObject]{
        let fetchRequestSemester = NSFetchRequest<NSFetchRequestResult>(entityName: "Sem")
        var semList: [NSManagedObject]?
        do{
            let result = try context!.fetch(fetchRequestSemester)
            
            semList = (result as! [NSManagedObject])
        } catch{
            
        }
        return semList!
    }
    

    //    //*******
    //    //function 3 fetching semester element
    //    //********
    //when fetching element run this function in a loop of length 6 to get all the elements
    func fetchSemesterElement(semester: NSManagedObject) -> [NSManagedObject]{
        let fetchRequestElement = NSFetchRequest<NSFetchRequestResult>(entityName: "Element")
        var elements = [NSManagedObject]()
        do {
            let result = try context!.fetch(fetchRequestElement)
            
            for data in result as! [NSManagedObject] {
                if (data.value(forKey: "sem_link") as! String) == (semester.value(forKey: "name") as! String) {
                    elements.append(data)
                }
            }
            
        } catch {
            
        }
        return elements
    }
    
    //function to fetch a youtube video url
    func getVideo(videoCode:String){
        let url = URL(string: "https://www.youtube.com/watch?v=\(videoCode)")
        ytVidView.load(URLRequest(url: url!))
    }
    
    var appDelegate: AppDelegate?
    
    var context: NSManagedObjectContext?
    
    var suggestionLabel: UILabel!
    var suggestionLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        
        context = self.appDelegate!.persistentContainer.viewContext
        
        //retrieving the element of the current semester with the highest weight
        print(1)
        let thisSem = fetchSemesterByKey(key: semestersList().count)
        var thisEle = fetchSemesterElement(semester: thisSem)[0]
        for ele in fetchSemesterElement(semester: thisSem){
            //if next element in list's weight is greater than current element then
            //choose next element's weight
            if (ele.value(forKey: "weight") as!Float) > (thisEle.value(forKey:"weight") as!Float){
                thisEle = ele
            }
        }
        
        //print(thisEle.value(forKey: "name") as!String)
        //print(thisEle)
        //print(thisEle.value(forKey:"score") as!Float)



        //if internship is their highest weight but they are not doing excellent
        if (((thisEle.value(forKey: "name") as!String) == "Internship") && ((thisEle.value(forKey: "score") as!Float) <= 0.85)){
            getVideo(videoCode:"MhTDp5FwfmM")
            self.suggestionLabel = UILabel()
            self.suggestionLabel.font = UIFont.boldSystemFont(ofSize: 20)
            self.suggestionLabel.text = ("Beep -> Boop -> Bop -> 100k salary.")
            self.suggestionLabel.sizeToFit()
            self.suggestionLabel.center = CGPoint(x:210, y:580)
            self.view.addSubview(self.suggestionLabel)
            self.suggestionLabel2 = UILabel()
            self.suggestionLabel2.font = UIFont.boldSystemFont(ofSize: 20)
            self.suggestionLabel2.text = ("Get back on the Leetcode grind.")
            self.suggestionLabel2.sizeToFit()
            self.suggestionLabel2.center = CGPoint(x:210, y:610)
            self.view.addSubview(self.suggestionLabel2)
        }

        
        //relationship
        else if (((thisEle.value(forKey: "name") as!String) == "Relationship") && ((thisEle.value(forKey: "score") as!Float) <= 0.85)){
            getVideo(videoCode:"xa-4IAR_9Yw")
            self.suggestionLabel = UILabel()
            self.suggestionLabel.font = UIFont.boldSystemFont(ofSize: 20)
            self.suggestionLabel.text = ("It's okay, you should value your own freedom.")
            self.suggestionLabel.sizeToFit()
            self.suggestionLabel.center = CGPoint(x:210, y:580)
            self.view.addSubview(self.suggestionLabel)
            self.suggestionLabel2 = UILabel()
            self.suggestionLabel2.font = UIFont.boldSystemFont(ofSize: 20)
            self.suggestionLabel2.text = ("Its better to be single.")
            self.suggestionLabel2.sizeToFit()
            self.suggestionLabel2.center = CGPoint(x:210, y:610)
            self.view.addSubview(self.suggestionLabel2)
        }

        //classes
        else if (((thisEle.value(forKey: "name") as!String) == "Classes") && ((thisEle.value(forKey: "score") as!Float) <= 0.85)){
            getVideo(videoCode:"9dgmp3KmwGg")
            self.suggestionLabel = UILabel()
            self.suggestionLabel.font = UIFont.boldSystemFont(ofSize: 20)
            self.suggestionLabel.text = ("Another final another all nighter.")
            self.suggestionLabel.sizeToFit()
            self.suggestionLabel.center = CGPoint(x:210, y:580)
            self.view.addSubview(self.suggestionLabel)
            self.suggestionLabel2 = UILabel()
            self.suggestionLabel2.font = UIFont.boldSystemFont(ofSize: 20)
            self.suggestionLabel2.text = ("Drink more red bull or idk, maybe more coffee.")
            self.suggestionLabel2.sizeToFit()
            self.suggestionLabel2.center = CGPoint(x:210, y:610)
            self.view.addSubview(self.suggestionLabel2)
        }

        //hobbies
        else if (((thisEle.value(forKey: "name") as!String) == "Hobbies") && ((thisEle.value(forKey: "score") as!Float) <= 0.85)){
            getVideo(videoCode:"Cv1RJTHf5fk")
            self.suggestionLabel = UILabel()
            self.suggestionLabel.font = UIFont.boldSystemFont(ofSize: 20)
            self.suggestionLabel.text = ("In this busy world we all put our passions behind.")
            self.suggestionLabel.sizeToFit()
            self.suggestionLabel.center = CGPoint(x:210, y:580)
            self.view.addSubview(self.suggestionLabel)
            self.suggestionLabel2 = UILabel()
            self.suggestionLabel2.font = UIFont.boldSystemFont(ofSize: 20)
            self.suggestionLabel2.text = ("Sucks to suck right? But no really go enjoy you time.")
            self.suggestionLabel2.sizeToFit()
            self.suggestionLabel2.center = CGPoint(x:210, y:610)
            self.view.addSubview(self.suggestionLabel2)
        }
        

        //sleep
        else if (((thisEle.value(forKey: "name") as!String) == "Sleep") && ((thisEle.value(forKey: "score") as!Float) <= 0.85)){
            getVideo(videoCode:"r32wheq4HAc")
            self.suggestionLabel = UILabel()
            self.suggestionLabel.font = UIFont.boldSystemFont(ofSize: 20)
            self.suggestionLabel.text = ("We all know you want to marry your bed.")
            self.suggestionLabel.sizeToFit()
            self.suggestionLabel.center = CGPoint(x:210, y:580)
            self.view.addSubview(self.suggestionLabel)
            self.suggestionLabel2 = UILabel()
            self.suggestionLabel2.font = UIFont.boldSystemFont(ofSize: 20)
            self.suggestionLabel2.text = ("Hit the hay a little earlier tonight.")
            self.suggestionLabel2.sizeToFit()
            self.suggestionLabel2.center = CGPoint(x:210, y:610)
            self.view.addSubview(self.suggestionLabel2)
        }

        //social
        else if (((thisEle.value(forKey: "name") as!String) == "Social") && ((thisEle.value(forKey: "score") as!Float) <= 0.85)){
            getVideo(videoCode:"WnbrbvmclHc")
            self.suggestionLabel = UILabel()
            self.suggestionLabel.font = UIFont.boldSystemFont(ofSize: 20)
            self.suggestionLabel.text = ("Honestly, its okay, as we get older we all lose friends.")
            self.suggestionLabel.sizeToFit()
            self.suggestionLabel.center = CGPoint(x:210, y:580)
            self.view.addSubview(self.suggestionLabel)
            self.suggestionLabel2 = UILabel()
            self.suggestionLabel2.font = UIFont.boldSystemFont(ofSize: 20)
            self.suggestionLabel2.text = ("Life will get brighter :D.")
            self.suggestionLabel2.sizeToFit()
            self.suggestionLabel2.center = CGPoint(x:210, y:610)
            self.view.addSubview(self.suggestionLabel2)
        }
        
        //else
        else{
            self.getVideo(videoCode:"Ll9nfNlDLII")
            self.suggestionLabel = UILabel()
            self.suggestionLabel.font = UIFont.boldSystemFont(ofSize: 20)
            self.suggestionLabel.text = ("You Smart You Loyal You a Genius")
            self.suggestionLabel.sizeToFit()
            self.suggestionLabel.center = CGPoint(x:320, y:102)
            self.view.addSubview(self.suggestionLabel)
        }
            
        
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
