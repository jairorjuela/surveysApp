import React, { useEffect, useState } from 'react'
import { useHistory } from "react-router-dom";
import Home from './Home'

export default function Options() {
const history = useHistory();

  return (
  <div className="col px-md-5">
    <button
      type="button"
      className="btn btn-outline-primary"
      onClick={() => history.push('/surveys')}
    >
      Responder Encuestas
    </button>
  </div>
  );
}
