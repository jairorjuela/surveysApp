import React, { useEffect, useState } from 'react'
import { BrowserRouter as Router, Route, Link, Switch } from "react-router-dom";
import Home from './Home'
import Options from './Options'

export default function App() {

  return (
    <Router>
      <main>
        <Switch>
          <Route exact path="/" component={Options} />
          <Route path="/surveys" exact component={Home} />
        </Switch>
      </main>
    </Router>
  );
}
