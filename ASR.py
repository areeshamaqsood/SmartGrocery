# Flask API
from flask import Flask, jsonify, request
from playsound import playsound
from IPython.display import Audio
import requests
import librosa
import torch
from transformers import Wav2Vec2ForCTC, Wav2Vec2Processor

app = Flask(__name__)

@app.route('/api', methods=['POST'])
def getAudioFile():
    if request.method == 'POST':
        audioLink = request.form['downloadLink']
        print(audioLink)

        audioFile = requests.get(audioLink, allow_redirects=True)
        with open("audio.wav", 'wb') as f:
            f.write(audioFile.content)

        data = librosa.load('audio.wav', sr=16000, mono=True)

        MODEL_ID = "jonatasgrosman/wav2vec2-large-xlsr-53-arabic"

        processor = Wav2Vec2Processor.from_pretrained(MODEL_ID)
        model = Wav2Vec2ForCTC.from_pretrained(MODEL_ID)

        print("Processing...")
        inputs = processor(data[0], sampling_rate=16_000, return_tensors="pt", padding=True)
        with torch.no_grad():
            logits = model(inputs.input_values, attention_mask=inputs.attention_mask).logits

        predicted_ids = torch.argmax(logits, dim=-1)
        predicted_word = processor.batch_decode(predicted_ids)

        print(predicted_word)

        return predicted_word[0]


if __name__ == "__main__":
    app.run()