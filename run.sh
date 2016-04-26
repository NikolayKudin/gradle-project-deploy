#!/bin/bash

echo Enter svn password
read -s svnpassword

options=$(getopt -o '' --long "user::" -- "$@")
eval set -- "$options"

echo $options

while true; do
    case "$1" in
        --user) user="$2"; shift ;;
        --) echo 'end'; shift; break;;
        *) break;;
    esac
    shift
done

extravars='user='$user' svnpassword='$svnpassword
echo "extravars: $extravars"

ansible-playbook -i hosts gradle_deploy.yml --extra-vars="$extravars" -v

exit 0;