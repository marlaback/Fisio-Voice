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
