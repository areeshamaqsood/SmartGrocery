# Flask API
from flask import Flask, jsonify, request
from playsound import playsound
from IPython.display import Audio
import requests
import librosa
import torch
from transformers import Wav2Vec2ForCTC, Wav2Vec2Processor
from spellchecker import SpellChecker
from inspect import getclosurevars
import Recomm

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

        # Translating words to English
        if corrected_word == 'أتار':
            corrected_word = 'Pickle'
        elif corrected_word == 'عندي' or corrected_word == 'أندي':
            corrected_word = 'Egg'
        elif corrected_word == 'بسن' or corrected_word == 'بيسن':
            corrected_word = 'Baisan'
        elif corrected_word == 'جني' or corrected_word == 'شاني':
            corrected_word = 'Chickpeas'
        elif corrected_word == 'أتى' or corrected_word == 'أعتا':
            corrected_word = 'Flour'
        elif corrected_word == 'شعول' or corrected_word == 'جاول':
            corrected_word = 'Rice'
        elif corrected_word == 'جيني':
            corrected_word = 'Sugar'
        elif corrected_word == 'دبروتي' or corrected_word == 'دبل روتي':
            corrected_word = 'Bread'
        elif corrected_word == 'دهي':
            corrected_word = 'yogurt'
        elif corrected_word == 'دود':
            corrected_word = 'Milk'
        elif corrected_word == 'إلعَيْتي' or corrected_word == 'إلعيتي' or \
                corrected_word == 'إِلَ عَيْتِي' or corrected_word == 'إلى أيتي':
            corrected_word = 'Elaichi'
        elif corrected_word == 'كي' or corrected_word == 'غي' or \
                corrected_word == 'تيل':
            corrected_word = 'Fats'
        elif corrected_word == 'حل دي' or corrected_word == 'حلدي':
            corrected_word = 'Haldi'
        elif corrected_word == 'إملي':
            corrected_word = 'Imli'
        elif corrected_word == 'نمك':
            corrected_word = 'Salt'
        elif corrected_word == 'بتي':
            corrected_word = 'Tea'
        elif corrected_word == 'صاب' or corrected_word == 'سعب':
            corrected_word = 'Soap'
        elif corrected_word == 'سركا':
            corrected_word = 'Vinegar'
        elif corrected_word == 'سرف':
            corrected_word = 'Ariel'

        print(corrected_word)

        return corrected_word

@app.route('/recomm', methods=['GET'])
def home():
    # return "Hello, Flask!"
    d1 = {}
    d1['Query'] = str(request.args['Query'])
    print("QUERY GET: ", d1['Query'])
    # RS.forEachUser(d1['Query'])
    results = Recomm.getCorrelations(d1['Query'])
    toDict = results.to_dict('list')
    # print("results:")
    # print(results)
    print("toDict:")
    # toDict= results.set_index('ProductName')['correlation'].to_dict()
    print(toDict)
    return jsonify(toDict)


if __name__ == "__main__":
    app.run()
