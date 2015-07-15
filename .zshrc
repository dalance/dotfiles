#- Complete ------------------------------------------------

autoload -U compinit
compinit -u

zstyle ':completion:*'         matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*'         use-cache    true
zstyle ':completion:*:default' menu         select=1
zstyle ':completion:*:default' list-colors  ""
zstyle ':completion:*:cd:*'    tag-order    local-directories path-directories
zstyle ':completion:sudo:*'    environ      PATH="$SUDO_PATH:$PATH"

#- Vcs Info ------------------------------------------------

autoload -Uz vcs_info

zstyle  ':vcs_info:*:*'   formats      '[%b(%s)]'
zstyle  ':vcs_info:svn:*' branchformat '%b:%r'

precmd() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

#- Prompt --------------------------------------------------

PROMPT='%B%{[36m%}%n%{[32m%}@%{[32m%}%m%{[m%}%b%B[%h]%0(?||%130(?||%20(?||%{[31m%})))%#%{[m%}%b '
RPROMPT='%B%{[33m%}[%~]%{[35m%}%1v%{[m%}%b'

#- Key Bind ------------------------------------------------

stty erase '^H'
stty intr  '^C'
stty susp  '^Z'

bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

#- Zsh Parameter -------------------------------------------

LISTMAX=0
HISTFILE=$HOME/.zsh/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

if [ $UID = 0 ]; then
    unset HISTFILE
    SAVEHIST=0
fi

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

REPORTTIME=3

#- Zsh Option ----------------------------------------------

# core抑制
limit coredumpsize 0

# ファイル作成時のパーミッション
umask 022

# ディレクトリ移動
unsetopt auto_cd                # ディレクトリのみで移動
setopt   auto_pushd             # 普通に cd するときにもディレクトリスタックにそのディレクトリを入れる
unsetopt cdable_vars            # cd の引数がディレクトリでなくスラッシュで始まらない場合に先頭に ~ を補完する
setopt   chase_dots             # パスの一部に .. が含まれるとき実際のディレクトリに変換する
unsetopt chase_links            # シンボリックリンクをリンク先のパスに変換する
setopt   pushd_ignore_dups      # ディレクトリスタック上の重複を除去する
setopt   pushd_minus            # cd の引数に {+-}[0-9]+ を指定する際の + と - の意味を逆にする
setopt   pushd_silent           # pushd,popdの度にディレクトリスタックの中身を表示しない
setopt   pushd_to_home          # pushd 引数ナシ == pushd $HOME

# 補完
setopt   always_last_prompt     # カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt   always_to_end          # 単語途中にカーソルを置いて補完したとき、補完されるとカーソルが単語末尾に移動する
setopt   auto_list              # ^Iで補完可能な一覧を表示する(補完候補が複数ある時に、一覧表示)
setopt   auto_menu              # 補完キー連打で順に補完候補を自動で補完
setopt   auto_name_dirs         # ディレクトリの絶対パスがセットされた変数は、そのディレクトリの名前となる
setopt   auto_param_keys        # カッコの対応などを自動的に補完
setopt   auto_param_slash       # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt   auto_remove_slash      # 補完で末尾に補われた / を自動的に削除
unsetopt bash_auto_list         # 曖昧な補完の場合、補完関数が二度連続で呼ばれると自動的に選択肢をリストアップする
unsetopt complete_aliases       # 補完時にエイリアスを元のコマンドとは違う名前のコマンドとみなす
setopt   complete_in_word       # セットされないと、補完を開始したときにカーソルは単語の終端に位置するとみなされる
setopt   glob_complete          # 現在の単語がグロブパターンのとき、パターンにマッチしたものを生成し、サイクルする
setopt   hash_list_all          # コマンド補完が行われたとき、コマンドパスをハッシュする
setopt   list_ambiguous         # 入力に曖昧さがない場合、補完候補のリストを出すことなく補完する
unsetopt list_beep              # 曖昧な補完の場合、ビープ音を出す
setopt   list_packed            # コンパクトに補完リストを表示
unsetopt list_rows_first        # 補完リストを水平方向にソートする(2番目の候補が1番目の右になる)
setopt   list_types             # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
unsetopt menu_complete          # 曖昧な補完の際に、補完候補のリストを表示するのではなく、最初にマッチしたものを挿入する
unsetopt rec_exact              # 曖昧さがあっても、入力と正確に一致する候補があればそれを優先する

# 展開・グロブ
setopt   bad_pattern            # ファイル名生成のパターンがフォーマット違反の時、エラーメッセージを表示する
setopt   bare_glob_qual         # グロブパターンにおいて、末尾にあって `|' も `(' も `~' も含まないならば、修飾子とみなす
setopt   brace_ccl              # ブレース内の式が正しくない形式とき、個々の文字の辞書順リストとなる
setopt   case_glob              # グロッビング(ファイル名生成)で大文字小文字を区別する
setopt   case_match             # zsh/regex モジュールのマッチで大文字小文字を区別する
unsetopt csh_null_glob          # ファイル名生成のパターンがマッチしないとき、引数リストからそのパターンを取り除く
setopt   equals                 # =COMMAND を COMMAND のパス名に展開
setopt   extended_glob          # 拡張グロブを有効にする
setopt   glob                   # グロブを有効にする
unsetopt glob_assign            # 代入式の右辺でもグロッビングする
unsetopt glob_dots              # . で開始するファイル名にマッチさせるとき、先頭に明示的に . を指定する必要がなくなる
unsetopt glob_subst             # 変数の結果を置換して得られた文字を、ファイル拡張やファイル名生成として扱う
unsetopt hist_subst_pattern     # 履歴からの置換結果をパターンをして扱う
unsetopt ignore_braces          # ブレース拡張を行わない
unsetopt ksh_glob               # パターンマッチにおいて、カッコの解釈は直前の `@'、`*'、`+'、`?'、`!' によって異なる
setopt   magic_equal_subst      # コマンドラインの引数で --PREFIX=/USR などの = 以降でも補完できる
setopt   mark_dirs              # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt   multibyte              # マルチバイト文字を認識する
setopt   nomatch                # ファイル名生成のパターンにマッチするものがない場合、エラーを表示する
unsetopt null_glob              # ファイル名生成のパターンがマッチしないとき、引数リストからそのパターンを取り除く
setopt   numeric_glob_sort      # 数字を数値と解釈してソートする
setopt   rc_expand_param        # 配列変数 x=(1 2) を用いて `a${x}b' を置換するとき、`a1 2b' ではなく `a1b a2b' に置換される
setopt   rematch_pcre           # =~ 演算子で正規表現マッチに Perl Compatible Regular Expressions ライブラリを用いる
unsetopt sh_glob                # グロッビングにおいて、`('、'|'、')' および '<' の特殊な意味を無効化する
unsetopt unset                  # 未定義変数を空白で置換する
unsetopt warn_create_global     # 関数内で代入によりグローバル変数が宣言された時に警告する

# 履歴
setopt   append_history         # 履歴を追加(毎回 .zhistory を作るのではなく)
unsetopt bang_hist              # cshスタイルのヒストリ拡張を使う(`!' 文字を特別に扱う)
unsetopt extended_history       # 履歴ファイルに開始時刻と経過時間を記録
unsetopt hist_allow_clobber     # 履歴において、出力リダイレクションに `|' を加える
unsetopt hist_beep              # エントリが存在しなかった場合にビープ音を出す
setopt   hist_expire_dups_first # 現在のコマンド行を履歴に追加するとき、末尾を削る代わりに、最も古い同一イベントを削る
setopt   hist_fcntl_lock        # 履歴ファイルのロックに fcntl を用いる
setopt   hist_find_no_dups      # ラインエディタで履歴エントリを表示するとき、過去に表示したものと同一のエントリは表示しない
setopt   hist_ignore_all_dups   # 重複するエントリは古い方を削除
setopt   hist_ignore_dups       # 直前と同じコマンドは履歴に追加しない
setopt   hist_ignore_space      # スペースで始まるコマンド行は履歴に追加しない
setopt   hist_no_functions      # 関数定義を履歴に追加しない
setopt   hist_no_store          # historyコマンドは履歴に追加しない
setopt   hist_reduce_blanks     # 余分な空白は詰めて記録
setopt   hist_save_by_copy      # 履歴ファイルを更新するとき、別名で保存してからリネームする
setopt   hist_save_no_dups      # 履歴ファイルに書き出すときに、古いコマンドと同じものは無視する
unsetopt hist_verify            # ヒストリを呼び出してから実行する間に一旦編集可能を止める
setopt   inc_append_history     # 履歴をインクリメンタルに追加
setopt   share_history          # 履歴の共有

# 初期化
unsetopt all_export             # 以降、定義された全ての変数は export される
setopt   global_export          # export された変数のスコープをグローバルにする
setopt   global_rcs             # /etc/zprofile、/etc/zshrc、/etc/zlogin、/etc/zlogout を実行する
setopt   rcs                    # global_rcs に加えて、.zshnv、.zprofile、.zshrc、.zlogin、.zlogout を実行する

# 入出力
setopt   aliases                # エイリアスを拡張する
setopt   clobber                # 上書きリダイレクトを許可する
unsetopt correct                # スペルミスを補完
unsetopt correct_all            # コマンドライン全てのスペルチェックをする
unsetopt dvorak                 # スペルミス補完をDVORAK配列モードにする
unsetopt flow_control           # フロー制御を有効にする
setopt   ignore_eof             # Ctrl-Dでログアウトしない
unsetopt interactive_comments   # 対話シェル上でコメントを有効にする
setopt   hash_cmds              # コマンドが実行されるときにパスをハッシュに入れる
setopt   hash_dirs              # コマンドがハッシュされるときに、ディレクトリ名もハッシュに入れる
unsetopt mail_warning           # シェルが最後にチェックした後でメールファイルがアクセスされていると、警告する
setopt   path_dirs              # コマンド名に / が含まれているとき PATH 中のサブディレクトリを探す
setopt   print_eight_bit        # 補完候補リストの日本語を適正表示
unsetopt print_exit_value       # プログラムの返り値が 0 でないとき、それを表示する
unsetopt rc_quotes              # シングルクォートで囲まれた文字列内部で `''' をシングルクォートとして扱う
unsetopt rm_star_silent         # rm * を実行する前に確認しない
unsetopt rm_star_wait           # rm * を実行する前に10秒待つ
setopt   short_loops            # FOR, REPEAT, SELECT, IF, FUNCTION などで簡略文法が使えるようになる
unsetopt sun_keyboard_hack      # SUNキーボードでの頻出 typo ` をカバーする

# ジョブ制御
unsetopt auto_continue          # disown でジョブテーブルから削除されたジョブに自動的に CONT シグナルを送る
setopt   auto_resume            # サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt   bg_nice                # 全てのバックグラウンドジョブを低優先度で実行する
unsetopt checkjobs              # ログアウト時にバックグラウンドジョブを確認する
unsetopt hup                    # ログアウト時にバックグラウンドジョブをkillする
setopt   long_list_jobs         # 内部コマンド jobs の出力をデフォルトで jobs -L にする
setopt   monitor                # ジョブ制御を有効にする
setopt   notify                 # バックグラウンドジョブが終了したら(プロンプトの表示を待たずに)すぐに知らせる

# プロンプト
unsetopt prompt_bang            # `!' をプロンプト拡張で特殊文字として扱う
setopt   prompt_cr              # ラインエディタのプロンプトを表示する直前に復帰文字を出力する
setopt   prompt_percent         # `%' をプロンプト拡張で特殊文字として扱う
setopt   prompt_subst           # プロンプトに escape sequence (環境変数) を通す
unsetopt transient_rprompt      # コマンド行を受け入れたときに、右プロンプトを削除する

# スクリプト・関数
setopt   c_bases                # 16進数を C 言語形式で出力する
setopt   c_precedences          # 演算子の優先度を C 言語に合わせる
unsetopt debug_before_cmd       # 各コマンドの前あるいは後にDEBUGトラップを実行する
unsetopt err_exit               # コマンドの返り値が 0 でないとき、ZERRトラップを実行する
unsetopt err_return             # コマンドの返り値が 0 でないとき、そのコマンドを呼び出した関数から脱出する
setopt   eval_lineno            # ライン番号の評価を有効にする
setopt   exec                   # コマンドの実行を有効にする
setopt   function_argzero       # 関数やスクリプトの source 実行時に、 $0 を一時的にその関数／スクリプト名にセットする
unsetopt local_options          # シェル関数の終了時に、すべての(このオプションを含む)オプションは復帰される
unsetopt local_traps            # 関数内でシグナルのトラップが設定されているとき、関数終了時にそのトラップ元に復帰する
setopt   multi_func_def         # 'fn1 fn2...()' のような関数宣言を許可する
setopt   multios                # 複数のリダイレクトやパイプなど、必要に応じて TEE や CAT の機能が使われる
unsetopt octal_zeroes           # 0から開始される整数は、8進数として解釈する
unsetopt typeset_silent         # 'typeset' コマンドを引数なしで呼び出すことを許可しない
unsetopt verbose                # 全ての入力を表示する
unsetopt xtrace                 # コマンドラインがどのように展開され実行されたかを表示する

# シェルエミュレーション

# シェル状態

# ZLE
unsetopt beep                  # コマンド入力エラーでビープ音を出す
setopt   emacs                 # キーバインドをemacsモードにする
unsetopt single_line_zle       # デフォルトの複数行コマンドライン編集ではなく、１行編集モードにする
unsetopt vi                    # キーバインドをviモードにする

#- Function ------------------------------------------------

# ssh ホスト名補完
make_p () {
    local t s
    t="$1"; shift

    [ -f $t ] || return 0

    for s; do
        [ $s -nt $t ] && return 0
    done

    return 1
}

cache_hosts_file="$HOME/.zsh/.cache_hosts"
known_hosts_file="$HOME/.ssh/known_hosts"

print_cache_hosts () {
    if [ -f $known_hosts_file ]; then
        awk '{ if (split($1, a, ",") > 1) for (i in a) { if (a[i] ~ /^[a-z]/) print a[i] } else print $1 }' $known_hosts_file
    fi
}

update_cache_hosts () {
    print_cache_hosts | sort -u > $cache_hosts_file
}

make_p $cache_hosts_file $known_hosts_file && update_cache_hosts

_cache_hosts=( $(< $cache_hosts_file) )

#- Alias ---------------------------------------------------

alias cp='cp -rf'
alias mv='mv -i'
alias pd="pushd"
alias po="popd"

alias vi='vim'
alias via="vim $HOME/.zshrc"
alias seta="source $HOME/.zshrc;zcompile $HOME/.zshrc"

# グローバルエイリアス
alias -g G='| grep '
alias -g L='| $PAGER '
alias -g W='| wc'
alias -g H='| head'
alias -g T='| tail'

# Suffixエイリアス
alias -s pdf=evince
alias -s xls=libreoffice
alias -s ppt=libreoffice
alias -s doc=libreoffice
alias -s bmp=gthumb
alias -s jpg=gthumb
alias -s png=gthumb

# colore-ls
# 個人カラー設定のロード
if [ -f $HOME/.dir_colors ]; then
    eval `dircolors -b $HOME/.dir_colors`
fi

# ls
alias la='ls -aF --show-control-char --color=always'
alias ls='ls --show-control-char --color=always'
alias ll='ls -l --show-control-char --color=always'
alias l.='ls -d .[a-zA-Z]* --color=always'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # 補完候補を色分け (GNU ls の色定義を流用)

alias du="du -h"
alias df="df -h"

alias firefox="firefox >& /dev/null"
alias thunderbird="thunderbird >& /dev/null"
alias chrome="chrome >& /dev/null"
alias conky="conky >& /dev/null"

alias s='dummy'

alias vlc='MALLOC_CHECK_=1 vlc >& /dev/null'

alias ctags='ctags -R --exclude=lib'

alias top='glances'

#- Local Setting -------------------------------------------

if [ -e $HOME/.zshrc.local ]; then
    source $HOME/.zshrc.local
fi

#- Antigen -------------------------------------------------

#source ~/dotfiles/antigen/antigen.zsh

#antigen bundle zsh-users/zsh-syntax-highlighting

#antigen apply
