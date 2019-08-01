from string import Formatter


class ProcFile:
    def __init__(self, fname):
        self._fo = open(fname, 'r')

    def read(self):
        self._fo.seek(0)
        return self._fo.read()


class PrefixSuffixFormatter(Formatter):
    """
    Adds syntax {prefix,property,suffix} syntax
    When property is Falsy, print nothing
    When only one ',' assume {prefix,property}
    When none, behave as normal

    Disables {property!conversion} syntax due to laziness
    Assumes always converting to string
    """
    def get_value(self, key, args, kwargs):
        if isinstance(key, str) and ',' in key:
            self.prefix, key, self.suffix, *_ = key.split(',') + [""] * 3
        else:
            self.prefix, self.suffix = "", ""
        return super().get_value(key, args, kwargs)

    def convert_field(self, value, conversion):
        if value:
            return self.prefix + super().convert_field(value, 's') + self.suffix
        return ""
