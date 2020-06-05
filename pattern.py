#!/usr/bin/python3
import sys

# max size 30976

patChr = "ABCDEFGHIJKLMNOPQRSTUVWXYZ#%&()*+,-./0123456789:;<=>?@[]^_abcdefghijklmnopqrstuvwxyz{|}~"
nbChr = len(patChr)
MAX_SIZE = nbChr * nbChr * 4  # (30976)
DEF_SIZE = 1000

def usage():
	print("python3 pattern <create|search> <arg>")
	print("\tcreate: <arg> = size of the pattern (max: " + str(MAX_SIZE) + ")")
	print("\tsearch: <arg> = the pattern to search, you can also set the size of the pattern")
	exit(0)


def createPattern(size = DEF_SIZE):
	if size > MAX_SIZE:
		usage()
	pat = ""
	for i in range(size):
		if i % 4 == 3:
			pat += patChr[nbChr - int(i / 4 % nbChr) - 1]
		else:
			pat += patChr[int(i / (nbChr * 4))]
	return pat


if len(sys.argv) < 3:
	usage()

if sys.argv[1] == "create":
	try:
		print(createPattern(int(sys.argv[2])))
	except ValueError:
		usage()
elif sys.argv[1] == "search":
	allPos = []
	start = 0
	size = DEF_SIZE
	if len(sys.argv) >= 4:
		try:
			size = int(sys.argv[3])
		except ValueError:
			usage()
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
