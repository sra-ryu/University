{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_swtpp_casino (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/mager/Documents/Lehre/SWTPP/WS24/Tutorien/blatt05/mittag/swtpp-casino/.stack-work/install/x86_64-linux/614f177adf8146165ca3cac071db21132aaf92f557a3bf000277980af235d7c9/9.0.2/bin"
libdir     = "/home/mager/Documents/Lehre/SWTPP/WS24/Tutorien/blatt05/mittag/swtpp-casino/.stack-work/install/x86_64-linux/614f177adf8146165ca3cac071db21132aaf92f557a3bf000277980af235d7c9/9.0.2/lib/x86_64-linux-ghc-9.0.2/swtpp-casino-0.1.0.0-7bS9BQ5EWlu2qbBJngkf0d-swtpp-casino-test"
dynlibdir  = "/home/mager/Documents/Lehre/SWTPP/WS24/Tutorien/blatt05/mittag/swtpp-casino/.stack-work/install/x86_64-linux/614f177adf8146165ca3cac071db21132aaf92f557a3bf000277980af235d7c9/9.0.2/lib/x86_64-linux-ghc-9.0.2"
datadir    = "/home/mager/Documents/Lehre/SWTPP/WS24/Tutorien/blatt05/mittag/swtpp-casino/.stack-work/install/x86_64-linux/614f177adf8146165ca3cac071db21132aaf92f557a3bf000277980af235d7c9/9.0.2/share/x86_64-linux-ghc-9.0.2/swtpp-casino-0.1.0.0"
libexecdir = "/home/mager/Documents/Lehre/SWTPP/WS24/Tutorien/blatt05/mittag/swtpp-casino/.stack-work/install/x86_64-linux/614f177adf8146165ca3cac071db21132aaf92f557a3bf000277980af235d7c9/9.0.2/libexec/x86_64-linux-ghc-9.0.2/swtpp-casino-0.1.0.0"
sysconfdir = "/home/mager/Documents/Lehre/SWTPP/WS24/Tutorien/blatt05/mittag/swtpp-casino/.stack-work/install/x86_64-linux/614f177adf8146165ca3cac071db21132aaf92f557a3bf000277980af235d7c9/9.0.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "swtpp_casino_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "swtpp_casino_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "swtpp_casino_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "swtpp_casino_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "swtpp_casino_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "swtpp_casino_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
