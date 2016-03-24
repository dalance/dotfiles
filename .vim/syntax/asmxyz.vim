" Vim syntax file
" Language:	Mpu XYZ Assembler
" Maintainer:	Naoya Hatta
" Last change:	2013/08/09
"

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case match

" Register symbols
syn keyword asmReg r00 r01 r02 r03 r04 r05 r06 r07 r08 r09 r10 r11 r12 r13 r14 r15
syn keyword asmReg r16 r17 r18 r19 r20 r21 r22 r23 r24 r25 r26 r27 r28 r29 r30 r31
syn keyword asmReg c00 c01 c02 c03 c04 c05 c06 c07

" Opcodes
syn keyword asmOpcode ldu1i
syn keyword asmOpcode ldu1z
syn keyword asmOpcode ldu1l
syn keyword asmOpcode ldu1h
syn keyword asmOpcode mv2cr
syn keyword asmOpcode mv1acr
syn keyword asmOpcode mv1lr
syn keyword asmOpcode mv1ir
syn keyword asmOpcode mv1sr
syn keyword asmOpcode mv1er
syn keyword asmOpcode mv2rc
syn keyword asmOpcode mv1arc
syn keyword asmOpcode mv1rl
syn keyword asmOpcode mv1ri
syn keyword asmOpcode mv1rs
syn keyword asmOpcode mv1re
syn keyword asmOpcode add2ss
syn keyword asmOpcode cp2
syn keyword asmOpcode sub2ss
syn keyword asmOpcode add3ss
syn keyword asmOpcode sub3ss
syn keyword asmOpcode not2
syn keyword asmOpcode neg2
syn keyword asmOpcode abs2
syn keyword asmOpcode atc2
syn keyword asmOpcode cta2
syn keyword asmOpcode pcnt2
syn keyword asmOpcode min1
syn keyword asmOpcode max1
syn keyword asmOpcode min3
syn keyword asmOpcode max3
syn keyword asmOpcode and3
syn keyword asmOpcode and2
syn keyword asmOpcode or3
syn keyword asmOpcode or2
syn keyword asmOpcode xor3
syn keyword asmOpcode xor2
syn keyword asmOpcode emb3
syn keyword asmOpcode msk1
syn keyword asmOpcode msk3
syn keyword asmOpcode bool2p
syn keyword asmOpcode bool2zp
syn keyword asmOpcode bool2z
syn keyword asmOpcode bool2zn
syn keyword asmOpcode bool2n
syn keyword asmOpcode bool2nz
syn keyword asmOpcode set2
syn keyword asmOpcode set3
syn keyword asmOpcode set2b
syn keyword asmOpcode set3b
syn keyword asmOpcode mul2ss
syn keyword asmOpcode mul3ss
syn keyword asmOpcode div2ss
syn keyword asmOpcode mod2ss
syn keyword asmOpcode div3ss
syn keyword asmOpcode mod3ss
syn keyword asmOpcode sht2lr
syn keyword asmOpcode sht2ll
syn keyword asmOpcode sht2ar
syn keyword asmOpcode sht2al
syn keyword asmOpcode sht2rr
syn keyword asmOpcode sht2rl
syn keyword asmOpcode sht3lr
syn keyword asmOpcode sht3ll
syn keyword asmOpcode sht3ar
syn keyword asmOpcode sht3al
syn keyword asmOpcode sht3rr
syn keyword asmOpcode sht3rl
syn keyword asmOpcode ld1
syn keyword asmOpcode ld1v
syn keyword asmOpcode ld2
syn keyword asmOpcode ld2v
syn keyword asmOpcode ld3
syn keyword asmOpcode ld3v
syn keyword asmOpcode pop1
syn keyword asmOpcode ld1ll
syn keyword asmOpcode ld2ll
syn keyword asmOpcode ld3ll
syn keyword asmOpcode ld1k
syn keyword asmOpcode ld2k
syn keyword asmOpcode ld3k
syn keyword asmOpcode st1
syn keyword asmOpcode st2
syn keyword asmOpcode st3
syn keyword asmOpcode push1
syn keyword asmOpcode st3sc
syn keyword asmOpcode lsux
syn keyword asmOpcode lsuxcc
syn keyword asmOpcode lsuxllc
syn keyword asmOpcode st1k
syn keyword asmOpcode st2k
syn keyword asmOpcode st3k
syn keyword asmOpcode cmp2r
syn keyword asmOpcode cmp3r
syn keyword asmOpcode cmp3ru
syn keyword asmOpcode cmp2c
syn keyword asmOpcode cmp3c
syn keyword asmOpcode cmp3cu
syn keyword asmOpcode cmp2i
syn keyword asmOpcode cmp2am
syn keyword asmOpcode cmp2om
syn keyword asmOpcode irm1g
syn keyword asmOpcode irm1s
syn keyword asmOpcode irms
syn keyword asmOpcode bcp2
syn keyword asmOpcode bcut2
syn keyword asmOpcode bpst2
syn keyword asmOpcode mmu2g
syn keyword asmOpcode mmu2s
syn keyword asmOpcode mmux
syn keyword asmOpcode sysent
syn keyword asmOpcode sysret
syn keyword asmOpcode sysrel
syn keyword asmOpcode sysbrk
syn keyword asmOpcode sys2g
syn keyword asmOpcode sys2s
syn keyword asmOpcode pro2g
syn keyword asmOpcode pro2s
syn keyword asmOpcode break
syn keyword asmOpcode perf1g
syn keyword asmOpcode perfrst
syn keyword asmOpcode jmpcabs
syn keyword asmOpcode jmpcrel
syn keyword asmOpcode jmpclnk
syn keyword asmOpcode jmpabs
syn keyword asmOpcode jmprel
syn keyword asmOpcode jmpreg
syn keyword asmOpcode jmpret
syn keyword asmOpcode jmpblk
syn keyword asmOpcode rfi
syn keyword asmOpcode rfe
syn keyword asmOpcode fork1
syn keyword asmOpcode join1
syn keyword asmOpcode exit
syn keyword asmOpcode tp2g
syn keyword asmOpcode tp2s
syn keyword asmOpcode nop

" Label
syn match asmLabel ":[a-zA-Z_][a-zA-Z0-9_]*"
syn match asmLabel ":\*[a-zA-Z_][a-zA-Z0-9_]*"
syn match asmLabel ":&[a-zA-Z_][a-zA-Z0-9_]*"

" Identifier
syn match asmIdent   "\$[a-zA-Z_][a-zA-Z0-9_]\+"
syn match asmIdent   "[a-zA-Z_][a-zA-Z0-9_]\+"

" Alias
syn match asmAlias "\$[A-Z_][A-Z0-9_]\+"
syn match asmAlias "[A-Z_][A-Z0-9_]\+"

" Number
syn match decNumber "[0-9]\+"
syn match hexNumber "0[xX][0-9a-fA-F_]\+"
syn match binNumber "0[bB][0-1_]\+"

" Special
syn match asmSpecial "__[a-zA-Z_][a-zA-Z0-9_]*__"

" Operators
syn match asmOperator "[-+*/%~&|]"
syn match asmOperator "<<"
syn match asmOperator ">>"
syn match asmOperator "++"
syn match asmOperator "--"
syn match asmOperator ">="
syn match asmOperator "<="
syn match asmOperator "=="
syn match asmOperator "!="

" String
syn match asmString "\".*\""
syn match asmString "\'.*\'"

" Comments
syn region asmComment start="/\*" end="\*/"
syn region asmComment start="//" end="$" keepend contains=asmTodo

" Directives
syn match asmDirective "\.macro"
syn match asmDirective "\.endmacro"
syn match asmDirective "\.scopein"
syn match asmDirective "\.scopeout"
syn match asmDirective "\.address"

syn case match

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_asmxyz_syntax_inits")
  if version < 508
    let did_asmxyz_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " The default methods for highlighting.  Can be overridden later
  " Comment Constant Error Identifier PreProc Special Statement Todo Type
  "
  " Constant		Boolean Character Number String
  " Identifier		Function
  " PreProc		Define Include Macro PreCondit
  " Special		Debug Delimiter SpecialChar SpecialComment Tag
  " Statement		Conditional Exception Keyword Label Operator Repeat
  " Type		StorageClass Structure Typedef

  HiLink asmComment		Comment
  HiLink asmString		String

  HiLink hexNumber		Number		" Constant
  HiLink binNumber		Number		" Constant
  HiLink decNumber		Number		" Constant

  HiLink asmAlias		Constant	" Statement

  HiLink asmIdent		Identifier	" Statement
  HiLink asmSpecial		Special	" Statement

  HiLink asmReg			Type
  HiLink asmOperator		Operator

  HiLink asmDirective		Keyword

  HiLink asmOpcode		Macro

  HiLink asmLabel		StorageClass
  delcommand HiLink
endif

let b:current_syntax = "asmxyz"

" vim: ts=8 sw=2
