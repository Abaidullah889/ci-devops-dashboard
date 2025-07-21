#!/bin/bash

echo "Running Python tests..."

# Run tests and capture both output and exit code
output=$(python -m unittest discover -s tests 2>&1)
exit_code=$?
echo "$output"

# Extract "Ran X tests" from summary
total_tests=$(echo "$output" | grep -oP "Ran \K[0-9]+(?= test)")

# Count passed tests by checking for 'OK' at the end
if echo "$output" | grep -q "^OK$"; then
  passed=$total_tests
  failed=0
else
  # Extract failures/errors from the FAILED(...) line
  fail_line=$(echo "$output" | grep -oP "FAILED \([^)]+\)")
  failures=$(echo "$fail_line" | grep -oP "failures=\K[0-9]+")
  errors=$(echo "$fail_line" | grep -oP "errors=\K[0-9]+")

  # Default to 0 if values are empty
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

# Display results in terminal
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
