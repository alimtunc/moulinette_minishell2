#!/bin/bash
export SHELL_REF=tcsh
export MY_SHELL=$(pwd)/mysh

TESTS=$(find ./Moulinette -name "*.tms2")

NB_TEST=0
NB_VALID=0

echo -n "Compiling.."
make >& /dev/null
echo "."
make re >& /dev/null
echo "-------------"

for ELEMENT in $TESTS
do
  NB_TEST=$(echo $NB_TEST+1 | bc)
  echo -n "$(basename $ELEMENT) -> "
  $ELEMENT
  diff .tmp1 .tmp2 >& /dev/null

  if [ $? == 0 ];then
    echo -e "\e[32;1mOK\e[0m"
    NB_VALID=$(echo $NB_VALID+1 | bc)
  else
    echo -e "\e[31;1mKO\e[0m"
  fi

  rm -f .tmp1
  rm -f .tmp2
done

echo -e "\n$NB_VALID / $NB_TEST -> $(echo $NB_VALID*100/$NB_TEST | bc)%"
make fclean
