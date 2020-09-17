"""
Return config on servers to start for xpra

See https://jupyter-server-proxy.readthedocs.io/en/latest/server-process.html
for more information.
"""
import os

def setup_xpra():
    def _get_cmd(port):
        return [
            os.path.join(os.path.dirname(os.path.abspath(__file__)), "xpra-nginx.sh"),
            str(port), 
            str(port+1) 
        ]

    return {
        'command': _get_cmd,
        'environment': {},
        'launcher_entry': {
            'title': 'xpra-nginx',
            'icon_path': os.path.join(os.path.dirname(os.path.abspath(__file__)), 'icons', 'xpra.svg')
        }
    }
