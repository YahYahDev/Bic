local parse = require("modules.String.Parse")
local str = require("modules.String.Str")
local struct = require("modules.Utils.Struct")


-- Open a file as a string.
local function OpenFileAsString(FilePath)
    local FILE = io.open(FilePath, 'r')
    if FILE == nil then
        FILE:close()
        return nil
    end
    local content = FILE:read('a')
    FILE:close()
    return content
end


-- Strips the comments from 'content'
local function StripComments(content)
    
    -- Strip comments.
    local source = str.Replace(content, "//[^\n]*", "")
    source = str.Replace(source, "/%*.-%*/", "")
    source = str.Replace(source, "^%s*\n", "")
    
    -- Strip white space.
    source = str.Replace(source, "%s*\n%s*", "\n")
    
    -- return source.
    return source
end


-- Get list of types.
local function GetTypes(source)
    
    local lines = parse.GetLines(source)
    
    local types = {}
    
    for i = 0, #lines do
    
        if lines[i] ~= nil and str.Find(lines[i], "typedef struct") ~= nil then
            
            types[#types +1] = parse.GetBlock(lines[i], "typedef struct ", "[{;]")
            types[#types] = str.Replace(types[#types], " .*", "")
        end
        
    end
    return types
end



local Source = StripComments(OpenFileAsString('raylib.h'))


str.PrintArray(GetTypes(Source))  







