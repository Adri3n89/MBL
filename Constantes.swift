//
//  Constantes.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 17/11/2021.
//

import Foundation

struct Constantes {
    
    static let urlTop50 = "https://api.factmaven.com/xml-to-json/?xml=https://api.geekdo.com/xmlapi2/hot?type=boardgame"
    static let urlByID = "https://api.factmaven.com/xml-to-json/?xml=https://api.geekdo.com/xmlapi2/thing?id="
    static func urlByName(name: String) -> String {
        return "https://api.factmaven.com/xml-to-json/?xml=https://api.geekdo.com/xmlapi2/search?query=\(name)&type=boardgame,boardgameaccessory,boardgameexpansion"
    }
    static let city = "City:"
    static let cityTF = " Enter your city here"
    static let logIn = "LogIn"
    static let logOut = "LogOut"
    static let signIn = "SignIn"
    static let signUp = "SignUp"
    static let gameType = ["Library", "Wishlist"]
    static let changePicture = "Change profil picture?"
    static let contact = "Contact"
    static let envelope = "envelope.fill"
    static let power = "power.circle.fill"
    static let cancel = "Cancel"
    static let camera = "Camera"
    static let gallery = "Gallery"
    static let background = "background"
    static let year = "Year: "
    static let player = "Players: "
    static let time = "Estimate play time: "
    static let noDescription = "Oups, no description for this game!"
    static let addLibrary = "Add to library ✅"
    static let addWish = "Add to wishlist 🙏🏻"
    static let removeLibrary = "Remove from library ❌"
    static let removeWish = "Remove from wishlist ❌"
    static let ok = "OK"
    static let createAccount = "Create Account"
    static let alreadyAccount = "Already have an account?"
    static let errorName = "Name and LastName must be complete"
    static let errorAdress = "Adress not determined, try with only your city"
    static let search = "Search"
    static let searchGame = "Enter your game name here"
    static let mgl = "M.G.L"
    static let myGameBoard = "My GameBoard Library"
    static let email = "E-mail:"
    static let emailTF = " Enter your email here"
    static let password = "Password:"
    static let passwordTF = " Enter your password here"
    static let name = "Name:"
    static let nameTF = " Enter your name here"
    static let lastName = "Lastname:"
    static let lastNameTF = " Enter your last name here"
    static let noAccount = "Don't have an account yet?"
    static let tab1 = "Top 50"
    static let tab1Logo = "arrow.up.square.fill"
    static let tab2 = "Search"
    static let tab2Logo = "magnifyingglass"
    static let tab3 = "Map"
    static let tab3Logo = "globe"
    static let tab4 = "Chat"
    static let tab4Logo = "message"
    static let tab5 = "Profil"
    static let tab5Logo = "person"
    static let mappPin = "mappin.circle.fill"
    static let arrow = "arrowtriangle.down.fill"
    static let refURL = "https://myboardgamelibrary-default-rtdb.europe-west1.firebasedatabase.app"
}
