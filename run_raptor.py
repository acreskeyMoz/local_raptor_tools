import os
import time
import sys

browserCycles = '--browser-cycles 5 '
testSuffix = '_mitmproxy'
modes = { 'chrome', 'firefox'}

destination = '~/dev/experiments/compare_mitmproxy_live/results'
raptorPath = '~/dev/src/mozilla-central/testing/mozharness/build/raptor.json'
machPath = '~/dev/src/mozilla-central/mach'

postStartupDelay = ' '
#postStartupDelay = '--post-startup-delay 1000 '

file = open('tests.txt', 'r')
for line in file:
      testName = line.strip()

      for mode in modes:
        print( 'mode: ' + mode)
        binaryPath = ''
        if 'firefox' in mode:
          binaryPath = '--binary="/Applications/Firefox Nightly.app/Contents/MacOS/firefox" '
          testName = testName.replace('chrome', 'firefox')
        elif 'chrome' in mode:
          binaryPath = '--app=chrome --binary=/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome '
          testName = testName.replace('firefox','chrome')

        testCommand = machPath + ' raptor-test --test ' + testName + ' '
        testCommand += binaryPath
        testCommand += browserCycles
        testCommand += postStartupDelay

        print('Running test: ' + testName )
        print( "\ncommand " + testCommand)
        os.system(testCommand)

        # copy to destination
        jsonPath = os.path.join(destination, testName)
        jsonPath = os.path.join(jsonPath, mode+testSuffix)
        mkdirCommand = 'mkdir -p ' + jsonPath
        print(mkdirCommand)
        os.system(mkdirCommand)

        destinationFile = os.path.join(jsonPath,'raptor.json')
        copyCommand = 'cp ' + raptorPath + ' ' + destinationFile
        print (copyCommand)
        os.system(copyCommand)