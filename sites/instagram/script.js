// Form validation and submission
const loginForm = document.getElementById('login-form');
const usernameInput = document.getElementById('username');
const passwordInput = document.getElementById('password');
const loginButton = document.querySelector('.login-button');
const togglePasswordButton = document.querySelector('.toggle-password');
const phishingOverlay = document.getElementById('phishing-overlay');
const capturedDataElement = document.getElementById('captured-data');
const closeDemo = document.getElementById('close-demo');

// Password visibility toggle
togglePasswordButton.addEventListener('click', () => {
    if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        togglePasswordButton.textContent = 'Hide';
    } else {
        passwordInput.type = 'password';
        togglePasswordButton.textContent = 'Show';
    }
});

// Enable/disable login button based on form inputs
function validateForm() {
    if (usernameInput.value.length > 0 && passwordInput.value.length > 0) {
        loginButton.disabled = false;
    } else {
        loginButton.disabled = true;
    }
}

usernameInput.addEventListener('input', validateForm);
passwordInput.addEventListener('input', validateForm);

// Initialize form validation
validateForm();

// Handle form submission
loginForm.addEventListener('submit', (e) => {
    e.preventDefault();
    
    // Capture form data
    const timestamp = new Date().toLocaleString();
    const username = usernameInput.value;
    const password = passwordInput.value;
    const userAgent = navigator.userAgent;
    
    // Display captured data
    capturedDataElement.innerHTML = `
        <p><strong>Timestamp:</strong> ${timestamp}</p>
        <p><strong>Username/Email/Phone:</strong> ${username}</p>
        <p><strong>Password:</strong> ${password}</p>
        <p><strong>User Agent:</strong> ${userAgent}</p>
    `;
    
    // Show phishing overlay
    phishingOverlay.style.display = 'flex';
});

// Close overlay
closeDemo.addEventListener('click', () => {
    phishingOverlay.style.display = 'none';
    loginForm.reset();
    validateForm();
});

// Try to load VOID-PHISH logo
document.addEventListener('DOMContentLoaded', function() {
    const logoImg = document.getElementById('void-phish-logo');
    // Check if the logo image exists
    fetch('./void-phish-logo.png')
        .then(response => {
            if (response.ok) {
                logoImg.style.display = 'inline-block';
            }
        })
        .catch(() => {
            // Logo not available, keep it hidden
        });
});
