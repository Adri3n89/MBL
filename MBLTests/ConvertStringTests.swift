//
//  ConvertStringTests.swift
//  ApiServiceTest
//
//  Created by Adrien PEREA on 31/12/2021.
//

import Foundation
import XCTest
@testable import MBL

class ConvertStringTests: XCTestCase {
    
    func testConvertStringForSearch() {
        
        var name = "7 Wonders"
        var name2 = "Pirate's Treasure"
        var name3 = "Ca/tan:"
        
        name = name.convertForSearch()
        name2 = name2.convertForSearch()
        name3 = name3.convertForSearch()
        
        XCTAssertEqual(name, "7_Wonders")
        XCTAssertEqual(name2, "Pirates_Treasure")
        XCTAssertEqual(name3, "Catan:")
        
    }
    
    func testDecodeDescriptionFromXML() {
        let decodedText =
        """
        A set collecting game. The four cards to a set tell a story. The first is the Victim, the 2nd is the Trap, the 3rd is Caught!, and the 4th is the Escape!
        
        Players are given an agreed number of counters, some of which are added to the Pool. When you take certain actions, you may have to put more counters into the Pool or you might be lucky enough to take counters from the Pool. The one with the most counters after all sets have been collected, wins.

        The game must be Victorian (for example, one card makes mention of crinolene, an essential part of a Victorian lady's fashionable attire.

        No artist mentioned, which is a shame because the illustrations are of a very high quality.

        Any number of persons may play. If five play. Ten sets only are used. If seven, the dealer has one card short.
        The cards (which are termed the “Victim” “Trap” “Caught” “Escaped”) are dealt round face downwards, and a game may be won by a player or side.
        All cards are played face upwards, and laid on the table, but when a set (either of three or four) is made up, it is turned face downwards.
        A player having more than one card of a set, may only use one at a time, in his turn. Only the player of a “Victim” may play the “Escaped” (Except in Rule 5), and he is allowed only one chance to claim a set with it (Rule 4). If he claim a wrong set, he cannot try with the same card again.

        
        """
        
        var text = "A set collecting game. The four cards to a set tell a story. The first is the Victim, the 2nd is the Trap, the 3rd is Caught!, and the 4th is the Escape!&#10;&#10;Players are given an agreed number of counters, some of which are added to the Pool. When you take certain actions, you may have to put more counters into the Pool or you might be lucky enough to take counters from the Pool. The one with the most counters after all sets have been collected, wins.&#10;&#10;The game must be Victorian (for example, one card makes mention of crinolene, an essential part of a Victorian lady's fashionable attire.&#10;&#10;No artist mentioned, which is a shame because the illustrations are of a very high quality.&#10;&#10;Any number of persons may play. If five play. Ten sets only are used. If seven, the dealer has one card short.&#10;The cards (which are termed the &ldquo;Victim&rdquo; &ldquo;Trap&rdquo; &ldquo;Caught&rdquo; &ldquo;Escaped&rdquo;) are dealt round face downwards, and a game may be won by a player or side.&#10;All cards are played face upwards, and laid on the table, but when a set (either of three or four) is made up, it is turned face downwards.&#10;A player having more than one card of a set, may only use one at a time, in his turn. Only the player of a &ldquo;Victim&rdquo; may play the &ldquo;Escaped&rdquo; (Except in Rule 5), and he is allowed only one chance to claim a set with it (Rule 4). If he claim a wrong set, he cannot try with the same card again.&#10;&#10;"
        
        text = text.decodingHTMLEntities()
        
        XCTAssertEqual(text, decodedText)
    }
    
}
