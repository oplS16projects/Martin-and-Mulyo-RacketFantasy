#lang racket


(require 2htdp/image)

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
game_board

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
;((a 'territory_count)5)
;((a 'income_inc)10)
;((a 'income_dec)2)
;((a 'territory_count)3)
;((a 'active_player_toggle))
;((a 'territory_count)7)
;((a 'active_player_toggle))
;((a 'get_territory_count))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;