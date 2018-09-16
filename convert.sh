#!/bin/sh

SED_COMMAND='sed'
if test "$(uname)" = "Darwin"; then
  SED_COMMAND='gsed'
fi


read -p "Converting SimpleAccounts (mayus) in: " choice
egrep -rl 'SimpleAccounts' * | xargs $SED_COMMAND -i "s/SimpleAccounts/$choice/g"

read -p "Converting simple_accounts (minus) in: " choice
egrep -rl 'simple_accounts' . | xargs $SED_COMMAND -i "s/simple_accounts/$choice/g"

rm -Rf .git
git init .
