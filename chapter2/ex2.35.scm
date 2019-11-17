#lang scheme

(define (accumulate fun initial sequence)
  (if (null? sequence)
      initial
      (fun (car sequence) (accumulate fun initial (cdr sequence)))))

(define (count-leaves t)
  (accumulate + 0
              (map (lambda (subtree)
                     (cond ((null? subtree) 0)
                           ((not (pair? subtree)) 1)
                           (else (count-leaves subtree)))) t)))

; test

(define tree (list 1 (list 2 3 (list 6 7))))
(count-leaves tree)


