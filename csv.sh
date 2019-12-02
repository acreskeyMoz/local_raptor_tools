#!/usr/bin/env bash
for filename in *.json; do
    cat $filename | jq --raw-output '.suites[] | .name as $parent | .subtests[] | [$parent, .name, "" , "", "", "" ] + .replicates | @csv' > $filename.csv
done
