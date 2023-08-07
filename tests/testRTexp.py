# -*- coding: utf-8 -*-

"""
Real time export simulation

__________________________________________________________________________
Copyright (C) 2016-2021 OpenNFT.org

Written by Artem Nikonorov, Yury Koush
"""


import shutil
from time import sleep
from pathlib import Path

delete_files = True

mask = "001_000008_000"
# fns = [1, 2, 3, 4, 6, 5, 7, 8]
fns = None

testCase = 'PSC'

if testCase == 'PSC':
    srcpath = '####TESTPATH####/Run_1_src'
    dstpath = '####TESTPATH####/Run_1'
    pause_in_sec = .5

elif testCase == 'SVM':
    srcpath = '####TESTPATH####/Run_1_src'
    dstpath = '####TESTPATH####/Run_1'
    pause_in_sec = 1

elif testCase == 'DCM':
    srcpath = '####TESTPATH####/Run_1_src'
    dstpath = '####TESTPATH####/Run_1'
    pause_in_sec = 1

elif testCase == 'REST':
    srcpath = '/Users/ak4379/Documents/OpenNFT/OpenNFT_DemoData_gradCPT/rtQA_REST/RS_Run_1_src'
    dstpath = '/Users/ak4379/Documents/OpenNFT/OpenNFT_DemoData_gradCPT/rtQA_REST/RS_Run_1'
    pause_in_sec = 1.97

elif testCase == 'TASK':
    srcpath = '/Users/ak4379/Documents/OpenNFT/OpenNFT_DemoData_gradCPT/rtQA_TASK/TASK_Run_1_src'
    dstpath = '/Users/ak4379/Documents/OpenNFT/OpenNFT_DemoData_gradCPT/rtQA_TASK/TASK_Run_1'
    pause_in_sec = 1.97

if delete_files:
    files = Path(dstpath)
    for f in files.glob('*'):
        f.unlink()


if fns is None:
    filelist = Path(srcpath).iterdir()
else:
    filelist = []
    for fn in fns:
        fname = "{0}{1:03d}.dcm".format(mask, fn)
        filelist.append(fname)

for filename in sorted(filelist):
    src = filename
    if Path.is_file(src) and (not str(filename).startswith(".")):
        dst = Path(dstpath, filename.name)
        shutil.copy(src, dst)
        print(filename)
        sleep(pause_in_sec)  # seconds
