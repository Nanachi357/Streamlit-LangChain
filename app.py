import os
import subprocess
import sys

# Function to check and install required packages
def install_requirements():
    try:
        import langchain  # Example: Check if langchain is installed
        import openai  # Example: Check if openai is installed
    except ImportError:
        print("Required packages not found. Installing...")
        subprocess.check_call([sys.executable, "-m", "pip", "install", "-r", "requirements.txt"])
        print("Packages installed. Please restart the application.")
        sys.exit()  # Exit to ensure proper reload after installation

# Call the function to ensure dependencies are installed
install_requirements()

# Import the required modules after ensuring they are installed
import streamlit as st

# Streamlit app content
st.title("Streamlit + LangChain App")

st.write("Welcome to your first Streamlit app inside Docker!")

# Placeholder for further LangChain and OpenAI integration
st.write("You can now integrate LangChain and OpenAI functionalities here!")
