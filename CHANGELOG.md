# Change Log

All notable changes to this project will be documented in this file.

# 2015-04-28

## Added

* We have a shiny new logo, thanks [@czajkovsky](https://github.com/czajkovsky)!
* Checks might be now disabled/enabled so they are not executed
* Reminder and deadline notification messages are fully customizable
* Table rows with checks are marked with appropriate color depending on their state

# 2015-04-27

## Added

* Slack channel name is saved in db when projects are synced
* The simplest version of admin authorization

## Fixed

* Flash messages have top margin and the are separated from the navbar

# 2015-04-26

## Added

* Sidekiq for background processing
* Field in `reminders` table to check on which days send a (gentle)
  notification about expiring task
* Task, jobs and services for handling notifications for appropriate checks
  (e.g. check is overdue)
* `Procfile` file for `foreman` users (easy way to start development services)
* Various validation to models
* `valid_for_n_days` column has been added to `reminders` table - it will tell
  for how many days the check is valid

## Removed

* `interval` column has been removed from `reminders` table

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
