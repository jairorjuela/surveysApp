import React, { useEffect, useState } from 'react'
import { BrowserRouter as Router, Switch, Route, Link } from 'react-router-dom';

export default function Answers(props) {
 const [apply, setApply] = useState({});

 return (
   <div>
     { props.error
       ? ( <h1>Ocurrió un errror, intente de nuevo</h1> )
       : ( <section> 
             <h1>Encuesta: {props.survey.title}</h1>
             <h5>Propietario: {props.survey.owner}</h5>
             <hr />
             <h3>Preguntas: </h3>
             <ShowQuestions value={props.survey.questions} />
         </section>)
     }
   </div>
 );
}

function ShowQuestions(props) {
  return (
    props.value.map(
      (question, index) =>
        <div key={index}>
        <h4>{question.name}</h4>
        <ShowOptions value={question.options} />
        </div>
    )
  );
}

function ShowOptions(props) {
  return (
    props.value.map(
      (option, index) =>
        <div className="form-check" key={index}>
          <input className="form-check-input" type="radio" name="exampleRadios" id={index}/>
            <label className="form-check-label" htmlFor={index}>
              {option}
            </label>
        </div>
    )
  );
}
