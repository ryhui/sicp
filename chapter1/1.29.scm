#lang scheme

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (inc n) (+ n 1))

(define (simpson-integral f a b n)
  (define half-n (/ n 2))
  (define h (/ (- b a) n))
  (define (g k) (+ (* 4 (f (+ a (* k h)))) (* 2 (f (+ a (* (+ k 1) h))))))
  (define (add-two x) (+ x 2))
  (* (+ (sum g 1 add-two (- n 1)) (f a) (f b)) (/ h 3)))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

(define (cube x) (* x x x))

(integral cube 0 1 0.01)
(simpson-integral cube 0 1 100.0)

(integral cube 0 1 0.001)
(simpson-integral cube 0 1 1000.0)
