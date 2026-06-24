import { describe, expect, it } from "vitest";

import { appMeta } from "./app-meta";

describe("appMeta", () => {
  it("identifies the admin shell", () => {
    expect(appMeta.name).toBe("Chapter House Admin");
    expect(appMeta.phase).toBe("M1 foundation");
  });
});
