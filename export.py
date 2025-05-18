import os

def concat(path:str, number: str ="") -> str:
    """
    Perform an in-order traversal of the given path and recursively concatenate all markdown files in source_dir and return the string.

    If the path argument is a directory, then the function will recursively call itself on all files in the directory. The number argument
    is used to keep track of the current directory number. The function will return the concatenated string of all files in the directory.

    Add a header to each file. Every directory and md file name name starts with a number. The header is
    all of the directory numbers concatenated together followed by the md file number then the md file name without the extension.
    """

    if os.path.isdir(path):
        files = os.listdir(path)
        files = sorted(files)
        output = ""
        for file in files:
            file_path = os.path.join(path, file)
            if os.path.isdir(file_path):
                if number != "":
                    output += concat(file_path, number + "." + file[:2])
                else:
                    output += concat(file_path, file[:2])
            else:
                if number != "":
                    output += concat(file_path, number)
                else:
                    output += concat(file_path, "")
        return output

    elif path.endswith(".md"):
        with open(path, "r") as f:
            output = f.read()
            header = f"{number}.{path.split('/')[-1].split('.')[0]}"
            return f"\n\n# {header}\n\n{output}"

    else:
        return ""

output = concat("lodge_spec")

print(output)

with open("lodge_spec.md", "w") as f:
   f.write(output)


