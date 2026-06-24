import { describe, expect, it } from "vitest";

import { contractVersion, supportedLocales, type ApiEnvelope } from "../src";

describe("contracts foundation", () => {
  it("exposes the M1 contract version", () => {
    expect(contractVersion).toBe("0.1.0-m1-foundation");
  });

  it("includes English and Bangla locales", () => {
    expect(supportedLocales).toEqual(["en", "bn"]);
  });

  it("types API envelopes with the contract version", () => {
    const envelope: ApiEnvelope<{ ok: true }> = {
      data: { ok: true },
      contractVersion,
    };

    expect(envelope.data.ok).toBe(true);
  });
});
