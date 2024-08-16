from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from webdriver_manager.chrome import ChromeDriverManager
import pyautogui
import time


# Set up the Chrome WebDriver
driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()))

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

time.sleep(10)                           # sleep until pop up shown
pyautogui.press('tab', presses=2)  # navigate to open button
pyautogui.press('enter')           # open application

time.sleep(10)  

# The browser window will remain open after the script finishes