"インデントのルール
setlocal indentexpr=GetAsmXyzIndent()

"以下のキーが押された場合は前の行を読んでインデントの調整が自動的に行われる
setlocal indentkeys=!^F,o,O,0<Bar>,0=where

function! GetAsmXyzIndent()
    let pnum = prevnonblank(v:lnum - 1)
    if pnum == 0
        return 0
    endif
    let line = getline(v:lnum)
    let pline = getline(pnum)

    " 現在のインデント幅
    let ind = indent(pnum)

    " 前の行が正規表現に一致する場合に次の行のインデント幅を調整する。&swはshift widthの略。
    " Check for clause head on previous line
    if pline =~ '\.(macro|scopein).*$'
        let ind = ind + &sw
        " Check for end of clause on previous line
    elseif pline =~ '\.(endmacro|scopeout).*$'
        let ind = ind - &sw
    endif
    return ind
endfunction
