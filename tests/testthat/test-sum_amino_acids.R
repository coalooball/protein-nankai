test_that("TEST sum_amino_acids", {
  expect_equal(unname(sum_amino_acids("ACDE")), c(15, 22, 8, 4, 0, 1))
})
