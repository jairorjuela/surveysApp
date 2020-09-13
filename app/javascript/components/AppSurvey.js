import React from 'react'
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import HomeSurvey from './HomeSurvey'
import OptionsSurvey from './OptionsSurvey'
import CreateSurvey from './CreateSurvey'

export default function AppSurvey() {

  return (
    <Router>
      <main>
        <Switch>
          <Route exact path="/" component={OptionsSurvey} />
          <Route path="/surveys" exact component={HomeSurvey} />
          <Route path="/createSurvey" exact component={CreateSurvey} />
        </Switch>
      </main>
    </Router>
  );
}
