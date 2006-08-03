{-# OPTIONS -fth #-}
-----------------------------------------------------------------------------
-- |
-- Module      :  Type.Binary.TH
-- Copyright   :  (C) 2006 Edward Kmett
-- License     :  BSD-style (see the file libraries/base/LICENSE)
--
-- Maintainer  :  Edward Kmett <ekmett@gmail.com>
-- Stability   :  experimental
-- Portability :  non-portable (Template Haskell)
--
-- Provides a simple way to construct type level binaries.
-- $(binaryE 24) returns an undefined value with the same type as the 
-- Type.Binary with value 24.
-----------------------------------------------------------------------------
module Type.Binary.TH (
	binaryE, binaryT
) where

import Type.Binary
import Language.Haskell.TH

f = conT $ mkName "F"
t = conT $ mkName "T"
o = conT $ mkName "O"
i = conT $ mkName "I"

binaryT :: Integral a => a -> TypeQ
binaryT n = case n of
    0  -> f
    -1 -> t
    n  -> appT (if (n `mod` 2) == 0 then o else i)$ binaryT $ n `div` 2

binaryE :: Integral a => a -> ExpQ
binaryE n = sigE (varE $ mkName "undefined") $ binaryT n