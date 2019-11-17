#lang scheme

(define (square x)
  (* x x))

(define (square-list-1 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items '()))

; it's in reversed order, because the result of
; the next item is appended to the beginning of
; the answer

(define (square-list-2 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items '()))

; this version does not work because a list should
; end, but not start with nil (or '() in scheme)
