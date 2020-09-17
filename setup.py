import setuptools

setuptools.setup(
    name="jupyter-xpra-nginx-proxy",
    version='1.0dev',
    url="https://github.com/evanlinde/jupyter-xpra-nginx-proxy",
    author="Evan Linde",
    description="Jupyter extension to proxy xpra via nginx",
    packages=setuptools.find_packages(),
	keywords=['Jupyter'],
	classifiers=['Framework :: Jupyter'],
    install_requires=[
        'jupyter-server-proxy'
    ],
    entry_points={
        'jupyter_serverproxy_servers': [
            'xpra = jupyter_xpra_nginx_proxy:setup_xpra',
        ]
    },
    package_data={
        'jupyter_xpra_nginx_proxy': ['icons/xpra.svg'],
    },
)
