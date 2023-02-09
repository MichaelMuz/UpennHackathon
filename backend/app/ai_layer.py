import openai
openai.api_key = "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"

def gpt_req(prompt):
    response = openai.Completion.create(
        engine="text-davinci-003",
        prompt=prompt,
        max_tokens=2048,
        temperature=0.5,
        top_p=1,
        frequency_penalty=0,
        presence_penalty=0
    )
    cleaned = response.choices[0].text.strip()
    if(len(cleaned) == 0):
        return "Got empty big bruh"
    return cleaned

DALLE_PROMPTS = {
    1: "Childish Drawing of",
    2: "A detailed one line drawing of",
    3: "A colorless oil painting of",
    4: "A detailed van gogh painting of",
    5: "A detailed colorful picasso painting of",
    6: "Detailed colorful banksy street art of"
    7: "A detailed colorful Haruki Murakami painting of",
    8: "A detailed colorful MC Escher painting of"
    9: "A detailed colorful Dali painting of"
}

def dalle_req(prompt):
    response = openai.Image.create(
        prompt=prompt,
        n=1,
        size="256x256"
    )
    image_url = response['data'][0]['url']
    return image_url