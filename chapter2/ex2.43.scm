#lang scheme

(flatmap
 (lambda (new-row)
   (map (lambda (rest-of-queens)
          (adjoin-position new-row k rest-of-queens))
        (queen-cols (- k 1))))
 (enumerate-interval 1 board-size))

; Louis Reasoner's answer: get queens for (k - 1) board size,
; then add new queen according to new-row in col k, where new-row
; is taken from a list from 1 to board-size
; In this case, in each loop (queen-cols (- k 1)) will be called once,
; making it k times in total

; Correct version is linear-recursive; wrong version is tree-
; recursive. It will take T^n time.