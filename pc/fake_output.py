import sys

READY_MESSAGE = "ready"
QUEUE_MESSAGE = "queue"
CANCELLED_MESSAGE = "cancelled"

if len(sys.argv) != 2:
    print("Usage: fake_output.py [filename]")
    sys.exit(1)

in_queue = False

while True:
    cmd = input("Enter a command (ready, queue, cancel, quit):\n").lower()
    with open(sys.argv[1], 'a') as f:
        if cmd == 'quit':
            break
        if 'r' in cmd:
            print(READY_MESSAGE, file=f)
            print("Ready Up")
            in_queue = True
            continue
        if 'q' in cmd:
            print(QUEUE_MESSAGE, file=f)
            print("Joined queue")
            continue
        if 'c' in cmd:
            if in_queue:
                print(CANCELLED_MESSAGE, file=f)
                print("Cancelled queue")
            else:
                print("Not in queue")
            continue
        print('"{}" is not a valid command'.format(cmd))
