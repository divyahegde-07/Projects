from fastapi import FastAPI, HTTPException, BackgroundTasks
from pydantic import BaseModel, HttpUrl
from typing import List
import httpx

import openai
import re
import langchain.chains
import langchain.llms
import langchain.chat_models
import langchain.prompts
import langchain.chains.summarize
from langchain_community.llms import OpenAI
from langchain_openai import OpenAI
from langchain.chains.summarize import load_summarize_chain
from langchain.text_splitter import CharacterTextSplitter
from langchain.docstore.document import Document
from langchain.prompts import PromptTemplate


import urllib
import requests

OPENAI_API_KEY = 'sk-proj-8SOl5PzwElWsyFHgemhfT3BlbkFJqOXOCGRd7lit1XN7ll0q'
app = FastAPI()
log_url_list = []
question = ''
summaries = []
final_summary = ''

class DocumentSubmission(BaseModel):
    question: str
    documents: List[str]


#POST REQUEST
@app.post("/submit_question_and_documents")
async def submit_question_and_documents(submission: DocumentSubmission, background_tasks: BackgroundTasks):
    global log_url_list, question, summaries, final_summary, status
    log_url_list = submission.documents
    question = submission.question

    status = 'processing'
    background_tasks.add_task(handle_document_processing, log_url_list)

    # Process URLs asynchronously and wait for the results
    #call_contents = await process_urls(submission.documents)
    #docs = chunks_and_document(call_contents)
    #final_summary = process_documents_with_langchain(docs)
    #summaries = process_documents_with_langchain(docs)
    #final_summary = get_final_summary(summaries,question) 
    #print('final summary: ', final_summary)
    
    return {"message": "Documents received, processing started", "question": submission.question, "documents": submission.documents}

#GET REQUEST
@app.get("/get_question_and_facts")
async def get_question_and_facts():
    return {
        "question": question,
        "facts": final_summary if status == 'done' else None,
        "status": status
    }

async def handle_document_processing(document_urls):
    # Asynchronously process URLs and wait for the results
    call_contents = await process_urls(document_urls)
    docs = chunks_and_document(call_contents)

    # Process documents with LangChain and summarize
    global final_summary, status
    final_summary = process_documents_with_langchain(docs)
    # Optionally, you might want to compute a final summary from individual summaries here
    # final_summary = get_final_summary(summaries, question)
    
    # Update status to done once processing is complete
    status = 'done'
    final_summary = re.split(r'(?<=[.!?]) +', '\n'.join(final_summary))
    final_summary = [final.strip() for final in final_summary if final.strip()]
    print('final summary: ', final_summary)


async def process_urls(log_call_list):
    async with httpx.AsyncClient() as client:
        results = []
        for url in log_call_list:
            try:
                response = await client.get(url)
                response.raise_for_status()  # Raises an HTTPError for bad responses
                results.append(response.text)
            except httpx.RequestError as e:
                print(f"Request failed: {e}")
                continue  # Optionally handle or log error
    return results

def chunks_and_document(call_contents):
    
    docs = []
    for content in call_contents:
        text_splitter = CharacterTextSplitter() # text splitter method by default it has chunk_size = 200 and chunk_overlap = 200
        #docs.append(text_splitter.create_documents(content)) # split the text into smaller chunks
        texts = text_splitter.split_text(content)
        doc = [Document(page_content=t) for t in texts]
        docs.append(doc)
    return docs

def process_documents_with_langchain(docs):

    summaries = []

    summarize_chain = load_custom_summarize_chain()
    print('len of docs: ', len(docs))

    for doc in docs:
        summary = summarize_chain.invoke(doc)
        print("Summary:", summary['output_text'])
        summaries.append(summary['output_text'])
        return summaries
    
def load_custom_summarize_chain():
    llm = OpenAI(api_key=OPENAI_API_KEY)
    prompt_template = create_dynamic_fact_update_prompt()
    prompt = prompt_template.format(question=question)
    #prompt_template = "Summarize the following text succinctly. GIve me the final facts of the conversation as a list:\n\n{text}\n\n:"
    summarize_chain = load_summarize_chain(
        llm
    )
    return summarize_chain



def get_final_summary(summaries,question):
    llm = OpenAI(api_key=OPENAI_API_KEY)
   #prompt_template = PromptTemplate.from_template(
    #"Give me the final facts from all the summaries {summaries}. And answer the question {question}. Give each fact in a single line")
    prompt_template = create_dynamic_fact_update_prompt()

    for i in range(0,len(summaries)-1):
        prompt = create_dynamic_fact_update_prompt()
        prompt = prompt_template.format(current_decisions=summaries[i], new_decision = summaries[i+1],question=question)
        response = llm(prompt)
        print('final respone: ', response)
        return response

def main():
    
    import uvicorn
    uvicorn.run("Requests:app", host="0.0.0.0", port=8000)

def create_dynamic_fact_update_prompt():
    template_text = """
    ### Background:
    You are given a list of call summaries. The ordering of summaries matter. A later summary may modify the fact from a previous summary. 
    So summary 1 may introduce new facts, but the facts in summary 2 may - add news facts to the list of facts, change facts in the list of facts, or remove facts in the list of facts.
    Some summaries will add new information, while others might override or invalidate previous decisions.
    Your task is to integrate new facts into the list accurately, ensuring that all facts reflect the most current state of the summaries. Remove any characters from the conversation in the final facts list.

    ### Summaries:
    {{summaries}}

    ### Task:
    Give the final facts as a list and discard the names of the speakers involved. And finally, answer this question based on the final facts - {question}. Give the final facts.
    """
    return PromptTemplate.from_template(template=template_text)

if __name__ == "__main__":
    main()





