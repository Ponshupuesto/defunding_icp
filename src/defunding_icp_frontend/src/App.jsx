// App.js

import { useState } from 'react';
import Login from './Login'; // Importa el componente de inicio de sesión
import Greeting from './Greeting'; // Importa el componente de saludo

function App() {
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const [actor, setActor] = useState(null);

  const handleLoginSuccess = (actorInstance) => {
    setActor(actorInstance);
    setIsLoggedIn(true);
  };

  return (
    <main>
      <img src="/logo2.svg" alt="DFINITY logo" />
      <br />
      <br />
      {isLoggedIn ? (
        <Greeting actor={actor} />
      ) : (
        <Login onLoginSuccess={handleLoginSuccess} />
      )}
    </main>
  );
}

export default App;
