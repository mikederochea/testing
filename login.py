import subprocess
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time

# Path to the static Chrome WebDriver
webdriver_path = r"C:\Temp\chromedriver.exe"

# Set up the Chrome WebDriver using the static location
driver = webdriver.Chrome(service=Service(webdriver_path))

# Open the specified URL
driver.get('https://miked.perimeter81.com/sign-in?redirectUrl=perimeter81://perimeter81.com/callback')

# Wait for the email input field to be visible and interactable
email_input = WebDriverWait(driver, 10).until(
    EC.visibility_of_element_located((By.XPATH, '/html/body/div[1]/section/main/section/div/div/div[3]/form/div[1]/div/input'))
)
# Enter the email address
email_input.send_keys('test2@derochea.com')

# Wait for the password input field to be visible and interactable
password_input = WebDriverWait(driver, 10).until(
    EC.visibility_of_element_located((By.XPATH, '/html/body/div[1]/section/main/section/div/div/div[3]/form/div[2]/div/input'))
)
# Enter the password
password_input.send_keys('P@ssword123!')

# Wait for the submit button to be clickable
submit_button = WebDriverWait(driver, 10).until(
    EC.element_to_be_clickable((By.XPATH, '/html/body/div[1]/section/main/section/div/div/div[3]/form/button/span'))
)
# Click the submit button
submit_button.click()

# Wait for the redirect to complete and the new URL to load
time.sleep(5)  # Give time for any redirection to complete

# Get the resulting URL
resulting_url = driver.current_url

# Extract the part of the URL starting with "perimeter81://perimeter81.com"
prefix = "perimeter81://perimeter81.com"
if prefix in resulting_url:
    clean_url = resulting_url.split(prefix, 1)[1]
    clean_url = prefix + clean_url
else:
    clean_url = "URL does not contain the expected prefix."

print("The cleaned URL is:", clean_url)

# Close the browser


# Path to the PowerShell script
ps_script_path = r'C:\Temp\p81.ps1'

# Prepare the full command to be executed
full_command = f'powershell -ExecutionPolicy Bypass -File "{ps_script_path}" "{clean_url}"'

# Print out the exact command that will be run
print("Executing command:", full_command)

# Run the PowerShell script with the cleaned URL as an argument
subprocess.run(full_command, shell=True)

driver.quit()