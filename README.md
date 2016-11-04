# Dominion Power Data Scraper

## Purpose
Extracts bill amount, bill due date, power usage (in kWh), and meter reading start & end dates and yields it in the console.

## Quickstart

### What you need
* Credentials to your Dominion Power Account (Used on https://www.dom.com/)

### Running the script
```
cd /path/to/repo
ruby script.rb
```

### Running tests
For security purposes, before you can run any rspec tests, you must create a *.env* file with the correct credentials to your DOM account.  Paste and modify the following (replace the \<VALUE\> with your credentials):
```
DOM_USERNAME=<VALUE>
DOM_PASSWORD=<VALUE>
```

When this is done, simply run the rspec command (in the project root):
```
rspec spec/
```

Note: This project includes simplecov.  You can check out the coverage/ directory automatically generated to check code coverage.

## Questions?  Issues?
[Ping me via email](mailto: pcho231@gmail.com) or [submit an ticket in the issue queue!](https://github.com/freestylebit/dom-scraper/issues)
