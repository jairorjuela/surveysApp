import React from 'react'
import ReactDOM from 'react-dom'
import { BrowserRouter as Router, Switch, Route, Link } from 'react-router-dom';
import AppSurvey from '../components/AppSurvey'

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Router>
      <AppSurvey />
    </Router>,
    document.body.appendChild(document.createElement('div')),
  )
})
