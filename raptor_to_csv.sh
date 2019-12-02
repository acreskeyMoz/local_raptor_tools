#!/usr/bin/env bash
for filename in $(find ./data -name "*.json"); do
  out_path=$(dirname $filename)/out.csv

  # get the directory name to be used as the "mode" header
  dir="$(dirname $filename)"   # Returns "/from/here/to"
  dir="$(basename $dir)"  # Returns just "to"
  echo $dir

  cat $filename | jq --arg mode $dir --raw-output '["mode", "test", "fcp", "loadtime" ], ( .suites[] | .name as $name | .subtests as $subtests | $subtests[] | select(.name == "fcp") as $fcp | $subtests[] | select(.name == "loadtime") as $loadtime | range(0; $subtests[0].replicates | length) as $i | [ $mode, $name, $fcp.replicates[$i], $loadtime.replicates[$i] ]) | @csv' > $out_path

done

#.browserScripts as $metrics | range(0; $metrics | length) as $i | [$mode, $url, $metrics[$i].timings.pageTimings.backEndTime,

