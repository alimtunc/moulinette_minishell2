# moulinette_minishell2

Fournir un fichier '.tms2' avec l'instruction à effectuer :

echo [INSTRUCTION] | $SHELL_REF [VALEUR À CATCH] > .tmp1

echo [INSTRUCTION] | $MY_SHELL [VALEUR À CATCH] > .tmp2



echo -e "setenv TOTO testde:value\nenv" | $SHELL_REF | grep TOTO > .tmp1

echo -e "setenv TOTO testde:value\nenv" | $MY_SHELL | grep TOTO > .tmp2

