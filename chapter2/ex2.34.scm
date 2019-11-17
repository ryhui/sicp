#lang scheme

(define (accumulate fun initial sequence)
  (if (null? sequence)
      initial
      (fun (car sequence) (accumulate fun initial (cdr sequence)))))

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms)
                (+ this-coeff (* x higher-terms)))
              0
              coefficient-sequence))

; test

(horner-eval 2 (list 1 3))