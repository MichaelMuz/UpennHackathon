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

def dalle_req(prompt):
    response = openai.Image.create(
        prompt=prompt,
        n=1,
        size="256x256"
    )
    image_url = response['data'][0]['url']
    return image_url