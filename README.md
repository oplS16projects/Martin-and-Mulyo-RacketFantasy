# Martin-and-Mulyo-RacketFantasy
# Project Title: Racket Fantasy

### Statement

Our project is a turn base game where two players compete for nine territories. The art of the game as well as the code itself are going to be created from scratch using the libraries available for Racket. Making a turn based game is of our interest because games like these have an element of trying to figure out what you want to do and what your opponent is trying to d. We hope to learn how to have a program where it has both user and object interaction as well as making a good game where players can enjoy together. 

### Analysis
Explain what approaches from class you will bring to bear on the project. Be explicit: e.g., will you use recursion? How? Will you use map/filter/reduce? How? Will you use data abstraction? Will you use object-orientation? Will you use functional approaches to processing your data? Will you use state-modification approaches? A combination?

The idea here is to identify what ideas from the class you will use in carrying out your project. 
We will be using HOP to manipulate the list of units. The players, tiles/territories and units are based of object-orientation. (..)

### Data set or other source materials

As of now, all the code and images we will be using are made from scratch using some graphics libraries such as htdp.

### Deliverable and Demonstration
Explain exactly what you'll have at the end. What will it be able to do at the live demo?

What exactly will you produce at the end of the project? A piece of software, yes, but what will it do? Here are some questions to think about (and answer depending on your application).

Will it run on some data, like batch mode? Will you present some analytical results of the processing? How can it be re-run on different source data?

Will it be interactive? Can you show it working? This project involves a live demo, so interactivity is good.

The game should run as we intend it to meaning a full working turn based game where players are able to spawn and control their units. We could call two people up to demonstrate and play the game against each other where they would compete for the nine teretories.


## Evaluation of Results
### Game Criteria

*Player can only control there units.

*Player income and terriroy count only increase/decrease on there turn.

*Player income decrease when income is spent on there units.

*Units get created properly on appropriate side.

*Units move.

*Units can not go out of bounds.

*Units can not be stacked on a territory.

*Units cannot move more then they are suppose to.

*Win condition is met, that means capturing 9 territories.


###Racket Libraries
(require 2htdp/universe)

(require 2htdp/batch-io)

(require 2htdp/image)


### Architecture Diagram
<img src="Architecture_digram.jpg">

####Player

The main purpose of this class is to make sure that the player in control can only access their items. For example, while spending your currency on units you want to make sure that you are only touching your money and not the other players� money, even though that would be nice.

####Territory

Territories have three main responsibilities. First, boundaries, they are here to make sure that you stick with in the game. Second, if another unit is on a territory it knows how to handle it. And last, you keep track of which player owns a territory.

####Units

Units main function are to move around the board and attack other enemy units. We want to make sure that other players cannot move another playersunit. We also want to keep track of how much movement a piece has made and at the beginning of their next turn it will reset so they have a fully functioning unit again.

### Game Flow
<img src="game_flow.jpg">


### Schedule

### First Milestone (Fri Apr 15)
*A complete drawing of the game (background, unit, castle and UI)

*Working UI

### Second Milestone (Fri Apr 22)
*Win condition can be met.

*Units can move on gameboard.

*Currency and territory numbers are being tracked correctly.

### Final Presentation (last week of semester)
*Cleaned up most, if not all the bugs in the game

*Smoother run

## Group Responsibilities
<img src="group_respons.jpg">

## Favorite Code
          (define (background tilelst)
            (define (currentImage) tilelst)
            (define (drawbkg slcted)
              (define (iter tilelst nT img)
                (if (null? tilelst)
                    img
                    (if (= (add1 nT) slcted)
                        (iter (cdr tilelst)(add1 nT)(overlay/xy (overlay ss (car tilelst))
                                                                (* (modulo nT mapSize) tilebW -1)
                                                                (* (rounded nT mapSize) tilebH -1)
                                                                img))
                        (iter (cdr tilelst)(add1 nT)(overlay/xy (car tilelst)
                                                                (* (modulo nT mapSize) tilebW -1)
                                                                (* (rounded nT mapSize) tilebH -1)
                                                                img)))))
              (define (mCirc)
                (overlay/xy (circle 7 "solid" "yellow")
                            (+ (/ tilebW -2) 7)
                            slcted
                            (iter tilelst 0 green)))
              (cond ((and (< 0 slcted) (> 16 slcted))(begin ((blueOption 'update) (list optionBlue1 optionBlue2 optionBlue3))
                                                            ((redOption 'update) (list  optionRed1 optionRed2 optionRed3))
                                                            (game_board (middle_board (iter tilelst 0 green)) ((blueTeam 'update) tilelst)((redTeam 'update) tilelst) (blueOption 'print) (redOption 'print) currentStatus)))
                    ((= 1001 slcted) (begin ((blueOption 'update) (list (overlay optionSS optionBlue1) optionBlue2 optionBlue3))
                                            ((redOption 'update) (list  optionRed1 optionRed2 optionRed3))
                                            (game_board (middle_board (iter tilelst 0 green)) ((blueTeam 'update) tilelst)((redTeam 'update) tilelst) (blueOption 'print) (redOption 'print) currentStatus)))
                    ((= 1002 slcted) (begin ((blueOption 'update) (list  optionBlue1 (overlay optionSS optionBlue2) optionBlue3))
                                            ((redOption 'update) (list  optionRed1 optionRed2 optionRed3))
                                            (game_board (middle_board (iter tilelst 0 green)) ((blueTeam 'update) tilelst)((redTeam 'update) tilelst) (blueOption 'print) (redOption 'print) currentStatus)))
                    ((= 1003 slcted) (begin ((blueOption 'update) (list  optionBlue1 optionBlue2 (overlay optionSS optionBlue3)))
                                            ((redOption 'update) (list  optionRed1 optionRed2 optionRed3))
                                            (game_board (middle_board (iter tilelst 0 green)) ((blueTeam 'update) tilelst)((redTeam 'update) tilelst) (blueOption 'print) (redOption 'print) currentStatus)))
                    ((= 2001 slcted) (begin ((redOption 'update) (list (overlay optionSS optionRed1) optionRed2 optionRed3))
                                            ((blueOption 'update) (list optionBlue1 optionBlue2 optionBlue3))
                                            (game_board (middle_board (iter tilelst 0 green)) ((blueTeam 'update) tilelst)((redTeam 'update) tilelst) (blueOption 'print) (redOption 'print) currentStatus)))
                    ((= 2002 slcted) (begin ((redOption 'update) (list  optionRed1 (overlay optionSS optionRed2) optionRed3))
                                            ((blueOption 'update) (list optionBlue1 optionBlue2 optionBlue3))
                                            (game_board (middle_board (iter tilelst 0 green)) ((blueTeam 'update) tilelst)((redTeam 'update) tilelst) (blueOption 'print) (redOption 'print) currentStatus)))
                    ((= 2003 slcted) (begin ((redOption 'update) (list  optionRed1 optionRed2 (overlay optionSS optionRed3)))
                                            ((blueOption 'update) (list optionBlue1 optionBlue2 optionBlue3))
                                            (game_board (middle_board (iter tilelst 0 green)) ((blueTeam 'update) tilelst)((redTeam 'update) tilelst) (blueOption 'print) (redOption 'print) currentStatus)))))
            (define (mutate lst) (set! tilelst lst))
            (define (dispatch message)
              (cond ((eq? 'draw message) drawbkg)
                    ((eq? 'mutate message) mutate)
                    ((eq? 'currentImage message) currentImage)))
            dispatch)

####Yusuf
This code handles how the game is drawn on the screen. Since we mainly rely upon the function big-bang from 2htdp/universe, the function that can be put in to-draw could only be a one parameter function. So what we did was we made a background object called world that has the whole set of list at the start (define world (background tile-list)) and contain a procedure that takes in an integer and manipulates the list accordingly. Although we made some variable and functions local to the background object, we could've done better by having the background object contain all of the values and procedures we made so that none of the variables and procedure are global.


          (define (unit_object current_moves SET_MAX_MOVES UNIT_COST UNIT_IMAGE)
            ;(define MAX_MOVES SET_MAX_MOVES)
            ;;;;;;;;;;;;;;;;;;;;;;
            ;Moving unit check to see if how many moves are left on the unit.
            ;If movement avaliable then use it.
            ;;;;;;;;;;;;;;;;;;;;;;
            (define (moving_unit)
              ;TO DO: check "PLAYER_OWNERSHIP" to make sure you can't move opponent piece
              (if (>= current_moves SET_MAX_MOVES)
                  "The max moves for this unit are spent" 
                  (begin (set! current_moves (+ current_moves 1))
                         current_moves)))
            ;;;;;;;;;;;;;;;;
            ;Reset "current_moves" to 0
            ;Maybe when unit is created we create a list of unit_objects and we
            ;can call this function on all of them
            ;;;;;;;;;;;;;;;;
            (define (reset_moves)
              (begin (set! current_moves 0)
              current_moves))
            (define (display_unit_image)
              (begin (set! current_moves 0)
              current_moves))
            ;;;;;;;;;;;;;;;;;;;;
            ;Dispatch
            ;;;;;;;;;;;;;;;;;;;;
            (define (dispatch m)
              (cond ((eq? m 'moving_unit) moving_unit)
                    ((eq? m 'reset_moves) reset_moves)                   
                    ((eq? m 'displayMoves) (- SET_MAX_MOVES current_moves))                    
                    (else
                     (error "Unknown Player Request"
                            m))))
            dispatch)
####Martin
The best part of this semester has been finding out how to make a "object" in racket. This is around the time I really started understand how racket actually works. The code above encapsualtes my learning process this semester in how evertyhing came togehter. This object above creates the unit object  of the game it holds the image of the unit, determins how many moves are left for the object and declares what it's max moves are. When you create a unit it is put into a list and at the end of your turn we call reset_moves to rest all unit movment count to 0.
