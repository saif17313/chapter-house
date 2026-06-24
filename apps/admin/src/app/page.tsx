import { appMeta } from "@/lib/app-meta";

export default function AdminHome() {
  return (
    <main className="admin-shell">
      <section className="admin-panel" aria-labelledby="admin-title">
        <p className="eyebrow">Operations</p>
        <h1 id="admin-title">{appMeta.name}</h1>
        <p className="summary">Foundation shell ready.</p>
      </section>
    </main>
  );
}
