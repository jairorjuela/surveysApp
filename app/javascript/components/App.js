import React, { useEffect, useState } from 'react'
import { Switch, Route, Link } from 'react-router-dom';
import Home from './Home'

export default function App() {
  return (
    <main>
      <Switch>
        <Route path="/" component={Home} exact />
      </Switch>
    </main>
  );
}
