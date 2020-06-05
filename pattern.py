#!/usr/bin/python3
import sys

DEF_SIZE = 1000

def usage():
    print("python3 pattern <create|search> <arg>")
    print("\tcreate: <arg> = size of the pattern")
    print("\tsearch: <arg> = the pattern to search, you can also set the size of the pattern")
    exit(0)


def createPattern(size = DEF_SIZE):
    pat = ""
    for i in range(size):
        if i % 4 == 3:
            nb = int(33 + (i / 4 % 94))
            pat += chr(nb)
        else:
            pat += chr(65 + int(i / (94 * 4)))
    return pat


if len(sys.argv) < 3:
    usage()

if sys.argv[1] == "create":
    try:
        int(sys.argv[2])
    except ValueError:
        usage()
    print(createPattern(int(sys.argv[2])))
elif sys.argv[1] == "search":
    allPos = []
    start = 0
    size = DEF_SIZE
    if len(sys.argv) >= 4:
        try:
            int(sys.argv[3])
        except ValueError:
            usage()
        size = int(sys.argv[3])
    pat = createPattern(size)
    while 1:
        if start >= DEF_SIZE:
            break
        find = pat.find(sys.argv[2], start)
        if find < 0:
            break
        allPos.append(find)
        start = find + len(sys.argv[2])
    if len(allPos) == 0:
        print("pattern not found")
    else:
        for find in allPos:
            print("found at offset:", find)

else:
    usage()
