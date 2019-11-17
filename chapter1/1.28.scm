#lang scheme

(define (square x)
  (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (let* ([r (expmod base (/ exp 2) m)]
                  [square-remainder (remainder (square r) m)])
           (if (and (and (not (eq? r 1)) (not (eq? r (- m 1)))) (eq? square-remainder 1))
               0
               square-remainder)))
        (#t
         (remainder (* base (expmod base (- exp 1) m)) m))))


(define (miller-rabin-test n times)
  (if (eq? times 0)
      #t
      (if (= (expmod (+ 2 (random (- n 2))) (- n 1) n) 1)
          (miller-rabin-test n (- times 1))
          #f)))

