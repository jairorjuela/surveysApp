import React, { useEffect, useState } from 'react'
import { BrowserRouter as Router, Switch, Route, Link } from 'react-router-dom';
import axios from 'axios'
import UserSurveys from './UserSurveys'

export default function HomeSurvey() {
  const [surveys, setSurveys] = useState({});
  const [load, setLoad] = useState(false);
  const [error, setError] = useState('');
  const user = localStorage.getItem('user')
  const params = {params: {'type': 'user', 'user': user }}

  useEffect(() => {
    axios.get("/api/v1/surveys", params)
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
      <UserSurveys error={error} surveys={surveys}/>
    );
  } else {
    return (
      <div>
        Cargando información....
      </div>
    );
  }
}
