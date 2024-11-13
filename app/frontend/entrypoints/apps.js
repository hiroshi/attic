// https://github.com/ElMassimo/vite_ruby/blob/cfdb0bed7e365787622d66b3e90097a9c54dca70/examples/rails/app/frontend/entrypoints/example_import.js
import React from "react";
import { createRoot } from "react-dom/client";
import AppFields from "~/components/AppFields";

const root = createRoot(document.getElementById("react-root"));
root.render(React.createElement(AppFields));
