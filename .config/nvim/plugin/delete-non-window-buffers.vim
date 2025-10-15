function! DeleteNonWindowBuffers()
	" Open a scratch buffer in a split
	silent! vsplit :enew

	" Redirect output of `ls` (buffer listing) into 'b' register
	silent! redir @b>
	silent! ls
	silent! redir END

	" Paste the contents of the 'b' register into the scratch file
	silent! normal "bp

	" Delete any lines that have any kind of marking between the buffer number
	" and the file name
	silent! v/^\s*\d*\s*"/d

	" Remove everything but the buffer numbers
	silent! %s/\s*\(\d*\).*/\1/

	" Get all of the buffer numbers on one line
	silent! g/.*/normal kJ

	" Create the command by typing 'bdelete ' before the buffer numbers. Then,
	" copy the whole line into the 'b' register.
	silent! normal 0ibdelete "byy

	" Execute the command stored in the 'b' register.
	silent! @b

	" Delete our scratch buffer
	silent! bd!
endfunction

command! DeleteNonWindowBuffers call DeleteNonWindowBuffers()
