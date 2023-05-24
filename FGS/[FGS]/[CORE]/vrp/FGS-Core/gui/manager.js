const audio = [
    { name: "headshot", file: "headshot.ogg", volume: 1.00 },
    { name: "bodyshot", file: "bodyshot.ogg", volume: 1.00 },
    { name: "zipper", file: "zipper.ogg", volume: 0.650 },
]

var audioPlayer = null;
  
window.addEventListener('message', function (event) {
    if (findAudioToPlay(event.data.transactionType)) {
      let audio = findAudioToPlay(event.data.transactionType)
      if (audioPlayer != null) {
        audioPlayer.pause();
      }
      audioPlayer = new Audio("sounds/" + audio.file);
      audioPlayer.volume = audio.volume;
      audioPlayer.play();
    }
});
  
function findAudioToPlay(name) {
    for (a of audio) {
      if (a.name == name) {
        return a
      }
    }
    return false
}