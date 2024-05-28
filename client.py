import socket

def main():
    server_ip = '127.0.0.1'  # Change this to the server's IP address
    server_port = 7995  # Port number changed to 7995
    
    while True:
        command = input("Enter the command to execute remotely: ")
        
        client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        client_socket.connect((server_ip, server_port))
        client_socket.send(command.encode('utf-8'))
        
        result = client_socket.recv(1024).decode('utf-8')
        print(f"Result: {result}")
        
        client_socket.close()

if __name__ == "__main__":
    main()
