#!/usr/bin/env bash
for filename in $(find ./data -name "*.csv"); do
  sed -i '' -e 's/-chrome//g' $filename
  sed -i '' -e 's/-firefox//g' $filename
  sed -i '' -e 's/-live//g' $filename
done

#.browserScripts as $metrics | range(0; $metrics | length) as $i | [$mode, $url, $metrics[$i].timings.pageTimings.backEndTime,

