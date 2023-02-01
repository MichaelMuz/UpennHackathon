import openai
openai.api_key = "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"

def gpt_req(prompt):
    completion = openai.Completion.create(
        engine="text-davinci-003",
        prompt=prompt,
        max_tokens=2048,
        temperature=0.5,
        top_p=1,
        frequency_penalty=0,
        presence_penalty=0
    )
    return completion.choices[0].text

print(gpt_req("what color are my balls?"))
