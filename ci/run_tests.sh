#!/bin/bash

echo "Running Python tests..."

mkdir -p /app/results

# Run tests and capture both output and exit code
output=$(python -m unittest discover -s tests 2>&1)
exit_code=$?
echo "$output"

# Extract total number of tests
total_tests=$(echo "$output" | grep -Eo 'Ran [0-9]+ test' | grep -Eo '[0-9]+')

# Count passed/failed
if echo "$output" | grep -q "^OK$"; then
  passed=$total_tests
  failed=0
else
  fail_line=$(echo "$output" | grep "^FAILED")
  failures=$(echo "$fail_line" | grep -oE 'failures=[0-9]+' | cut -d= -f2)
  errors=$(echo "$fail_line" | grep -oE 'errors=[0-9]+' | cut -d= -f2)

  [[ "$failures" =~ ^[0-9]+$ ]] || failures=0
  [[ "$errors" =~ ^[0-9]+$ ]] || errors=0

  failed=$((failures + errors))
  passed=$((total_tests - failed))
fi

# Determine status
status="FAILURE"
[[ $exit_code -eq 0 ]] && status="SUCCESS"

timestamp=$(date)

# Output results
echo "Passed: $passed"
echo "Failed: $failed"
echo "Status: $status"
echo "Timestamp: $timestamp"

# Save to JSON
echo "✅ Writing results.json..."
cat <<EOF > /app/results/results.json
{
  "status": "$status",
  "passed": $passed,
  "failed": $failed,
  "timestamp": "$timestamp"
}
EOF

echo "✅ results.json created."
