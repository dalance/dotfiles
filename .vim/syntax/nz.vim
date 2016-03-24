" Vim syntax file
" Language:             Scala
" Maintainer:           Derek Wyatt
" URL:                  https://github.com/derekwyatt/vim-nz
" License:              Apache 2
" ----------------------------------------------------------------------------

if !exists('main_syntax')
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'nz'
endif

scriptencoding utf-8

let b:current_syntax = "nz"

" Allows for embedding, see #59; main_syntax convention instead? Refactor TOP
"
" The @Spell here is a weird hack, it means *exclude* if the first group is
" TOP. Otherwise we get spelling errors highlighted on code elements that
" match nzBlock, even with `syn spell notoplevel`.
function! s:ContainedGroup()
  try
    silent syn list @nz
    return '@nz,@NoSpell'
  catch /E392/
    return 'TOP,@Spell'
  endtry
endfunction

syn include @nzHtml syntax/html.vim  " Doc comment HTML
unlet! b:current_syntax

syn case match
syn sync minlines=200 maxlines=1000

syn keyword nzKeyword catch do else final finally for forSome if
syn keyword nzKeyword match return throw try while yield macro
syn keyword nzKeyword class trait object extends with nextgroup=nzInstanceDeclaration skipwhite
syn keyword nzKeyword case nextgroup=nzKeyword,nzCaseFollowing skipwhite
syn keyword nzKeyword val nextgroup=nzNameDefinition,nzQuasiQuotes skipwhite
syn keyword nzKeyword def var nextgroup=nzNameDefinition skipwhite
hi link nzKeyword Keyword

exe 'syn region nzBlock start=/{/ end=/}/ contains=' . s:ContainedGroup() . ' fold'

syn keyword nzAkkaSpecialWord when goto using startWith initialize onTransition stay become unbecome
hi link nzAkkaSpecialWord PreProc

syn match nzSymbol /'[_A-Za-z0-9$]\+/
hi link nzSymbol Number

syn match nzChar /'.'/
syn match nzChar /'\\[\\"'ntbrf]'/ contains=nzEscapedChar
syn match nzChar /'\\u[A-Fa-f0-9]\{4}'/ contains=nzUnicodeChar
syn match nzEscapedChar /\\[\\"'ntbrf]/
syn match nzUnicodeChar /\\u[A-Fa-f0-9]\{4}/
hi link nzChar Character
hi link nzEscapedChar Function
hi link nzUnicodeChar Special

syn match nzOperator "||"
syn match nzOperator "&&"
hi link nzOperator Special

syn match nzNameDefinition /\<[_A-Za-z0-9$]\+\>/ contained nextgroup=nzPostNameDefinition
syn match nzNameDefinition /`[^`]\+`/ contained nextgroup=nzPostNameDefinition
syn match nzPostNameDefinition /\_s*:\_s*/ contained nextgroup=nzTypeDeclaration
hi link nzNameDefinition Function

syn match nzInstanceDeclaration /\<[_\.A-Za-z0-9$]\+\>/ contained nextgroup=nzInstanceHash
syn match nzInstanceDeclaration /`[^`]\+`/ contained
syn match nzInstanceHash /#/ contained nextgroup=nzInstanceDeclaration
hi link nzInstanceDeclaration Special
hi link nzInstanceHash Type

syn match nzUnimplemented /???/
hi link nzUnimplemented ERROR

syn match nzCapitalWord /\<[A-Z][A-Za-z0-9$]*\>/
hi link nzCapitalWord Special

" Handle type declarations specially
syn region nzTypeStatement matchgroup=Keyword start=/\<type\_s\+\ze/ end=/$/ contains=nzTypeTypeDeclaration,nzSquareBrackets,nzTypeTypeEquals,nzTypeStatement

" Ugh... duplication of all the nzType* stuff to handle special highlighting
" of `type X =` declarations
syn match nzTypeTypeDeclaration /(/ contained nextgroup=nzTypeTypeExtension,nzTypeTypeEquals contains=nzRoundBrackets skipwhite
syn match nzTypeTypeDeclaration /\%(⇒\|=>\)\ze/ contained nextgroup=nzTypeTypeDeclaration contains=nzTypeTypeExtension skipwhite
syn match nzTypeTypeDeclaration /\<[_\.A-Za-z0-9$]\+\>/ contained nextgroup=nzTypeTypeExtension,nzTypeTypeEquals skipwhite
syn match nzTypeTypeEquals /=\ze[^>]/ contained nextgroup=nzTypeTypePostDeclaration skipwhite
syn match nzTypeTypeExtension /)\?\_s*\zs\%(⇒\|=>\|<:\|:>\|=:=\|::\|#\)/ contained nextgroup=nzTypeTypeDeclaration skipwhite
syn match nzTypeTypePostDeclaration /\<[_\.A-Za-z0-9$]\+\>/ contained nextgroup=nzTypeTypePostExtension skipwhite
syn match nzTypeTypePostExtension /\%(⇒\|=>\|<:\|:>\|=:=\|::\)/ contained nextgroup=nzTypeTypePostDeclaration skipwhite
hi link nzTypeTypeDeclaration Type
hi link nzTypeTypeExtension Keyword
hi link nzTypeTypePostDeclaration Special
hi link nzTypeTypePostExtension Keyword

syn match nzTypeDeclaration /(/ contained nextgroup=nzTypeExtension contains=nzRoundBrackets skipwhite
syn match nzTypeDeclaration /\%(⇒\|=>\)\ze/ contained nextgroup=nzTypeDeclaration contains=nzTypeExtension skipwhite
syn match nzTypeDeclaration /\<[_\.A-Za-z0-9$]\+\>/ contained nextgroup=nzTypeExtension skipwhite
syn match nzTypeExtension /)\?\_s*\zs\%(⇒\|=>\|<:\|:>\|=:=\|::\|#\)/ contained nextgroup=nzTypeDeclaration skipwhite
hi link nzTypeDeclaration Type
hi link nzTypeExtension Keyword
hi link nzTypePostExtension Keyword

syn match nzTypeAnnotation /\%([_a-zA-Z0-9$\s]:\_s*\)\ze[_=(\.A-Za-z0-9$]\+/ skipwhite nextgroup=nzTypeDeclaration contains=nzRoundBrackets
syn match nzTypeAnnotation /)\_s*:\_s*\ze[_=(\.A-Za-z0-9$]\+/ skipwhite nextgroup=nzTypeDeclaration
hi link nzTypeAnnotation Normal

syn match nzCaseFollowing /\<[_\.A-Za-z0-9$]\+\>/ contained
syn match nzCaseFollowing /`[^`]\+`/ contained
hi link nzCaseFollowing Special

syn keyword nzKeywordModifier abstract override final lazy implicit implicitly private protected sealed null require super
hi link nzKeywordModifier Function

syn keyword nzSpecial this true false ne eq
syn keyword nzSpecial new nextgroup=nzInstanceDeclaration skipwhite
syn match nzSpecial "\%(=>\|⇒\|<-\|←\|->\|→\)"
syn match nzSpecial /`[^`]*`/  " Backtick literals
hi link nzSpecial PreProc

syn keyword nzExternal package import
hi link nzExternal Include

syn match nzStringEmbeddedQuote /\\"/ contained
syn region nzString start=/"/ end=/"/ contains=nzStringEmbeddedQuote,nzEscapedChar,nzUnicodeChar
hi link nzString String
hi link nzStringEmbeddedQuote String

syn region nzIString matchgroup=nzInterpolationBrackets start=/\<[a-zA-Z][a-zA-Z0-9_]*"/ skip=/\\"/ end=/"/ contains=nzInterpolation,nzInterpolationB,nzEscapedChar,nzUnicodeChar
syn region nzTripleIString matchgroup=nzInterpolationBrackets start=/\<[a-zA-Z][a-zA-Z0-9_]*"""/ end=/"""\%([^"]\|$\)/ contains=nzInterpolation,nzInterpolationB,nzEscapedChar,nzUnicodeChar
hi link nzIString String
hi link nzTripleIString String

syn match nzInterpolation /\$[a-zA-Z0-9_$]\+/ contained
exe 'syn region nzInterpolationB matchgroup=nzInterpolationBoundary start=/\${/ end=/}/ contained contains=' . s:ContainedGroup()
hi link nzInterpolation Function
hi link nzInterpolationB Normal

syn region nzFString matchgroup=nzInterpolationBrackets start=/f"/ skip=/\\"/ end=/"/ contains=nzFInterpolation,nzFInterpolationB,nzEscapedChar,nzUnicodeChar
syn match nzFInterpolation /\$[a-zA-Z0-9_$]\+\(%[-A-Za-z0-9\.]\+\)\?/ contained
exe 'syn region nzFInterpolationB matchgroup=nzInterpolationBoundary start=/${/ end=/}\(%[-A-Za-z0-9\.]\+\)\?/ contained contains=' . s:ContainedGroup()
hi link nzFString String
hi link nzFInterpolation Function
hi link nzFInterpolationB Normal

syn region nzTripleString start=/"""/ end=/"""\%([^"]\|$\)/ contains=nzEscapedChar,nzUnicodeChar
syn region nzTripleFString matchgroup=nzInterpolationBrackets start=/f"""/ end=/"""\%([^"]\|$\)/ contains=nzFInterpolation,nzFInterpolationB,nzEscapedChar,nzUnicodeChar
hi link nzTripleString String
hi link nzTripleFString String

hi link nzInterpolationBrackets Special
hi link nzInterpolationBoundary Function

syn match nzNumber /\<0[dDfFlL]\?\>/ " Just a bare 0
syn match nzNumber /\<[1-9]\d*[dDfFlL]\?\>/  " A multi-digit number - octal numbers with leading 0's are deprecated in Scala
syn match nzNumber /\<0[xX][0-9a-fA-F]\+[dDfFlL]\?\>/ " Hex number
syn match nzNumber /\%(\<\d\+\.\d*\|\.\d\+\)\%([eE][-+]\=\d\+\)\=[fFdD]\=/ " exponential notation 1
syn match nzNumber /\<\d\+[eE][-+]\=\d\+[fFdD]\=\>/ " exponential notation 2
syn match nzNumber /\<\d\+\%([eE][-+]\=\d\+\)\=[fFdD]\>/ " exponential notation 3
hi link nzNumber Number

syn region nzRoundBrackets start="(" end=")" skipwhite contained contains=nzTypeDeclaration,nzSquareBrackets,nzRoundBrackets

syn region nzSquareBrackets matchgroup=nzSquareBracketsBrackets start="\[" end="\]" skipwhite nextgroup=nzTypeExtension contains=nzTypeDeclaration,nzSquareBrackets,nzTypeOperator,nzTypeAnnotationParameter
syn match nzTypeOperator /[-+=:<>]\+/ contained
syn match nzTypeAnnotationParameter /@\<[`_A-Za-z0-9$]\+\>/ contained
hi link nzSquareBracketsBrackets Type
hi link nzTypeOperator Keyword
hi link nzTypeAnnotationParameter Function

syn match nzShebang "\%^#!.*" display
syn region nzMultilineComment start="/\*" end="\*/" contains=nzMultilineComment,nzDocLinks,nzParameterAnnotation,nzCommentAnnotation,nzTodo,nzCommentCodeBlock,@nzHtml,@Spell keepend
syn match nzCommentAnnotation "@[_A-Za-z0-9$]\+" contained
syn match nzParameterAnnotation "@param" nextgroup=nzParamAnnotationValue skipwhite contained
syn match nzParamAnnotationValue /[`_A-Za-z0-9$]\+/ contained
syn region nzDocLinks start="\[\[" end="\]\]" contained
syn region nzCommentCodeBlock matchgroup=Keyword start="{{{" end="}}}" contained
syn match nzTodo "\vTODO|FIXME|XXX" contained
hi link nzShebang Comment
hi link nzMultilineComment Comment
hi link nzDocLinks Function
hi link nzParameterAnnotation Function
hi link nzParamAnnotationValue Keyword
hi link nzCommentAnnotation Function
hi link nzCommentCodeBlockBrackets String
hi link nzCommentCodeBlock String
hi link nzTodo Todo

syn match nzAnnotation /@\<[`_A-Za-z0-9$]\+\>/
hi link nzAnnotation PreProc

syn match nzTrailingComment "//.*$" contains=nzTodo,@Spell
hi link nzTrailingComment Comment

syn match nzAkkaFSM /goto([^)]*)\_s\+\<using\>/ contains=nzAkkaFSMGotoUsing
syn match nzAkkaFSM /stay\_s\+using/
syn match nzAkkaFSM /^\s*stay\s*$/
syn match nzAkkaFSM /when\ze([^)]*)/
syn match nzAkkaFSM /startWith\ze([^)]*)/
syn match nzAkkaFSM /initialize\ze()/
syn match nzAkkaFSM /onTransition/
syn match nzAkkaFSM /onTermination/
syn match nzAkkaFSM /whenUnhandled/
syn match nzAkkaFSMGotoUsing /\<using\>/
syn match nzAkkaFSMGotoUsing /\<goto\>/
hi link nzAkkaFSM PreProc
hi link nzAkkaFSMGotoUsing PreProc

let b:current_syntax = 'nz'

if main_syntax ==# 'nz'
  unlet main_syntax
endif

" vim:set sw=2 sts=2 ts=8 et:
