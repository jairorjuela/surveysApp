import React, { useEffect, useState } from 'react'
import { useForm } from 'react-hook-form';
import { useHistory } from 'react-router-dom';

export default function FormAnswer(props) {
  const history = useHistory()
  const { register, errors, handleSubmit } = useForm()

  const onSubmit = data => {
    if(Object.entries(errors).length === 0){
      props.updateOption(data)
    }
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <div>
       <h1>Encuesta: <span>{props.formAnswers.title}</span></h1> 
       <label>Propietario: {props.formAnswers.owner}</label>
      </div>

      <div>
        {
          props.formAnswers.questions.map((question, index) => {
            return (
              <section key={index}>
                <label key={index}>{question.name}</label>
                <select key={question.name} name={question.name} ref={register({ required: true })}>
                  {question.options.map((option, index) =>
                    <option key={index} value={option}>{option}</option>
                  )}
                </select>
              </section>
            )
          })
        }
      </div>

      <hr />

      <button
        type="button"
        className="btn btn-outline-primary"
        onClick={() => history.push('/')}
      >
        Cancelar
      </button>
      <span> </span>
      <span> </span>
      <button
        type="submit"
        className="btn btn-outline-success"
      >
        Enviar Respuesta
      </button>
    </form>
  );
}
