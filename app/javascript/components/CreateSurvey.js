import React, { useEffect, useState } from 'react'
import { useHistory } from 'react-router-dom';

export default function CreateSurvey() {
  const history = useHistory();

 return (
   <div>
     <button
       type="button"
       className="btn btn-outline-primary"
       onClick={() => history.push('/')}
     >
       Ir al Inicio
     </button>
   </div>
 );
}
