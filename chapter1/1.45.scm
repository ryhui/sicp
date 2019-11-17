#lang scheme

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (counter f n accu)
    (if (zero? n)
        accu
        (counter f (- n 1) (compose f accu))))
  (counter f n (lambda (x) x)))

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (average a b)
  (/ (+ a b) 2))

(define (damp f)
  (lambda (x) (average x (f x))))

(define (damp-n n)
  (repeated damp n))

(define (test-nth-root x n)
  (fixed-point ((damp-n 3) (lambda (y) (/ x (expt y (- n 1)))))
               1.0))

; damp 1 sufficient for 2, 3rd roots
; damp 2 for 4, 5, 6, 7th roots
; damp 3 for 8~15th roots
; ...

(define log2
  (lambda (x)
    (/ (log x) (log 2))))

(define (nth-root x n)
  (let ((m (floor (log2 n))))
    (fixed-point ((damp-n m) (lambda (y) (/ x (expt y (- n 1)))))
                 1.0)))
  