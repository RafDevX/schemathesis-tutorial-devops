intro to fuzzing

intro to schemathesis

background.sh should install schemathesis, ideally using pip

tell user to run command, but don't actually analyze (next step)

"we will look at an example output in the next step"

# Intro to Fuzzing
Fuzzing, also known as fuzz testing, is a software testing technique which aims to find implementation bugs by automatically injecting malformed data. An example of malformed data would be entering the 30th of February 2024 as a date. The data stems from generators that often use a combination of random data and static fuzzing vectors which are known to be dangerous. Vulnerabilities are then identified using debugging tools. It is with noting that the main purpose of fuzzing is to showcase the presence of bugs rather than their absence, i.e., bugs might still be present in a software even though no vulnerabilities are identified when fuzzing.
