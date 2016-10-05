#!/usr/bin/env bash

cd book/Book_Jira_Risk_Workflow
git pull origin master
cd ../..

./bin/Create-Book.coffee

cd book/Book_Jira_Risk_Workflow_Build
git add -A
git commit -m "Adding build files"
git push origin master
