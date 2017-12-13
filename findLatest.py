path = r'C:\Program Files (x86)\Lunas\sodlab01\Results\athenaSuite'

print path

setupPath = r'C:\Program Files (x86)\Lunas\sodlab01\Results\athenaSuite'
def getLatestModified(resultsPath = ''):
    import os
    dirsInPath = []
    for d in os.listdir(resultsPath):
        if os.path.isdir(resultsPath + '\\' + d):
            dirsInPath.append(resultsPath + '\\' + d)
            print d
    latestDir = max(dirsInPath, key=os.path.getmtime)
    return latestDir

print getLatestModified(setupPath)