import React, { useEffect, useState } from 'react'
import axios from 'axios'
import Answers from './Answers'

export default function Application(props) {
  const [survey, setSurvey] = useState({});
  const [load, setLoad] = useState(false);
  const [error, setError] = useState('');

  useEffect(() => {
    axios.get(`/api/v1/applications/${props.surveyToFill.surveyId}`)
      .then(response => {
        console.log("pss", response.data);
        setSurvey(response.data)
        setLoad(true)
      })
      .catch(error => {
        console.log("ERRER", error);
        setError(error.message)
        setLoad(true)
      });
  }, [])

  if (load) {
    return (
      <Answers error={error} survey={survey} surveyId={props.surveyToFill.surveyId} />
    );
  } else {
    return (
      <div>
        Cargando información....
      </div>
    );
  }
}
