VOIDPHISH - Advanced Phishing Toolkit
VOIDPHISH License

VOIDPHISH is a powerful web-based phishing toolkit designed for security professionals to conduct security awareness training and penetration testing. This tool helps organizations identify vulnerabilities in their security awareness programs and improve their defenses against social engineering attacks.

⚠️ DISCLAIMER
This tool is created for EDUCATIONAL PURPOSES ONLY. The developers assume no liability and are not responsible for any misuse or damage caused by this program. Using this tool against targets without explicit permission is illegal and may result in legal consequences.

USE AT YOUR OWN RISK AND RESPONSIBILITY

🔧 Features
📱 Multiple pre-built phishing templates
🌐 Custom website cloning capability
🔄 Automatic Ngrok integration for public URL generation
📊 Real-time credential harvesting and monitoring
🔐 Simple and intuitive command-line interface
📋 Pre-built Templates
VOIDPHISH comes with several pre-built templates for common websites:

Microsoft Login
Twitter
LinkedIn
Netflix
More coming soon…
🛠️ Requirements
PHP (7.0 or higher)
Ngrok account and authtoken
Bash terminal (Linux/macOS) or Git Bash (Windows)
📥 Installation
Clone this repository:
git clone https://github.com/yourusername/voidphish.git
cd voidphish
Make the scripts executable:
chmod +x voidphish.sh
chmod +x server.sh
chmod +x ngrok.sh
Configure Ngrok (if not already done):
ngrok authtoken YOUR_AUTHTOKEN_HERE
🚀 Usage
Launch the toolkit:
./voidphish.sh
From the main menu, choose one of the following options:

Launch Phishing Attack: Start a phishing campaign with a pre-built or custom template
Clone Website: Create a new template by cloning an existing website
View Credentials: Check harvested credentials
Exit: Close the toolkit
Launching a Phishing Attack
Select “Launch Phishing Attack” from the main menu
Choose a template from the list
The tool will start a PHP server and create an Ngrok tunnel
Share the generated Ngrok URL with your target(s)
Captured credentials will be saved to .server/credentials.txt
Cloning a Website
Select “Clone Website” from the main menu
Enter the URL of the website you want to clone
Provide a name for the new template
The website will be cloned to the sites/[template_name] directory
You may need to edit the login.php file to match the form fields of the cloned site
📁 Directory Structure
VOIDPHISH/
├── .server/              # Server-related files
│   └── credentials.txt   # Harvested credentials
├── sites/                # Phishing templates
│   ├── microsoft/        # Microsoft template
│   ├── twitter/          # Twitter template
│   ├── linkedin/         # LinkedIn template
│   └── netflix/          # Netflix template
├── voidphish.sh          # Main script
├── server.sh             # PHP server script
└── ngrok.sh              # Ngrok tunneling script
🔍 Advanced Usage
Customizing Templates
You can customize any template by editing the HTML and PHP files in the corresponding directory:

sites/[template_name]/index.html  # The phishing page
sites/[template_name]/login.php   # The credential harvesting script
Adding Custom CSS and Images
To add custom CSS or images to your phishing pages, place them in the appropriate template directory and update the HTML file to reference them.

🛡️ Security Best Practices
When conducting authorized security assessments:

Always obtain proper written permission before targeting any organization
Handle captured data with care and in accordance with privacy laws
Use the results only to improve security awareness and defenses
Delete all captured credentials after completing your assessment
🤝 Contributing
Contributions are welcome! If you’d like to add new templates or features, please:

Fork the repository
Create a new branch for your feature
Add your changes
Submit a pull request
📄 License
This project is licensed under the MIT License - see the LICENSE file for details.

📞 Support
For questions, issues, or feature requests, please open an issue on the GitHub repository.

Remember: With great power comes great responsibility. Use this tool ethically and legally.
