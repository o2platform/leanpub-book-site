#!/usr/bin/env bash

echo ***** Pulling latest Changes *****
cd book/Book_Jira_Risk_Workflow
git pull origin master
cd ../..

echo ***** Building Changes *****
./bin/Create-Book.coffee

echo ***** Publishing Book Changes *****
cd book/Book_Jira_Risk_Workflow_Build
git add -A
git commit -m "Adding build files"
git push origin master
