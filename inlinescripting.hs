-- includes.hs
import Text.Pandoc
import Text.Pandoc.Options
import System.Process
--import Data.Set
import GHC.IOBase ( ioException, IOException(..), IOErrorType(..) )
import qualified Control.Exception as C
import System.IO
import System.IO.Error
import System.Exit  ( ExitCode(..) )
import Control.Concurrent
import Control.Monad

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
                        , writerTemplate = tmpl
                        }

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
