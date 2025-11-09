# shell-keylogger

Educational keylogger tool written in shell script to understand security risks.

## ⚠️ LEGAL WARNING

**This project is strictly for educational and security awareness purposes.**

- ❌ **Using this software on systems you do not own is illegal**
- ❌ **Use without explicit consent is prohibited by law**
- ✅ **Use only in controlled test environments**
- ✅ **Always respect privacy and comply with applicable laws**

The author disclaims all responsibility for misuse of this tool.

## Description

This project provides two shell scripts to understand how basic keyloggers work and how they can compromise system security:

- **keylogger.sh**: Script to capture keyboard input in a terminal
- **analyse_log.sh**: Script to analyze and visualize captured logs

## Features

### keylogger.sh

- Real-time keystroke capture in current terminal
- Timestamped recording of each keystroke
- Detection of special keys (ENTER, BACKSPACE, TAB, ESC)
- Clean shutdown handling via Ctrl+C
- Automatic saving to log file

### analyse_log.sh

- Display complete log contents
- Search for keywords in logs
- Keystroke statistics (number of keys, ENTER, BACKSPACE, etc.)
- Timeline of events
- Automatic detection of sensitive commands
- Interactive command-line interface

## Installation

```bash
# Clone the repository
git clone https://github.com/ryantsou/shell-keylogger.git
cd shell-keylogger

# Make scripts executable
chmod +x keylogger.sh analyse_log.sh
```

## Usage

### Start the keylogger

```bash
# Display help
./keylogger.sh --help

# Launch the keylogger
./keylogger.sh
```

The script will capture keystrokes and save them to `~/.keylog_YYYYMMDD_HHMMSS.txt`

Press **Ctrl+C** to stop capture.

### Analyze logs

```bash
# Launch the analyzer
./analyse_log.sh ~/.keylog_20231109_120000.txt
```

You will have access to an interactive menu with several analysis options.

## Educational Objectives

This project allows you to:

1. **Understand risks**: See concretely how a keylogger can capture sensitive information
2. **Security awareness**: Realize the importance of protecting your systems
3. **Learn shell scripting**: Study Bash programming techniques
4. **Develop skills**: Understand how to detect and protect against this type of attack

## Protection Against Keyloggers

### Best Practices

- Regularly check running processes (`ps aux`, `top`)
- Monitor suspicious files in the system
- Use up-to-date antivirus software
- Never execute unknown scripts
- Verify permissions on sensitive files
- Use password managers

### Detection

```bash
# Search for suspicious processes
ps aux | grep -i keylog

# Check for unusual log files
find ~ -name "*.keylog*" -o -name "*keylog*.txt"

# Monitor recent modifications
find ~ -type f -mtime -1 -name "*.txt"
```

## Project Structure

```
shell-keylogger/
├── keylogger.sh          # Capture script
├── analyse_log.sh        # Analysis script
├── README.md             # Documentation
└── LICENSE               # MIT License
```

## Limitations

This keylogger is **intentionally limited** for educational purposes:

- Works only in the terminal where it is launched
- Does not capture system-wide keystrokes
- Easily detectable by the user
- Log files are visible and unencrypted

## License

This project is distributed under the MIT license. See the `LICENSE` file for more details.

## Contributing

Contributions are welcome to improve the educational aspect of the project:

- Documentation improvements
- Additional analysis features
- Bug fixes
- Security advice additions

## Resources

- [OWASP - Application Security](https://owasp.org/)
- [NIST - Cybersecurity Framework](https://www.nist.gov/cyberframework)
- [Bash Scripting Guide](https://tldp.org/LDP/abs/html/)

## Contact

For any questions regarding this educational project, please open an issue on GitHub.

---

**Reminder**: This project is for educational purposes only. Use it responsibly and ethically.
