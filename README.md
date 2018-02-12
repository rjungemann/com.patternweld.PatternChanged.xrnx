PatternChanged
--------------

This is a Renoise plugin which will broadcast over OSC port 8008 (by default) whenever a pattern is changed during playback.

Messages are broadcast at the route `/renoise/song/sequence` and they have the following parameters:

* Section Name (String)
* Lines Per Beat (Integer)
* Lines Per Pattern (Integer)
* Pattern Number (Integer)

To install, click on the Release tab of this repo and download the `.xrnx` file and double-click it.

From now on, whenever the transport is playing and a pattern is changed, an OSC message will be broadcast.
