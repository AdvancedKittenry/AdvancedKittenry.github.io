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

doInclude :: Block -> IO Block
doInclude cb@(CodeBlock (id, classes, namevals) contents) =
  case lookup "execute" namevals of
       Just f     -> return . (CodeBlock (id, classes, namevals)) =<< readProcess f [] contents
       Nothing    -> return cb
doInclude x = return x

main :: IO ()
main = getContents >>= bottomUpM doInclude . readMarkdown def{
                          readerStandalone = True
                        } 
                   >>= putStrLn . writeMarkdown def {
                          writerStandalone = True
                        --, writerExtensions = insert Ext_pandoc_title_block pandocExtensions
                        , writerTemplate = tmpl
                        }
