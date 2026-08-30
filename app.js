let patients =
  JSON.parse(localStorage.getItem("fisioia_patients")) || [];

let anamneses =
  JSON.parse(localStorage.getItem("fisioia_anamneses")) || [];

let evolutions =
  JSON.parse(localStorage.getItem("fisioia_evolutions")) || [];

let aiRecords =
  JSON.parse(localStorage.getItem("fisioia_ai_records")) || [];

document.addEventListener("DOMContentLoaded", () => {

  document.querySelectorAll(".nav-btn").forEach(button => {
    button.addEventListener("click", () => {
      showPage(button.dataset.page);
    });
  });

  updateDashboard();
  renderPatients();
  populatePatientSelects();

});


/* =========================================================
   NAVEGAÇÃO
========================================================= */

function showPage(page) {

  document.querySelectorAll(".page")
    .forEach(p => p.classList.remove("active"));

  const selectedPage = document.getElementById(page);

  if (selectedPage) {
    selectedPage.classList.add("active");
  }

  document.querySelectorAll(".nav-btn")
    .forEach(btn => {

      btn.classList.toggle(
        "active",
        btn.dataset.page === page
      );

    });

  window.scrollTo({
    top: 0,
    behavior: "smooth"
  });

}


/* =========================================================
   PACIENTES
========================================================= */

function openPatientModal() {

  document
    .getElementById("patientModal")
    .classList.add("open");

}


function closePatientModal() {

  document
    .getElementById("patientModal")
    .classList.remove("open");

}


function createPatient() {

  const name =
    document.getElementById("newPatientName").value.trim();

  const birth =
    document.getElementById("newPatientBirth").value;

  const phone =
    document.getElementById("newPatientPhone").value.trim();

  const complaint =
    document.getElementById("newPatientComplaint").value.trim();


  if (!name) {

    alert("Informe o nome do paciente.");

    return;

  }


  const patient = {

    id: Date.now(),

    name,

    birth,

    phone,

    complaint,

    createdAt: new Date().toISOString()

  };


  patients.unshift(patient);

  saveData();

  document.getElementById("newPatientName").value = "";
  document.getElementById("newPatientBirth").value = "";
  document.getElementById("newPatientPhone").value = "";
  document.getElementById("newPatientComplaint").value = "";

  closePatientModal();

  updateDashboard();
  renderPatients();
  populatePatientSelects();

}


function renderPatients() {

  const container =
    document.getElementById("patientsList");

  if (!container) return;

  const search =
    document
      .getElementById("patientSearch")
      ?.value
      .toLowerCase() || "";


  const filtered =
    patients.filter(patient =>
      patient.name.toLowerCase().includes(search)
    );


  if (!filtered.length) {

    container.innerHTML = `
      <div class="empty-state">
        <p>Nenhum paciente encontrado.</p>
      </div>
    `;

    return;

  }


  container.innerHTML =
    filtered.map(patient => `

      <div class="patient-row">

        <div class="patient-info">

          <div class="patient-avatar">
            ${getInitials(patient.name)}
          </div>

          <div>

            <div class="patient-name">
              ${escapeHTML(patient.name)}
            </div>

            <div class="patient-sub">
              ${escapeHTML(
                patient.complaint ||
                "Sem queixa registrada"
              )}
            </div>

          </div>

        </div>

        <button
          class="text-btn"
          onclick="selectPatient(${patient.id})"
        >
          Abrir
        </button>

      </div>

    `).join("");

}


function selectPatient(id) {

  const patient =
    patients.find(p => p.id === id);

  if (!patient) return;


  const anamnesisSelect =
    document.getElementById("anamnesisPatient");

  const evolutionSelect =
    document.getElementById("evolutionPatient");


  if (anamnesisSelect) {
    anamnesisSelect.value = patient.id;
  }

  if (evolutionSelect) {
    evolutionSelect.value = patient.id;
  }


  showPage("anamnesis");

}


/* =========================================================
   DASHBOARD
========================================================= */

function updateDashboard() {

  const patientCount =
    document.getElementById("patientCount");

  const sessionCount =
    document.getElementById("sessionCount");

  const aiCount =
    document.getElementById("aiCount");


  if (patientCount) {
    patientCount.textContent = patients.length;
  }

  if (sessionCount) {
    sessionCount.textContent = evolutions.length;
  }

  if (aiCount) {
    aiCount.textContent = aiRecords.length;
  }


  const recent =
    document.getElementById("recentPatients");

  if (!recent) return;


  if (!patients.length) {

    recent.innerHTML = `
      <div class="empty-state">
        <p>Cadastre seu primeiro paciente.</p>
      </div>
    `;

    return;

  }


  recent.innerHTML =
    patients.slice(0, 5).map(patient => `

      <div class="patient-row">

        <div class="patient-info">

          <div class="patient-avatar">
            ${getInitials(patient.name)}
          </div>

          <div>

            <div class="patient-name">
              ${escapeHTML(patient.name)}
            </div>

            <div class="patient-sub">
              ${escapeHTML(
                patient.complaint || "Paciente"
              )}
            </div>

          </div>

        </div>

      </div>

    `).join("");

}


/* =========================================================
   SELECTS DE PACIENTES
========================================================= */

function populatePatientSelects() {

  const selects = [
    document.getElementById("anamnesisPatient"),
    document.getElementById("evolutionPatient")
  ];


  selects.forEach(select => {

    if (!select) return;


    const currentValue = select.value;

    select.innerHTML =
      `<option value="">Selecione o paciente</option>`;


    patients.forEach(patient => {

      const option =
        document.createElement("option");

      option.value = patient.id;

      option.textContent = patient.name;

      select.appendChild(option);

    });


    select.value = currentValue;

  });

}


/* =========================================================
   RECONHECIMENTO DE VOZ — ANAMNESE
========================================================= */

let recognition = null;


function startVoiceRecognition() {

  const SpeechRecognition =
    window.SpeechRecognition ||
    window.webkitSpeechRecognition;


  if (!SpeechRecognition) {

    alert(
      "Seu navegador não suporta reconhecimento de voz. " +
      "Experimente usar Google Chrome ou Microsoft Edge."
    );

    return;

  }


  if (recognition) {

    recognition.stop();

    return;

  }


  recognition =
    new SpeechRecognition();

  recognition.lang = "pt-BR";

  recognition.continuous = true;

  recognition.interimResults = true;


  const button =
    document.getElementById("voiceButton");

  const status =
    document.getElementById("voiceStatus");

  const textarea =
    document.getElementById("voiceText");


  recognition.onstart = () => {

    if (button) {
      button.classList.add("recording");
    }

    if (status) {
      status.textContent =
        "🔴 Gravando... fale normalmente.";
    }

  };


  recognition.onresult = event => {

    let finalText = "";

    for (
      let i = event.resultIndex;
      i < event.results.length;
      i++
    ) {

      finalText +=
        event.results[i][0].transcript;

    }


    if (textarea) {
      textarea.value +=
        finalText + " ";
    }

  };


  recognition.onerror = () => {

    if (status) {
      status.textContent =
        "Não foi possível reconhecer a fala.";
    }

  };


  recognition.onend = () => {

    if (button) {
      button.classList.remove("recording");
    }

    if (status) {
      status.textContent =
        "Clique novamente para continuar.";
    }

    recognition = null;

  };


  recognition.start();

}


/* =========================================================
   IA — ANAMNESE
========================================================= */

function processWithAI() {

  const patientId =
    document.getElementById("anamnesisPatient").value;

  const text =
    document.getElementById("voiceText").value.trim();


  if (!patientId) {

    alert("Selecione um paciente.");

    return;

  }


  if (!text) {

    alert("Digite ou grave o relato clínico.");

    return;

  }


  const patient =
    patients.find(p => p.id == patientId);


  if (!patient) {

    alert("Paciente não encontrado.");

    return;

  }


  const result =
    generateClinicalStructure(
      patient,
      text
    );


  const resultBox =
    document.getElementById("aiResult");

  if (resultBox) {
    resultBox.innerHTML = result;
  }


  const saveButton =
    document.getElementById("saveAnamnesis");

  if (saveButton) {
    saveButton.classList.remove("hidden");
  }


  window.currentAnamnesis = {

    patientId: Number(patientId),

    originalText: text,

    result

  };

}


function generateClinicalStructure(patient, text) {

  /*
    Esta é uma demonstração local.

    Para utilizar uma IA real, posteriormente você poderá
    conectar esta função a uma API de inteligência artificial.
  */


  const complaint =
    patient.complaint || "Não informado";


  return `

    <h3>Identificação</h3>

    <p>
      <strong>Paciente:</strong>
      ${escapeHTML(patient.name)}
    </p>


    <h3>Queixa principal</h3>

    <p>
      ${escapeHTML(complaint)}
    </p>


    <h3>Relato da anamnese</h3>

    <p>
      ${escapeHTML(text)}
    </p>


    <h3>Observações clínicas</h3>

    <p>
      Informações extraídas do relato devem ser
      revisadas pelo profissional antes do salvamento.
    </p>


    <h3>Plano / próximos passos</h3>

    <p>
      Avaliar achados clínicos, definir objetivos
      terapêuticos e registrar conduta conforme
      avaliação profissional.
    </p>

  `;

}


function saveAnamnesis() {

  if (!window.currentAnamnesis) return;


  anamneses.push({

    id: Date.now(),

    ...window.currentAnamnesis,

    createdAt: new Date().toISOString()

  });


  aiRecords.push({

    id: Date.now(),

    type: "anamnese",

    createdAt: new Date().toISOString()

  });


  saveData();

  alert("Anamnese salva com sucesso.");


  const voiceText =
    document.getElementById("voiceText");

  if (voiceText) {
    voiceText.value = "";
  }


  const aiResult =
    document.getElementById("aiResult");

  if (aiResult) {

    aiResult.innerHTML = `

      <div class="empty-state">

        <span>✓</span>

        <p>Anamnese salva no prontuário.</p>

      </div>

    `;

  }


  const saveButton =
    document.getElementById("saveAnamnesis");

  if (saveButton) {
    saveButton.classList.add("hidden");
  }


  window.currentAnamnesis = null;

  updateDashboard();

}


/* =========================================================
   EVOLUÇÃO — VOZ
========================================================= */

function startEvolutionVoice() {

  const SpeechRecognition =
    window.SpeechRecognition ||
    window.webkitSpeechRecognition;


  if (!SpeechRecognition) {

    alert(
      "Seu navegador não suporta reconhecimento de voz."
    );

    return;

  }


  const recognition =
    new SpeechRecognition();


  recognition.lang = "pt-BR";

  recognition.continuous = false;

  recognition.interimResults = false;


  recognition.onstart = () => {

    alert(
      "Fale agora. A gravação será encerrada ao terminar."
    );

  };


  recognition.onresult = event => {

    const text =
      event.results[0][0].transcript;


    const textarea =
      document.getElementById("evolutionText");


    if (textarea) {
      textarea.value += text + " ";
    }

  };


  recognition.start();

}


/* =========================================================
   GERAR EVOLUÇÃO
========================================================= */

function generateEvolution() {

  const patientId =
    document.getElementById("evolutionPatient").value;

  const text =
    document
      .getElementById("evolutionText")
      .value
      .trim();

  const conduct =
    document
      .getElementById("conduct")
      .value
      .trim();


  if (!patientId) {

    alert("Selecione um paciente.");

    return;

  }


  if (!text) {

    alert("Informe o relato da sessão.");

    return;

  }


  const patient =
    patients.find(p => p.id == patientId);


  if (!patient) {

    alert("Paciente não encontrado.");

    return;

  }


  const result = `

    <h3>Paciente</h3>

    <p>
      ${escapeHTML(patient.name)}
    </p>


    <h3>Evolução</h3>

    <p>
      ${escapeHTML(text)}
    </p>


    <h3>Conduta realizada</h3>

    <p>
      ${escapeHTML(
        conduct || "Não informado"
      )}
    </p>


    <h3>Plano</h3>

    <p>
      Manter acompanhamento fisioterapêutico e
      reavaliar resposta clínica na próxima sessão.
    </p>

  `;


  const resultBox =
    document.getElementById("evolutionResult");


  if (resultBox) {

    resultBox.innerHTML = result;

    resultBox.classList.remove("hidden");

  }


  const saveButton =
    document.getElementById("saveEvolution");


  if (saveButton) {
    saveButton.classList.remove("hidden");
  }


  window.currentEvolution = {

    patientId: Number(patientId),

    originalText: text,

    conduct,

    result

  };

}


/* =========================================================
   SALVAR EVOLUÇÃO
========================================================= */

function saveEvolution() {

  if (!window.currentEvolution) return;


  evolutions.push({

    id: Date.now(),

    ...window.currentEvolution,

    createdAt: new Date().toISOString()

  });


  aiRecords.push({

    id: Date.now(),

    type: "evolucao",

    createdAt: new Date().toISOString()

  });


  saveData();

  alert("Evolução salva com sucesso.");


  const evolutionText =
    document.getElementById("evolutionText");

  if (evolutionText) {
    evolutionText.value = "";
  }


  const conduct =
    document.getElementById("conduct");

  if (conduct) {
    conduct.value = "";
  }


  const result =
    document.getElementById("evolutionResult");

  if (result) {
    result.classList.add("hidden");
  }


  const saveButton =
    document.getElementById("saveEvolution");

  if (saveButton) {
    saveButton.classList.add("hidden");
  }


  window.currentEvolution = null;

  updateDashboard();

}


/* =========================================================
   LOCAL STORAGE
========================================================= */

function saveData() {

  localStorage.setItem(
    "fisioia_patients",
    JSON.stringify(patients)
  );


  localStorage.setItem(
    "fisioia_anamneses",
    JSON.stringify(anamneses)
  );


  localStorage.setItem(
    "fisioia_evolutions",
    JSON.stringify(evolutions)
  );


  localStorage.setItem(
    "fisioia_ai_records",
    JSON.stringify(aiRecords)
  );

}


/* =========================================================
   UTILITÁRIOS
========================================================= */

function getInitials(name) {

  if (!name) return "";

  return name
    .split(" ")
    .filter(Boolean)
    .slice(0, 2)
    .map(word => word[0])
    .join("")
    .toUpperCase();

}


function escapeHTML(text) {

  const div =
    document.createElement("div");

  div.textContent = text || "";

  return div.innerHTML;

}
