import React from "react";
import { Routes, Route, Navigate, useLocation } from "react-router-dom";
import Step1 from "./pages/Step1.jsx";
import Step2 from "./pages/Step2.jsx";
import Review from "./pages/Review.jsx";
import Applying from "./pages/Applying.jsx";

function stepFromPath(pathname) {
  if (pathname.startsWith("/step/1")) return 1;
  if (pathname.startsWith("/step/2")) return 2;
  if (pathname.startsWith("/review")) return 5;
  return null;
}

export default function App() {
  const loc = useLocation();
  const step = stepFromPath(loc.pathname);

  return (
    <div className="container">
      <div className="topbar">
        <div className="brand">
          <h1>ExtendFi</h1>
        </div>
        {step && <div className="badge">Step {Math.min(step, 2)} / 2</div>}
      </div>

      <Routes>
        <Route path="/" element={<Navigate to="/step/1" replace />} />
        <Route path="/step/1" element={<Step1 />} />
        <Route path="/step/2" element={<Step2 />} />
        <Route path="/review" element={<Review />} />
        <Route path="/applying" element={<Applying />} />
        <Route path="*" element={<div className="card"><div className="cardBody">Not found</div></div>} />
      </Routes>
    </div>
  );
}
