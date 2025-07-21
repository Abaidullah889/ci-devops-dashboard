#!/bin/bash

echo "Running Python tests..."

# Run tests and capture both output and exit code
output=$(python -m unittest discover -s tests 2>&1)
exit_code=$?
echo "$output"

# Extract total number of tests using awk (more portable)
total_tests=$(echo "$output" | awk '/^Ran [0-9]+ test/ {print $2}')

# Count passed tests
if echo "$output" | grep -q "^OK$"; then
  passed=$total_tests
  failed=0
else
  # Extract number of failures and errors using awk
  fail_line=$(echo "$output" | grep "^FAILED")
  failures=$(echo "$fail_line" | awk -F'failures=' '{print $2}' | awk -F',' '{print $1}' | awk '{print $1}')
  errors=$(echo "$fail_line" | awk -F'errors=' '{print $2}' | awk -F')' '{print $1}' | awk '{print $1}')

  # Default to 0 if empty
  [[ -z "$failures" ]] && failures=0
  [[ -z "$errors" ]] && errors=0

  failed=$((failures + errors))
  passed=$((total_tests - failed))
fi

# Determine build status
if [[ $exit_code -eq 0 ]]; then
  status="SUCCESS"
else
  status="FAILURE"
fi

timestamp=$(date)

# Display results
echo "Passed: $passed"
echo "Failed: $failed"
echo "Status: $status"
echo "Timestamp: $timestamp"

# Save results to JSON
cat <<EOF > results.json
{
  "status": "$status",
  "passed": $passed,
  "failed": $failed,
  "timestamp": "$timestamp"
}
EOF

echo "✅ results.json created."
