# Change Log

All notable changes to this project will be documented in this file.

# 2015-04-23

## Added

* Ability to sync missing projects for a reminder. It could be useful when you
  have an old reminder and some new projects coming.
* Projects checks on reminder page are sorted by project's name
* `bullet` gem has been added to monitor SQL queries on development

# 2015-04-21

## Added

* Projects listing
* Slack API
* Synchronization of Slack channels with projects. Project are created based on
  channel name - has to be prefixed with `project-`, eg. `project-foo`

## Removed

* Google drive-related code, we don't need to use spreadsheets

## Fixed

* Page notices are displayed correctly

# 2015-04-20

## Added

* Basic code, configuration and views
