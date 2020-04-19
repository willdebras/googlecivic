httptest::with_mock_api({
  test_that("get_electionid works", {
    out <- get_electionid(key = "fake key")

    expect_identical(names(out), c("kind", "elections"))
    expect_identical(out$kind, "civicinfo#electionsQueryResponse")
    expect_is(out$elections$electionDay, "character")
  })

  test_that("get_electionid works", {
    # fixture: elections-f8233b.json
    out <- get_electionid(key = "new fake key")

    expect_identical(names(out), c("kind", "elections"))
    expect_identical(out$kind, "some other thing")
    expect_is(out$elections$electionDay, "integer")
  })
})

