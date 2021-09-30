import streams
import httpclient
import strutils
import defColor

var client: HttpClient = newHttpClient()


proc doReq*(urlWeb: string, dirWordlist: string, extFile: string) =
  var dirWordlist: FileStream = newFileStream(dirWordlist, fmRead)
  var line: string = ""

  if not isNil(dirWordlist):
      echo redCol & "[+] Results:"
      while dirWordlist.readLine(line):
        for word in extFile.split(","):
          var printTarget: string = urlWeb & "/"
          printTarget.add(line & word)
          var response: Response = client.get(printTarget)
          if not response.status.startsWith("404"):
            echo limeCol & " " & response.status & ": " & orangeCol & printTarget & blueCol & " (size: " & intToStr(len(response.body)) & ")" & endCol
            client.close()
