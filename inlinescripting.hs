-- includes.hs
import Text.Pandoc
import Text.Pandoc.Options
import System.Process
import Data.Set

tmpl = unlines [
  "$if(titleblock)$$titleblock$",
  "$endif$$for(header-includes)$$header-includes$",
  "$endfor$$for(include-before)$$include-before$",
  "$endfor$$if(toc)$$toc$",
  "$endif$$body$$for(include-after)$",
  "$include-after$$endfor$"
  ]

doInclude :: [Block] -> IO [Block]
doInclude (cb@(CodeBlock (id, classes, namevals) contents):xs) =
  do rst <- doInclude xs
     case lookup "execute" namevals of
          Just f -> 
            do txt <- readProcess f [] contents
               case lookup "type" namevals of
                    Just "plainText" -> 
                      return (makePlain txt : rst)
                    Just "block" -> 
                      return (makeBlock txt : rst)
                    Nothing -> 
                      return ((blocks $ readMarkdown def txt) ++ rst)
               where makePlain = Plain . (\d -> [d]) . (Str)
                     makeBlock = CodeBlock attrs 
                     attrs = (id, classes, n)
                        where n = Prelude.filter notExecute namevals
                              notExecute (a,b) = a /= "execute"
                     blocks p@(Pandoc _ b) = b
          Nothing -> return (cb : rst)
doInclude (x:xs) =do rst <- doInclude xs
                     return (x:rst)
doInclude [] = return []

main :: IO ()
main = getContents >>= bottomUpM doInclude . readMarkdown def{
                          readerStandalone = True
                        } 
                   >>= putStrLn . writeMarkdown def {
                          writerStandalone = True
                        --, writerExtensions = insert Ext_pandoc_title_block pandocExtensions
                        , writerTemplate = tmpl
                        }
