
;;;======================================================
;;;   Automotive Expert System
;;;
;;;     This expert system diagnoses some simple
;;;     problems with a car.
;;;
;;;     CLIPS Version 6.3 Example
;;;
;;;     For use with the Auto Demo Example
;;;======================================================

;;; ***************************
;;; * DEFTEMPLATES & DEFFACTS *
;;; ***************************

(deftemplate UI-state
   (slot display)
   (slot relation-asserted (default none))
   (slot response (default none))
   (multislot valid-answers)
   (slot state (default middle)))
   
;;;****************
;;;* STARTUP RULE *
;;;****************

(defrule system-banner ""

  =>
  
  (assert (UI-state (display WelcomeMessage)
                    (relation-asserted start)
                    (state initial)
                    (valid-answers))))

;;;***************
;;;* QUERY RULES *
;;;***************

(defrule determine-smak ""

   (start)
   ?state<-(UI-state)

   =>
   (retract ?state) 
   (assert (smak))
   (assert (UI-state (display SmakQuestion)
                     (relation-asserted smak)
                     (response tak)
                     (valid-answers tak nie))))
   
(defrule determine-powietrze ""

  (smak nie)
   ?state<-(UI-state)

   =>
   (retract ?state) 
   (assert (powietrze))
   (assert (UI-state (display PowietrzeQuestion)
                     (relation-asserted powietrze)
                     (response tak)
                     (valid-answers tak nie))))

(defrule determine-goraco ""

  (powietrze tak)
   ?state<-(UI-state)

   =>
   (retract ?state) 
   (assert (goraco))
   (assert (UI-state (display GoracoQuestion)
                     (relation-asserted goraco)
                     (response tak)
                     (valid-answers tak nie))))

(defrule determine-oryginalny ""

  (goraco tak)
   ?state<-(UI-state)

   =>
   (retract ?state) 
   (assert (oryginalny))
   (assert (UI-state (display OryginalnyQuestion)
                     (relation-asserted oryginalny)
                     (response d)
                     (valid-answers d o))))
					 
(defrule determine-gorycz ""

  (oryginalny d)
   ?state<-(UI-state)

   =>
   (retract ?state) 
   (assert (gorycz))
   (assert (UI-state (display GoryczQuestion)
                     (relation-asserted gorycz)
                     (response tak)
                     (valid-answers tak nie))))
;;;****************
;;;* REPAIR RULES *
;;;****************

(defrule smak-conclusions ""

    (smak tak)
    ?state<-(UI-state)
   =>
   (retract ?state)
   (assert (UI-state (display Eur)
                     (state final))))
					 
(defrule gorycz-conclusions ""

    (gorycz tak)
    ?state<-(UI-state)
   =>
   (retract ?state)
   (assert (UI-state (display Pil)
                     (state final))))
	