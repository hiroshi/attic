import { useState, useEffect } from "react";
// import reactLogo from "./assets/react.svg";
// import viteLogo from "/vite.svg";
// import "./App.css";

function App() {
  const [currentUser, setCurrentUser] = useState();

  useEffect(() => {
    try {
      (async () => {
        const resp = await fetch(
          "https://attic.lvh.me:3011/api/v0/current_user",
          {
            headers: {
              Authorization: "bearer XXX",
            },
            credentials: "include",
          },
        );
        if (resp.ok) {
          const data = await resp.json();
          console.log(data);
          setCurrentUser(data);
        }
      })();
    } catch (error) {
      console.error(error);
    }
  }, []);

  return (
    <>
      <div>
        {currentUser ? (
          <p>Logged in as: {currentUser.email}</p>
        ) : (
          <a href="https://attic.lvh.me:3011/login">login</a>
        )}
      </div>
      <hr />
      <div></div>
    </>
  );
}

export default App;
