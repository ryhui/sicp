#lang racket

(define make-vect cons)
(define xcor-vect car)
(define ycor-vect cdr)

(define (add-vect x y)
  (make-vect (+ (xcor-vect x) (xcor-vect y))
             (+ (ycor-vect x) (ycor-vect y))))

(define (sub-vect x y)
  (make-vect (- (xcor-vect x) (xcor-vect y))
             (- (ycor-vect x) (ycor-vect y))))

(define (scale-vect v s)
  (make-vect (* s (xcor-vect v))
             (* s (ycor-vect v))))