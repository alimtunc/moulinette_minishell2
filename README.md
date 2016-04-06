# moulinette_minishell2

Fournir un fichier '.tms2' avec l'instruction à effectuer :

echo -e "setenv TOTO testde:value\nenv" | $SHELL_REF | grep TOTO > .tmp1
         ^---------------------------^    ^--------^   ^-------^
             Commande à effectuer           Tcsh         Résultat à catch, et le rediriger dans .tmp1

echo -e "setenv TOTO testde:value\nenv" | $MY_SHELL | grep TOTO > .tmp2
^---------------------------------------------------------------------^
  Comme pour le premier mais avec la variable $MY_SHELL et une redirection dans .tmp2
