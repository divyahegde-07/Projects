import streamlit as st
import requests

# URL of the FastAPI backend
FASTAPI_URL = "http://127.0.0.1:8000"

def send_documents(question, documents):
    response = requests.post(
        f"{FASTAPI_URL}/submit_question_and_documents",
        json={"question": question, "documents": documents}
    )
    return response.json()

def main():
    st.title("Document Processor")
    st.header("Submit your question and document URLs")

    # Text input for question
    question = st.text_input("Enter your question:", "")

    # Text area for document URLs (one URL per line)
    doc_urls = st.text_area("Enter document URLs (one per line):", "")
    document_list = doc_urls.split()

    # Button to submit to the FastAPI backend
    if st.button("Submit Documents"):
        if question and document_list:
            response = send_documents(question, document_list)
            st.success("Submitted successfully!")
            st.json(response)
        else:
            st.error("Please provide both a question and at least one document URL.")

    st.subheader("Response from Server")
    if st.button("Get Facts and Status"):
        response = requests.get(f"{FASTAPI_URL}/get_question_and_facts")
        st.json(response.json())

if __name__ == "__main__":
    main()
