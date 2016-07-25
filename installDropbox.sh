#!/bin/sh

#  installDropbox.sh
#  
#
#  Created by command.Zi on 16/7/23.
#

function install_Dropbox() {
    cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
    ~/.dropbox-dist/dropboxd
    ~/.dropbox-dist/dropboxd &
}

install_Dropbox