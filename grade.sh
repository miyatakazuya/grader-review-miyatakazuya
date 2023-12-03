CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission > /dev/null
echo 'Finished cloning'

cd student-submission

# Check if the student has a ListExamples.java file
if [ ! -f ListExamples.java ]; then
    echo 'ListExamples.java not found'
    exit 1
fi

# Check if the student has "static List<String> filter(List<String> s, StringChecker sc)" in their ListExamples.java file. The arguments can be named differently, but the return type and method name must be the same.
if ! grep -E 'static List<String> filter\(List<String> .*, StringChecker .*\)' ListExamples.java; then
    echo 'filter method not found. Please make sure the method name and return type are the same as the instructions. The arguments can be named differently. It should look like this "static List<String> filter(List<String> s, StringChecker sc)"'
    exit 1
fi

if ! grep -i -E "static List<String> merge\(List<String> .*, List<String> .*\)" ListExamples.java; then
    echo 'merge method not found. Please make sure the method name and return type are the same as the instructions. The arguments can be named differently. It should look like this "static List<String> merge(List<String> s1, List<String> s2)"'
    exit 1
fi

# ------------------------


# Print new lines
echo
echo
echo

# Move the ListExamples.java files to the grading area
cp -r . ../grading-area
cp ../TestListExamples.java ../grading-area
cp -r ../lib ../grading-area

# Compile the student's code
cd ../grading-area


javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" *.java
# Check if the student's code compiled
if [ $? -ne 0 ]; then
    echo 'Student code did not compile'
    exit 1
fi

# Run the tests
java -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar;grading-area" org.junit.runner.JUnitCore TestListExamples > output.txt

# Check if the tests passed in output.txt
if ! grep -i -E "OK \([0-9]+\stests?\)" output.txt; then
    echo 'Tests did not pass'
    # Put number of tests passed in a variable
    NUMBER_OF_TESTS=$(grep -oP '(?<=Tests run: )\d+' output.txt)
    echo "Number of Tests: $NUMBER_OF_TESTS"

    # Put number of tests failed in a variable
    NUMBER_OF_TESTS_FAILED=$(grep -oP '(?<=Failures: )\d+' output.txt)
    echo "Number of Tests Failed: $NUMBER_OF_TESTS_FAILED"


    NUMBER_OF_TESTS_PASSED=$((NUMBER_OF_TESTS - NUMBER_OF_TESTS_FAILED))

    echo "Number of Tests Passed: $NUMBER_OF_TESTS_PASSED"

    SCORE=$((NUMBER_OF_TESTS_PASSED * 100 / NUMBER_OF_TESTS))

    if [ $SCORE -lt 50 ]; then
        echo 'Your code is bad'
    fi

    echo "Score: $SCORE%"
    exit 1

fi

# Whooooo everything passed :)

echo 'All tests passed'
echo 'Score: 100%'
echo 'Great job!'
echo 'You are a rockstar!'
echo 'You are a coding god!'
echo 'You are a coding goddess!'
echo 'You are a coding deity!'
echo 'You are a coding legend!'
echo 'You are a coding wizard!'
echo 'You are a coding ninja!'
echo 'You are a coding guru!'
exit 0











