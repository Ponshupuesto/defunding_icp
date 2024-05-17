// Login.js
import { AuthClient } from "@dfinity/auth-client";
import { HttpAgent } from "@dfinity/agent";
import { createActor } from 'declarations/defunding_icp_backend';
import MyButton from "./Button";
import './Login.css'; // Importa el archivo de estilos CSS para el componente de inicio de sesión



function Login({ onLoginSuccess }) {
  const handleLogin = async () => {
    const authClient = await AuthClient.create({
      // Configura el cliente de autenticación
    });

    await authClient.login({
      identityProvider: process.env.DFX_NETWORK === "ic"
      ? "https://identity.ic0.app"
      : `http://be2us-64aaa-aaaaa-qaabq-cai.localhost:4943`,
      // Realiza el inicio de sesión
      onSuccess: async () => {
        const identity = await authClient.getIdentity();
        const actor = createActor(process.env.CANISTER_ID_DEFUNDING_ICP_BACKEND, {
          agent: new HttpAgent({ identity }),
        });
        onLoginSuccess(actor); // Llama a la función de éxito del inicio de sesión
      }
    });
  };

  return (
    <div className="login-container">
    <MyButton onClick={handleLogin} name = "Login with your Internet Identity"></MyButton>
    </div>
  );
}

export default Login;

