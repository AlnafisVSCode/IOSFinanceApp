//
//  HelpGuideViewController.swift
//  FinanceApp
//
//  Created by Alnafis Chowdhury on 07/03/2022.
//

import UIKit

class HelpGuideViewController: UIViewController {

    @IBOutlet weak var HelpPage: UILabel!
    @IBOutlet weak var DescriptionMortgage: UILabel!
    @IBOutlet weak var CompundSavings: UILabel!
    @IBOutlet weak var CompundSavingDescription: UILabel!
    @IBOutlet weak var SimpleSavingsLabel: UILabel!
    @IBOutlet weak var simpleSavingDesc: UILabel!
    @IBOutlet weak var segmentedOutlet: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Default data view
        self.HelpPage.text = "Loans / Mortgage"
        self.DescriptionMortgage.text = "A mortgage loan is a secured loan that allows people to borrow money by providing an immovable asset, such as a house or commercial property, as collateral to the lender."
        
        self.CompundSavings.text = "Compound Savings"
        self.CompundSavingDescription.text = "Compound Saving allows people to earn compound interest on initial principal invested in addition to interest that accumulates over time. To receive interest based on the amount deposited."
        
        self.SimpleSavingsLabel.text = "Simple Saving"
        self.simpleSavingDesc.text = "Simple savings account is a type of bank account that gives you a safe place to store your money and earn compounding interest."
        
        // Do any additional setup after loading the view.
    }
    
    
    //Seperator of 2 Sections. Changes valaues in the text fields depending on the case
    @IBAction func segmentedAction(_ sender: UISegmentedControl) {
        switch segmentedOutlet.selectedSegmentIndex
        {
        case 0:
            DescriptionMortgage.text = "A mortgage loan is a secured loan that allows people to borrow money by providing an immovable asset, such as a house or commercial property, as collateral to the lender."

            CompundSavingDescription.text = "Compound Saving allows people to earn compound interest on initial principal invested in addition to interest that accumulates over time. To receive interest based on the amount deposited."
            

            simpleSavingDesc.text = "Simple savings account is a type of bank account that gives you a safe place to store your money and earn compounding interest."
            
        case 1:
            DescriptionMortgage.text = "To calculate the mortgage loan : Required to fill in three fields from the following text fields, Loan Amount, Interest, Monthly payment or Number of Payments. Interest Rate Must be Filled!"


            CompundSavingDescription.text = "To calculate the compound saving : Required to fill in four fields from the following, principal amount, interest, monthly payment, future value and number of payment. Interest Rate Must be Filled!"


            simpleSavingDesc.text = "To calculate the simple saving : Required to fill in three fields from principal amount, interest, future value and number of payment. Interest rate can be left not filled!"
        default:
            break;
            
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
