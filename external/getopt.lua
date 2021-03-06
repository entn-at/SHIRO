-- modified from http://lua-users.org/wiki/AlternativeGetOpt

function getopt( arg, options )
  local tab = {_ = {}}
  local skipnext = false
  for k, v in ipairs(arg) do
    if string.sub( v, 1, 2) == "--" then
      local x = string.find( v, "=", 1, true )
      if x then tab[ string.sub( v, 3, x-1 ) ] = string.sub( v, x+1 )
      else      tab[ string.sub( v, 3 ) ] = true
      end
    elseif string.sub( v, 1, 1 ) == "-" then
      local y = 2
      local l = string.len(v)
      local jopt
      while ( y <= l ) do
        jopt = string.sub( v, y, y )
        if string.find( options, jopt, 1, true ) then
          if y < l then
            tab[ jopt ] = string.sub( v, y+1 )
            y = l
          else
            tab[ jopt ] = arg[ k + 1 ]
            skipnext = true
          end
        else
          tab[ jopt ] = true
        end
        y = y + 1
      end
    else
      if skipnext then
        skipnext = false
      else
        tab._[ #tab._ + 1 ] = v
      end
    end
  end
  return tab
end

return getopt
