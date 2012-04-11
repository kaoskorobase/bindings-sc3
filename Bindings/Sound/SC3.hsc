#include <bindings.dsl.h>
#include <SC_WorldOptions.h>

module Bindings.Sound.SC3 where

#strict_import

-- | Synthesis engine handle.
#opaque_t World

-- | Synthesis engine options.
#starttype struct WorldOptions
	#field mPassword                         , CString
	#field mNumBuffers                       , CUInt
	#field mMaxLogins                        , CUInt
	#field mMaxNodes                         , CUInt
	#field mMaxGraphDefs                     , CUInt
	#field mMaxWireBufs                      , CUInt
	#field mNumAudioBusChannels              , CUInt
	#field mNumInputBusChannels              , CUInt
	#field mNumOutputBusChannels             , CUInt
	#field mNumControlBusChannels            , CUInt
	#field mBufLength                        , CUInt
	#field mRealTimeMemorySize               , CUInt
	#field mNumSharedControls                , CInt
	#field mSharedControls                   , Ptr CFloat
	#field mRealTime                         , CInt
	#field mMemoryLocking                    , CInt
	#field mNonRealTimeCmdFilename           , CString
	#field mNonRealTimeInputFilename         , CString
	#field mNonRealTimeOutputFilename        , CString
	#field mNonRealTimeOutputHeaderFormat    , CString
	#field mNonRealTimeOutputSampleFormat    , CString
	#field mPreferredSampleRate              , CUInt
	#field mNumRGens                         , CUInt
	#field mPreferredHardwareBufferFrameSize , CUInt
	#field mLoadGraphDefs                    , CUInt
	#field mInputStreamsEnabled              , CString
	#field mOutputStreamsEnabled             , CString
	#field mInDeviceName                     , CString
	#field mVerbosity                        , CInt
	#field mRendezvous                       , CInt
	#field mUGensPluginPath                  , CString
	#field mOutDeviceName                    , CString
	#field mRestrictedPath                   , CString
	#field mSharedMemoryID                   , CInt
#stoptype

-- | Default synthesis engine options.
#cinline kDefaultWorldOptions , IO (Ptr <struct WorldOptions>)

-- | Reply address.
#opaque_t struct ReplyAddress

-- | Access the callback data pointer in a reply address.
#ccall ReplyAddress_ReplyData , Ptr <ReplyAddress> -> IO (Ptr ())

-- | Reply function callback.
--
-- Arguments:
--
-- * 'Ptr' 'C'ReplyAddress' - Reply address handle
--
-- * 'Ptr' 'CChar' - OSC packet data
--
-- * 'CInt' - OSC packet size in bytes
#callback ReplyFunc , Ptr <ReplyAddress> -> Ptr CChar -> CInt -> IO ()

-- | Create a new synthesis engine.
#ccall World_New , Ptr <WorldOptions> -> IO (Ptr <World>)

-- | Free the synthesis engine.
--
-- This function should only be called after 'c'World_WaitForQuit' has returned.
#ccall World_Cleanup , Ptr <World> -> IO ()

-- | Perform non-realtime synthesis with the given 'C'WorldOptions'.
#ccall World_NonRealTimeSynthesis   , Ptr <World> -> Ptr <WorldOptions> -> IO ()

-- | Open a UDP input port for receiving OSC commands.
--
-- Returns non-zero if the call was successful.
#ccall World_OpenUDP , Ptr <World> -> CInt -> IO CInt

-- | Open a TCP input port for receiving OSC commands.
--
-- Returns non-zero if the call was successful.
#ccall World_OpenTCP , Ptr <World> -> CInt -> CInt -> CInt -> IO CInt

-- | Wait for the synthesis engine to quit.
--
-- In order to stop the synthesis engine, send a \"/quit\" OSC message with
-- 'c'World_SendPacket', 'c'World_SendPacketWithContext' or through an open
-- network port.
#ccall World_WaitForQuit , Ptr <World> -> IO ()

-- | Send an OSC packet to the synthesis engine.
--
-- Returns 'True' if the packet was sent successfully.
--
-- Arguments:
--
-- * 'CInt' - OSC packet size in bytes
--
-- * 'Ptr' 'CChar' - OSC packet data
--
-- * 'C'ReplyFunc' - Reply function callback.
#ccall World_SendPacket             , Ptr <World> -> CInt -> Ptr CChar -> <ReplyFunc> -> IO Bool

-- | Send an OSC packet to the synthesis engine with callback data.
--
-- Returns 'True' if the packet was sent successfully.
--
-- Arguments:
--
-- * 'CInt' - OSC packet size in bytes
--
-- * 'Ptr' 'CChar' - OSC packet data
--
-- * 'C'ReplyFunc' - Reply function callback.
--
-- * 'Ptr' () - Reply function callback data.
#ccall World_SendPacketWithContext  , Ptr <World> -> CInt -> Ptr CChar -> <ReplyFunc> -> Ptr () -> IO Bool

-- | Haskell print function.
#callback HaskellPrintFunc , Ptr CChar -> IO ()

-- | Set the global Haskell print function.
--
-- This function, when set, is called by the synthesis engine to print
-- character strings to an appropriate output channel.
#ccall SetHaskellPrintFunc , <HaskellPrintFunc> -> IO ()
