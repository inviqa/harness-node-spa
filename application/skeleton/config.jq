{
    # JSON-like mapping of key to environment variable
    # this is processed at runtime in nginx to provide %CONFIG% replacement
    # in index.html
    # do not put sensitive configuration in
    # e.g.
    "api_url": env.API_URL
}
