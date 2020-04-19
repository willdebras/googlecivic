
# {googlecivic}

{googlecivic} is an R package designed to interface with the Google
Civic Information API. In order to use this R package you will need to
have a project under a Google Cloud Platform account and will need to
create an API key for that project. Log in or create an account for
[Google Cloud Platform](https://console.developers.google.com/apis).
Click on the dropdown in the console in the top left, then create a new
project:

<img src="./images/project.png" width="100%" />

Next, enable APIs and services on the project:

<img src="./images/enable.png" width="100%" />

Then, search for the google civic API and enable
it:

<img src="./images/search.png" width="100%" /><img src="./images/add.png" width="100%" />

Create a key for the Google Civic API:

<img src="./images/cred.png" width="100%" />

Once you have this API key you can save it somewhere safe and supply it
to functions in this R package.

The Google Civic Information API offers several APIs to get information
on election information, polling places, and political geographies of
representatives. This package current just has a function to interface
with the voter information endpoint, but functions will be added in the
future to use the full API.

## Installation

You can install the released version of googlecivic from
[Github](https://github.com/willdebras/googlecivic) with:

``` r
library(remotes)
install_github("willdebras/googlecivic")
```

## API keys

The functions for each of the three APIs have a `key` argument that
defaults to an object called `google_civic_api`. We can use the function
argument to manually include the key, such as:

`get_voterinfo(address = "55 e monroe, chicago, il", key =
xxxxxxxxxxxxx)`

Alternatively, we can assign the key to an object called
`google_civic_api` and leave the `key` argument blank, such as:

`google_civic_api <- xxxxxxxxxxxxx`

The best method to store this key though is probably to set it to an
environment variable and call it later, such as:

``` r

Sys.setenv(google_civic_api="xxxxxxxxxxxxx")

get_voterinfo(address = "55 e monroe, chicago, il", key = Sys.getenv("google_civic_api"))
```

You can also use a `.Renviron` file to have R automatically set the
environment variable at startup. The package `usethis` can be handy for
this.

``` r
usethis::edit_r_environ()
```

This will open a .Renviron file for you. Add a line like this, but
substitute your API key:

`google_civic_api="xxxxxxxxxxxxx"`

Save the file then restart your R
session

``` r
get_voterinfo(address = "55 e monroe, chicago, il", key = Sys.getenv("google_civic_api"))
```

## Voter Information API

The voter information API produces a list of voter information related
to a single address or election. The function takes a single argument of
a string for an address and returns a nested list of information related
to elections, polling locations and information, and state information
related to elections.

We can get some basic data about voter information with the
`get_voterinfo()` function. Type `?get_voterinfo` to see an explanation
of each parameter.

``` r

library(googlecivic)

get_voterinfo(address = "55 e monroe, chicago, il", key = Sys.getenv("google_civic_api"))
#> $error
#> $error$errors
#>   domain  reason          message
#> 1 global invalid Election unknown
#> 
#> $error$code
#> [1] 400
#> 
#> $error$message
#> [1] "Election unknown"
```

## Election API

The election API returns a list of election informations as id, name,
date and Open Civic Data Division Identifier(OCDid). We can get these
data with the `get_electionid()` function that receives the API key as
the only argument.

``` r
library(googlecivic)

get_electionid(key = Sys.getenv("google_civic_api"))
```

## Representatives Information by Address API

The representatives by address API retrieves information about
divisions, offices and officials’ information related to an address. The
`get_rep_address()` function takes an address, an office level and role
as arguments. For detailed explanation of the each parameter type
`?get_rep_voter`.

``` r
get_rep_address(address = "55 e monroe, chicago,il", level="regional", role="schoolBoard", key = Sys.getenv("google_civic_api"))
```

## Representatives Information by Division API

This API returns a list of offices by divisions and respective
officials. The `get_rep_by_division()` function takes an OCD identifier
office levels and roles as parameters. The OCDid can be retrieved from
the `get_electionid()` function. For detailed explanation about it type
`?get_rep_by_division`.

``` r
get_rep_by_division(ocdId = "ocd-division/country:us/district:dc",level="locality",recursive = TRUE)
```

### API documentation

While the {googlecivic} package has documentation in the help files, it
can be useful to see an explanation of each endpoint and each parameter
in the functions. The [Google Civic Information API developer
page](https://developers.google.com/civic-information/docs/v2) contains
reference to all of these endpoints and parameters and additional
documentation of running individual queries outside of the context of
this package.

## Issues

If you have an issue, feature suggestion, or question regarding use,
feel free to open an issue here on github or tweet at me
@[\_willdebras](https://twitter.com/_willdebras).
