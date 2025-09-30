function initializeAppreciationForm() {
  const form = document.querySelector('[data-appreciation-form]');
  if (!form) return;

  let selectedOfficeId = form.dataset.firstOfficeId;

  // Office buttons
  document.querySelectorAll('[data-office-id]').forEach(btn => {
    btn.addEventListener('click', () => {
      const officeId = btn.dataset.officeId;
      selectedOfficeId = officeId;

      // Update buttons
      document.querySelectorAll('[data-office-id]').forEach(b => {
        b.classList.remove('border-blue-600', 'bg-blue-50', 'text-blue-700');
        b.classList.add('border-gray-200', 'bg-white', 'text-gray-700');
      });
      btn.classList.add('border-blue-600', 'bg-blue-50', 'text-blue-700');
      btn.classList.remove('border-gray-200', 'bg-white', 'text-gray-700');

      // Show/hide office content
      document.querySelectorAll('[data-office]').forEach(el => {
        if (el.dataset.office !== officeId) {
          el.classList.add('hidden');
          el.style.display = 'none';
        } else {
          el.classList.remove('hidden');
          el.style.display = 'block';
        }
      });

      // Clear selection
      const receiverId = document.getElementById('receiver_id');
      const selectedDisplay = document.getElementById('selected-display');
      const selectionArea = document.getElementById('selection-area');

      if (receiverId) receiverId.value = '';
      if (selectedDisplay) {
        selectedDisplay.classList.add('hidden');
        selectedDisplay.style.display = 'none';
      }
      if (selectionArea) {
        selectionArea.classList.remove('hidden');
        selectionArea.style.display = 'block';
      }
    });
  });

  // Department toggle
  document.querySelectorAll('[data-dept]').forEach(btn => {
    btn.addEventListener('click', (e) => {
      e.preventDefault();
      e.stopPropagation();

      const deptId = btn.dataset.dept;
      const content = document.querySelector(`[data-dept-content="${deptId}"]`);
      const svg = btn.querySelector('svg');

      if (content) {
        const isCurrentlyHidden = content.classList.contains('hidden');

        if (isCurrentlyHidden) {
          content.classList.remove('hidden');
          content.style.display = 'block';
          if (svg) svg.style.transform = 'rotate(180deg)';
        } else {
          content.classList.add('hidden');
          content.style.display = 'none';
          if (svg) svg.style.transform = '';
        }
      }
    });
  });

  // Section toggle
  document.querySelectorAll('[data-section]').forEach(btn => {
    btn.addEventListener('click', (e) => {
      e.preventDefault();
      e.stopPropagation();

      const content = document.querySelector(`[data-section-content="${btn.dataset.section}"]`);
      const svg = btn.querySelector('svg');

      if (content) {
        const isCurrentlyHidden = content.classList.contains('hidden');

        if (isCurrentlyHidden) {
          content.classList.remove('hidden');
          content.style.display = 'block';
          if (svg) svg.style.transform = 'rotate(180deg)';
        } else {
          content.classList.add('hidden');
          content.style.display = 'none';
          if (svg) svg.style.transform = '';
        }
      }
    });
  });

  // User selection
  document.querySelectorAll('.user-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      const receiverId = document.getElementById('receiver_id');
      const selectedDisplay = document.getElementById('selected-display');
      const selectionArea = document.getElementById('selection-area');
      const selectedAvatar = document.getElementById('selected-avatar');
      const selectedName = document.getElementById('selected-name');
      const selectedLocation = document.getElementById('selected-location');

      if (receiverId) receiverId.value = btn.dataset.userId;
      if (selectedAvatar) selectedAvatar.textContent = btn.dataset.avatar;
      if (selectedName) selectedName.textContent = btn.dataset.name;
      if (selectedLocation) selectedLocation.textContent = btn.dataset.location;
      if (selectedDisplay) {
        selectedDisplay.classList.remove('hidden');
        selectedDisplay.style.display = 'block';
      }
      if (selectionArea) {
        selectionArea.classList.add('hidden');
        selectionArea.style.display = 'none';
      }
    });
  });

  // Change button
  const changeBtn = document.getElementById('change-btn');
  if (changeBtn) {
    changeBtn.addEventListener('click', (e) => {
      e.preventDefault();

      const receiverId = document.getElementById('receiver_id');
      const selectedDisplay = document.getElementById('selected-display');
      const selectionArea = document.getElementById('selection-area');

      if (receiverId) receiverId.value = '';
      if (selectedDisplay) {
        selectedDisplay.classList.add('hidden');
        selectedDisplay.style.display = 'none';
      }
      if (selectionArea) {
        selectionArea.classList.remove('hidden');
        selectionArea.style.display = 'block';
      }
    });
  }

  // Category selection
  document.querySelectorAll('[data-category]').forEach(btn => {
    btn.addEventListener('click', () => {
      document.querySelectorAll('[data-category]').forEach(b => {
        b.classList.remove('border-blue-600', 'bg-blue-50', 'text-blue-700');
        b.classList.add('border-gray-200', 'bg-white', 'text-gray-900');
      });
      btn.classList.add('border-blue-600', 'bg-blue-50', 'text-blue-700');
      btn.classList.remove('border-gray-200', 'bg-white');
      document.getElementById('category').value = btn.dataset.category;
    });
  });

  // 初期化: すべての部署・課を閉じる
  document.querySelectorAll('[data-dept-content]').forEach(content => {
    content.classList.add('hidden');
    content.style.display = 'none';
  });
  document.querySelectorAll('[data-section-content]').forEach(content => {
    content.classList.add('hidden');
    content.style.display = 'none';
  });

  // 初期化: 最初のoffice以外を非表示にする
  document.querySelectorAll('[data-office]').forEach((el, index) => {
    if (index === 0) {
      el.classList.remove('hidden');
      el.style.display = 'block';
    } else {
      el.classList.add('hidden');
      el.style.display = 'none';
    }
  });
}

// イベントリスナーを追加
document.addEventListener('turbo:load', initializeAppreciationForm);
document.addEventListener('turbo:frame-load', initializeAppreciationForm);

// 最近送信したユーザーのクリック処理（グローバルスコープ）
document.addEventListener('click', (e) => {
  const btn = e.target.closest('.recent-user-btn');
  if (!btn) return;

  e.preventDefault();

  const receiverId = document.getElementById('receiver_id');
  const selectedDisplay = document.getElementById('selected-display');
  const selectionArea = document.getElementById('selection-area');
  const selectedAvatar = document.getElementById('selected-avatar');
  const selectedName = document.getElementById('selected-name');
  const selectedLocation = document.getElementById('selected-location');

  if (receiverId) receiverId.value = btn.dataset.userId;
  if (selectedAvatar) selectedAvatar.textContent = btn.dataset.avatar;
  if (selectedName) selectedName.textContent = btn.dataset.name;
  if (selectedLocation) selectedLocation.textContent = btn.dataset.location;
  if (selectedDisplay) {
    selectedDisplay.classList.remove('hidden');
    selectedDisplay.style.display = 'block';
  }
  if (selectionArea) {
    selectionArea.classList.add('hidden');
    selectionArea.style.display = 'none';
  }

  // フォームまでスクロール
  document.getElementById('selected-display')?.scrollIntoView({ behavior: 'smooth', block: 'center' });
});