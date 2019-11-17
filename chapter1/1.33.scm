#lang scheme

(define (filtered-accumulate combiner null-value term a next b predicate)
  (if (> a b)
      null-value
      (if (predicate a)
          (combiner (term a) (filtered-accumulate combiner null-value term (next a) next b predicate))
          (filtered-accumulate combiner null-value term (next a) next b predicate))))

; the sum of the squares of the prime numbers in the interval a to b

(define (square x)
  (* x x))

(define (next-num x)
  (if (= x 2)
      3
      (+ x 1)))

(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next-num test-divisor)))))
(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (inc a)
  (+ a 1))

(define (identity a)
  a)

(define (sum-of-square-prime a b)
  (filtered-accumulate + 0 square a inc b prime?))

; the product of all the positive integers less than n that are relatively prime to n

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (product-of-relative-primes n)
  (define (relative-prime a)
    (equal? (gcd a n) 1))
  (filtered-accumulate * 1 identity 2 inc (- n 1) relative-prime))
  