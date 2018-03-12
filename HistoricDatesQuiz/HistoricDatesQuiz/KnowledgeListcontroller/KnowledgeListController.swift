//
//  KnowledgeListController.swift
//  HistoricDatesQuiz
//
//  Created by Normand Martin on 18-01-11.
//  Copyright © 2018 Normand Martin. All rights reserved.
//

import UIKit

class KnowledgeListController: UITableViewController {
    var listOfDates = [String]()
    var listOfEventDescription = [String]()
    var arrayOfDates = [[String]]()
    var arrayOfEventDescription = [[String]]()
    var arraySectionSubject = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.plain, target: self, action: #selector(KnowledgeListController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        //let sumOfBadResponse = CountGoodOrBadResponse.sumOfBadResponses()
        //let sumOfGoodResponse = CountGoodOrBadResponse.sumOfGoodResponse()
        //let totalResponse = sumOfBadResponse + sumOfGoodResponse
        //let percentOfGoodResponse = Int(Double(sumOfGoodResponse) * 100/Double(totalResponse))
        for subject in arraySectionSubject{
            var listForSubject = [String]()
            listOfDates = []
            listOfEventDescription = []
            guard let finishedAndSelected = CodeDataHandler.filerForCompletedSelectedTitleOfTypeA(searchForTitlte: subject, inTitleAttribute: "selectedTitle") else {
                print("There is no completed events for this title")
                return
            }
            for event in finishedAndSelected{
                guard let newdate = event.date, let newEventDescription = event.eventDescription else {print("no event date or description"); return}
                listForSubject.append("\(newdate), \(newEventDescription)")
                listOfDates.append(newdate)
                listOfEventDescription.append(newEventDescription)
            }
            arrayOfDates.append(listOfDates)
            arrayOfEventDescription.append(listOfEventDescription)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return arraySectionSubject.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfEventDescription[section].count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arraySectionSubject[section]
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DateAndeventTableViewCell
        cell.columnDate.text = arrayOfDates[indexPath.section][indexPath.row]
        cell.columnEventDescription.text = arrayOfEventDescription[indexPath.section][indexPath.row]
        return cell
    }
    
    @objc func back(sender: UIBarButtonItem) {

        _ = navigationController?.popToRootViewController(animated: true)
    }
}