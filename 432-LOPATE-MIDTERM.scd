/*

 ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄        ▄
▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░▌      ▐░▌
▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀▀▀ ▐░▌░▌     ▐░▌
▐░▌          ▐░▌       ▐░▌▐░▌          ▐░▌          ▐░▌▐░▌    ▐░▌
▐░▌ ▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄▄▄ ▐░▌ ▐░▌   ▐░▌
▐░▌▐░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌  ▐░▌  ▐░▌
▐░▌ ▀▀▀▀▀▀█░▌▐░█▀▀▀▀█░█▀▀ ▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀▀▀ ▐░▌   ▐░▌ ▐░▌
▐░▌       ▐░▌▐░▌     ▐░▌  ▐░▌          ▐░▌          ▐░▌    ▐░▌▐░▌
▐░█▄▄▄▄▄▄▄█░▌▐░▌      ▐░▌ ▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄▄▄ ▐░▌     ▐░▐░▌
▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌      ▐░░▌
 ▀▀▀▀▀▀▀▀▀▀▀  ▀         ▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀        ▀▀  *ish*


CPSC 432/532 Midterm Project Description 2019

General Description: You will pick a song from Hiroshi Yoshimura's album 'Green' and use it as a model and guide for your own piece. Your piece may be original (your own notes/chords, etc), or may be a "cover": exactly the same notes and kinds of sampled ambient sounds.

The album may be found in full here: https://www.youtube.com/watch?v=D7aYjRl_6Zw&t=772s

The following criteria must be adhered to:

1) Your piece should have the same
   -number of type of musical parts (synth lead, bass, etc.)
   -number and type of sound samples (rain, forest sounds, etc)
   -number and type of FX (reverb, phasing, delays, etc)
   -Spatial features (panning)
   -Be the same length (within 10 or so seconds)

2) You must use the Pattern classes for organization and generation of synth events.

3) You may use whatever synthesis methods we have covered that get the results you want/need

4) You may organize your musical data however you wish, but you must take advantage of language features when it comes to formal structures and repetition. By this I mean you should organize your note data in the smallest meaningful arrays and reuse these arrays to account for repetition, changing only those parameters required of the musical process (as defined by the Yoshimura tune itself). This as opposed to multiple pitch arrays (for example) that are the same, or long, hard-coded arrays representing entire instrumental parts.

You can find nature samples on the internet. Use a quick google search to find places like FreeSound.org: https://freesound.org/  *Use only good-sounding .wav audio samples -- no lossy mp3s, nothing that sounds jank.

You will have to master a few technical effects as well including fade-ins and fade-outs, use of sample-playing synths with the Pattern classes, and the all-important Pmono for changing a continuously running Synth with a Pattern.

Key classes will be Pseq, Pbind, Pmono, Pfx, Ppar, Ptpar

There are two pattern tutorials in the IDE documentation. **Read through both.** You will not be able to complete this assignment without doing so. Here are the web links, but they exist locally.

1) http://doc.sccode.org/Tutorials/Streams-Patterns-Events1.html
2) http://doc.sccode.org/Tutorials/A-Practical-Guide/PG_01_Introduction.html

Beyond meeting the minimum criteria outlined above you will be judged on:

-stylistic match to your model: does your piece live in the same stylistic world (1980s Japanese Minimal Ambient Electronic)

-sonic match to your model: do the instruments and samples in your piece sound the same as the model

-formal match to your model: does your piece have the same meta structure as your model -- number of sections, parts, lengths, etc.

As always you must write two blog posts, one (1) by the end of break detailing your progress with in-progress notes, ideas, CODE EXAMPLES, etc, and one (2) by the due date detailing your finished product with mp3 upload and embed, etc.

Specific questions regarding this assignment should be posted to an appropriately-named Discussion on Canvas. */

s.boot;
s.quit;
s.options.memSize = 81920;

// Impulse Responses
(
~buff = Buffer.read(s, "Hall 3.wav".resolveRelative);
~buff2 = Buffer.read(s, "Room 2.wav".resolveRelative);
~birdbuff = Buffer.read(s, "Bird2.wav".resolveRelative);
~waterbuff = Buffer.read(s, "Water.wav".resolveRelative);
)

// Prepare PartConv
(
~buffsize = PartConv.calcBufSize(2048, ~buff);
~irSpectrum = Buffer.alloc(s, ~buffsize, 2);
~irSpectrum.preparePartConv(~buff, 2048);

~buffsize2 = PartConv.calcBufSize(2048, ~buff2);
~irSpectrum2 = Buffer.alloc(s, ~buffsize2, 2);
~irSpectrum2.preparePartConv(~buff2, 2048);

~buffsize3 = PartConv.calcBufSize(2048, ~buff);
~irSpectrum3 = Buffer.alloc(s, ~buffsize3, 2);
~irSpectrum3.preparePartConv(~buff, 2048);
)

(
SynthDef (\mallet, {|freq=200, amp=1, pan=0, out=0|
	var sig, temp, dec, sig1, sig2, sig3, sig4, env1, env2, env3, verb;
	dec = 140 / freq;
	env1 = Env.perc(0.01, dec, 0.1, -4).kr();
	env2 = Env.perc(0.01, dec * 0.55, 0.1, -10).kr();
	env3 = Env.perc(0.01, dec * 0.33, 0.1, -10).kr();
	sig1 = SinOsc.ar(freq) * env1;
	sig2 = SinOsc.ar(freq * 3) * env2;
	sig3 = SinOsc.ar(freq * 4.47) * env3;
	sig4 = SinOsc.ar(freq * 4.5) * env3 * 0.3;
	sig = Mix([sig1, sig2, sig3, sig4]);
	sig = BLowPass4.ar(sig, 1000, 1);
	sig = Pan2.ar(sig * amp, pan);
/*	verb = PartConv.ar(sig, 2048, ~irSpectrum2, 0.025);
	sig = sig + verb;*/
	sig = FreeVerb.ar(sig, 0.25, 0.7);
	Out.ar(out, sig) * Env.perc(0.01, dec + 1, 0.1, -4).kr(doneAction: 2);
}).add;
)

~malletTest = Synth(\mallet, [\freq, 130, \amp, 1, \pan, 0, \out, 0]);


(
SynthDef (\glass, {|freq, amp, pan, out|
	var durArray, sig, env, harms, harmAmp;
	durArray = [0.2, 0.1, 0.06, 0.05, 0.05, 0.05, 0.04, 0.03, 0.02];
	env = Array.fill(9, {arg i; Env.perc(0.01, durArray[i], 0.025, -4).kr()});
	harms = [1, 1.5, 2, 3, 4, 5, 6, 7, 8];
	harmAmp = [1, 0.4, 0.3, 0.2, 0.4, 0.1, 0.1, 0.1];
	sig = harms * freq;
	sig = SinOsc.ar(sig) * env * harmAmp;
	sig = Mix(sig);
	sig = RHPF.ar(sig * amp, 6000, 0.1);
	sig = Pan2.ar(sig, pan);
	sig = FreeVerb.ar(sig, 0.3, 0.2);
	Out.ar(out, sig) * Env.perc(0.01, 0.3).kr(doneAction: 2);
}).add;
)

~glassTest = Synth(\glass, [\freq, 7000, \amp, 1, \pan, 0, \out, 0]);

(
SynthDef (\flute, {|freq, amp, dur, pan, out|
	var sig, env, noise, verb, noiseEnv, filterEnv;
	env = Env([0, 1, 0.55, 0.55, 0], [1, 1.2, dur - 1.2, 1]).kr();
	noiseEnv = Env([0, 0.53, 0.55, 0.45, 0], [0.4, 1.2, dur - 1.2, 0.1]).kr();
	filterEnv = Env([0, 0.6, 0.3, 0.3, 0], [0.1, 3, dur - 3, 1]).kr();
	amp = amp * LinLin.kr(SinOsc.kr(2), -1, 1, 0.7, 1);
	noise = BrownNoise.ar(0.02) * noiseEnv;
	noise = BLowPass.ar(noise, 4000, 1, 0.45);
	sig = Saw.ar(freq) * env;
	sig = BLowPass4.ar(sig, 2000 * filterEnv, 1, 0.3);
	sig = BHiPass4.ar(sig, 300, 0.1);
	sig = Mix([sig, noise]);
	sig = Pan2.ar(sig * amp, pan, 0.6);
	verb = PartConv.ar(sig, 2048, ~irSpectrum, 0.2);
	sig = sig + verb;
	sig = FreeVerb.ar(sig, 0.3, 0.3);
	Out.ar(out, sig) * Env.linen(1, dur + 2, 1, 0.5, \sin).kr(doneAction: 2);
}).add;
)

~fluteTest = Synth(\flute, [\freq, 450, \amp, 1, \dur, 3, \pan, 0, \out, 0]);

(
SynthDef (\pad, {|freq, amp, dur, pan, out|
	var sig, sig1, sig2, sig3, phaser, env, noise, noise2, noiseEnv, filterEnv, filterLFO, buff, verb;
	env = Env([0, 1, 1, 1, 0], [0.6, 0.5, dur, 4], \sin).kr();
	noiseEnv = Env([0, 1, 1, 1, 0], [0.6, 0.5, dur, 4], \sin).kr();
	filterEnv = Env([0, 1, 1, 0.1], [1, dur, 4], \sin).kr();
	filterLFO = SinOsc.ar(0.25, 0, 100);
	sig1 = Pan2.ar(Saw.ar((freq - 2) + SinOsc.kr(5, mul: 3), 0.4), -1) * env;
	sig2 = Pan2.ar(Saw.ar((freq + 2) + SinOsc.kr(5, mul: 3), 0.4), 1) * env;
	sig3 = Saw.ar((freq * 2) + SinOsc.kr(5, mul: 3), 0.4) * env;
	sig = Mix([sig1, sig2, sig3]);
	sig = RLPF.ar(sig, 1000, 1, 0.6);
	noise = Pan2.ar(PinkNoise.ar(0.4) * noiseEnv, -1);
	noise2 = Pan2.ar(DelayL.ar(PinkNoise.ar(0.4) * noiseEnv, 0.3, 0.2), 1);
	noise = Mix([noise, noise2]);
	noise = RLPF.ar(noise, 4000, 1);
	noise = RHPF.ar(noise, 250, 1);
	sig = Mix([sig, noise]);
	sig = RLPF.ar(sig, (700 + filterLFO) * filterEnv, 0.4, 0.1);
	phaser = Mix(Array.fill(4, {AllpassC.ar(sig, 1, SinOsc.ar(0.3, 0, 0.005, 0.0051), 0, 0.8)}));
	sig = sig + phaser;
	verb = PartConv.ar(sig, 2048, ~irSpectrum, 0.5);
	sig = sig + verb;
	sig = FreeVerb.ar(sig, 0.9, 0.9);
	sig = Pan2.ar(sig, pan, 0.3);
	Out.ar(out, sig * amp) * Env([0, 1, 1, 1, 0], [0.6, 0.5, dur + 3, 4], \sin).kr(doneAction: 2);
}).add;
)

~pad2Test = Synth(\pad2, [\freq, 280, \amp, 1, \dur, 2, \pan, -1, \out, 0]);

(
SynthDef (\sampler, {|bufID, start, attack, release, dur, amp, pan, out|
	var sig, env;
	env = Env([0, 1, 1, 0], [attack, dur, release], \sin).kr();
	sig = Pan2.ar(PlayBuf.ar(2, bufID, 1, 0, 0, 0, 2) * amp * env, pan);
	Out.ar(out, sig) * Env([0, 1, 1, 0], [attack, dur, release]).kr();
}).add;
)

~birdstest = Synth(\sampler, [\bufID, ~birdbuff, \amp, 1, \pan, 0, \out, 0]);

(
TempoClock.default.tempo = 0.8;

~marim1 = Pbind(
	\instrument, \mallet,
	\midinote, Pseq([48, 63, 62, 55, 70, 77, 70, 58], 4),
	\dur, 0.125,
	\amp, 1,
	\pan, Pseq([-1, 1, 0.8, -0.8, 0.6, 0.4, -0.6, -0.4], 4),
	\out, 0
);

~marim2 = Pbind(
	\instrument, \mallet,
	\midinote, Pseq([56, 63, 62, 58, 70, 77, 70, 58], 4),
	\dur, 0.125,
	\amp, 1,
	\pan, Pseq([-1, 1, 0.8, -0.8, 0.6, 0.4, -0.6, -0.4], 4),
	\out, 0
);

~marim3 = Pbind(
	\instrument, \mallet,
	\midinote, Pseq([56, 63, 62, 58, 75, 82, 75, 70], 4),
	\dur, 0.125,
	\amp, 1,
	\pan, Pseq([-1, 1, 0.8, -0.8, 0.6, 0.4, -0.6, -0.4], 4),
	\out, 0
);

~marim4 = Pbind(
	\instrument, \mallet,
	\midinote, Pseq([49, 64, 63, 56, 71, 78, 71, 59], 4),
	\dur, 0.125,
	\amp, 1,
	\pan, Pseq([-1, 1, 0.8, -0.8, 0.6, 0.4, -0.6, -0.4], 4),
	\out, 0
);

~marim5 = Pbind(
	\instrument, \mallet,
	\midinote, Pseq([51, 66, 65, 58, 73, 80, 73, 61], 4),
	\dur, 0.125,
	\amp, 1,
	\pan, Pseq([-1, 1, 0.8, -0.8, 0.6, 0.4, -0.6, -0.4], 4),
	\out, 0
);

~marim6 = Pbind(
	\instrument, \mallet,
	\midinote, Pseq([54, 61, 60, 56, 70, 73, 72, 80], 4),
	\dur, 0.125,
	\amp, 1,
	\pan, Pseq([-1, 1, 0.8, -0.8, 0.6, 0.4, -0.6, -0.4], 4),
	\out, 0
);

~marim7 = Pbind(
	\instrument, \mallet,
	\midinote, Pseq([56, 63, 62, 58, 72, 75, 74, 82], 4),
	\dur, 0.125,
	\amp, 1,
	\pan, Pseq([-1, 1, 0.8, -0.8, 0.6, 0.4, -0.6, -0.4], 4),
	\out, 0
);

~marim8 = Pbind(
	\instrument, \mallet,
	\midinote, Pseq([56, 71, 70, 63, 78, 85, 78, 66], 4),
	\dur, 0.125,
	\amp, 1,
	\pan, Pseq([-1, 1, 0.8, -0.8, 0.6, 0.4, -0.6, -0.4], 4),
	\out, 0
);

~marim9 = Pbind(
	\instrument, \mallet,
	\midinote, Pseq([Pseq([48, 63, 62, 55, 70, 77, 70, 58], 4), Rest(2)], 1),
	\dur, Pseq([Pseq([0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125], 4), 2], 1),
	\amp, 1,
	\pan, Pseq([Pseq([-1, 1, 0.8, -0.8, 0.6, 0.4, -0.6, -0.4], 4), 0]),
	\out, 0
);

~marim10 = Pbind(
	\instrument, \mallet,
	\midinote, Pseq([Pseq([55, 70, 69, 62, 70, 77, 70, 62], 4), Rest(2)], 1),
	\dur, Pseq([Pseq([0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125], 4), 2], 1),
	\amp, 1,
	\pan, Pseq([Pseq([-1, 1, 0.8, -0.8, 0.6, 0.4, -0.6, -0.4], 4), 0]),
	\out, 0
);

~marim11 = Pbind(
	\instrument, \mallet,
	\midinote, Pseq([44, 59, 58, 51, 66, 73, 66, 54], 4),
	\dur, 0.125,
	\amp, 1,
	\pan, Pseq([-1, 1, 0.8, -0.8, 0.6, 0.4, -0.6, -0.4], 4),
	\out, 0
);

~marim12 = Pbind(
	\instrument, \mallet,
	\midinote, Pseq([52, 59, 58, 54, 66, 73, 66, 54], 4),
	\dur, 0.125,
	\amp, 1,
	\pan, Pseq([-1, 1, 0.8, -0.8, 0.6, 0.4, -0.6, -0.4], 4),
	\out, 0
);

~marim13 = Pbind(
	\instrument, \mallet,
	\midinote, Pseq([52, 59, 58, 54, 66, 73, 66, 54], 4),
	\dur, 0.125,
	\amp, 1,
	\pan, Pseq([-1, 1, 0.8, -0.8, 0.6, 0.4, -0.6, -0.4], 4),
	\out, 0
);

~marim14 = Pbind(
	\instrument, \mallet,
	\midinote, Pseq([45, 60, 59, 52, 67, 74, 67, 55], 4),
	\dur, 0.125,
	\amp, 1,
	\pan, Pseq([-1, 1, 0.8, -0.8, 0.6, 0.4, -0.6, -0.4], 4),
	\out, 0
);

~glass1 = Pbind(
	\instrument, \glass,
	\midinote, Pseq([120], 32),
	\dur, 0.125,
	\amp, 0.15,
	\pan, Pseq([0, 0.125, 0.25, 0.375, 0.5, 0.675, 0.75, 0.875, 1, 0.875, 0.75, 0.675, 0.5, 0.375, 0.25, 0.125, 0, -0.125, -0.25, -0.375, -0.5, -0.675, -0.75, -0.875, -1, -0.875, -0.75, -0.675, -0.5, -0.375, -0.25, -0.125], 1),
	\out, 0
);

~glass2 = Pbind(
	\instrument, \glass,
	\midinote, Pseq([120], 64),
	\dur, 0.125,
	\amp, Pseq((Array.fill(64, {arg i; i / 640}) ), 1),
	\pan, 0,
	\out, 0
);

~pad1 = Pbind(
	\instrument, \pad,
	\midinote, Pseq([60]),
	\dur, Pseq([16]),
	\amp, 0.2,
	\pan, 0,
	\out, 0
);

~pad2 = Pbind(
	\instrument, \pad,
	\midinote, Pseq([61]),
	\dur, 8,
	\amp, 0.2,
	\pan, 0,
	\out, 0
);

~pad3 = Pbind(
	\instrument, \pad,
	\midinote, Pseq([63, 66]),
	\dur, Pseq([4, 4]),
	\amp, 0.2,
	\pan, 0,
	\out, 0
);

~pad4 = Pbind(
	\instrument, \pad,
	\midinote, Pseq([58, 62]),
	\dur, Pseq([4, 4]),
	\amp, 0.2,
	\pan, 0,
	\out, 0
);

~pad5 = Pbind(
	\instrument, \pad,
	\midinote, Pseq([63, 58]),
	\dur, Pseq([16, 8]),
	\amp, Pseq([0.25, 0.4]),
	\pan, 0,
	\out, 0
);

~pad6 = Pbind(
	\instrument, \pad,
	\midinote, Pseq([30, Rest(), 51]),
	\dur, Pseq([8, 1, 7]),
	\amp, Pseq([0.2, 0, 0.2]),
	\pan, 0,
	\out, 0
);

~pad7 = Pbind(
	\instrument, \pad,
	\midinote, Pseq([44]),
	\dur, Pseq([6]),
	\amp, Pseq([0.2]),
	\pan, 0,
	\out, 0
);

~pad8 = Pbind(
	\instrument, \pad,
	\midinote, Pseq([56]),
	\dur, Pseq([8]),
	\amp, Pseq([0.3]),
	\pan, 0,
	\out, 0
);

~pad9 = Pbind(
	\instrument, \pad,
	\midinote, Pseq([64]),
	\dur, Pseq([22]),
	\amp, Pseq([0.3]),
	\pan, 0,
	\out, 0
);

~flute1 = Pbind(
	\instrument, \flute,
	\midinote, Pseq([70]),
	\dur, Pseq([4]),
	\amp, 0.6,
	\pan, Pxrand([-1, -0.75, -0.5, -0.25, 0.25, 0.5, 0.75, 1], 1),
	\out, 0
);

~flute2 = Pbind(
	\instrument, \flute,
	\midinote, Pseq([72, 74, 75, 77, 79]),
	\dur, Pseq([4, 4, 3, 3.5, 7.5]),
	\amp, 0.75,
	\pan, Pxrand([-1, -0.75, -0.5, -0.25, 0.25, 0.5, 0.75, 1], 5),
	\out, 0
);

~flute3 = Pbind(
	\instrument, \flute,
	\midinote, Pseq([70, 72, 68, 72]),
	\dur, Pseq([6, 1, 5, 2]),
	\amp, Pseq([0.7, 0.9, 0.9, 1]),
	\pan, Pxrand([-1, -0.75, -0.5, -0.25, 0.25, 0.5, 0.75, 1], 4),
	\out, 0
);

~flute4 = Pbind(
	\instrument, \flute,
	\midinote, Pseq([68, 70, 71, 75, 90, 90, 74]),
	\dur, Pseq([2, 3, 3, 8, 4, 4, 20]),
	\amp, Pseq([0.8, 0.8, 0.8, 1, 1, 1, 0.5]),
	\pan, Pxrand([-1, -0.75, -0.5, -0.25, 0.25, 0.5, 0.75, 1], 7),
	\out, 0
);

~water = Pbind(
	\instrument, \sampler,
	\bufID, ~waterbuff,
	\attack, 20,
	\release, 20,
	\dur, 82,
	\start, 0,
	\amp, 0.1,
	\pan, 0,
	\out, 0
);

~water2 = Pbind(
	\instrument, \sampler,
	\bufID, ~waterbuff,
	\attack, 20,
	\release, 20,
	\dur, 22,
	\start, 120,
	\amp, 0.1,
	\pan, 0,
	\out, 0
);

~birds = Pbind(
	\instrument, \sampler,
	\bufID, ~birdbuff,
	\attack, 2,
	\release, 6,
	\dur, 28,
	\start, 0,
	\amp, 0.6,
	\pan, 0,
	\out, 0
);

~birds2 = Pbind(
	\instrument, \sampler,
	\bufID, ~birdbuff,
	\attack, 2,
	\release, 6,
	\dur, 28,
	\start, 60,
	\amp, 0.7,
	\pan, 0,
	\out, 0
);
)

s.makeGui;


// FINAL PIECE

(
Pseq([Ptpar([0, Pfindur(48, Pseq([~water], 1)), 16, Pfindur(48, Pseq([~birds], 1))]), Ppar([PfadeIn(~marim1, 8)], 1), Ppar([~marim1], 1), Ptpar([0, ~marim2, 0, ~glass2, 4, ~marim2], 1), Ptpar([0, ~marim1, 0, ~glass1, 0, PfadeIn(~pad1, 10), 4, ~marim1, 4, ~glass1, 8, ~marim3, 8, ~glass1, 12, ~marim3, 12, ~glass1], 1), Ppar([~pad2, Ppar([~marim4, ~glass1], 2)], 1), Ppar([~pad3, Ppar([~marim5, ~glass1], 2)], 1), Ptpar([0, ~pad4, 0, Ppar([~marim3, ~glass1], 2), 4, ~flute1], 1), Ptpar([0, ~pad5, 0, Ppar([~marim1, ~glass1], 2), 2, ~flute2, 8, Ppar([~marim2, ~glass1], 2), 16, Ppar([~marim1, ~glass1], 2)], 1), Ptpar([0, ~pad6, 0, Ppar([~marim6, ~glass1], 2), 2, ~flute3, 8, Ppar([~marim7, ~glass1], 2)]), Ptpar([0, Pseq([Ppar([PfadeOut(~marim1, 4), PfadeOut(~glass1, 4)]), Event.silent(1)], 3), 0, Pfindur(16, PfadeIn(~water, 8)), 14.5, Pseq([Ppar([PfadeOut(~marim2, 4), PfadeOut(~glass1, 4)]), Event.silent(1)], 3), 21, Pfindur(16, PfadeIn(~birds, 8)), 29, Pseq([Ppar([PfadeOut(~marim10, 4), PfadeOut(~glass1, 4)]), Event.silent(1)], 3), 43.5, Pseq([Ppar([PfadeOut(~marim7, 4), PfadeOut(~glass1, 4)]), Event.silent(1)], 3), 57, Ppar([PfadeIn(~marim8, 8), PfadeIn(~glass1, 8)], 1), 61, Ptpar([0, Ppar([~marim11,  ~glass1], 2), 0, ~pad7]), 69, Ptpar([0, ~pad8, 0, Ppar([~marim12, ~glass1], 2), 0, ~flute4, 8, Ppar([~marim11,  ~glass1], 2), 8, ~pad7, 16, Ppar([~marim13, ~glass1], 2), 17, Pfindur(8, PfadeIn(~water2, 8)), 24, Ppar([~marim14, ~glass1], 2), 24, ~pad9, 32, Ppar([PfadeOut(~marim14, 4), PfadeOut(~glass1, 4)], 1), 36, Pfindur(16, PfadeIn(~birds2, 8))])])]).play;
)

/* TESTING

Ptpar([0, Ppar([PfadeIn(~marim8, 8), PfadeIn(~glass1, 8)], 1), 4, Ptpar([0, Ppar([~marim11,  ~glass1], 2), 0, ~pad7]), 12, Ptpar([0, ~pad8, 0, Ppar([~marim12, ~glass1], 2), 0, ~flute4, 8, Ppar([~marim11,  ~glass1], 2), 8, ~pad7, 16, Ppar([~marim13, ~glass1], 2), 17, Pfindur(8, PfadeIn(~water2, 8)), 24, Ppar([~marim14, ~glass1], 2), 24, ~pad9, 32, Ppar([PfadeOut(~marim14, 4), PfadeOut(~glass1, 4)], 1), 36, Pfindur(16, PfadeIn(~birds2, 8))])]).play

// Pseq([Ptpar([0, ~pad8, 0, Ppar([~marim12, ~glass1], 2), 0, ~flute4, 8, Ppar([~marim11,  ~glass1], 2), 8, ~pad7, 16, Ppar([~marim13, ~glass1], 2), 17, Pfindur(8, PfadeIn(~water2, 8)), 24, Ppar([~marim14, ~glass1], 2), 24, ~pad9, 32, Ppar([PfadeOut(~marim14, 4), PfadeOut(~glass1, 4)], 1), 36, Pfindur(16, PfadeIn(~birds2, 8))])]).play;
//
// Pfindur.new(1, PfadeIn(~water, 8)).play;
// PfadeIn(Pfindur(1, ~water), 4).play;
//
// Ppar([~pad1], 1).play;
// Ptpar([0, ~marim1, 0, ~glass1, 0, ~pad1, 4, ~marim1, 4, ~glass1, 8, ~marim3, 8, ~glass1, 12, ~marim3, 12, ~glass1], 1).play;
//
// Pseq([Ptpar([0, Ppar([~marim11,  ~glass1], 2), 0, ~pad7]), Ptpar([0, ~pad8, 0, Ppar([~marim12, ~glass1], 2), 0, ~flute4, 8, Ppar([~marim11,  ~glass1], 2), 8, ~pad7, 16, Ppar([~marim13, ~glass1], 2)])]).play;
//
//
// Pfindur(6, Pseq([~water], 1)).play;
// PfadeIn(~marim1, 20, 0, 10).play;
// Ptpar([0, ~pad2, 0, Ppar([~marim4, ~glass1], 2)], 1).play;
// Ptpar([0, ~pad2, 0, Ppar([~marim4, ~glass1], 2)], 1).play;
// Ptpar([0, ~pad3, 0, Ppar([~marim5, ~glass1], 2)], 1).play;
// Ptpar([0, ~pad4, 0, Ppar([~marim3, ~glass1], 2), 4, ~flute1], 1).play;
// Ptpar([0, ~pad5, 0, Ppar([~marim1, ~glass1], 2), 2, ~flute2, 8, Ppar([~marim2, ~glass1], 2), 16, Ppar([~marim1, ~glass1], 2)], 1).play;
// Ptpar([0, ~pad6, 0, Ppar([~marim6, ~glass1], 2), 2, ~flute3, 8, Ppar([~marim7, ~glass1], 2)])
// Pseq([Ppar([PfadeOut(~marim1, 4), PfadeOut(~glass1, 4)]), Rest(1)], 4).play;
//
// Pseq([Ptpar([0, ~pad6, 0, Ppar([~marim6, ~glass1], 2), 2, ~flute3, 4, Pfindur(16, Pseq([PfadeIn(~water, 4)]), 1), 8, Ppar([~marim7, ~glass1], 2), 10, Pfindur(16, Pseq([PfadeIn(~birds, 4)]), 1), 16,
//
// 	Ptpar([0, Pseq([Ppar([PfadeOut(~marim1, 4), PfadeOut(~glass1, 4)]), Event.silent(1)], 3), 0, Pfindur(16, PfadeIn(~water, 8)), 14.5, Pseq([Ppar([PfadeOut(~marim2, 4), PfadeOut(~glass1, 4)]), Event.silent(1)], 3), 21, Pfindur(16, PfadeIn(~birds, 8)), 29, Pseq([Ppar([PfadeOut(~marim10, 4), PfadeOut(~glass1, 4)]), Event.silent(1)], 3), 43.5, Pseq([Ppar([PfadeOut(~marim7, 4), PfadeOut(~glass1, 4)]), Event.silent(1)], 3), 57, Ppar([PfadeIn(~marim8, 8), PfadeIn(~glass1, 8)], 2), 61, Ptpar([0, Ppar([~marim11,  ~glass1], 3), 0, ~pad7])]).play;
//
// 	Pseq([Ptpar([0, Ppar([PfadeIn(~marim8, 8), PfadeIn(~glass1, 8)], 1), 4, Ptpar([0, Ppar([~marim11,  ~glass1], 2), 0, PfadeIn(~pad7, 8)])])]).play;
//
// 	Pseq([Ptpar([0, ~pad6, 0, Ppar([~marim6, ~glass1], 2), 2, ~flute3, 8, Ppar([~marim7, ~glass1], 2)]), Pseq([Ppar([PfadeOut(~marim1, 4), PfadeOut(~glass1, 4)]), Rest(1)], 4)]).play;
// 	Pseq([Ptpar([0, ~marim1, 0, ~glass1, 0, PfadeIn(~pad1, 10), 4, ~marim1, 4, ~glass1, 8, ~marim3, 8, ~glass1, 12, ~marim3, 12, ~glass1], 1)]).play;
// 	Pseq([Ptpar([0, ~pad5, 0, Ppar([~marim1, ~glass1], 2), 2, ~flute2, 8, Ppar([~marim2, ~glass1], 2), 16, Ppar([~marim1, ~glass1], 2)], 1), Ptpar([0, ~pad6, 0, Ppar([~marim6, ~glass1], 2), 2, ~flute3, 8, Ppar([~marim7, ~glass1], 2)])]).play;
//
//
// 	Pseq([Ptpar([0, ~marim1, 0, ~glass1, 0, PfadeIn(~pad1, 10), 4, ~marim1, 4, ~glass1, 8, ~marim3, 8, ~glass1, 12, ~marim3, 12, ~glass1], 1), Ptpar([0, Ppar([~marim4, ~glass1], 2)], 1)]).play;
// 	Pseq([~glass1], 1).play;
//
// 	Pseq([~marim14]).play;
