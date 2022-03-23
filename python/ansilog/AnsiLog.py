"""
输出彩色日志

@author aszswaz
@date 2022-03-23
"""

from sys import stderr


def info(*args):
    if len(args) == 0:
        return
    stderr.write("\033[92m")
    for item in args:
        if isinstance(item, str) and item != "\n":
            stderr.write(item)
        else:
            stderr.write(str(item))
    stderr.write("\033[0m")
    print('', file=stderr)


def warn(*args):
    if len(args) == 0:
        return
    stderr.write("\033[33m")
    for item in args:
        if isinstance(item, str) and item != "\n":
            stderr.write(item)
        else:
            stderr.write(str(item))
    stderr.write("\033[0m")
    print('', file=stderr)


def error(*args):
    if len(args) == 0:
        return
    stderr.write("\033[31m")
    for item in args:
        if isinstance(item, str) and item != "\n":
            stderr.write(item)
        else:
            stderr.write(str(item))
    stderr.write("\033[0m")
    print('', file=stderr)
