
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
					 
(defrule determine-aktywny ""

  (goraco nie)
   ?state<-(UI-state)

   =>
   (retract ?state) 
   (assert (aktywny))
   (assert (UI-state (display AktywnyQuestion)
                     (relation-asserted aktywny)
                     (response nie)
                     (valid-answers tak nie))))
					 
(defrule determine-wyzwanie ""

  (aktywny nie)
   ?state<-(UI-state)

   =>
   (retract ?state) 
   (assert (wyzwanie))
   (assert (UI-state (display WyzwanieQuestion)
                     (relation-asserted wyzwanie)
                     (response nie)
                     (valid-answers tak nie))))
					 
(defrule determine-jedzenie ""

  (aktywny tak)
   ?state<-(UI-state)

   =>
   (retract ?state) 
   (assert (jedzenie))
   (assert (UI-state (display JedzenieQuestion)
                     (relation-asserted jedzenie)
                     (response tak)
                     (valid-answers tak nie))))
					 
(defrule determine-lekko ""

  (jedzenie tak)
   ?state<-(UI-state)

   =>
   (retract ?state) 
   (assert (lekko))
   (assert (UI-state (display LekkoQuestion)
                     (relation-asserted lekko)
                     (response l)
                     (valid-answers l s))))
					 
(defrule determine-danie ""

  (lekko s)
   ?state<-(UI-state)

   =>
   (retract ?state) 
   (assert (danie))
   (assert (UI-state (display DanieQuestion)
                     (relation-asserted danie)
                     (response g)
                     (valid-answers g des))))

(defrule determine-aromaty ""

  (danie g)
   ?state<-(UI-state)

   =>
   (retract ?state) 
   (assert (aromaty))
   (assert (UI-state (display AromatyQuestion)
                     (relation-asserted aromaty)
                     (response oz)
                     (valid-answers oz cp))))

(defrule determine-chmielpiwo ""

  (jedzenie nie)
   ?state<-(UI-state)

   =>
   (retract ?state) 
   (assert (chmielpiwo))
   (assert (UI-state (display ChmielPiwoQuestion)
                     (relation-asserted chmielpiwo)
                     (response tak)
                     (valid-answers tak nie))))		

(defrule determine-zimno ""

  (powietrze nie)
   ?state<-(UI-state)

   =>
   (retract ?state) 
   (assert (zimno))
   (assert (UI-state (display ZimnoQuestion)
                     (relation-asserted zimno)
                     (response tak)
                     (valid-answers tak nie))))

(defrule determine-glowa ""

  (zimno tak)
   ?state<-(UI-state)

   =>
   (retract ?state) 
   (assert (glowa))
   (assert (UI-state (display GlowaQuestion)
                     (relation-asserted glowa)
                     (response tak)
                     (valid-answers tak nie))))			

(defrule determine-kawa ""

  (glowa tak)
   ?state<-(UI-state)

   =>
   (retract ?state) 
   (assert (kawa))
   (assert (UI-state (display KawaQuestion)
                     (relation-asserted kawa)
                     (response tak)
                     (valid-answers tak nie))))
					 
(defrule determine-chmielchce ""

  (zimno nie)
   ?state<-(UI-state)

   =>
   (retract ?state) 
   (assert (chmielchce))
   (assert (UI-state (display ChmielChceQuestion)
                     (relation-asserted chmielchce)
                     (response tak)
                     (valid-answers tak nie))))	
					 
(defrule determine-kwasne ""

  (chmielchce nie)
   ?state<-(UI-state)

   =>
   (retract ?state) 
   (assert (kwasne))
   (assert (UI-state (display KwasneQuestion)
                     (relation-asserted kwasne)
                     (response tak)
                     (valid-answers tak nie))))	
					 
(defrule determine-chmiellubie ""

  (kwasne nie)
   ?state<-(UI-state)

   =>
   (retract ?state) 
   (assert (chmiellubie))
   (assert (UI-state (display ChmielLubieQuestion)
                     (relation-asserted chmiellubie)
                     (response tak)
                     (valid-answers tak nie))))	
					 
;;;****************
;;;* REPAIR RULES *
;;;****************

(defrule euro-conclusions ""

    (smak tak)
    ?state<-(UI-state)
   =>
   (retract ?state)
   (assert (UI-state (display Eur)
                     (state final))))
					 
(defrule pilzner-conclusions ""

    (or (gorycz tak) (wyzwanie nie))
    ?state<-(UI-state)
   =>
   (retract ?state)
   (assert (UI-state (display Pil)
                     (state final))))
					 
(defrule pszeniczne-conclusions ""

    (or (gorycz nie) (lekko l))
    ?state<-(UI-state)
   =>
   (retract ?state)
   (assert (UI-state (display Psz)
                     (state final))))
					 
(defrule farhouse-conclusions ""

    (or (oryginalny o) (wyzwanie tak) (chmielpiwo nie))
    ?state<-(UI-state)
   =>
   (retract ?state)
   (assert (UI-state (display Far)
                     (state final))))
					 
(defrule porter-conclusions ""

    (or (aromaty cp) (glowa nie) (chmiellubie nie))
    ?state<-(UI-state)
   =>
   (retract ?state)
   (assert (UI-state (display Por)
                     (state final))))
					 
(defrule pale-conclusions ""

    (or (chmielpiwo tak) (chmiellubie tak))
    ?state<-(UI-state)
   =>
   (retract ?state)
   (assert (UI-state (display Pal)
                     (state final))))
					 
(defrule ipa-conclusions ""

    (or (aromaty oz) (chmielchce tak))
    ?state<-(UI-state)
   =>
   (retract ?state)
   (assert (UI-state (display Ipa)
                     (state final))))
					 
(defrule rosyjski-conclusions ""

    (kawa tak)
    ?state<-(UI-state)
   =>
   (retract ?state)
   (assert (UI-state (display Ros)
                     (state final))))
					 
(defrule sour-conclusions ""

    (or (danie des) (kwasne tak))
    ?state<-(UI-state)
   =>
   (retract ?state)
   (assert (UI-state (display Sou)
                     (state final))))
					 
(defrule berleywine-conclusions ""

    (kawa nie)
    ?state<-(UI-state)
   =>
   (retract ?state)
   (assert (UI-state (display Ber)
                     (state final))))