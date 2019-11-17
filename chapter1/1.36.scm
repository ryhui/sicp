#lang scheme

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (display guess)
    (newline)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

; without average damping:

(fixed-point (lambda (x) (/ (log 1000) (log x))) 5)
; 29 steps, 4.555539314360711

; with average damping:

(fixed-point (lambda (x) (/ (+ x (/ (log 1000) (log x))) 2)) 5)
; 9 steps, 4.5555361005218895