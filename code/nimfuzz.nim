import argparse
import os
import streams
import libs/doRequest

var p = newParser("Nimfuzz"):
  option("-u", "--url", help="Enter the URL target.")
  option("-w", "--wordlist", help="Enter a wordlist.")
  option("-e", "--extension", help="Set extensions.")

try: 
    var opts = p.parse(commandLineParams())

    var urlWeb: string = opts.url
    var dirWordlist: string = opts.wordlist
    var extFile: string = opts.extension
    echo ""

    doReq(urlWeb, dirWordlist, extFile)

    echo ""

except ShortCircuit as e:
   if e.flag == "argparse_help":
    echo p.help
    quit(0)

except UsageError:
  stderr.writeLine getCurrentExceptionMsg()
  echo p.help
  quit(1)
