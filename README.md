# DNS-decoder-Assembly
A program written in MIPS 32 bit Assembly language to decode a DNS into a URL.

What is a DNS?:
The DNS is a 'phonebook' of the Internet translating 'human-friendly' domain names into computer-readable IP addresses. It enables users to access websites, without remembering complex, numerical network addresses.

What is the process of DNS decoding:
The DNS message is split into packets: One packet is called the Header, which includes the QDCount, which can either be a number such as 0 or 1. It also contains 'flags'. Initially, the DNS packet is checked if it is valid: A valid DNS packet must end with a '10' as it's last two digits. If it does not, then it is invalid, returning an appropriate error message.
Otherwise, then the DNS packet is read from the body of it, splitting the text between the '.' separators in the packet. This is then read and decoded using nested for loops. Finally, the fully decoded DNS packet, the URL, is outputted to the user.

Note: Code is still a WIP (Work In Progress). If any issues or bugs found with the code, please feel free to message.
