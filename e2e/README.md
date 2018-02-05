# Modus Create Assignment - Atomated Test Suite

## Introduction

Three scenarios were choosen from the list, and automated using Cucumber, Capybara and Selenium. There is a step on the second scenario that will fail, that will happen because there's a bug on the app when sending a number of at least 17 digits (the last digits will turn into 0).

## Preparing the environment

For this tests, it is required to include the following gems on the project:

* Capybara
* Cucumber
* Selenium Webdriver
* site_prism
* RSpec
* report_builder

Those are already included on the Gemfile, to install them, just execute:

```
gem install bundler
bundle install
```

To test in chrome, please run the following command:

```
brew install chromedriver
```

## Running the tests

To run the tests, please execute the following command:

```
cucumber features/register_income.feature --format html --out report.html
```

This run will generate a report with the results, to view the results please open the file /report.html in your browser.