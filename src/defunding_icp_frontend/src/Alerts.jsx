// Alert.js
import React, { useState, useEffect } from 'react';
import Snackbar from '@mui/material/Snackbar';
import MuiAlert from '@mui/material/Alert';

function Alert(props) {
  return <MuiAlert elevation={6} variant="filled" {...props} />;
}

export default function CustomizedAlert({ open, onClose, severity, message }) {
  const [openAlert, setOpenAlert] = useState(open);

  useEffect(() => {
    setOpenAlert(open);
    if (open) {
      const timer = setTimeout(() => {
        onClose();
      }, 3000); // Tiempo en milisegundos antes de cerrar automáticamente la alerta
      return () => clearTimeout(timer);
    }
  }, [open, onClose]);

  return (
    <Snackbar open={openAlert} autoHideDuration={null} onClose={onClose}>
        <div><Alert onClose={onClose} severity={severity}>
        {message}
      </Alert></div>      
    </Snackbar>
  );
}
