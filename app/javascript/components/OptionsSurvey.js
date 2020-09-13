import React, { useEffect, useState } from 'react'
import { useHistory } from "react-router-dom";
import HomeSurvey from './HomeSurvey'

export default function OptionsSurvey() {

  const history = useHistory();

  return (
  <div className="col px-md-5">
    <button
      type="button"
      className="btn btn-outline-primary"
      onClick={() => history.push('/surveys')}
    >
      Ver mis encuestas
    </button>
    <span> </span>
    <button
      type="button"
      className="btn btn-outline-primary"
      onClick={() => history.push('createSurvey')}
    >
      Crear Encuesta
    </button>
  </div>
  );
}
