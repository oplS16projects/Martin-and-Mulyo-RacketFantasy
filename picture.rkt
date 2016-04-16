#lang racket


(require 2htdp/image)

; Above the rectangle
; Triangles beside each other


;Castle with towers
(define victorian                       ; Left rectangle                        
  (above (overlay/offset(overlay/offset (above (triangle 100 "solid" "red")(rectangle 60 80 "solid" "dimgray"))190 0
                                        ; middle Rectangle
                                        (above (triangle 100 "solid" "red")(rectangle 60 80 "solid" "dimgray")))280 0
                                        ;right rectangle
                                        (above (triangle 100 "solid" "red")(rectangle 60 80 "solid" "dimgray")))
         (rectangle 600 150 "solid" "dimgray")))
;so we can call door
(define door (overlay/align "center" "bottom" (rectangle 60 60 "solid" "brown")
                            (rotate 180(ellipse 60 100 "solid" "brown"))))
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
(define water_bridge(above
                     (above
                      (above
                       (above
                        (above
                         (above(rectangle 60 70 "solid" "blue")
         
                               (rectangle 60 90 "solid" (make-color 75 54 33)))
                         (rectangle 60 95 "solid" "blue"))
                        (rectangle 60 90 "solid" (make-color 75 54 33)))
                       (rectangle 60 95 "solid" "blue"))
                      (rectangle 60 90 "solid" (make-color 75 54 33)))
                     (rectangle 60 70 "solid" "blue")))

(define middle_board(beside(beside water_bridge (rectangle 600 600 "solid" "darkgreen"))water_bridge))

;
(define game_board(overlay/align "center" "top" (beside
                   (beside
                    ;Left Castle
                    (rotate 90 castle)
                    ;Middle Game board piece
                    middle_board)
                   ;Right caslte Piece
                   (rotate 270 castle))
                     ;Game board bottom      
                    (overlay/align "center" "bottom" (overlay/offset (place-image (text "Player 1" 24 "white") 75 25 (rectangle 400 180 "solid" "blue"))800 0  (place-image (text "Player 2" 24 "white") 75 25 (rectangle 400 180 "solid" "red")))(rectangle 1500 800 "solid" "gray"))))
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
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (player_object balance)
  ;Setting default value for territory count
  (define t_count 0)       ; territory count
  (define active_player 1) ; active player. 1 Means acctive, 0 means not active

  (define (active_player_on) (set! active_player 1)active_player)
  (define (active_player_off) (set! active_player 0)active_player)
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
    (cond ((eq? m 'active_player_on) active_player_on)
          ((eq? m 'active_player_off) active_player_off))
    (if (= active_player 0)
        (error "Player not active!")
    (cond ((eq? m 'income_dec) income_dec)
          ((eq? m 'income_inc) income_inc)
          ((eq? m 'territory_count) territory_count)
          ((eq? m 'get_territory_count) get_territory_count)
          ((eq? m 'get_income_count) get_income_count)
          (else
           (error "Unknown Player Request"
                  m)))))
  dispatch)

(define a (player_object 0))
((a 'territory_count)5)
((a 'income_inc)10)
((a 'income_dec)2)
((a 'territory_count)3)
