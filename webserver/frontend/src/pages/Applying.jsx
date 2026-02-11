import React from "react";
import { useNavigate } from "react-router-dom";
import { useWizard } from "../wizard/WizardContext.jsx";

export default function Applying() {
  const nav = useNavigate();
  const { answers } = useWizard();

  const mode = answers?.mode; // or whatever key you store it under

  return (
    <div className="card">
      <div className="cardHeader">
        <div>
          <h2>Settings sent to device!</h2>
          {mode === "gateway" ? (
            <div className="sub">
              You may now close this tab and set up your Extender device.
            </div>
          ) : (
            <div className="sub">
              You may now close this tab and connect your device to the extended
              network <strong>"{answers?.regssid || "—"}_EXT"</strong>.
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
