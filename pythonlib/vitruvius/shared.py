class ProcFile:
    def __init__(self, fname):
        self._fo = open(fname, 'r')

    def read(self):
        self._fo.seek(0)
        return self._fo.read()

