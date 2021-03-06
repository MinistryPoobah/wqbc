# Copyright 2016 Province of British Columbia
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.

context("test-trends")

test_that("test_trends", {
  trend1 <- test_trends(wqbc::yuepilon)
  # test output structure
  expect_identical(nrow(trend1), 4L)
  expect_identical(ncol(trend1), 9L)
  expect_is(trend1$slope, "numeric")
  expect_is(trend1$Month, "character")
  # test values
  expect_equal(trend1$slope[1], 0.01350760, tolerance = 10^-5)
  # test breaks
  trend2 <- test_trends(wqbc::yuepilon, breaks = c(1,4,12))
  expect_identical(nrow(trend2), 4L * 3L)
  expect_identical(ncol(trend2), 9L)
  expect_identical(sum(is.na(trend2$slope)), 4L * 2L)
  expect_lt(abs(trend1$slope[1] - trend2$slope[1]), 1e-6)
})

test_that("test_trends provides useful error messages", {
  expect_error(test_trends(wqbc::dummy), "data column names must include 'Station', 'Date', 'Variable', 'Value' and 'Units'")
})
