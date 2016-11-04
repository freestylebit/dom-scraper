# Dominion Power Data Scraper

## Purpose
Extracts bill amount, bill due date, power usage (in kWh), and meter reading start & end dates and yields it in the console.

## Quickstart

### What you need
* Credentials to your Dominion Power Account (Used on https://www.dom.com/)

### Running the script
```
rake scraper:dom
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
Note: VCR is included to minimize live requests to the server during testing. Once in a while, you should stash the fixtures directory to get updated data.
```
rm -rf /spec/fixtures
```

## Questions?  Issues?
[Ping me via email](mailto: pcho231@gmail.com) or [submit an ticket in the issue queue!](https://github.com/freestylebit/dom-scraper/issues)
