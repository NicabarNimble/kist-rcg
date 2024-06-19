import { useState } from "react";
import "./App.css";
import { useDojo } from "./dojo/useDojo";

function App() {
  const { setup: { client }, account: { account } } = useDojo();
  const [job, setJob] = useState<string | null>(null);

  const handleGetJob = async () => {
    try {
      const result = await client.actions.getJob({ account });
      setJob(result.job); // assuming the job is returned in result.job
    } catch (error) {
      console.error("Error fetching job:", error);
      setJob("Error fetching job");
    }
  };

  return (
    <div className="container mx-auto">
      <h1 className="text-3xl text-center">Get Me a Job</h1>
      <div className="flex justify-center py-4">
        <button
          className="px-4 py-2 border border-blue-500 bg-blue-100"
          onClick={handleGetJob}
        >
          Get Me a Job
        </button>
      </div>
      {job && (
        <div className="text-xl text-center mt-4">
          <p>Your Job: {job}</p>
        </div>
      )}
    </div>
  );
}

export default App;
