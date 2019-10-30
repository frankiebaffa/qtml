" Vim syntax file
" Language:        DoubleDown
" Maintainer:      Frankie Baffa
" Latest Revision: 18 Oct 2019
" TODO: fix highlighting of layout block tag
"       following a variable

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syntax spell toplevel

syn case ignore

syn match ddownTagName contained containedin=ddownCloseTag,ddownOpenTag "\(_\)\@<=[a-zA-Z0-9]\+\(\.\||\|#\|\[\)\@="
syn match ddownTagName contained containedin=ddownCloseTag,ddownOpenTag "\(|\)\@<=[a-zA-Z0-9]\+\(_\)\@="
syn match ddownId      contained containedin=ddownOpenTag,ddownVarTag   "\(#\)\@<=[a-zA-Z0-9]\+\(\.\||\|\[\|@\|#\)\@="
syn match ddownClass   contained containedin=ddownOpenTag              "\(\.\)\@<=[a-zA-Z0-9]\+\(\.\||\|#\|\[\)\@="

" Attributes
syn match  ddownAttr         contained containedin=ddownAtterList                                "[a-zA-Z]\+"
syn match  ddownAttrVal      contained containedin=ddownAtterList                                "[a-zA-Z0-9\.]\+"
syn match  ddownAttrValDelim contained containedin=ddownAtterList nextgroup=ddownAttrVal          "="
syn match  ddownAttrKey      contained containedin=ddownAtterList nextgroup=ddownAttrValDelim     "[a-zA-Z]\+"
syn match  ddownAttrDelim    contained containedin=ddownAtterList nextgroup=ddownAttrKey,ddownAttr ","

syn region ddownAttrList contained containedin=ddownOpenTag contains=ddownAttr,ddownAttrVal,ddownAttrValDelim,ddownAttrKey,ddownAttrDelim start="\[" end="\]"

syn match ddownVarName contained containedin=ddownVarName "\(@\)\@<=[a-zA-Z0-9]\+"

" Tag Elements
syn region ddownVarTag   contained containedin=ddownLayout                oneline contains=ddownId,ddownVarName                          start="@\([a-zA-Z0-9]\)\@="     end="@"
syn region ddownOpenTag  contained containedin=ddownLayoutVar,ddownLayout oneline contains=ddownId,ddownClass,ddownTagName,ddownAttrList start="_\(CONTENT\|LAYOUT\)\@!" end="\(CONTENT\|LAYOUT\)\@<!|"
syn region ddownCloseTag contained containedin=ddownLayoutVar,ddownLayout oneline contains=ddownTagName                                  start="|\(CONTENT\|LAYOUT\)\@!" end="\(CONTENT\|LAYOUT\)\@<!_"

" Content Id
syn region ddownContentText                            contained containedin=ddownContent start="\(\(^\s*\)\@<=#[a-zA-Z0-9]\+\s\+\)\@<=\s\([a-zA-Z0-9%><|\*_]\)\@=" end="^\(\(\(^\s*\)\@<=#[a-zA-Z0-9]\+\(\s\+\)\@=\)\|^\(|CONTENT_\)\@=\)\@="
syn match  ddownInlineChar                             contained containedin=ddownContentText "\(%>\|<%\|\$>\|<\$\||\|_\|\*\)"
syn match  ddownContentId   nextgroup=ddownContentText contained containedin=ddownContent "\(^\s*\)\@<=#[a-zA-Z0-9]\+\(\s\+\)\@="

syn region ddownLayoutVar contained containedin=ddownLayoutVarSec contains=ddownOpenTag,ddownCloseTag start="@\(CONTENT\|LAYOUT\)\@![a-zA-Z0-9]\+|" end="|\(CONTENT\|LAYOUT\)\@![a-zA-Z0-9]\+@"

" Import CSS
syn include @css syntax/css.vim

" Content region
syn region  ddownLayout       start=+^_LAYOUT|$+  end=+^|LAYOUT_$+  contains=ddownOpenTag,ddownCloseTag
syn region  ddownLayoutVarSec start=+^@LAYOUT|$+  end=+^|LAYOUT@$+  contains=ddownLayoutVar
syn region  ddownContent      start=+^_CONTENT|$+ end=+^|CONTENT_$+ contains=ddownContentId
syn region  ddownStyle        start=+^_STYLE|$+   end=+^|STYLE_$+   contains=@css

hi def link ddownStyle        Comment
hi def link ddownContent      Comment
hi def link ddownLayoutVarSec Comment
hi def link ddownHtml         Comment
hi def link ddownLayout       Comment
hi def link ddownStyleIdent   Special
hi def link ddownStyleRegion  Exception
hi def link ddownStyleKey     Title
hi def link ddownStyleValue   Type
hi def link ddownContentId    Type
hi def link ddownContentText  Title
hi def link ddownInlineChar   Exception
hi def link ddownInnerText    Special
hi def link ddownLayoutVar    Special
hi def link ddownOpenTag      Exception
hi def link ddownVarTag       Exception
hi def link ddownCloseTag     Exception
hi def link ddownAttrList     Exception
hi def link ddownAttrDelim    Comment
hi def link ddownAttrKey      Title
hi def link ddownAttrValDelim Special
hi def link ddownAttrVal      Type
hi def link ddownAttr         Title
hi def link ddownClass        Type
hi def link ddownId           Type
hi def link ddownTagName      Title
hi def link ddownVarName      Special
