import React, { useEffect, useState } from 'react'
import Application from './Application'

export default function Surveys(props) {
 const [apply, setApply] = useState({});

const handleClick = id => {
  setApply({surveyId: id})
};

 return (
   <div>
     { Object.entries(apply).length != 0
       ? ( <Application surveyToFill={apply} /> )
       : ( <ul>
           { props.error 
             ? <li>{error.message}</li>
             : props.surveys.map(
               (survey, index) => 
                 <li key={index}>
                   {survey.name}
                   <span> </span>
                   <button type="button" className="btn btn-outline-info" onClick={() => handleClick(survey.id)}>
                     Responder Encuesta
                   </button>
                 </li>
             )
           }
       </ul>)
     }
   </div>
 );
}
