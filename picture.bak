#lang slideshow


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
                    (overlay/align "center" "bottom" (overlay/offset(rectangle 400 180 "solid" "blue") 900 0 (rectangle 400 180 "solid" "red"))(rectangle 1500 800 "solid" "gray"))))
; Calling gameboard
game_board

;(beside/align "baseline"
 ;               (text "ijy" 18 "black")
  ;              (text "ijy" 24 "black"))

