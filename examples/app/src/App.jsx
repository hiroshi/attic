import { useState, useEffect, useRef } from "react";
// import reactLogo from "./assets/react.svg";
// import viteLogo from "/vite.svg";
// import "./App.css";

function Todos() {
  const inputRef = useRef(null);

  const handleSubmit = async (event) => {
    event.preventDefault();
    // console.log(inputRef.current.value);
    const resp = await fetch("https://attic.lvh.me:3011/api/v0/todo/items", {
      method: "POST",
      credentials: "include",
    });
    // console.log(resp);
    // console.log(await resp.text());
  };

  return (
    <form onSubmit={handleSubmit}>
      <input type="text" ref={inputRef} />
      <button>New item</button>
    </form>
  );
}

function App() {
  const [currentUser, setCurrentUser] = useState();

  useEffect(() => {
    try {
      (async () => {
        const resp = await fetch(
          "https://attic.lvh.me:3011/api/v0/current_user",
          {
            // headers: {
            //   Authorization: "bearer XXX",
            // },
            credentials: "include",
          },
        );
        if (resp.ok) {
          const data = await resp.json();
          // console.log(data);
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
          <p>Logged in as: {currentUser.accounts[0].email}</p>
        ) : (
          <a href="https://attic.lvh.me:3011/login">login</a>
        )}
      </div>
      <hr />
      <Todos />
    </>
  );
}

export default App;
