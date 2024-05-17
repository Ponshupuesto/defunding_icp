// Greeting.js

import React, { useState, useEffect } from 'react';
import "./Form.css"
import { createActor } from 'declarations/defunding_icp_backend';
import CustomizedAlert from './Alerts';



function Greeting({actor}) {
  const [openAlert, setOpenAlert] = useState(false);
  const [severity, setSeverity] = useState('success');
  const [message, setMessage] = useState('');

  const handleOpenAlert = (severity, message) => {
    setSeverity(severity);
    setMessage(message);
    setOpenAlert(true);
  };

  const handleCloseAlert = () => {
    setOpenAlert(false);
  };

  const [greeting, setGreeting] = useState('');
  const [formData, setFormData] = useState({
    name: '',
    lastName: '',
    userName: '',
    email: '',
    phone: '', // Mantenemos phone como string
    country: '',
    city: ""
  });

  useEffect(() => {
    const fetchData = async () => {
      if (!actor) return; // Verifica si el actor está inicializado
      const greeting = await actor.whoami2();
      setGreeting(greeting);
    };

    fetchData(); // Llama a la función fetchData cuando el componente se monta
  }, [actor]); // Dependencia: se volverá a ejecutar si cambia el valor de actor


  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!actor) return; // Verifica si el actor está inicializado

    try {
      const addUser = await actor.addUser({
        name: formData.name,
        lastName: formData.lastName,
        userName: formData.userName,
        email: formData.mail,
        profileImage : [],
        phone: formData.phone, // Convertimos phone a un número entero
        country: formData.country,
        city : formData.city
      });
      if(addUser.err){
        handleOpenAlert("error","User Already Exist");
      } else{
        handleOpenAlert("success", "User " + formData.userName + " User was added succesfully! :D");
        //alert('User ' +  formData.userName + ' was added successfully! :D ');
      };
      //handleOpenAlert("success","User was added succesfully! :D" + addUser);
      //alert('User ' +  formData.userName + ' was added successfully! :D ' + addUser);
    } catch (error) {
      alert('Error adding user: ' + error);
    }
  };

  return (
    <>

    
      {greeting && ( // Render the greeting section only if greeting is not empty
        <section id="greeting">
          {"Your Principal is " + greeting}
        </section>
      )}
    
    <form onSubmit={handleSubmit} className="form-container">
  <label className="form-label">
    Name:
    <input type="text" name="name" value={formData.name} onChange={handleChange} className="form-input" required />
  </label>
  <label className="form-label">
    Last Name:
    <input type="text" name="lastName" value={formData.lastName} onChange={handleChange} className="form-input" required />
  </label>
  <label className="form-label">
    Username:
    <input type="text" name="userName" value={formData.userName} onChange={handleChange} className="form-input" />
  </label>
  <label className="form-label">
    Email:
    <input type="email" name="mail" value={formData.mail} onChange={handleChange} className="form-input" required />
  </label>
  <label className="form-label">
    Phone:
    <input type="tel" name="phone" value={formData.phone} onChange={handleChange} className="form-input" required />
  </label>
  <label className="form-label">
    Location:
    <input type="text" name="location" value={formData.location} onChange={handleChange} className="form-input" required />
  </label>
  <button type="submit" className="form-button">Submit</button>
</form>

<div>
  <CustomizedAlert open={openAlert} onClose={handleCloseAlert} severity={severity} message={message} />
</div>


    </>
  );
}

export default Greeting;
