export const contractVersion = "0.1.0-m1-foundation";

export const supportedLocales = ["en", "bn"] as const;

export type SupportedLocale = (typeof supportedLocales)[number];

export type ApiEnvelope<T> = {
  data: T;
  contractVersion: typeof contractVersion;
};
