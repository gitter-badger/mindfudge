pragma solidity ^0.4.0;
/// @title Playing a Mindfudge Game
contract Mindfudge  {
    // This declares a new complex type which will
    // be used for variables later.
    //uint lenGame = 5;
    address player1; 
    address player2;
    bool[] cards1;
    bool[] cards2;
    uint[2] middle = [0,0];
    uint wins1 = 0;
    uint wins2 = 0;
    uint drawpot = 0;
    address mindfudger;
    //uint amount
    
    function Mindfudge(address enemy){
      player1 = msg.sender;
      player2 = enemy;
      cards1 = [true, true, true, true, true];
      cards2 = [true, true, true ,true, true];
    }

    //put a card that has not been played in the middle
    function playACard(uint card){
        //which player?
        uint playerindex;
        if (msg.sender == player1){
          playerindex = 0;
          //check whether has not played the card before AND
          // whether he has not played in this round before
          if (cards1[card] && middle[0] == 0){
                middle[0] = card;
                cards1[card] = false;
            }else{
                // Exception : card already played
            }
        }else{
            if (msg.sender == player2){
                playerindex = 1;
                //check whether has not played the card before AND
                // whether he has not played in this round before
                if(cards2[card] && middle[1] == 0){
                    middle[1] = card;
                    cards1[card] = false;
                }else{
                    // Exception : card already played
                }
            }
        }
        //both players have submitted a card?
        if (middle[0] != 0 && middle[1] !=0) {
            reveal();
        }
    }

    //find out whos card is higher and assign wins
    function reveal(){
      //DRAW: no one gets a point, but next round is for one more
      if ( middle[0] == middle[1] ) {
            drawpot += 1;
      }
      //player1 wins
      if ( middle[0]>middle[1] ) {
            wins1 += 1 + drawpot; 
            drawpot = 0;
            if ( wins1 > 2 ){
                endGame(1);
            }
      }
      //player2 wins
      if ( middle[1]>middle[0] ){ 
            wins2 += 1  + drawpot;
            drawpot =0;
            if ( wins2 > 2 ){
                endGame(2);
            }
      }
      middle = [0,0];
    }

    //function to declare the game ended
    //later: payOut Winner
    function endGame(uint winner){
    if (winner == 1){ 
        mindfudger = player1;
    }else{ 
        mindfudger = player2; 
        }    
    }

    //queryfunction to find out whether you won
    function didIWin() returns (bool) {
        return msg.sender == mindfudger;
    }

}
