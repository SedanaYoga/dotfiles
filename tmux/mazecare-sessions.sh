#!/bin/zsh
mazecare_path_saas=~/mazecare/saas
mazecare_path_saas_cwt=~/mazecare/saas-cwt
mazecare_path_saas_scwt=~/mazecare/saas-scwt

tmux new-session -d -s "saas" -c "$mazecare_path_saas"
tmux new-window -t "saas" -c "$mazecare_path_saas"
tmux new-window -t "saas" -c "$mazecare_path_saas"
tmux new-session -d -s "saas-cwt" -c "$mazecare_path_saas_cwt"
tmux new-window -t "saas-cwt" -c "$mazecare_path_saas_cwt"
tmux new-window -t "saas-cwt" -c "$mazecare_path_saas_cwt"
tmux new-session -d -s "saas-scwt" -c "$mazecare_path_saas_scwt"
tmux new-window -t "saas-scwt" -c "$mazecare_path_saas_scwt"
tmux new-window -t "saas-scwt" -c "$mazecare_path_saas_scwt"
