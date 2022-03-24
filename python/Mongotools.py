#!/bin/env python

"""
Mongodb 工具
"""

import pymongo
from sys import argv, stderr


class Options:
    def __init__(self) -> None:
        """
        解析控制台传入参数
        """
        index = 1
        length = len(argv)
        while index < length:
            opt = argv[index]
            if opt.startswith('-'):
                index += 1
                if index == length:
                    raise Exception("No argument found for option", opt)
                value = argv[index]
                if opt == "--source-ip":
                    self.source_ip = value
                elif opt == "--target-ip":
                    self.target_ip = value
                elif opt == "--db":
                    self.db = value
                else:
                    raise Exception("Unknown option:", opt)
                continue
            self.command = opt
            index += 1
        if self.command is None or self.command == '':
            raise Exception("Please specify the command to exceute.")
        pass


def main():
    try:
        # 所有的指令与对应的函数
        commands = {
            "clone": clone
        }

        options = Options()
        func = commands.get(options.command)
        if func is None:
            raise Exception("Unknown command", options.command)
        # 执行函数
        func(options)
    except Exception as e:
        print("\033[31m", e.args, "\033[0m", file=stderr)
    pass


def clone(options: Options):
    """
    克隆数据库
    """
    print("\033[33mStart cloning the database, before the end of the database cloning, make sure that no other machine is operating the database.\033[0m")
    raise Exception("Operarion not currently supported.")
    pass


if __name__ == "__main__":
    main()
