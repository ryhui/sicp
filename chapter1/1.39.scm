#lang scheme

(define (cont-frac n d k)
  (define (helper i)
    (if (equal? i k)
        (/ (n i) (d i))
        (/ (n i) (+ (d i) (helper (+ 1 i))))))
  (helper 1))

(define (tan-cf x k)
  (cont-frac (lambda (i) (if (equal? 1 i) x (- (* x x))))
             (lambda (i) (- (* 2 i) 1))
             k))

(tan-cf pi 100)
(tan-cf (/ pi 3) 100)
(tan-cf (/ pi 4) 100)

