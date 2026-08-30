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
