#lang racket

(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

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
         (make-segment (make-vect 0.25 0.55) (make-vect 0.35 0.5))
         (make-segment (make-vect 0.4 0.75) (make-vect 0.5 0.7))
         (make-segment (make-vect 0.5 0.7) (make-vect 0.6 0.75)))))

(define (square-limit painter n)
  (let ((combine4 (square-of-four identity identity
                                  rotate180 rotate180)))
    (combine4 (corner-split painter n))))

(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
          (bottom (beside (bl painter) (br painter))))
      (below bottom top))))

(define (corner-split painter n)
  (if (= n 1)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1))))
        (let ((top-left (beside white up))
              (bottom-right (below white right))
              (corner (corner-split painter (- n 1))))
          (beside (below painter top-left)
                  (below bottom-right corner))))))

(define (right-split painter n)
  (if (= n 1)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

(define (up-split painter n)
  (if (= n 1)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))