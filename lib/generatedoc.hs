-- includes.hs
import Text.Pandoc
import Text.Pandoc.Options
import Text.Pandoc.Shared ( err )
import Text.Highlighting.Kate ( languages, Style, tango, pygments,
         espresso, zenburn, kate, haddock, monochrome )
import System.Process
--import Data.Set
import Data.Char ( isAlphaNum)
import GHC.IOBase ( ioException, IOException(..), IOErrorType(..) )
import qualified Control.Exception as C
import System.IO
import System.IO.Error
import System.Environment ( getArgs )
import System.Exit  ( ExitCode(..) )
import Control.Concurrent
import Control.Monad
import qualified Text.Pandoc.UTF8 as UTF8

blockLikeTags = ["sidebyside", "expandable", "collapsible", "tabs", "tab", "column"]

main :: IO ()
main = do
         args <- liftM (map UTF8.decodeArg) getArgs
         unless (length args == 1) $ err 2 "Usage: generatedoc navigationfile"

         let navFile = head args
         nav <- UTF8.readFile navFile

         src <- getContents
         let odoc@(Pandoc docmeta blocks) = readMarkdown def{
                          readerStandalone = True
                        , readerSmart = True
                        } src
         doc <- bottomUpM doInclude $ Pandoc docmeta $ sanitizeBlockTags blockLikeTags blocks
         tmpl <- UTF8.readFile "lib/template.html5"

         putStrLn $ writeHtmlString def {
                       writerStandalone  = True
                     , writerVariables  = [("navigation", nav)]
                     , writerTemplate    = tmpl
                     , writerSectionDivs = True
                     , writerHtml5       = True
                     , writerHighlight        = True
                     , writerHighlightStyle   = pygments
                    } doc

data RecursiveBlock = NormalBlock Block
                    | HTMLBlock Block Block [RecursiveBlock]
                    | Root [RecursiveBlock]

sanitizeBlockTags :: [String] -> [Block] -> [Block]
sanitizeBlockTags tags = fixHack.flatten.(Root).buildHTMLblocks.(filter isNotEmptyPara).(separateTags tags)

fixHack :: [Block] -> [Block]
fixHack = bottomUp f
  where f (RawBlock _ s) = RawBlock (Format "html") s
        f b = b


flatten :: RecursiveBlock -> [Block]
flatten (NormalBlock b) = [b]
flatten (HTMLBlock tag endtag bs) = tag : contents ++ [endtag]
  where contents = concatMap flatten bs
flatten (Root bs) = map f bs
  where f (NormalBlock b) = b
        f h@(HTMLBlock _ _ _) = Div ("",[],[]) $ flatten h

buildHTMLblocks :: [Block] -> [RecursiveBlock]
buildHTMLblocks [] = []
buildHTMLblocks (t@(RawBlock (Format "Hack") _):bs) = 
  let (html, rest) = eatUntil t bs
  in html: (buildHTMLblocks rest)
buildHTMLblocks (b:bs) = (NormalBlock b) : buildHTMLblocks bs

eatUntil :: Block -> [Block] -> (RecursiveBlock, [Block])
eatUntil t@(RawBlock (Format "Hack") html) bs = 
  seekEnd bs
  where tagname = maybe "" id $ tagFromStr html
        isRightTag = (==tagname).(maybe "" id).tagFromBlock
        errStr = "Invalid HTML: expected </"++tagname++"> to close "++html++(show bs)

        --seeks to find the contents, the endtag and the rest
        seekEnd :: [Block] -> (RecursiveBlock, [Block])
        seekEnd [] = error $ "EOF reached! "++errStr
        seekEnd (b:bs) = if isHTMLTag b
          then 
            case (isEndTag b, isRightTag b) of
              (True, True) -> ((HTMLBlock t b []), bs)
              (False, _) -> 
                 let (subblock, bs') = eatUntil b bs
                     ((HTMLBlock t e cont), rest) = seekEnd bs' 
                 in ((HTMLBlock t e $ subblock: cont), rest)
              _ -> error errStr
          else let ((HTMLBlock t e cont), rest) = seekEnd bs
               in ((HTMLBlock t e $ (NormalBlock b) : cont), rest)



separateTags :: [String] -> [Block] -> [Block]
separateTags tags blks = concatMap (separateTagsFromParas tags) blks

separateTagsFromParas :: [String] -> Block -> [Block]
separateTagsFromParas ts (Para []) = []
separateTagsFromParas ts (Para is) = 
  let isRightTag e = case tagFromInline e of
                            Just t -> t `elem` ts
                            _ -> False
      (firstpara, nextparas) = break isRightTag is
      rest = if nextparas == []
                then []
                else let ((RawInline f s) : rst) = nextparas 
                     in (RawBlock (Format "Hack") s) : separateTagsFromParas ts (Para rst)
      
  in if firstpara == [] then rest else (Para firstpara) : rest 
separateTagsFromParas _ b = [b]

tagFromStr ('<' : x : rs) = Just $ takeWhile isAlphaNum t
  where t = if x == '/' then rs else x : rs
tagFromStr _ = Nothing

isEndTag :: Block -> Bool
isEndTag (RawBlock (Format "Hack") s) = (s !! 1) == '/'
isEndTag _ = False

isHTMLTag :: Block -> Bool
isHTMLTag (RawBlock (Format "Hack") s) = True
isHTMLTag _ = False

tagFromBlock :: Block -> Maybe String
tagFromBlock (RawBlock (Format "Hack") s) = tagFromStr s
tagFromBlock _ = Nothing

tagFromInline :: Inline -> Maybe String
tagFromInline (RawInline (Format "html") s) = tagFromStr s
tagFromInline _ = Nothing

isNotEmptyPara :: Block -> Bool
isNotEmptyPara (Para is) = (filter (/= Space) is) /= []
isNotEmptyPara _ = True

doInclude :: [Block] -> IO [Block]
doInclude (cb@(CodeBlock (id, classes, namevals) contents):xs) =
  do rst <- doInclude xs
     case lookup "execute" namevals of
          Just f -> 
            do txt <- Main.readProcess f contents
               case lookup "type" namevals of
                    Just "plain" -> 
                      return (makePlain txt : rst)
                    Just "plainText" -> 
                      return (makePlain txt : rst)
                    Just "block" -> 
                      return (makeBlock txt : rst)
                    Just "code" -> 
                      return (makeBlock txt : rst)
                    _ -> 
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


readProcess 
    :: String                   -- ^ command to run
    -> String                   -- ^ standard input
    -> IO String                -- ^ stdout + stderr
readProcess cmd input = do
    (Just inh, Just outh, _, pid) <-
        createProcess (shell cmd){ std_in  = CreatePipe,
                                   std_out = CreatePipe,
                                   std_err = Inherit }

    -- fork off a thread to start consuming the output
    output  <- hGetContents outh
    outMVar <- newEmptyMVar
    forkIO $ C.evaluate (length output) >> putMVar outMVar ()

    -- now write and flush any input
    when (not (null input)) $ do hPutStr inh input; hFlush inh
    hClose inh -- done with stdin

    -- wait on the output
    takeMVar outMVar
    hClose outh

    -- wait on the process
    ex <- waitForProcess pid

    case ex of
     ExitSuccess   -> return output
     ExitFailure r -> 
      ioError (mkIOError OtherError ("readProcess: " ++ cmd ++ 
                                     " (exit " ++ show r ++ ")")
                                 Nothing Nothing)
