#!/bin/python
from urllib.parse import urlparse, unquote, parse_qs
from argparse import ArgumentParser


def main():
    parser = ArgumentParser(description="format url.")
    parser.add_argument("url", type=str, help="url")
    args = parser.parse_args()

    url_format(args.url)
    pass


def url_format(url: str):
    url = unquote(url)
    print("url:", url)
    url_parse = urlparse(url)
    print("Scheme:", url_parse.scheme)
    print("Host:", url_parse.netloc)
    print("Path:", url_parse.path)
    print("Query:")

    if url_parse.query != "":
        query: dict = parse_qs(url_parse.query)
        max_key_len = 0
        for key in query.keys():
           if max_key_len < len(key):
               max_key_len = len(key)

        str_format = "{:" + str(max_key_len) + "s} = {}"
        for key in query.keys():
            values = query[key]
            for value in values:
               print(str_format.format(key, value))
    pass


if __name__ == "__main__":
    main()
