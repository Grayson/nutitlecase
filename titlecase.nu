(load "Nu:beautify")
(class NuRegex
		(- (id) replaceAllInString:(id)text usingBlock:(id)block is
			(set out (NSMutableString stringWithString:text))
			((self findAllInString:text) each:(do (m) (out replaceCharactersInRange:(m range) withString:(block m)) ))
			out))

(class NSString
	(- (id) convertToTitleCase is
		(set smallWordsRE "a|an|and|as|at|but|by|en|for|if|in|of|on|or|the|to|v\.?|via|vs\.?")
		(set punctuation "\"' \t\n?")
		(set out "")
		(set lines (/(\r\n|\r|\n)/ splitString:self))
		(lines each:(do (line)
			(set components (/( [:.;?!][ ] | (?:[ ]|^)["“] )/x splitString:(line strip)))
			(components each:(do (component)
				(set s (/\b([a-zA-Z][a-z.'’]*)\b/x replaceAllInString:component usingBlock:(do (wordMatch)
					# Do not capitalize if the string has a period in it like del.icio.us
					(if (== nil (/[A-z]\.[A-z]/x findInString:(wordMatch group))) ((wordMatch group) capitalizedString)
					(else (wordMatch group) )) )) )
				
				# Replace from the small words list
				(set s ((NuRegex regexWithPattern:"\\b(#{smallWordsRE})\\b" options:1) replaceAllInString:s usingBlock:(do (m) 
					((m group) lowercaseString) )) )
				# Capitalize if first word is a small word
				(set s ((NuRegex regexWithPattern:"\\A([#{punctuation}]*)(#{smallWordsRE})\\b" options:1) replaceAllInString:s usingBlock:(do (m)
					"#{(m groupAtIndex:1)}#{((m groupAtIndex:2) capitalizedString)}")) )
				# Capitalize if the last word is a small word
				(set s ((NuRegex regexWithPattern:"\\b(#{smallWordsRE})([#{punctuation}]*)\\Z" options:1) replaceAllInString:s usingBlock:(do (m) "#{((m groupAtIndex:1) capitalizedString)}#{(m groupAtIndex:2)}")) )
				(set out (+ out s)) )) ))
		(set out (/V(s?)\./ replaceWithString:"v$1." inString:out))
		(set out (/(['’])S\b/ replaceWithString:"$1s" inString:out))
		(set out (/\b(AT&T|Q&A)\b/i replaceAllInString:out usingBlock:(do (m) ((m group) uppercaseString))))
		
		out))
