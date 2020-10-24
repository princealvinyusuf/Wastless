//
//  DataCategory.swift
//  iwaste-ios
//
//  Created by Muhammad Hilmy Fauzi on 15/10/20.
//

import UIKit

let straw = Waste(wasteName: "Straw", wasteImg: UIImage(named: "inputStraw")!)
let bottle = Waste(wasteName: "Bottle", wasteImg: UIImage(named: "inputBottle")!)
let snackPackage = Waste(wasteName: "Snack Package", wasteImg: UIImage(named: "inputSnackPackage")!)
let drinkCup = Waste(wasteName: "Drink Cup", wasteImg: UIImage(named: "inputDrinkCup")!)
let plasticBag = Waste(wasteName: "Plastic Bag", wasteImg: UIImage(named: "inputPlasticBag")!)
let plasticOther = Waste(wasteName: "Other", wasteImg: UIImage(named: "otherPlastic")!)
let catPlastic = ModelWaste(categoryName: "Plastic", categoryImg: UIImage(named: "inputPlastic")!, waste: [straw, bottle, snackPackage, drinkCup, plasticBag, plasticOther])

let jar = Waste(wasteName: "Jar", wasteImg: UIImage(named: "inputjar")!)
let glassCup = Waste(wasteName: "Glass Cup", wasteImg: UIImage(named: "inputGlassCup")!)
let ceramicCup = Waste(wasteName: "Ceramic Cup", wasteImg: UIImage(named: "inputCeramicCup")!)
let glassBottle = Waste(wasteName: "Glass Bottle", wasteImg: UIImage(named: "inputGlassBottle")!)
let plate = Waste(wasteName: "Plate", wasteImg: UIImage(named: "inputPlate")!)
let glassOther = Waste(wasteName: "Other", wasteImg: UIImage(named: "otherGlass")!)
let catGlass = ModelWaste(categoryName: "Glass", categoryImg: UIImage(named: "inputGlass")!, waste: [jar, glassCup, ceramicCup, glassBottle, plate,glassOther])

let foodBox = Waste(wasteName: "Food Box", wasteImg: UIImage(named: "inputFoodBox")!)
let hardBox = Waste(wasteName: "Hard Box", wasteImg: UIImage(named: "inputHardBox")!)
let softBox = Waste(wasteName: "Soft Box", wasteImg: UIImage(named: "inputSoftBox")!)
let paperDrinkCup = Waste(wasteName: "Drink Cup", wasteImg: UIImage(named: "inputDrinkCupPaper")!)
let papers = Waste(wasteName: "Papers", wasteImg: UIImage(named: "inputPapers")!)
let paperOther = Waste(wasteName: "Other", wasteImg: UIImage(named: "otherPaper")!)
let catPaper = ModelWaste(categoryName: "Paper", categoryImg: UIImage(named: "inputPaper")!, waste: [foodBox, hardBox, softBox, paperDrinkCup, papers, paperOther])

let foodCans = Waste(wasteName: "Food Cans", wasteImg: UIImage(named: "inputFoodCans")!)
let beverageCans = Waste(wasteName: "Beverage Cans", wasteImg: UIImage(named: "inputBeverageCans")!)
let screwUtensils = Waste(wasteName: "Screw Utensils", wasteImg: UIImage(named: "inputScrewUtensils")!)
let battery = Waste(wasteName: "Battery", wasteImg: UIImage(named: "inputBattery")!)
let sprayCan = Waste(wasteName: "Spray Can", wasteImg: UIImage(named: "inputSprayCan")!)
let metalOther = Waste(wasteName: "Other", wasteImg: UIImage(named: "otherMetal")!)
let catMetal = ModelWaste(categoryName: "Metal", categoryImg: UIImage(named: "inputMetal")!, waste: [foodCans, beverageCans, screwUtensils, battery, sprayCan, metalOther])

let leftovers = Waste(wasteName: "Leftovers", wasteImg: UIImage(named: "inputLeftovers")!)
let cigarette = Waste(wasteName: "Cigarette", wasteImg: UIImage(named: "inputCigarette")!)
let leaves = Waste(wasteName: "Leaves", wasteImg: UIImage(named: "inputLeaves")!)
let eggshell = Waste(wasteName: "Eggshell", wasteImg: UIImage(named: "inputEggshell")!)
let rindWeevils = Waste(wasteName: "Rind Weevils", wasteImg: UIImage(named: "inputRindWeevils")!)
let organicOther = Waste(wasteName: "Other", wasteImg: UIImage(named: "otherOrganic")!)
let catOrganic = ModelWaste(categoryName: "Organic", categoryImg: UIImage(named: "inputOrganic")!, waste: [leftovers, cigarette, leaves, eggshell, rindWeevils,organicOther])

let styrofoam = Waste(wasteName: "Styrofoam", wasteImg: UIImage(named: "inputStraw")!)
let diapers = Waste(wasteName: "Diapers", wasteImg: UIImage(named: "inputStraw")!)
let others = ModelWaste(categoryName: "Others", categoryImg: UIImage(named: "inputStraw")!, waste: [styrofoam, diapers])


let dataWaste: [ModelWaste] = [catPlastic, catGlass, catPaper, catMetal, catOrganic]



var category = [CategoryCD]()

var trashPlastic = [TrashCD]()
var trashGlass = [TrashCD]()
var trashPaper = [TrashCD]()
var trashMetal = [TrashCD]()
var trashOrganic = [TrashCD]()

var plasticDataCD = TrashData(trashname: "Plastic", trash: trashPlastic)
var glassDataCD = TrashData(trashname: "Glass", trash: trashGlass)
var paperDataCD = TrashData(trashname: "Paper", trash: trashPaper)
var metalDataCD = TrashData(trashname: "Metal", trash: trashMetal)
var organicDataCD = TrashData(trashname: "Organic", trash: trashOrganic)


var trashDataCD: [TrashData] = [plasticDataCD, glassDataCD, paperDataCD, metalDataCD, organicDataCD]
