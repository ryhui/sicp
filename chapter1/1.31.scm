#lang scheme

; provided sum function:
;(define (sum term a next b)
;  (if (> a b)
;      0
;      (+ (term a)
;         (sum term (next a) next b))))

(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (inc x) (+ x 1))
(define (identity x) x)

(define (factorial n)
  (product identity 1 inc n))

; test factorial
(factorial 3)
(factorial 5)

(define (approx-pi n)
  (define (term n)
    (/ (+ (* (quotient n 2) 2) 2) (+ (* (quotient (+ n 1) 2) 2) 1.0)))
  (* 4 (product term 1 inc n)))

(approx-pi 100)
(approx-pi 1000)

; now the iterative version:

(define (product-iter term a next b)
  (define (iter result a)
    (if (> a b)
        result
        (iter (* result (term a)) (next a))))
  (iter 1 a))

; test the iterative version

(define (factorial-i n)
  (product-iter identity 1 inc n))

; test factorial
(factorial-i 3)
(factorial-i 5)