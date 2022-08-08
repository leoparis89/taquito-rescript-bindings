module Toolkit = {
  type tz
  type contract
  type estimate
  type operation = {hash: string}

  type toolkit = {
    tz: tz,
    contract: contract,
    estimate: estimate,
  }

  type estimation = {
    suggestedFeeMutez: int,
    gasLimit: int,
  }

  @module("@taquito/taquito") @new
  external create: (~nodeUrl: string) => toolkit = "TezosToolkit"

  @send external getBalance: (tz, string) => Promise.t<Js.Json.t> = "getBalance"
  @send external setProvider: (toolkit, 'a) => unit = "setProvider"
  @send external transfer: (contract, 'a) => Promise.t<operation> = "transfer"
  @send external estimateTransfer: (estimate, 'a) => Promise.t<estimation> = "transfer"
}

module Contract = {
  type transfer
  type transferParams

  @send external send: (transfer, unit) => Promise.t<'a> = "send"
  @send
  external toTransferParams: (transfer, unit) => transferParams = "toTransferParams"
}

module Signer = {
  type signer

  @module("@taquito/signer") @new
  external create: (~pkh: string, ~pk: string) => signer = "InMemorySigner"

  @module("@taquito/signer") @scope("InMemorySigner")
  external fromSecretKey: (string, string) => Promise.t<signer> = "fromSecretKey"

  @send external publicKeyHash: (signer, unit) => Promise.t<string> = "publicKeyHash"
  @send external publicKey: (signer, unit) => Promise.t<string> = "publicKey"
}

module Utils = {
  @module("@taquito/utils")
  external validateAddress: string => int = "validateAddress"
}
