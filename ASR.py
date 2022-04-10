# Flask API
from flask import Flask, jsonify, request
from playsound import playsound
from IPython.display import Audio
import requests
import librosa
import torch
from transformers import Wav2Vec2ForCTC, Wav2Vec2Processor
from spellchecker import SpellChecker

app = Flask(__name__)

# Load model from the internet
MODEL_ID = "jonatasgrosman/wav2vec2-large-xlsr-53-arabic"

processor = Wav2Vec2Processor.from_pretrained(MODEL_ID)
model = Wav2Vec2ForCTC.from_pretrained(MODEL_ID)

# Load API on call
@app.route('/api', methods=['POST'])
def getAudioFile():

    # Download the audio file from Cloud Storage using 
    # the http link sent through POST request
    if request.method == 'POST':
        audioLink = request.form['downloadLink']
        print(audioLink)

        # Read the audio file
        audioFile = requests.get(audioLink, allow_redirects=True)
        with open("audio.wav", 'wb') as f:
            f.write(audioFile.content)

        # Load the audio file
        data = librosa.load('audio.wav', sr=16000, mono=True)

        print("Processing...")

        # Send the audio file to the model to generate a string
        inputs = processor(data[0], sampling_rate=16_000, return_tensors="pt", padding=True)
        with torch.no_grad():
            logits = model(inputs.input_values, attention_mask=inputs.attention_mask).logits

        predicted_ids = torch.argmax(logits, dim=-1)

        # Predicted word is stored in a variable
        predicted_word = processor.batch_decode(predicted_ids)

        # Dictionary of words for our Grocery dataset
        word_list = ['أتار', 'عندي', 'أندي', 'بسن', 'بيسن', 'جني', 'شاني', 'أتى', 'أعتا', 'شعول', 'جاول',
            'جيني', 'دبروتي', 'دبل روتي', 'دهي', 'دود', 'إلعَيْتي', 'إلعيتي', 'إِلَ عَيْتِي', 'إلى أيتي',
            'كي', 'غي', 'حل دي', 'حلدي', 'إملي', 'نمك', 'بتي', 'صاب', 'سعب', 'سركا', 'سرف', 'تيل']

        # Create an object of spellchecker
        # Checks and correctes spellings to upto 5 edit distance (Levenshtiens)
        # Loads the self made dictionary of words
        spell = SpellChecker(distance=5)
        spell.word_frequency.load_words(word_list)

        # Corrected Word
        corrected_word = spell.correction(predicted_word[0])

        print(corrected_word)

        return corrected_word


if __name__ == "__main__":
    app.run()