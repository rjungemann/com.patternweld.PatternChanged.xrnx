PatternChanged
--------------

<img align="left" width="64" height="64" src="icon.png" alt="PatternChanged Logo"> PatternChanged is a Renoise plugin which will broadcast over OSC port 8008 (by default) whenever a pattern is changed during playback. This allows another app (such as Max) to be able to respond to these changes.

Messages are broadcast at the route `/renoise/song/sequence` and they have the following parameters:

* Section Name (String)
* Lines Per Beat (Integer)
* Lines Per Pattern (Integer)
* Pattern Number (Integer)

To install, click on the Release tab of this repo and download the `.xrnx` file and double-click it.

From now on, whenever the transport is playing and a pattern is changed, an OSC message will be broadcast.

**NOTE:** You will still want to listen to the MIDI clock as well to ensure that your other application is beat-synced to Renoise.

## TODO

* Add an example Max patch.
* Instructions for changing the default port.
* Release on the Renoise Tools site.
