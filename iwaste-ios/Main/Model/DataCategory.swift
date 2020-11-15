//
//  DataCategory.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 15/10/20.
//

import UIKit

let straw = Waste(wasteName: NSLocalizedString("wastename_straw", comment: "Straw"), wasteImg: UIImage(named: "inputStraw")!)
let bottle = Waste(wasteName: NSLocalizedString("wastename_bottle", comment: "Bottle"), wasteImg: UIImage(named: "inputBottle")!)
let snackPackage = Waste(wasteName: NSLocalizedString("wastename_snackpackage", comment: "Snack Package"), wasteImg: UIImage(named: "inputSnackPackage")!)
let drinkCup = Waste(wasteName: NSLocalizedString("wastename_drinkcup", comment: "Drink Cup"), wasteImg: UIImage(named: "inputDrinkCup")!)
let plasticBag = Waste(wasteName: NSLocalizedString("wastename_plasticbag", comment: "Plastic Bag"), wasteImg: UIImage(named: "inputPlasticBag")!)
let plasticOther = Waste(wasteName: NSLocalizedString("wastename_other", comment: "Other"), wasteImg: UIImage(named: "otherPlastic")!)
let catPlastic = ModelWaste(categoryName: NSLocalizedString("categoryname_plastic", comment: "Plastic"), categoryImg: UIImage(named: "inputPlastic")!, waste: [straw, bottle, snackPackage, drinkCup, plasticBag, plasticOther])

let jar = Waste(wasteName: NSLocalizedString("wastename_jar", comment: "Jar"), wasteImg: UIImage(named: "inputjar")!)
let glassCup = Waste(wasteName: NSLocalizedString("wastename_glasscup", comment: "Glass Cup"), wasteImg: UIImage(named: "inputGlassCup")!)
let ceramicCup = Waste(wasteName: NSLocalizedString("wastename_ceramiccup", comment: "Ceramic Cup"), wasteImg: UIImage(named: "inputCeramicCup")!)
let glassBottle = Waste(wasteName: NSLocalizedString("wastename_glassbottle", comment: "Glass Bottle"), wasteImg: UIImage(named: "inputGlassBottle")!)
let plate = Waste(wasteName: NSLocalizedString("wastename_plate", comment: "Plate"), wasteImg: UIImage(named: "inputPlate")!)
let glassOther = Waste(wasteName: NSLocalizedString("wastename_other2", comment: "Other"), wasteImg: UIImage(named: "otherGlass")!)
let catGlass = ModelWaste(categoryName: NSLocalizedString("categoryname_glass", comment: "Glass"), categoryImg: UIImage(named: "inputGlass")!, waste: [jar, glassCup, ceramicCup, glassBottle, plate,glassOther])

let foodBox = Waste(wasteName: NSLocalizedString("wastename_foodbox", comment: "Food Box"), wasteImg: UIImage(named: "inputFoodBox")!)
let hardBox = Waste(wasteName: NSLocalizedString("wastename_hardbox", comment: "Hard Box"), wasteImg: UIImage(named: "inputHardBox")!)
let softBox = Waste(wasteName: NSLocalizedString("wastename_softbox", comment: "Soft Box"), wasteImg: UIImage(named: "inputSoftBox")!)
let paperDrinkCup = Waste(wasteName: NSLocalizedString("wastename_drinkcup", comment: "Drink Cup"), wasteImg: UIImage(named: "inputDrinkCupPaper")!)
let papers = Waste(wasteName: NSLocalizedString("wastename_papers", comment: "Papers"), wasteImg: UIImage(named: "inputPapers")!)
let paperOther = Waste(wasteName: NSLocalizedString("wastename_other3", comment: "Other"), wasteImg: UIImage(named: "otherPaper")!)
let catPaper = ModelWaste(categoryName: NSLocalizedString("categoryname_paper", comment: "Paper"), categoryImg: UIImage(named: "inputPaper")!, waste: [foodBox, hardBox, softBox, paperDrinkCup, papers, paperOther])

let foodCans = Waste(wasteName: NSLocalizedString("wastename_foodcans", comment: "Food Cans"), wasteImg: UIImage(named: "inputFoodCans")!)
let beverageCans = Waste(wasteName: NSLocalizedString("wastename_beveragecans", comment: "Beverage Cans"), wasteImg: UIImage(named: "inputBeverageCans")!)
let screwUtensils = Waste(wasteName: NSLocalizedString("wastename_screwutensils", comment: "Screw Utensils"), wasteImg: UIImage(named: "inputScrewUtensils")!)
let battery = Waste(wasteName: NSLocalizedString("wastename_battery", comment: "Battery"), wasteImg: UIImage(named: "inputBattery")!)
let sprayCan = Waste(wasteName: NSLocalizedString("wastename_spraycan", comment: "Spray Can"), wasteImg: UIImage(named: "inputSprayCan")!)
let metalOther = Waste(wasteName: NSLocalizedString("wastename_other4", comment: "Other"), wasteImg: UIImage(named: "otherMetal")!)
let catMetal = ModelWaste(categoryName: NSLocalizedString("categoryname_metal", comment: "Metal"), categoryImg: UIImage(named: "inputMetal")!, waste: [foodCans, beverageCans, screwUtensils, battery, sprayCan, metalOther])

let leftovers = Waste(wasteName: NSLocalizedString("wastename_leftovers", comment: "Leftovers"), wasteImg: UIImage(named: "inputLeftovers")!)
let cigarette = Waste(wasteName: NSLocalizedString("wastename_cigarette", comment: "Cigarette"), wasteImg: UIImage(named: "inputCigarette")!)
let leaves = Waste(wasteName: NSLocalizedString("wastename_leaves", comment: "Leaves"), wasteImg: UIImage(named: "inputLeaves")!)
let eggshell = Waste(wasteName: NSLocalizedString("wastename_eggshell", comment: "Eggshell"), wasteImg: UIImage(named: "inputEggshell")!)
let rindWeevils = Waste(wasteName: NSLocalizedString("wastename_rindweevils", comment: "Rind Weevils"), wasteImg: UIImage(named: "inputRindWeevils")!)
let organicOther = Waste(wasteName: NSLocalizedString("wastename_other5", comment: "Other"), wasteImg: UIImage(named: "otherOrganic")!)
let catOrganic = ModelWaste(categoryName: NSLocalizedString("categoryname_organic", comment: "Organic"), categoryImg: UIImage(named: "inputOrganic")!, waste: [leftovers, cigarette, leaves, eggshell, rindWeevils,organicOther])

let styrofoam = Waste(wasteName: NSLocalizedString("wastename_styrofoam", comment: "Styrofoam"), wasteImg: UIImage(named: "inputStraw")!)
let diapers = Waste(wasteName: NSLocalizedString("wastename_diapers", comment: "Diapers"), wasteImg: UIImage(named: "inputStraw")!)
let others = ModelWaste(categoryName: NSLocalizedString("categoryname_others", comment: "Others"), categoryImg: UIImage(named: "inputStraw")!, waste: [styrofoam, diapers])


let dataWaste: [ModelWaste] = [catPlastic, catGlass, catPaper, catMetal, catOrganic]
