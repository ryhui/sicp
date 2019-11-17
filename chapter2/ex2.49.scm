#lang racket

(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

;a
(define outline
  (segments->painter
   (list (make-segment (make-vect 0 0) (make-vect 0 1))
         (make-segment (make-vect 0 1) (make-vect 1 1))
         (make-segment (make-vect 1 0) (make-vect 1 1))
         (make-segment (make-vect 0 0) (make-vect 1 0)))))

;b
(define x-shape
  (segments->painter
   (list (make-segment (make-vect 0 0) (make-vect 1 1))
         (make-segment (make-vect 1 0) (make-vect 0 1)))))

;c
(define diamond
  (segments->painter
   (list (make-segment (make-vect 0 0.5) (make-vect 0.5 1))
         (make-segment (make-vect 0.5 1) (make-vect 1 0.5))
         (make-segment (make-vect 1 0.5) (make-vect 0.5 0))
         (make-segment (make-vect 0.5 0) (make-vect 0 0.5)))))

;d
(define wave
  (segments->painter
   (list (make-segment (make-vect 0.25 0) (make-vect 0.35 0.5))
         (make-segment (make-vect 0.4 0) (make-vect 0.5 0.3))
         (make-segment (make-vect 0.6 0) (make-vect 0.5 0.3))
         (make-segment (make-vect 0.75 0) (make-vect 0.6 0.45))
         (make-segment (make-vect 0.6 0.45) (make-vect 1 0.15))
         (make-segment (make-vect 1 0.4) (make-vect 0.75 0.6))
         (make-segment (make-vect 0.75 0.6) (make-vect 0.6 0.6))
         (make-segment (make-vect 0.6 0.6) (make-vect 0.7 0.8))
         (make-segment (make-vect 0.7 0.8) (make-vect 0.6 1))
         (make-segment (make-vect 0.4 1) (make-vect 0.3 0.8))
         (make-segment (make-vect 0.3 0.8) (make-vect 0.4 0.6))
         (make-segment (make-vect 0.4 0.6) (make-vect 0.25 0.6))
         (make-segment (make-vect 0.25 0.6) (make-vect 0.125 0.55))
         (make-segment (make-vect 0.125 0.55) (make-vect 0 0.8))
         (make-segment (make-vect 0 0.6) (make-vect 0.125 0.4))
         (make-segment (make-vect 0.125 0.4) (make-vect 0.25 0.55))
         (make-segment (make-vect 0.25 0.55) (make-vect 0.35 0.5)))))
                         