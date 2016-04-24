#lang racket


(require 2htdp/image)
 (require lang/posn)

; Above the rectangle
; Triangles beside each other


;Castle with towers
(define victorian                       ; Left rectangle                        
  (above (overlay/offset(overlay/offset (above (triangle 60 "solid" "red")(rectangle 30 40 "solid" "dimgray"))190 0
                                        ; middle Rectangle
                                        (above (triangle 60 "solid" "red")(rectangle 30 40 "solid" "dimgray")))280 0
                                        ;right rectangle
                                        (above (triangle 60 "solid" "red")(rectangle 30 40 "solid" "dimgray")))
         (rectangle 600 100 "solid" "dimgray")))
;so we can call door
(define door (overlay/align "center" "bottom" (rectangle 40 40 "solid" "brown")
                            (rotate 180(ellipse 40 60 "solid" "brown"))))
;TO DO: Use (frame...) for bars
(define door-with-knob
  (overlay/align "center" "center" (circle 6 "solid" "yellow")  door))

;Create bottom picture
(define castle(overlay/align "center" "bottom"
                             ; creates three doors
                             (overlay/offset (overlay/offset door-with-knob 190 0 door-with-knob)
                                             280 0 door-with-knob)
                             ;creates the rest of castle
                             victorian))
;The image where it goes water bridge water bridge....
(define water_bridge(beside
                     (beside
                      (beside
                       (beside
                        (beside
                         (beside(rectangle 70 45 "solid" "blue")
         
                               (rectangle 90 45 "solid" (make-color 75 54 33)))
                         (rectangle 95 45 "solid" "blue"))
                        (rectangle 90 45 "solid" (make-color 75 54 33)))
                       (rectangle 95 45 "solid" "blue"))
                      (rectangle 90 45 "solid" (make-color 75 54 33)))
                     (rectangle 70 45 "solid" "blue")))

(define middle_board(above(above water_bridge (rectangle 600 300 "solid" "darkgreen"))water_bridge))

;
(define game_board(overlay/align "center" "top" (above
                   (above
                    ;Top Castle
                    castle
                    ;Middle Game board piece
                    middle_board)
                   ;Bottomt caslte Piece
                    (rotate 180 castle))
                     ;Game board bottom      
                    (overlay/align "center" "bottom" (overlay/offset (place-image (text "Player 1" 24 "white") 75 25 (rectangle 400 180 "solid" "blue"))1050 0  (place-image (text "Player 2" 24 "white") 75 25 (rectangle 400 180 "solid" "red")))(rectangle 1500 825 "solid" "gray"))))
;Calling gameboard
;game_board

;(define player_obj m

;(beside/align "baseline"
;                (text "ijy" 18 "black")
;                (text "ijy" 24 "black"))

;(overlay/offset (place-image (text "Player 1" 24 "white") 75 25 (rectangle 400 180 "solid" "blue"))400 0  (place-image (text "Player 2" 24 "white") 75 25 (rectangle 400 180 "solid" "red")))

;;;;;;;;;;;;;Player Object;;;;;;;;;;;;;;;;;;;;;
;Setting up player 
;var balance = player money
;var t_count = plater territory count
;var active_player  = Turn ON/OFF, can player spend income and build units?
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (player_object balance)
  ;Setting default variable values 
  (define t_count 0)           ; territory count
  (define active_player "on") 
  ;;;;;;;;;;;;;;;;;;;;;;
  ;Toggle active_player
  ; "on" active,
  ; "off" not active
  ;;;;;;;;;;;;;;;;;;;;;;
  (define (active_player_toggle)
    (if (eq? "off" active_player)
        (begin (set! active_player "on")active_player)
    (begin (set! active_player "off")active_player)))
  ;;;;;;;;;;;;;;;;
  ;Decrease Income
  ;;;;;;;;;;;;;;;;
  (define (income_dec amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  ;;;;;;;;;;;;;;;;
  ;Increase Income
  ;;;;;;;;;;;;;;;;
  (define (income_inc amount)
    (set! balance (+ balance amount))
    balance)
  ;;;;;;;;;;;;;;;;;;;
  (define (get_income_count) balance)
  ;;;;;;;;;;;;;;;;;;;;
  ;Set territory count
  ;Get territory count
  ;;;;;;;;;;;;;;;;;;;;
  (define (territory_count amount)
    (set! t_count amount)
    t_count)
  ;;;;;;;;;;;;;;;;;;;;
  (define (get_territory_count)t_count)      
  ;;;;;;;;;;;;;;;;;;;;
  ;Dispatch
  ;;;;;;;;;;;;;;;;;;;;
  (define (dispatch m)
    (if (eq? active_player "on")
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;If "on" player can access their menu
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        (cond ((eq? m 'active_player_toggle) active_player_toggle)
              ((eq? m 'income_dec) income_dec)                    ;Sets income decrease
              ((eq? m 'income_inc) income_inc)                    ;Sets income increae
              ((eq? m 'territory_count) territory_count)          ;Sets territory count
              ((eq? m 'get_territory_count) get_territory_count)  ;return current territory count
              ((eq? m 'get_income_count) get_income_count)        ;return value of income
              (else
               (error "Unknown Player Request"
                      m)))
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;Else check to see if game is trying to activate player,
        ;If not then Player is not active.
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        (cond ((eq? m 'active_player_toggle) active_player_toggle)
              (else (lambda (x) "Player not active." )))))
  dispatch)
;;;;Test code for player object;;;;;;
;(define a (player_object 0))
;((a 'territory_count)5)
;((a 'income_inc)10)
;((a 'income_dec)2)
;((a 'territory_count)3)
;((a 'active_player_toggle))
;((a 'territory_count)7)
;((a 'active_player_toggle))
;((a 'get_territory_count))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;-----------------------------------------------------------------------
(define (unit_object current_moves SET_MAX_MOVES UNIT_COST PLAYER_OWNERSHIP UNIT_IMAGE)
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
        (begin (set! current_moves 0))
               current_moves)
    (define (display_unit_image)
        (begin (set! current_moves 0))
               current_moves)  
  ;;;;;;;;;;;;;;;;;;;;
  ;Dispatch
  ;;;;;;;;;;;;;;;;;;;;
  (define (dispatch m)
    (cond ((eq? m 'moving_unit) moving_unit)
          ((eq? m 'reset_moves) reset_moves)                   
          ((eq? m 'display_unit_image) display_unit_image)                    
          (else
           (error "Unknown Player Request"
                  m))))
  dispatch)

(define unit (unit_object 0 2 2 2 2))
((unit 'moving_unit))
((unit 'moving_unit))
((unit 'moving_unit))
((unit 'reset_moves))
((unit 'moving_unit))
((unit 'moving_unit))

(define sword(overlay/offset (line 40 15 "black") +15 3 (line -15 15 "black")))

(define body_red(overlay/offset (ellipse 20 20 "solid" "red")0 15
                               (isosceles-triangle 40 30 "solid" "firebrick")))
(define body_blue(overlay/offset (ellipse 20 20 "solid" "blue")0 15
                                 (isosceles-triangle 40 30 "solid" "lightblue")))

                                           ;Kind of the top of shield
(define shield(rotate -90 (polygon (list (make-pulled-point 1/2 15 0 0 1/2 -15)
                                           ;top left of shield          
                                           (make-posn -5 12)
                                           ;Kind of the bottom of shield
                                           (make-pulled-point 1/2 -20 25 0 1/2 20)
                                           ;top right of shield
                                           (make-posn -5 -12))
                                     "solid"
                                     "burlywood")))

(define unit1_blue (overlay/offset shield -30 0
                     (overlay/offset sword 25 0
                      body_blue)))

(define unit1_red (overlay/offset shield -30 0
                    (overlay/offset sword 25 0
                     body_red)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define weapon_flail_red(overlay/offset (above
                              (above
                               (above (ellipse 3 6 "outline" "black")
                                      (ellipse 3 6 "outline" "black"))
                               (ellipse 3 6 "outline" "black"))
                              (star-polygon 5 10 3 "solid" "red")) 11 -10
                              ;Handle of weapon                                               
                              (rotate -20(rectangle 20 5 "solid" "black"))))
                                   ;Head
(define body_red2(overlay/offset (ellipse 20 20 "solid" (make-color 60  0 0)) 0 15
                                   (overlay/offset
                                    ;Body
                                    (overlay/offset(rotate 180(isosceles-triangle 40 30 "solid" "red"))10 -11
                                               ;Right Shoulder
                                               (rotate -210(isosceles-triangle 30 25 "solid" "firebrick")))-16 -8
                                               ;Left Shoulder
                                               (rotate 208(isosceles-triangle 30 25 "solid" "firebrick")))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define weapon_flail_blue(overlay/offset (above
                              (above
                               (above (ellipse 3 6 "outline" "black")
                                      (ellipse 3 6 "outline" "black"))
                               (ellipse 3 6 "outline" "black"))
                              (star-polygon 5 10 3 "solid" "blue")) 11 -10
                              ;Handle of weapon                                               
                              (rotate -20(rectangle 20 5 "solid" "black"))))

(define body_blue2(overlay/offset (ellipse 20 20 "solid" (make-color 0  0 60)) 0 15
                                   (overlay/offset
                                    ;Body
                                    (overlay/offset(rotate 180(isosceles-triangle 40 30 "solid" (make-color 0  80 240)))10 -11
                                               ;Right Shoulder
                                               (rotate -210(isosceles-triangle 30 25 "solid" (make-color 0  0 180))))-16 -8
                                               ;Left Shoulder
                                               (rotate 208(isosceles-triangle 30 25 "solid" (make-color 0  0 180))))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define unit2_red(overlay/offset shield -20 -2
                                 (overlay/offset weapon_flail_red 20 -7
                                                 body_red2)))
(define unit2_blue(overlay/offset shield -20 -2
                                 (overlay/offset weapon_flail_blue 20 -7
                                                 body_blue2)))


unit2_red
unit2_blue

unit1_blue

unit1_red



