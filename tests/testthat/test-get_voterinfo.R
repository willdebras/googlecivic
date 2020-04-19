context("get_voterinfo()")

with_mock_api({
  test_that("get_voterinfo() gets voter info", {
    voterinfo <- get_voterinfo(
      address = "1600 Pennsylvania Ave NW, Washington DC 20500",
      key = "fake key"
    )

    expect_equal(voterinfo$kind, "civicinfo#voterInfoResponse")
    expect_named(
      voterinfo,
      c("kind", "election", "normalizedInput", "pollingLocations",
        "earlyVoteSites", "contests", "state")
    )
    expect_equal(
      voterinfo$pollingLocations$address$locationName,
      "THE SCHOOL WITHOUT WALLS"
    )
  })
})

