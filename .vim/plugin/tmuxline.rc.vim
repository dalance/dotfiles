"let g:tmuxline_preset = 'powerline'
let g:tmuxline_preset = {
            \'a'       : '#(whoami)',
            \'b'       : '',
            \'c'       : '',
            \'win'     : '#I #W',
            \'cwin'    : '#I #W',
            \'x'       : ['#[fg=green,bold]#(cat /proc/loadavg | cut -d " " -f 1,2,3)', '#(uptime  | cut -d " " -f 3,4,5 | sed "s/,//g")'],
            \'y'       : ['#[fg=blue,bold]%R', '%m/%d', '%Y'],
            \'z'       : ['#[fg=black,bold]#H', '#(/sbin/ip -o -f inet addr | grep eth0 | cut -d " " -f 7)'],
            \'options' : {'status-justify' : 'left'}
            \ }
let g:tmuxline_theme = 'powerline'
let g:tmuxline_separators = {
            \ 'left' : '⮀',
            \ 'left_alt': '⮁',
            \ 'right' : '⮂',
            \ 'right_alt' : '⮃',
            \ 'space' : ' '}
