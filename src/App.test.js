import { render, screen } from "@testing-library/react";
import App from "./App";

test("renders learn react link", () => {
  render(<App />);
  const linkElement = screen.getByText(/h/i);
  expect(linkElement).toBeInTheDocument();
});

test("sum", () => {
  expect(1 + 2).toBe(3);
});
