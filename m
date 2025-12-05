Return-Path: <linux-aspeed+bounces-3054-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1231D3ABF5
	for <linux-aspeed@archiver.kernel.org>; Sat,  6 Dec 2025 06:51:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dNf6870Qlz2xZt;
	Sat, 06 Dec 2025 17:51:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:d0a:203a::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764943717;
	cv=none; b=keOTE1XJQwwTHL/lB8HLk/r2zdOR83ZyiX7PJmAuykWjJlDO9own47U0sau9RDeS0ypkxJCb8A2CrjYNcP8QUWX8Ekah9uYzA5MPExLhQQQ6oDq0m1JdRdUSPaie9eaEcSBXRrD7GNTgDB8i73lQn00P37RJdMTnabws611y+rrj7Ivu0K35bcW7J/QKkiQmV0dnoxsWVmjy6Zoy3iTfBbV9LjjWtcAN4kS1yfmlJ3eHlGvt+T2mAj01OV/xAcCXErC6o+D1CJ6ruMq6F/q5BlECdrHaX0aTXfrgWPmecur8Mu/HOVlVQa6wTs+J9HbsrPm2npRGM2/UK0jElkw5fA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764943717; c=relaxed/relaxed;
	bh=4VGNoc0X+amaG+Vf4liyINH5bYw87cv1QWYZ3H767n4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=W1gfFvsNpcvHs4dL8Y2CRHLGQDIUuhaRQiOcQg42OXZG4/p94WsXHTr/NpNpcB7kQT210NuyYzpMgtEbL7HOVKT2wYB3pZ9QQcCM/qkJwLwjv2YPFdxal25H/kPFNRMJCzPlEWAEoqlf/Gw509Z2uk+J5epJhlWN2nVgt4GcNQVxb4/TcJ03wr04BQPM1oQ6CIXNdEC4mZyfo7cUVxrM5HVlfSTj17UTgK2w2st0hoQrT4v1uegudfp8RorNiml6jhBnRhBWKMnpDkWyWqsRxLoQyNuTBeowMvD7dmqqYmRQpTFD1wgYbOIQZtJxUoFYPpOnm6uWosFQ9RcTXpEFrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=hetzner.com; dkim=pass (2048-bit key; unprotected) header.d=hetzner.com header.i=@hetzner.com header.a=rsa-sha256 header.s=lms2212 header.b=C4kr3/MX; dkim-atps=neutral; spf=pass (client-ip=2a01:4f8:d0a:203a::1; helo=mail.hetzner.company; envelope-from=tan.siewert@hetzner.com; receiver=lists.ozlabs.org) smtp.mailfrom=hetzner.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=hetzner.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=hetzner.com header.i=@hetzner.com header.a=rsa-sha256 header.s=lms2212 header.b=C4kr3/MX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=hetzner.com (client-ip=2a01:4f8:d0a:203a::1; helo=mail.hetzner.company; envelope-from=tan.siewert@hetzner.com; receiver=lists.ozlabs.org)
Received: from mail.hetzner.company (mail.hetzner.company [IPv6:2a01:4f8:d0a:203a::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dNCsG2yqhz2xGY
	for <linux-aspeed@lists.ozlabs.org>; Sat, 06 Dec 2025 01:08:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hetzner.com
	; s=lms2212; h=Content-Type:In-Reply-To:References:Cc:To:From:Subject:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=4VGNoc0X+amaG+Vf4liyINH5bYw87cv1QWYZ3H767n4=; b=C4kr3/MXHHS8pNVsS+HYLhHZu5
	7seDZewlYAXCnIQGgF8P3GkVQh3W7cUzU+EZ/rEDdxOJQsnm/fWYF5MB5wQV/9U+ImHJUiqdrHexV
	03fekcok56mZL48UMvTNrH1edicNbFR9CAUR/gx8Fo38L2KStk/R2UcCfbPGE4BPIkaOcsfZSOneJ
	xq6PewMXoTiMhfxzYfZPfY2N5i4GsWbX6zWCegtyeVK/DPdIakCup/bEKglfBq1MUuNdZSi0ALXu3
	rpWqVLgoRDbUE7EdcPZQkb55Hc2bDg7+x7GLVHAFG4XPlazS+Kba2gcKVBvIqGKnn0zYcPAjiYxry
	tLAXG7IA==;
Received: from fsn1-vpn1-entry1.hetzner.company ([188.40.24.77] helo=[10.10.220.249])
	by mail.hetzner.company with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.94.2)
	(envelope-from <tan.siewert@hetzner.com>)
	id 1vRWTp-009Xor-77; Fri, 05 Dec 2025 15:08:17 +0100
Message-ID: <a8b5df46-edd1-4e35-a8d4-8842526df8d0@hetzner.com>
Date: Fri, 5 Dec 2025 15:08:12 +0100
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] ARM: dts: aspeed: add device tree for ASRock Rack
 ALTRAD8 BMC
Content-Language: en-GB
From: Tan Siewert <tan.siewert@hetzner.com>
To: Rebecca Cran <rebecca@bsdio.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Billy Tsai <billy_tsai@aspeedtech.com>
References: <20251204210238.40742-1-rebecca@bsdio.com>
 <20251204210238.40742-3-rebecca@bsdio.com>
 <aa75c5a4-27cf-4cc2-9851-07713999f469@hetzner.com>
Autocrypt: addr=tan.siewert@hetzner.com; keydata=
 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
Organization: Hetzner Cloud GmbH
In-Reply-To: <aa75c5a4-27cf-4cc2-9851-07713999f469@hetzner.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1FUsj50sBQSbEE06fOMSydYO"
X-Authenticated-Sender: tan.siewert@hetzner.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------1FUsj50sBQSbEE06fOMSydYO
Content-Type: multipart/mixed; boundary="------------wU9zEc6hgvOoHr4mLXq6YeJX";
 protected-headers="v1"
From: Tan Siewert <tan.siewert@hetzner.com>
To: Rebecca Cran <rebecca@bsdio.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Billy Tsai <billy_tsai@aspeedtech.com>
Message-ID: <a8b5df46-edd1-4e35-a8d4-8842526df8d0@hetzner.com>
Subject: Re: [PATCH v3 2/3] ARM: dts: aspeed: add device tree for ASRock Rack
 ALTRAD8 BMC
References: <20251204210238.40742-1-rebecca@bsdio.com>
 <20251204210238.40742-3-rebecca@bsdio.com>
 <aa75c5a4-27cf-4cc2-9851-07713999f469@hetzner.com>
In-Reply-To: <aa75c5a4-27cf-4cc2-9851-07713999f469@hetzner.com>

--------------wU9zEc6hgvOoHr4mLXq6YeJX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDQuMTIuMjUgMjM6MjksIFRhbiBTaWV3ZXJ0IHdyb3RlOg0KPiBPbiAwNC4xMi4yNSAy
MjowMiwgUmViZWNjYSBDcmFuIHdyb3RlOg0KPj4gVGhlIEFMVFJBRDggQk1DIGlzIGFuIEFz
cGVlZCBBU1QyNTAwLWJhc2VkIEJNQyBmb3IgdGhlIEFTUm9jayBSYWNrDQo+PiBBTFRSQUQ4
VUQtMUwyVCBhbmQgQUxUUkFEOFVEMi0xTDJRIGJvYXJkcy4NCj4+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBSZWJlY2NhIENyYW4gPHJlYmVjY2FAYnNkaW8uY29tPg0KPj4gLS0tDQo+PiDCoCBh
cmNoL2FybS9ib290L2R0cy9hc3BlZWQvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+PiDCoCBhcmNoL2FybS9ib290L2R0
cy9hc3BlZWQvYXNwZWVkLWJtYy1hc3JvY2stYWx0cmFkOC5kdHMgfCA2MTIgKysrKysrKyAN
Cj4+ICsrKysrKysrKysrKysNCj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgNjEzIGluc2VydGlv
bnMoKykNCg0KKnNuaXAqDQoNCj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9h
c3BlZWQvYXNwZWVkLWJtYy1hc3JvY2stYWx0cmFkOC5kdHMgYi8gDQo+PiBhcmNoL2FybS9i
b290L2R0cy9hc3BlZWQvYXNwZWVkLWJtYy1hc3JvY2stYWx0cmFkOC5kdHMNCj4+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjI2OTZhODY5MjYwNw0K
Pj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2Fz
cGVlZC1ibWMtYXNyb2NrLWFsdHJhZDguZHRzDQoNCipzbmlwKg0KDQo+PiArJmdwaW8gew0K
Pj4gK8KgwqDCoCBncGlvLWxpbmUtbmFtZXMgPQ0KPj4gK8KgwqDCoCAvKkEwLUE3Ki/CoMKg
wqAgIiIsIiIsIiIsImJtYy1yZWFkeSIsIiIsIiIsIiIsIiIsDQo+PiArwqDCoMKgIC8qQjAt
QjcqL8KgwqDCoCAiaTJjLWJhY2t1cC1zZWwiLCIiLCIiLCIiLCIiLCIiLCIiLCJob3N0MC1z
aGQtYWNrLW4iLA0KPj4gK8KgwqDCoCAvKkMwLUM3Ki/CoMKgwqAgIiIsIiIsIiIsIiIsIiIs
IiIsIiIsIiIsDQo+PiArwqDCoMKgIC8qRDAtRDcqL8KgwqDCoCAicG93ZXItYnV0dG9uIiwi
cG93ZXItb3V0IiwiYnV0dG9uLXJlc2V0IiwNCg0KSSBqdXN0IG5vdGljZWQgdGhhdCBJIG92
ZXJsb29rZWQgdGhlIHBvd2VyIGJ1dHRvbnMgaW4gbXkgcmVjZW50IHJldmlldy4NCg0KcG93
ZXItYnV0dG9uID0gYnV0dG9uLXBvd2VyLW4gKGFjdGl2ZSBsb3cpDQoNCnBvd2VyLW91dCA9
IGNvbnRyb2wtcG93ZXItbiAoYWN0aXZlIGxvdykNCg0KYnV0dG9uLXJlc2V0ID0gYnV0dG9u
LXJlc2V0LW4gKGFjdGl2ZSBsb3cpDQoNClRoZSBvdGhlciByZXZpZXcgY29tbWVudHMgcmVt
YWluLg0KDQotLSBUYW4NCg0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgImhvc3QwLXN5
c3Jlc2V0LW4iLCIiLCIiLCJwb3dlci1jaGFzc2lzLWdvb2QiLCIiLA0KPj4gK8KgwqDCoCAv
KkUwLUU3Ki/CoMKgwqAgIiIsInMwLXZyZDEtdmRkcTAxMjMtZmF1bHQtbiIsDQo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAiczAtdnJkMS12ZGRxNDU2Ny1mYXVsdC1uIiwiczAtdnJk
MC12ZGRjLWZhdWx0LW4iLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgInMwLXZyZDMt
cDB2NzUtZmF1bHQtbiIsIiIsIiIsIiIsDQo+PiArwqDCoMKgIC8qRjAtRjcqL8KgwqDCoCAi
IiwiIiwicHMtYXR4LW9uLW4iLCIiLCIiLCIiLCIiLCIiLA0KPj4gK8KgwqDCoCAvKkcwLUc3
Ki/CoMKgwqAgImxlZC1pZGVudGlmeSIsImJ1dHRvbi1pZGVudGlmeSIsIiIsIiIsInVib290
LXJlYWR5IixcDQo+IA0KPiBgYnV0dG9uLWlkZW50aWZ5YCBzaG91bGQgYmUgYGJ1dHRvbi1p
ZGVudGlmeS1uYCAoYWN0aXZlLWxvdykuDQo+IA0KPiBgbGVkLXN5c3RlbS1mYXVsdC1uYCBp
cyBHUElPRzMuDQo+IA0KPiBgbGVkLWlkZW50aWZ5LW5gIF9jb3VsZF8gYmUgYXQgR1BJT1E2
IChzZWVtcyB0byBiZSB3aXJlZCB0byB0aGUgQ1BMRCAoPyEpKS4NCj4gDQo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAiYm1jLXNhbHQyLW4iLCIiLCIiLA0KPj4gK8KgwqDCoCAvKkgw
LUg3Ki/CoMKgwqAgInBzLXB3ci1vayIsInVhcnQxLW1vZGUxIiwidWFydDItbW9kZTEiLCJ1
YXJ0My1tb2RlMSIsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAidWFydDQtbW9kZTEi
LCIiLCJsZWQtYm1jLWhlYXJ0YmVhdCIsIiIsDQo+IA0KPiBHUElPSDYgaXMgYEJNQ19KVEFH
X1NFTF9TMGAuIFRoZSBgbGVkLWJtYy1oZWFyYmVhdC1uYCBzaG91bGQgYmUgR1BJT0cwLg0K
PiANCj4+ICvCoMKgwqAgLypJMC1JNyovwqDCoMKgICIiLCIiLCIiLCIiLCIiLCIiLCIiLCIi
LA0KPj4gK8KgwqDCoCAvKkowLUo3Ki/CoMKgwqAgInMwLWhpZ2h0ZW1wLW4iLCIiLCIiLCIi
LCIiLCIiLCIiLCIiLA0KPj4gK8KgwqDCoCAvKkswLUs3Ki/CoMKgwqAgIiIsIiIsIiIsIiIs
IiIsIiIsIiIsIiIsDQo+PiArwqDCoMKgIC8qTDAtTDcqL8KgwqDCoCAiIiwiIiwiIiwiIiwi
IiwiIiwiIiwiIiwNCj4+ICvCoMKgwqAgLypNMC1NNyovwqDCoMKgICIiLCIiLCIiLCIiLCIi
LCJzMC1zcGktYXV0aC1mYWlsLW4iLCIiLCIiLA0KPj4gK8KgwqDCoCAvKk4wLU43Ki/CoMKg
wqAgIiIsIiIsIiIsIiIsIiIsIiIsIiIsIiIsDQo+PiArwqDCoMKgIC8qTzAtTzcqL8KgwqDC
oCAiIiwiIiwiIiwiIiwiIiwiIiwiIiwiIiwNCj4+ICvCoMKgwqAgLypQMC1QNyovwqDCoMKg
ICIiLCIiLCJjcGxkLWRpc2FibGUtYm1jIiwiIiwiIiwiIiwiIiwiIiwNCj4gDQo+IGBjcGxk
LWRpc2FibGUtYm1jYCBzaG91bGQgYmUgYGNwbGQtZGlzYWJsZS1ibWMtbmAgYW5kIGF0IEdQ
SU9NMCANCj4gKGBDUExEX0RJU0FCTEVfQk1DX0xgIGluIHNjaGVtYXRpYykuIEdQSU9QMiBp
cyBhIGZhbiB0YWNoby4NCj4gDQo+PiArwqDCoMKgIC8qUTAtUTcqL8KgwqDCoCAiIiwiIiwi
ZXh0LWhpZ2h0ZW1wLW4iLCIiLCIiLCIiLCIiLA0KPiANCj4gZG91YmxlIGFzc2lnbm1lbnQg
b2YgYGV4dC1oaWdodGVtcC1uYC4gQ29ycmVjdCBvbmUgaXMgR1BJT1IyLiBQbGVhc2UgDQo+
IHJlbW92ZSBpdC4NCj4gDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiY2hhc3Npcy1p
bnRydXNpb24iLA0KPiANCj4gYGNoYXNzaXMtaW50cnVzaW9uLW5gIChhY3RpdmUtbG93KS4N
Cj4gDQo+PiArwqDCoMKgIC8qUjAtUjcqL8KgwqDCoCAiIiwiIiwiZXh0LWhpZ2h0ZW1wLW4i
LCJzcGkwLXByb2dyYW0tc2VsIiwiIiwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJo
d20tYmF0LWVuIiwiIiwiIiwNCj4gDQo+IGBod20tYmF0LWVuYCBjb3VsZCBiZSBwcmVmaXhl
ZCB3aXRoIGBvdXRwdXQtYC4NCj4gDQo+PiArwqDCoMKgIC8qUzAtUzcqL8KgwqDCoCAiczAt
dnItaG90LW4iLCIiLCIiLCJibWMtc3lzcmVzZXQtbiIsIiIsIiIsIiIsIiIsDQo+IA0KPiBH
UElPUzIgKGBpbnB1dC1zYWx0NS1uYCkgX2NvdWxkXyBiZSB1c2VmdWwgKGNvbWVzIGZyb20g
dGhlIFg1NTAgZm9yIFdvTCANCj4gKGBMQU5fM1YzU1RCWV9BTFJUX05gIGluIHNjaGVtYXRp
YykpLg0KPiANCj4+ICvCoMKgwqAgLypUMC1UNyovwqDCoMKgICIiLCIiLCIiLCIiLCIiLCIi
LCIiLCIiLA0KPj4gK8KgwqDCoCAvKlUwLVU3Ki/CoMKgwqAgIiIsIiIsIiIsIiIsIiIsIiIs
IiIsIiIsDQo+PiArwqDCoMKgIC8qVjAtVjcqL8KgwqDCoCAiIiwiIiwiIiwiIiwiIiwiIiwi
IiwiIiwNCj4+ICvCoMKgwqAgLypXMC1XNyovwqDCoMKgICIiLCIiLCIiLCIiLCIiLCIiLCIi
LCIiLA0KPj4gK8KgwqDCoCAvKlgwLVg3Ki/CoMKgwqAgIiIsIiIsIiIsIiIsIiIsIiIsIiIs
IiIsDQo+PiArwqDCoMKgIC8qWTAtWTcqL8KgwqDCoCAic2lvLXMzIiwic2lvLXM1Iiwic2lv
LXB3ci1yZXEiLCJzaW8tb24tIA0KPj4gY3RybCIsIiIsIiIsIiIsIiIsDQo+PiArwqDCoMKg
IC8qWjAtWjcqL8KgwqDCoCAiIiwic2lvLXB3ci1nb29kIiwiIiwiczAtcnRjLWxvY2siLCIi
LCIiLCIiLCIiLA0KPiANCj4gU3lzdGVtIGhhcyBubyBTdXBlci1JTy4gUGxlYXNlIHJlbW92
ZSB0aGUgYHNpby1gIGFzc2lnbm1lbnRzLg0KPiANCj4+ICvCoMKgwqAgLypBQTAtQUE3Ki/C
oMKgwqAgInJ0Yy1pbnQiLCIiLCIiLCIiLCIiLCJwbWJ1cy1zZWwtbiIsIiIsIiIsDQo+IA0K
PiBgcnRjLWludGAgc2hvdWxkIGJlIGBzMC1ydGMtaW50LW5gLg0KPiANCj4+ICvCoMKgwqAg
LypBQjAtQUI3Ki/CoMKgwqAgImhvc3QwLXJlYm9vdC1hY2stbiIsInMwLXN5cy1hdXRoLWZh
aWx1cmUtbiIsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiIiwiIiwiIiwiIiwiIiwi
IiwNCj4+ICvCoMKgwqAgLypBQzAtQUM3Ki/CoMKgwqAgInMwLWZhdWx0LWFsZXJ0IiwiaG9z
dDAtcmVhZHkiLCJzMC1vdmVydGVtcC1uIiwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICIiLCJibWMtb2siLCJob3N0MC1zcGVjaWFsLWJvb3QiLCJwcmVzZW5jZS1jcHUwIiwNCj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJob3N0MC1zaGQtcmVxLW4iOw0KPj4gKw0KPj4g
K8KgwqDCoCBzdGF0dXMgPSAib2theSI7DQo+PiArfTsNCg0K

--------------wU9zEc6hgvOoHr4mLXq6YeJX--

--------------1FUsj50sBQSbEE06fOMSydYO
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEGogUkqo1678CFZJAOx3dOtjZyWMFAmky50wFAwAAAAAACgkQOx3dOtjZyWPw
VA/7BZ7aig3+IXTaIkats5ko/1PK31gzMVkLzEF3mooTv8wL03J6Q8n5jbpWqSgh+oYzokipY3lh
y1wKGd6P4kIhkZ4sHtacT5e6Z2yoocHCqWNFM+pXxHvUvaZC6SwCS+RGZKulvEQutb6032BLU4WE
77rzsmMbJMmM2b4dLjB3rktXseVli+mnzVJWHjwOpoMuikYZChX+Sv3NX3+NLfOcjsQw0mWoEDc2
5iPw54xgOmhklfcwrDfMWBosxOvEQqbvRcTDxxhTTgkWMOHUzFiSLuV7Ik7a/8Pg8r1TGLuFpYtw
XA8JDZBy2W4Xx9vMYUu4RSv3CtXymTUqyYIFlpcxwYWnQ2+sUFeJ0YkbMZCBDwb3i/sxwibBOC+Q
ahjihNEjD5grdb7JMPFSUKqt7EU0pCV101+Mmrqat2Yyiyb8wtB8kTMQYlYDo++hrpO9HbGw6G1K
HZILGPyNF1C29+n2IpAsZZJaux9bJ/Evm8K4mx0FqIE0EAaVgbT3156R5DAC5/L4zPhMYMNlkoDl
NVRaBQxRNk9iT9a6S592mglxJovhFchwxD0OV4/wP7pNsiHTizJd0cCFpeAmccqLpITvhQT3PaKD
GswpcOW/vO5EZRaXMd/5bzSdytYkSbzVnXoTRDC01Ptme6E2nHGJG7p7gThHvMJg4X1o4o3xfgwD
mnw=
=kIXt
-----END PGP SIGNATURE-----

--------------1FUsj50sBQSbEE06fOMSydYO--

