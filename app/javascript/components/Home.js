import React, { useEffect, useState } from 'react'
import { BrowserRouter as Router, Switch, Route, Link } from 'react-router-dom';
import axios from 'axios'
import Surveys from './Surveys'

export default function Home() {
  const [surveys, setSurveys] = useState({});
  const [load, setLoad] = useState(false);
  const [error, setError] = useState('');

  useEffect(() => {
    axios.get("/api/v1/surveys")
      .then(response => {
        setSurveys(response.data)
        setLoad(true)
      })
      .catch(error => {
        setError(error.message)
        setLoad(true)
      });
  }, [])

  if (load) {
    return (
      <Surveys error={error} surveys={surveys}/>
    );
  } else {
    return (
      <div>
        Cargando información....
      </div>
    );
  }
}
