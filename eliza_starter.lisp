;;==========================================================================
;;
;; STARTER FILE FOR CSC 4240/5240 PROGRAM #1: Eliza
;;==========================================================================

;;----------------------------------------------------------------------------
;; eliza: top-level function which, when given a sentence (no
;; punctuation, please!), comes back with a response like you would.

( defun eliza ( sentence )
  ( respond ( change-pros sentence ) database ) )

;;----------------------------------------------------------------------------
;; change-pros: changes the pronouns of the sentence so that Eliza can
;; come back with the appropriately switched first and second person
;; references.
;; I need to add more pronoun changes here
( defun change-pros ( sentence )
  ( cond 
    ( ( null sentence ) nil )
    ( ( equal ( car sentence ) 'you )
      ( cons 'I ( change-pros ( cdr sentence ) ) ) )
    ( ( equal ( car sentence ) 'I )
      ( cons 'you ( change-pros ( cdr sentence ) ) ) )

    ( ( equal ( car sentence ) 'am )
      ( cons 'are ( change-pros ( cdr sentence ) ) ) )
    ( ( equal ( car sentence ) 'are )
      ( cons 'am ( change-pros ( cdr sentence ) ) ) )

     ( ( equal ( car sentence ) 'your )
      ( cons 'I ( change-pros ( cdr sentence ) ) ) )
    ( ( equal ( car sentence ) 'our )
      ( cons 'yours ( change-pros ( cdr sentence ) ) ) )
    ( ( equal ( car sentence ) 'myself )
      ( cons 'yourself ( change-pros ( cdr sentence ) ) ) )
    ( ( equal ( car sentence ) 'yourself )
      ( cons 'myself ( change-pros ( cdr sentence ) ) ) )  
    ( ( equal ( car sentence ) 'my )
      ( cons 'your ( change-pros ( cdr sentence ) ) ) )
    ( ( equal ( car sentence ) 'me )
      ( cons 'you ( change-pros ( cdr sentence ) ) ) ) 
    ( ( equal ( car sentence ) 'mine )
      ( cons 'yours ( change-pros ( cdr sentence ) ) ) )
    ( ( equal ( car sentence ) 'yours )
      ( cons 'mine ( change-pros ( cdr sentence ) ) ) ) 
            

    ;; CHANGE THIS: add more cases here of pronouns or other words
    ;; that should flip in order for this to work well

    ( t ( cons ( car sentence ) ( change-pros ( cdr sentence ) ) ) ) ) )

;;----------------------------------------------------------------------------
;; respond: given a sentence, looks through the database in search of
;; a matching pattern and the response; given the database response,
;; uses 'instantiate' to fill in the blanks, and returns the completed
;; response

( defun respond ( sentence db )
  ( cond
    ;; end of DB, return nil - should never really happen
    ( ( null db ) nil )

    ;; if the result of matching the sentence against the current
    ;; pattern is a success, produce this response
    ( ( success ( setq result ( match sentence ( first ( car db ) ) ) ) )
      ( instantiate result ( second ( car db ) ) ) )

    ;; otherwise, keep looking through the DB
    ( t ( respond sentence ( cdr db ) ) ) ) )
     ;;(t
     ;;(let ((randomCatchAll (nth (random (length catchAllResponses)) catchAllResponses)))
      ;; (instantiate nil randomCatchAll)))))

;;----------------------------------------------------------------------------
;; match: if there is not a match between this pattern and this data,
;; returns 'fail;' otherwise, returns the sentence in partitioned
;; format

( defun match ( data pattern )
  ( cond
    ;; end of both data and pattern; a match
    ( ( and ( null data ) ( null pattern ) ) nil )

    ;; end of pattern, but not end of data; no match
    ( ( null pattern ) fail )

    ;; end of data, but not end of pattern; if the pattern starts with
    ;; a variable, eat it and try and match the rest of the pattern to
    ;; the null sentence (will only work if all variables); otherwise,
    ;; fail
    ( ( null data ) 
      ( cond
	( ( variablep ( car pattern ) )
	  ( if ( success ( setq result ( match data ( cdr pattern ) ) ) )
	      result
	    fail ) )
	( t fail ) ) )


    ;; first item of data and pattern are identical; if the rest of it
    ;; matched, return the first item cons'ed with the rest of the
    ;; partitioned sentence; otherwise, fail
    ( ( equal ( car data ) ( car pattern ) )
      ( if ( success ( setq result ( match ( cdr data ) ( cdr pattern ) ) ) )
	  ( cons ( list ( car data ) ) result )
	fail ) )

    ;; first item of pattern is a variable; if the rest of the data
    ;; (minus the first word, matched to the variable) is a match with
    ;; all of the pattern, return the appropriate stuff; if all of the
    ;; data (variable eats nothing) matches the rest of the pattern,
    ;; return appropriate stuff; else, fail.
    ( ( variablep ( car pattern ) ) 
      ( cond
	;; variable eats nothing;  () is put in partitioned sentence
	( ( success ( setq result ( match data ( cdr pattern ) ) ) )
	  ( cons () result ) )
	;; variable eats one word; word is cons'ed into the first
	;; element of the partitioned sentence, assuming that the step
	;; before an actual match word would be a ()
	( ( success ( setq result ( match ( cdr data ) pattern ) ) )
	  ( cons ( cons ( car data ) ( car result ) ) ( cdr result ) ) )
	;; otherwise, fail
	( t fail ) ) )

    ( t fail ) ) )

;;----------------------------------------------------------------------------
;; instantiate: takes a partitioned sentence and the response it has
;; been matched to and generates the appropriated completed response

( defun instantiate ( partitioned response )
  ( cond
    ( ( null response ) nil )
    ;; numbers indicate what part of the partitioned sentence to
    ;; insert into the response
    ( ( numberp ( car response ) )
      ( setq index ( - ( car response ) 1 ) )
      ( append ( nth index partitioned )
	     ( instantiate partitioned ( cdr response ) ) ) )
    ( t ( cons ( car response )
	     ( instantiate partitioned ( cdr response ) ) ) ) ) )

;;---------------------------------------------------------------------------
;;
;;  			     helping functions
;;
;;---------------------------------------------------------------------------

( setq fail '-1 )

( defun success ( result )
  ( not ( equal result fail ) ) )

( defun variablep ( word )
  ( equal word '0 ) )


;;---------------------------------------------------------------------------
;;
;;  			         database
;;
;;---------------------------------------------------------------------------

;; CHANGE THIS: add more to this database so that the interaction is
;; more interesting and communicative and so that Eliza sounds like you 
;; would sound in the same conversation!
;;---------------------------------------------------------------------------

( setq database
       '(
	 ;; example greetings/farewells -- change them to sound like you

   ;; Greeting and Goodbyes- starting and ending conversations

	 ( (Hello 0)
	   (Hello - have a seat and tell me how you feel today.) )
   ( (Hi 0)
     (Hey - how's it going?))
   ( (Hey 0) 
     (Hi would you like to talk? ))
   ( (Hola 0)
     (Hola is there something you wanna talk about?)) 
   ( (Good morning 0)
     (Good morning how are you doing today?))
   ( (Good afternoon 0)
     (Hey there how's your day been?))

   ( (0 bye 0)
     (Byeeeee been nice talking you))
   ( (0 See ya 0)
     (See ya talk to ya later))
   ( (0 Chao 0)
     (Chao it was great talking with you.))   
	 ( (0 Goodbye 0)
	   (Have a good one!) 
    )

     ;; early conversation sentences
    
   ( (0 you came here 0)
	   (Well everyone needs someone to talk to I'm all ears.) )
   ( (0 can you talk 0)
     (Yeah I can talk right now what's on your mind?))
   ( (0 you would 0 )
     (Sure what's going on.)) 
   ( (0 talk to I 0)
     (What is it you wanna talk about?)) 
   
   ;; If we apologize to eliza
   ( ( 0 sorry 0)
     (Ehh don't apologize it's not your fault))
   

	 ;; feelings
	 ( (0 you think 0)
	   (And just why do you think 4 ?) )
   ( (0 you feel 0)
      (And why do you feel 4 ?))  
    ( (0 you are 0)
     (Why are you 4 ?)) 
   ( (0 you enjoy 0)
     (Why do you enjoy 4 ?))
   ( (0 makes you 0)
      (That's great that it makes you 4 )) 

   ;; responding to subjects - partitioned 
   ;; partitioned lines that are a little complex
   ;; meant for a deeper conversation
   ( (0 have I ever 0)
     (I don't think I have ever 5 ))
   ( (0 you have a 0)
     (That's wonderful that you have a 5 ))

   ( (0 you miss your 0)
     (Why do you miss your 5 ?))

   ( (0 you got 0) 
     (Great job on getting a 4 )) 
   ( (0 do I have a 0)
     (Can't say I've ever had a 6 ))
   ( (0 do you 0)
     (I don't 4 ))

   ( (0 you can't 0)
     (Why can't you 4 ))  
   ( (0 you need to 0)
     (It seems like you need to 5 ))
   ( (0 you know 0 but you 0)
     (Why haven't you 7 )) 
   ( (0 you live 0 from 0)
     (4 is not that far away))   

   ;; These aren't partitioned off in the beginning
   ;; since lisp is linear these will need to be further below in the program 
   ;; in order for lisp to recognize other rules
   ( (you have to 0)
     (Do you want to do that?))

   ( (thank I 0)
     (Of course anytime!) ) 
   ( (0 thanks 0)
     (Hey no problem.))

   ( (you are 0)
     (Why are you 3 ?))  
   ( (do I 0)
     (Yeah, I really think so))
   ( (you have 0)
     (Why have you 3))

   ( (you want to 0)
     (If you want to 4 then you should))
   ( (you don't 0)
     (Oh! Do you wanna keep talking about it?))
  
   ( (why haven't I 0)
     (Well because I have allergies))  
   ( (Why don't I 0)
     (I've never given it much thought))
   ( (because 0)
     (That's a pretty good reason))  

   ;; one word responses
   ( (no)
     (Let's talk about something else then.))
   ( (yes)
     (Then let's keep talking about it.))  

   ;; Conversation extenders
  
   ( (0)
   (Could you explain that further.) ) 
    
   ( (0)
    (Can you think of another example?) )
    
   ( (0)
    (Can you phrase that in another way?) )
    
   ( (0)
   (I'm not sure I understand that.) )
    
   ( (0)
   (Go on...) )
    
   ( (0)
   (I'm not sure what to think of that.) )
    
   ( (0)
   (What do you mean by that?) )
	 

    ) )




