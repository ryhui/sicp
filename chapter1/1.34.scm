#lang scheme

(define (f g)
  (g 2))

(define (square x)
  (* x x))

(f square)

(f (lambda (z) (* z (+ z 1))))

; (f f) will evaluate to (f 2) then run into trouble, because (2 2) does not make sense - or is that a list?

(f f)

; application: not a procedure;
;  expected a procedure that can be applied to arguments
;   given: 2
;   arguments...: