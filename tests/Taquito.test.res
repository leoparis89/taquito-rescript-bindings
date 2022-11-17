open Test

test("test", () => {
    assertion((a, b) => a === b, 1, 1, ~message="One equals one")
})