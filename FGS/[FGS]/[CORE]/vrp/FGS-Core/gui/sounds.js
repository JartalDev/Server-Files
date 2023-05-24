var audioPlayer = null;
    window.addEventListener('message', function(event) {
        if (event.data.submissionType == "sendSound") {
				
        if (audioPlayer != null) {
            audioPlayer.pause();
        }

        audioPlayer = new Howl({src: ["./sounds/" + event.data.submissionFile + ".ogg"]});
        audioPlayer.volume(event.data.submissionVolume);
        audioPlayer.play();
    }
});