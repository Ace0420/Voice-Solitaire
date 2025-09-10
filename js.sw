self.addEventListener('install', (e) => {
    e.waitUntil(
        caches.open('solitaire-cache').then((cache) => cache.addAll([
            '/',
            '/index.html',
            '/icon-192.png',
            '/icon-512.png',
            '/apple-touch-icon.png',
            '/favicon-32x32.png',
            '/favicon-16x16.png',
            '/tone.js',
            '/click.mp3',
            '/error.mp3'
        ]))
    );
});
self.addEventListener('fetch', (e) => {
    e.respondWith(caches.match(e.request).then((response) => response || fetch(e.request)));
});

function handleVoiceCommand(command) {
  if (command.includes("hint")) {
    score -= 5;
    speak("Hint given. 5 points deducted.");
    // logic to provide hint
  } else if (command.includes("undo")) {
    if (undosLeft > 0) {
      undosLeft--;
      score -= 10;
      speak(`Undo performed. You have ${undosLeft} undos left.`);
      // logic to undo move
    } else {
      speak("No undos remaining.");
    }
  } else if (command.includes("difficulty")) {
    if (command.includes("easy")) stockFlip = 1;
    else if (command.includes("medium")) stockFlip = 2;
    else if (command.includes("hard")) stockFlip = 3;
    speak(`Difficulty set to ${stockFlip} card${stockFlip > 1 ? 's' : ''} per flip.`);
  } else if (command.includes("status")) {
    speak(`Score: ${score}. Undos left: ${undosLeft}.`);
  }
}
function flipStock() {
  for (let i = 0; i < stockFlip; i++) {
    // move card from stock to waste
  }
  speak(`${stockFlip} card${stockFlip > 1 ? 's' : ''} flipped.`);
}
window.onload = () => {
  speak("Welcome to Voice Solitaire. Say 'start' to begin or 'help' for instructions.");
  recognition.start(); // Starts listening immediately
};