<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>FisioIA — Prontuário Inteligente</title>
  <link rel="stylesheet" href="style.css">
</head>

<body>
<aside class="sidebar">
    <div class="logo">
      <div class="logo-icon">✚</div>
      <div>
        <strong>FisioIA</strong>
        <span>Prontuário inteligente</span>
      </div>
    </div>

    <nav>
      <button class="nav-btn active" data-page="dashboard">
        <span>⌂</span> Dashboard
      </button>

      <button class="nav-btn" data-page="patients">
        <span>♙</span> Pacientes
      </button>

      <button class="nav-btn" data-page="anamnesis">
        <span>◉</span> Nova anamnese
      </button>

      <button class="nav-btn" data-page="evolution">
        <span>▣</span> Evolução
      </button>
    </nav>

    <div class="sidebar-bottom">
      <div class="user">
        <div class="avatar">DR</div>
        <div>
          <strong>Fisioterapeuta</strong>
          <span>Profissional</span>
        </div>
      </div>
    </div>
  </aside>

<main class="main">

    <!-- DASHBOARD -->

    <section id="dashboard" class="page active">

      <header class="topbar">
        <div>
          <p class="eyebrow">VISÃO GERAL</p>
          <h1>Bom dia 👋</h1>
          <p class="muted">
            Gerencie seus pacientes e registros clínicos.
          </p>
        </div>

        <button class="primary-btn" onclick="showPage('anamnesis')">
          + Nova anamnese
        </button>
      </header>


      <div class="stats">

        <div class="stat-card">
          <div class="stat-icon blue">♙</div>
          <div>
            <span>Pacientes</span>
            <strong id="patientCount">0</strong>
          </div>
        </div>

        <div class="stat-card">
          <div class="stat-icon green">✓</div>
          <div>
            <span>Sessões registradas</span>
            <strong id="sessionCount">0</strong>
          </div>
        </div>

        <div class="stat-card">
          <div class="stat-icon purple">✦</div>
          <div>
            <span>Registros com IA</span>
            <strong id="aiCount">0</strong>
          </div>
        </div>

      </div>


      <div class="dashboard-grid">

        <div class="card">
          <div class="card-header">
            <div>
              <h2>Pacientes recentes</h2>
              <p>Últimos pacientes cadastrados</p>
            </div>

            <button class="text-btn" onclick="showPage('patients')">
              Ver todos
            </button>
          </div>

          <div id="recentPatients" class="patient-list"></div>
        </div>


        <div class="card ai-card">

          <div class="ai-header">
            <div class="ai-sparkle">✦</div>
            <div>
              <h2>Assistente FisioIA</h2>
              <p>Transforme sua fala em registro clínico.</p>
            </div>
          </div>

          <div class="ai-example">
            <span>🎙️</span>
            <p>
              "Paciente relata dor lombar há duas semanas,
              piora ao permanecer sentado..."
            </p>
          </div>

          <button class="primary-btn full" onclick="showPage('anamnesis')">
            🎙️ Registrar por voz
          </button>

        </div>

      </div>

    </section>


    <!-- PACIENTES -->

    <section id="patients" class="page">

      <header class="topbar">
        <div>
          <p class="eyebrow">PRONTUÁRIO</p>
          <h1>Pacientes</h1>
  <p class="muted">Cadastre e acompanhe seus pacientes.</p>
        </div>

        <button class="primary-btn" onclick="openPatientModal()">
          + Novo paciente
        </button>
      </header>

      <div class="card">

        <div class="search-box">
          🔎
          <input
            id="patientSearch"
            type="text"
            placeholder="Buscar paciente..."
            oninput="renderPatients()"
          >
        </div>

        <div id="patientsList" class="patient-table"></div>

      </div>

    </section>


    <!-- ANAMNESE -->

    <section id="anamnesis" class="page">

      <header class="topbar">
        <div>
          <p class="eyebrow">INTELIGÊNCIA ARTIFICIAL</p>
          <h1>Nova anamnese</h1>
          <p class="muted">
            Fale naturalmente e deixe a IA organizar o registro.
          </p>
        </div>
      </header>


      <div class="clinical-grid">

        <div class="card">

          <label>Paciente</label>

          <select id="anamnesisPatient">
            <option value="">Selecione o paciente</option>
          </select>


          <label>Relato clínico</label>

          <div class="voice-box">

            <textarea
              id="voiceText"
              placeholder="Digite ou fale o relato do paciente..."
            ></textarea>

            <button
              id="voiceButton"
              class="voice-btn"
              onclick="startVoiceRecognition()"
            >
              🎙️
            </button>

          </div>

          <div id="voiceStatus" class="voice-status">
            Clique no microfone para começar.
          </div>


          <button
            class="ai-button"
            onclick="processWithAI()"
          >
            ✦ Organizar com IA
          </button>

        </div>


        <div class="card">

          <div class="card-header">
            <div>
              <h2>Anamnese estruturada</h2>
              <p>Resultado gerado pela IA</p>
            </div>
          </div>

          <div id="aiResult" class="ai-result">

            <div class="empty-state">
              <span>✦</span>
              <p>
O registro estruturado aparecerá aqui.
              </p>
            </div>

          </div>

          <button
            id="saveAnamnesis"
            class="primary-btn full hidden"
            onclick="saveAnamnesis()"
          >
            Salvar no prontuário
          </button>

        </div>

      </div>

    </section>


    <!-- EVOLUÇÃO -->

    <section id="evolution" class="page">

      <header class="topbar">

        <div>
          <p class="eyebrow">SESSÃO</p>
          <h1>Evolução do paciente</h1>
          <p class="muted">
            Registre a evolução de cada atendimento.
          </p>
        </div>

      </header>


      <div class="card evolution-card">

        <label>Paciente</label>

        <select id="evolutionPatient">
          <option value="">Selecione o paciente</option>
        </select>


        <label>Relato da sessão</label>

        <div class="voice-box">

          <textarea
            id="evolutionText"
            placeholder="Ex.: paciente apresentou melhora da dor após exercícios..."
          ></textarea>

          <button
            class="voice-btn"
            onclick="startEvolutionVoice()"
          >
            🎙️
          </button>

        </div>


        <label>Conduta realizada</label>

        <textarea
          id="conduct"
          placeholder="Descreva exercícios, técnicas, orientações..."
        ></textarea>


        <button
          class="ai-button"
          onclick="generateEvolution()"
        >
          ✦ Gerar evolução estruturada
        </button>


        <div id="evolutionResult" class="evolution-result hidden"></div>


        <button
          id="saveEvolution"
          class="primary-btn full hidden"
          onclick="saveEvolution()"
        >
          Salvar evolução
        </button>

      </div>

    </section>

  </main>


  <!-- MODAL PACIENTE -->

  <div id="patientModal" class="modal">

    <div class="modal-content">

      <button class="close" onclick="closePatientModal()">×</button>

      <h2>Novo paciente</h2>
      <p class="muted">Cadastre as informações básicas.</p>

      <label>Nome completo</label>
      <input id="newPatientName" placeholder="Nome do paciente">

      <label>Data de nascimento</label>
      <input id="newPatientBirth" type="date">

      <label>Telefone</label>
      <input id="newPatientPhone" placeholder="Telefone">

      <label>Queixa principal</label>
      <textarea
        id="newPatientComplaint"
        placeholder="Queixa principal..."
      ></textarea>

      <button class="primary-btn full" onclick="createPatient()">
        Cadastrar paciente
      </button>

    </div>

  </div>


  <script src="app.js"></script>

</body>
</html>
style.css
:root {
  --primary: #087f7b;
  --primary-dark: #05625f;
  --background: #f5f8f8;
  --card: #ffffff;
  --text: #172525;
  --muted: #708080;
  --border: #e2eaea;
  --purple: #7257d9;
  --green: #20a878;
  --blue: #3578e5;
}

* {
  box-sizing: border-box;
}

body {
  margin: 0;
  font-family:
    Inter,
    -apple-system,
    BlinkMacSystemFont,
    "Segoe UI",
    sans-serif;
  background: var(--background);
  color: var(--text);
}

button,
input,
textarea,
select {
  font: inherit;
}

button {
  cursor: pointer;
}

.sidebar {
  position: fixed;
  width: 250px;
  height: 100vh;
  background: #ffffff;
  border-right: 1px solid var(--border);
  padding: 28px 18px;
  display: flex;
  flex-direction: column;
}

.logo {
  display: flex;
  gap: 12px;
  align-items: center;
  padding: 0 10px 35px;
}

.logo-icon {
  width: 40px;
  height: 40px;
  border-radius: 12px;
  background: var(--primary);
  color: white;
  display: grid;
  place-items: center;
  font-size: 23px;
  font-weight: bold;
}

.logo strong {
  display: block;
  font-size: 18px;
}

.logo span {
  font-size: 11px;
  color: var(--muted);
}

nav {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.nav-btn {
  border: 0;
  background: transparent;
  color: #607070;
  padding: 13px 15px;
  border-radius: 10px;
  text-align: left;
  display: flex;
  gap: 13px;
  align-items: center;
}

.nav-btn:hover,
.nav-btn.active {
  background: #e9f5f4;
  color: var(--primary);
}

.sidebar-bottom {
  margin-top: auto;
}

.user {
  border-top: 1px solid var(--border);
  padding: 20px 8px 0;
  display: flex;
  gap: 10px;
  align-items: center;
}

.user strong {
  display: block;
  font-size: 13px;
}

.user span {
  color: var(--muted);
  font-size: 11px;
}

.avatar {
  width: 38px;
  height: 38px;
  background: #dcefed;
  color: var(--primary);
  display: grid;
  place-items: center;
  border-radius: 50%;
  font-weight: bold;
}

.main {
  margin-left: 250px;
  padding: 42px;
  min-height: 100vh;
}

.page {
  display: none;
  max-width: 1250px;
  margin: auto;
}

.page.active {
  display: block;
}

.topbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 32px;
}

.eyebrow {
  color: var(--primary);
  font-size: 11px;
  font-weight: 700;
  letter-spacing: 1.5px;
  margin: 0 0 6px;
}

h1 {
  margin: 0;
  font-size: 31px;
}

h2 {
  margin: 0;
  font-size: 18px;
}

.muted {
  color: var(--muted);
  margin-top: 7px;
}

.primary-btn {
  border: none;
  background: var(--primary);
  color: white;
  padding: 12px 18px;
  border-radius: 9px;
  font-weight: 600;
}

.primary-btn:hover {
  background: var(--primary-dark);
}

.text-btn {
  border: 0;
  background: none;
  color: var(--primary);
  font-weight: 600;
}

.full {
  width: 100%;
}

.stats {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 18px;
  margin-bottom: 22px;
}

.stat-card {
  background: var(--card);
  border: 1px solid var(--border);
  border-radius: 14px;
  padding: 22px;
  display: flex;
  align-items: center;
  gap: 15px;
}

.stat-card span {
  color: var(--muted);
  font-size: 13px;
  display: block;
}

.stat-card strong {
  font-size: 27px;
}

.stat-icon {
  width: 46px;
  height: 46px;
  border-radius: 12px;
  display: grid;
  place-items: center;
  font-size: 20px;
}

.blue {
  background: #eaf1ff;
  color: var(--blue);
}

.green {
  background: #e5f8ef;
  color: var(--green);
}

.purple {
  background: #eeeafd;
  color: var(--purple);
}

.dashboard-grid {
  display: grid;
  grid-template-columns: 1.5fr 1fr;
  gap: 22px;
}

.card {
  background: var(--card);
  border: 1px solid var(--border);
  border-radius: 15px;
  padding: 25px;
  margin-bottom: 22px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 22px;
}

.card-header p {
  color: var(--muted);
  font-size: 13px;
}

.patient-list {
  display: flex;
  flex-direction: column;
}

.patient-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 14px 0;
  border-bottom: 1px solid var(--border);
}

.patient-info {
  display: flex;
  gap: 12px;
  align-items: center;
}

.patient-avatar {
  width: 42px;
  height: 42px;
  background: #e6f3f2;
  color: var(--primary);
  border-radius: 50%;
  display: grid;
  place-items: center;
  font-weight: bold;
}

.patient-name {
  font-weight: 600;
}

.patient-sub {
  color: var(--muted);
  font-size: 12px;
  margin-top: 3px;
}

.ai-card {
  background:
    linear-gradient(145deg, #f1fbfa, #ffffff);
border-color: #cce9e6;
}

.ai-header {
  display: flex;
  gap: 13px;
  align-items: center;
}

.ai-sparkle {
  background: #ddf5f2;
  color: var(--primary);
  width: 44px;
  height: 44px;
  display: grid;
  place-items: center;
  border-radius: 12px;
}

.ai-example {
  background: white;
  border: 1px solid var(--border);
  border-radius: 10px;
  padding: 15px;
  margin: 22px 0;
  display: flex;
  gap: 10px;
  font-size: 13px;
  line-height: 1.5;
}

.search-box {
  border: 1px solid var(--border);
  border-radius: 9px;
  padding: 11px 14px;
  display: flex;
  gap: 10px;
  margin-bottom: 20px;
}

.search-box input {
  border: 0;
  outline: 0;
  width: 100%;
}

.patient-table {
  display: flex;
  flex-direction: column;
}

label {
  display: block;
  font-size: 13px;
  font-weight: 600;
  margin: 20px 0 8px;
}

input,
select,
textarea {
  width: 100%;
  border: 1px solid var(--border);
  border-radius: 9px;
  padding: 12px;
  outline: none;
  background: white;
}

textarea {
  min-height: 130px;
  resize: vertical;
}

input:focus,
select:focus,
textarea:focus {
  border-color: var(--primary);
}

.clinical-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 22px;
}

.voice-box {
  position: relative;
}

.voice-box textarea {
  padding-right: 65px;
}

.voice-btn {
  position: absolute;
  right: 12px;
  bottom: 12px;
  border: 0;
  width: 43px;
  height: 43px;
  border-radius: 50%;
  background: var(--primary);
  color: white;
  font-size: 19px;
}

.voice-btn.recording {
  background: #dc3545;
  animation: pulse 1.3s infinite;
}

@keyframes pulse {
  50% {
    transform: scale(1.08);
  }
}

.voice-status {
  color: var(--muted);
  font-size: 12px;
  margin-top: 8px;
}

.ai-button {
  width: 100%;
  margin-top: 20px;
  border: 0;
  background: #7057d9;
  color: white;
  padding: 14px;
  border-radius: 9px;
  font-weight: 600;
}

.ai-button:hover {
  background: #5942bd;
}

.ai-result {
  background: #f8fbfb;
  border: 1px solid var(--border);
  border-radius: 10px;
  padding: 20px;
  min-height: 330px;
}

.ai-result h3 {
  font-size: 13px;
  color: var(--primary);
  text-transform: uppercase;
  letter-spacing: .5px;
}

.ai-result p {
  font-size: 14px;
  line-height: 1.6;
}

.empty-state {
  min-height: 280px;
  display: grid;
  place-items: center;
  text-align: center;
  color: var(--muted);
}

.empty-state span {
  font-size: 30px;
  color: var(--purple);
}

.evolution-card {
  max-width: 850px;
}

.evolution-result {
  background: #f5f9f8;
  border: 1px solid var(--border);
  border-radius: 10px;
  margin-top: 20px;
  padding: 20px;
  line-height: 1.7;
}

.hidden {
  display: none !important;
}

.modal {
  position: fixed;
  inset: 0;
  background: rgba(15, 35, 35, .45);
  display: none;
  align-items: center;
  justify-content: center;
  padding: 20px;
}

.modal.open {
  display: flex;
}

.modal-content {
  background: white;
  border-radius: 15px;
  padding: 30px;
  width: 100%;
  max-width: 500px;
  position: relative;
}

.close {
  position: absolute;
  right: 20px;
  top: 15px;
  border: 0;
  background: none;
  font-size: 28px;
  color: var(--muted);
}

@media (max-width: 900px) {

  .sidebar {
    width: 70px;
    padding: 20px 10px;
  }

  .logo div:not(.logo-icon),
  .nav-btn:not(.active)::after,
  .nav-btn span + * {
    display: none;
  }

  .logo {
    padding: 0 5px 30px;
  }

  .nav-btn {
    justify-content: center;
    font-size: 0;
  }

  .nav-btn span {
    font-size: 18px;
  }

  .user {
    justify-content: center;
  }

  .user div:not(.avatar) {
    display: none;
  }

  .main {
    margin-left: 70px;
    padding: 25px;
  }

  .stats,
  .dashboard-grid,
  .clinical-grid {
    grid-template-columns: 1fr;
  }

}

@media (max-width: 600px) {

  .main {
    padding: 18px;
  }

  .topbar {
    align-items: flex-start;
    gap: 15px;
    flex-direction: column;
  }

  h1 {
    font-size: 25px;
  }

}
app.js
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


function showPage(page) {

  document.querySelectorAll(".page")
    .forEach(p => p.classList.remove("active"));

  document.getElementById(page)
    .classList.add("active");

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


/* =========================
   PACIENTES
========================= */

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
              ${escapeHTML(patient.complaint || "Sem queixa registrada")}
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

  document.getElementById("anamnesisPatient").value =
    patient.id;

  document.getElementById("evolutionPatient").value =
    patient.id;

  showPage("anamnesis");

}


/* =========================
   DASHBOARD
========================= */

function updateDashboard() {

  document.getElementById("patientCount")
    .textContent = patients.length;

  document.getElementById("sessionCount")
    .textContent = evolutions.length;

  document.getElementById("aiCount")
    .textContent = aiRecords.length;


  const recent =
    document.getElementById("recentPatients");


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
              ${escapeHTML(patient.complaint || "Paciente")}
            </div>

          </div>

        </div>

      </div>

    `).join("");

}


/* =========================
   SELECTS
========================= */

function populatePatientSelects() {

  const selects = [
    document.getElementById("anamnesisPatient"),
    document.getElementById("evolutionPatient")
  ];


  selects.forEach(select => {

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


/* =========================
   VOZ
========================= */

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

    button.classList.add("recording");

    status.textContent =
      "🔴 Gravando... fale normalmente.";

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


    textarea.value +=
      finalText + " ";

  };


  recognition.onerror = () => {

    status.textContent =
      "Não foi possível reconhecer a fala.";

  };


  recognition.onend = () => {

    button.classList.remove("recording");

    status.textContent =
      "Clique novamente para continuar.";

    recognition = null;

  };


  recognition.start();

}


/* =========================
   IA — ANAMNESE
========================= */

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


  const result = generateClinicalStructure(
    patient,
    text
  );


  document.getElementById("aiResult").innerHTML = result;

  document
    .getElementById("saveAnamnesis")
    .classList.remove("hidden");


  window.currentAnamnesis = {

    patientId: Number(patientId),

    originalText: text,

    result

  };

}


function generateClinicalStructure(patient, text) {

  /*
    DEMONSTRAÇÃO LOCAL.

    Aqui você poderá conectar uma API de IA posteriormente.
    O texto abaixo organiza automaticamente o relato em
    campos clínicos básicos.
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

  document.getElementById("voiceText").value = "";

  document.getElementById("aiResult").innerHTML = `

    <div class="empty-state">

      <span>✓</span>

      <p>Anamnese salva no prontuário.</p>

    </div>

  `;

  document
    .getElementById("saveAnamnesis")
    .classList.add("hidden");

  updateDashboard();

}


/* =========================
   EVOLUÇÃO
========================= */

function startEvolutionVoice() {

  const SpeechRecognition =
    window.SpeechRecognition ||
    window.webkitSpeechRecognition;


  if (!SpeechRecognition) {

    alert("Seu navegador não suporta reconhecimento de voz.");

    return;

  }


  const recognition =
    new SpeechRecognition();

  recognition.lang = "pt-BR";

  recognition.continuous = false;

  recognition.interimResults = false;


  recognition.onstart = () => {

    alert("Fale agora. A gravação será encerrada ao terminar.");

  };


  recognition.onresult = event => {

    const text =
      event.results[0][0].transcript;

    document.getElementById("evolutionText")
      .value += text + " ";

  };


  recognition.start();

}


function generateEvolution() {

  const patientId =
    document.getElementById("evolutionPatient").value;

  const text =
    document.getElementById("evolutionText")
      .value.trim();

  const conduct =
    document.getElementById("conduct")
      .value.trim();


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


  const result = `

    <h3>Paciente</h3>

    <p>${escapeHTML(patient.name)}</p>


    <h3>Evolução</h3>

    <p>${escapeHTML(text)}</p>


    <h3>Conduta realizada</h3>

    <p>
      ${escapeHTML(conduct || "Não informado")}
    </p>


    <h3>Plano</h3>

    <p>
      Manter acompanhamento fisioterapêutico e
      reavaliar resposta clínica na próxima sessão.
    </p>

  `;


  const resultBox =
    document.getElementById("evolutionResult");


  resultBox.innerHTML = result;

  resultBox.classList.remove("hidden");

  document
    .getElementById("saveEvolution")
    .classList.remove("hidden");


  window.currentEvolution = {

    patientId: Number(patientId),

    originalText: text,

    conduct,

    result

  };

}


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

  document.getElementById("evolutionText").value = "";

  document.getElementById("conduct").value = "";

  document
    .getElementById("evolutionResult")
    .classList.add("hidden");

  document
    .getElementById("saveEvolution")
    .classList.add("hidden");

  updateDashboard();

}


/* =========================
   STORAGE
========================= */

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


/* =========================
   UTILITÁRIOS
========================= */

function getInitials(name) {

  return name
    .split(" ")
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
