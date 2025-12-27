import { useState } from 'react';

function App() {
  const [count, setCount] = useState(0);

  return (
    <div className="min-h-screen bg-gray-100 flex items-center justify-center">
      <div className="bg-white p-8 rounded-lg shadow-md text-center">
        <h1 className="text-4xl font-bold text-gray-800 mb-4">
          Mary Platform
        </h1>
        <p className="text-gray-600 mb-4">
          Multi-technology desktop application platform with AI orchestration
        </p>
        <div className="mt-6">
          <button
            onClick={() => setCount((count) => count + 1)}
            className="bg-blue-500 hover:bg-blue-600 text-white font-medium py-2 px-4 rounded transition-colors"
          >
            Count is {count}
          </button>
        </div>
        <p className="text-sm text-gray-500 mt-6">
          Click the button to test the application
        </p>
      </div>
    </div>
  );
}

export default App;