#!/bin/bash

# Este script fue obtenido de: https://sangsoonam.github.io/2019/02/08/using-git-worktree-to-deploy-github-pages.html 

DIA=`date +"%d/%m/%Y"`
HORA=`date +"%H:%M"`
directory=_site
branch=gh-pages
build_command() {
  jekyll build
}

echo -e "\033[0;32mUpdating main...\033[0m"
git add --all
git commit -m "Actualización automática del $DIA a las $HORA"
git push origin

echo -e "\033[0;32mDeleting old content...\033[0m"
rm -rf $directory

echo -e "\033[0;32mChecking out $branch....\033[0m"
git worktree add $directory $branch

echo -e "\033[0;32mGenerating site...\033[0m"
build_command

echo -e "\033[0;32mDeploying $branch branch...\033[0m"
cd $directory &&
  git add --all &&
  git commit -m "Deploy updates" &&
  git push origin $branch

echo -e "\033[0;32mCleaning up...\033[0m"

echo y | git worktree remove $directory
