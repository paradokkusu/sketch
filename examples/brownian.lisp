;;;; brownian.lisp

(in-package #:sketch-examples)

;;  ____  ____   _____        ___   _ ___    _    _   _
;; | __ )|  _ \ / _ \ \      / / \ | |_ _|  / \  | \ | |
;; |  _ \| |_) | | | \ \ /\ / /|  \| || |  / _ \ |  \| |
;; | |_) |  _ <| |_| |\ V  V / | |\  || | / ___ \| |\  |
;; |____/|_| \_\\___/  \_/\_/  |_| \_|___/_/   \_\_| \_|

(defsketch brownian
    (:title "Brownian" :width 400 :height 400
	    :framerate 30 :copy-pixels t :debug :scancode-f1)
    ((pos '(200 . 200)) (dir '(1 . 0))
     (pen (make-pen :stroke (gray 0)))
     (bg (gray 1))
     (len 2))
  (flet ((draw (paces)
	   (dotimes (i paces)
	     (let ((new-pos (cons (+ (car pos) (car dir))
				  (+ (cdr pos) (cdr dir)))))
	       (with-pen pen
		 (line (car pos) (cdr pos) (car new-pos) (cdr new-pos)))
	       (setf pos new-pos))))
	 (rotate (a)
	   (let ((a (+ a (degrees (atan (cdr dir) (car dir))))))
	     (setf dir (cons (cos (radians a))
			     (sin (radians a)))))))
    (rotate (- (random 180) 90))
    (draw (+ (random len) len))
    (setf (car pos) (alexandria:clamp (car pos) -10 410)
	  (cdr pos) (alexandria:clamp (cdr pos) -10 410))))

(define-sketch-setup brownian
  (background bg))
