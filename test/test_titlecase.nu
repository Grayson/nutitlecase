(load "TitleCase")
(load "Nu:beautify")

(class TestTitleCaps is NuTestCase
	
	(imethod (id) testConversion is
		(set test <<-END
Q&A With Steve Jobs: 'That's What Happens In Technology'
What Is AT&T's Problem?
Apple Deal With AT&T Falls Through

this v that
this vs that
this v. that
this vs. that

The SEC's Apple Probe: What You Need to Know

'by the Way, small word at the start but within quotes.'

Small word at end is nothing to be afraid of


Starting Sub-Phrase With a Small Word: a Trick, Perhaps?
Sub-Phrase With a Small Word in Quotes: 'a Trick, Perhaps?'
Sub-Phrase With a Small Word in Quotes: "a Trick, Perhaps?"

"Nothing to Be Afraid of?"
"Nothing to Be Afraid Of?"

a thing



Known Issues
------------

2lmc Spool: 'Gruber on OmniFocus and Vapo(u)rware'
END)
		(set test ((test strip) convertToTitleCase))
		(set real <<-END
Q&A With Steve Jobs: 'That's What Happens in Technology'
What Is AT&T's Problem?
Apple Deal With AT&T Falls Through

This v That
This vs That
This v. That
This vs. That

The SEC's Apple Probe: What You Need to Know

'By the Way, Small Word at the Start but Within Quotes.'

Small Word at End Is Nothing to Be Afraid Of


Starting Sub-Phrase With a Small Word: A Trick, Perhaps?
Sub-Phrase With a Small Word in Quotes: 'A Trick, Perhaps?'
Sub-Phrase With a Small Word in Quotes: "A Trick, Perhaps?"

"Nothing to Be Afraid Of?"
"Nothing to Be Afraid Of?"

A Thing



Known Issues
------------

2lmc Spool: 'Gruber on OmniFocus and Vapo(U)Rware'
END)
		(assert_equal test real)
	))
