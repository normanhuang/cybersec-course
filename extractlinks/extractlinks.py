
#!/usr/bin/python
import re
import sys

def main():
    print ('Zoom Chat Link Extractor')
    absoluteFp = sys.argv[1]
    p = re.compile(r'(?:(?:https?:\/\/|www.)(?:\w*-*)*(?:\.)(?:.*))', flags=re.UNICODE|re.IGNORECASE)

    links = set()
    with open(absoluteFp, mode='r') as f:
        for line in f:
            found = p.findall(line)
            if found:
                for link in found:
                    if link in links : continue
                    links.add(link)
                    print(link)

if __name__ == "__main__":
    main()
