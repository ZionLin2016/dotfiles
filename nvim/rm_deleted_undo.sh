#!/bin/bash
undodir=~/.config/nvim/.undo
undo_str=$(ls $undodir)

files=${undo_str//%//}
for f in $files
do
    if [ ! -f $f ];  then
        raw_file=$undodir/${f////%}
        echo "rm $raw_file ..."
        rm $raw_file
    fi
done
