#lang scheme

; recursive version

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a) (accumulate combiner null-value term (next a) next b))))

(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (product term a next b)
  (accumulate * 1 term a next b))

(define (inc x) (+ x 1))
(define (identity x) x)

; test sum and product
(sum identity 0 inc 10)
(product identity 1 inc 5)

; iterative version

(define (accumulate-i combiner null-value term a next b)
  (define (iter result a)
    (if (> a b)
        result
        (iter (combiner (term a) result) (next a))))
    (iter null-value a))

(define (sum-i term a next b)
  (accumulate-i + 0 term a next b))

(define (product-i term a next b)
  (accumulate-i * 1 term a next b))

(sum-i identity 0 inc 10)
(product-i identity 1 inc 5)