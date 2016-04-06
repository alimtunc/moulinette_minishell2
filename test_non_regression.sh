#!/bin/bash
SHELL_REF=tcsh
MY_SHELL=./mysh

TESTS="
setenv
setenv_no_env
unsetenv
ctrl_d
exit
exit_char
exit_val
exit_neg_val"

NB_TEST=0
NB_VALID=0

setenv()
{
  echo -e "setenv TOTO testde:value\nenv" | $SHELL_REF | grep TOTO > .tmp1
  echo -e "setenv TOTO testde:value\nenv" | $MY_SHELL | grep TOTO > .tmp2
}

setenv_no_env()
{
  echo -e "setenv TOTO testde:value\nenv" | env -i $SHELL_REF | grep TOTO=testde:value | wc -l > .tmp1
  echo -e "setenv TOTO testde:value\nenv" | env -i $MY_SHELL | grep TOTO=testde:value | wc -l > .tmp2
}

unsetenv()
{
  echo -e "unsetenv PATH\nenv" | env -i $SHELL_REF | grep PATH | wc -l > .tmp1
  echo -e "unsetenv PATH\nenv" | env -i $MY_SHELL | grep PATH | wc -l > .tmp2
}

ctrl_d()
{
  echo -e "^D" | $SHELL_REF >& /dev/null; echo $? >> .tmp1
  echo -e "^D" | $MY_SHELL >& /dev/null; echo $? >> .tmp2
}

exit_char()
{
  echo -e "exit char" | $SHELL_REF >& /dev/null; echo $? >> .tmp1
  echo -e "exit char" | $MY_SHELL >& /dev/null; echo $? >> .tmp2
}

exit_val()
{
  echo -e "exit 42" | $SHELL_REF >& /dev/null; echo $? >> .tmp1
  echo -e "exit 42" | $MY_SHELL >& /dev/null; echo $? >> .tmp2
}

exit_neg_val()
{
  echo -e "exit -1" | $SHELL_REF >& /dev/null; echo $? >> .tmp1
  echo -e "exit -1" | $MY_SHELL >& /dev/null; echo $? >> .tmp2
}

exit()
{
  echo -e "exit" | $SHELL_REF >& /dev/null; echo $? >> .tmp1
  echo -e "exit" | $MY_SHELL >& /dev/null; echo $? >> .tmp2
}

echo -n "Compiling.."
make >& /dev/null
echo "."
make re >& /dev/null
echo "-------------"

for ELEMENT in $TESTS
do
  NB_TEST=$(echo $NB_TEST+1 | bc)
  echo -n "$ELEMENT -> "
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
