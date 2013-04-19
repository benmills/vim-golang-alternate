function! GolangGetAlternateFilename(filepath)
  let fileToOpen = ""

  if empty(matchstr(a:filepath, "_test"))
    let currentFileRoot = split(a:filepath, ".go$")[0]
    let fileToOpen = currentFileRoot . "_test.go"
  else
    let currentFileRoot = split(a:filepath, "_test.go$")[0]
    let fileToOpen = currentFileRoot . ".go"
  endif

  return fileToOpen
endfunction

function! GolangEditCommand(baseCommand)
    if a:baseCommand == "A"
      return "e"
    elseif a:baseCommand == "AS"
      return "sp"
    elseif a:baseCommand == "AV"
      return "vs"
    endif
endfunction

function! GolangAlternateFile(baseCommand)
  let currentFilePath = expand(bufname("%"))
  let fileToOpen = GolangGetAlternateFilename(currentFilePath)

  if filereadable(fileToOpen)
    exec(":" . GolangEditCommand(a:baseCommand). " " . fileToOpen)
  else
    echoerr "couldn't find file " . fileToOpen
  endif
endfunction
