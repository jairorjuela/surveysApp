import React, { useEffect, useState } from 'react'
import { useHistory } from 'react-router-dom';
import axios from 'axios'
import FormAnswer from "./FormAnswer";

export default function Answers(props) {
  const history = useHistory();
  const [load, setLoad] = useState(false);
  const [send, setSend] = useState(false);
  const [error, setError] = useState('');
  const testAnswers = props.survey.questions
  const [apply, setApply] = useState({ id: String(props.surveyId), owner: props.survey.owner})

  const updateAnswers = (option) => {
  console.log("update")
    let selectedOptions = testAnswers

    selectedOptions.forEach(function(element) {
      let getValue = option[`${element.name}`]

      if(element.name === getKeyByValue(option, getValue)){
        element.options = [ getValue ]
      }
    })

    let dateApply = new Date().valueOf()

    setApply({...apply, answers: selectedOptions, date_apply: String(dateApply) })
    setSend(true)
  }

  function getKeyByValue(object, value) {
    return Object.keys(object).find(key => object[key] === value);
  }

  useEffect(() => {
    if(send){
      axios.post("/api/v1/applications", apply)
        .then(response => {
          setLoad(true)
        })
        .catch(error => {
        console.log("error apply", error)
          setError(error.message)
          setLoad(true)
        });
    }
  }, [send])

   if(send) {
    return (
      <div>
        <h1>Se envió la respuesta</h1>
        <button
          type="button"
          className="btn btn-outline-primary"
          onClick={() => history.push('/')}
        >
          Ir al Inicio
        </button>
      </div>
    );
   } else {
     return (
       <div>
         { props.error
           ? ( <div>
               <h1>Ocurrió un error, intente de nuevo</h1>
               <button
                 type="button"
                 className="btn btn-outline-primary"
                 onClick={() => history.push('/')}
               >
                 Ir al Inicio
               </button>
             </div> )
           : ( <div className="col px-md-5">
               <FormAnswer updateOption={updateAnswers} formAnswers={props.survey}/>
             </div>)
         }
       </div>
    )
  }
}
