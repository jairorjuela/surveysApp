import React, { useEffect, useState } from 'react'
import axios from 'axios'
import { Redirect, useHistory } from 'react-router-dom';

export default function UserSurveys(props) {
 const history = useHistory();
 const [destroy, setDestroy] = useState(false);
 const [redirect, setRedirect] = useState(false);
 const [error, setError] = useState('');
 const [selectedSurvey, setSelectedSurvey] = useState(0)

 const handleClick = id => {
   setSelectedSurvey(id)
   setDestroy(true)
 }

 useEffect(() => {
   if(destroy){
     axios.delete(`/api/v1/surveys/${selectedSurvey}`)
       .then(response => {
         setRedirect(true)
       })
       .catch(error => {
         setRedirect(true)
         setError(error.message)
       });
   }
 }, [destroy])

 if(redirect){
   return <Redirect to="/"/>
 }else{
   return (
     <div>
       <ul>
         { props.error 
           ? <li>{error.message}</li>
           : props.surveys.map(
             (survey, index) => 
               <li key={index}>
                 {survey.name}
                 <span> </span>
                 <button type="button" className="btn btn-outline-info" onClick={() => handleClick(survey.id)}>
                   Eliminar Encuesta
                 </button>
               </li>
           )
         }
         <button
           type="button"
           className="btn btn-outline-primary"
           onClick={() => history.push('/')}
         >
           Ir al Inicio
         </button>
       </ul>)
     </div>
   );
}
}
