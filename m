Return-Path: <linux-aspeed+bounces-347-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6CFE77197
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jan 2025 00:30:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSTNG0Pp5z30DX;
	Wed,  8 Jan 2025 11:30:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736296238;
	cv=none; b=SD2E9HjLP4C6ERaqtUA7GMWMxZPhn17wumPNBEVgvDW7uznTCem4cYwuSSNiLqmvX7rv/t9tcS91uFbcRJ36j7oIc1leABvq/HYFR8hrj95y/BuGv0pPR7F0RNPSrHJjnDhEdXUpdED1tcFnMQiwnM6YeucgB2q1c7LDyg7Sum6kbdKg7cPumb3qN5ssrSh67eO2u8h6LpPTp86LIlPF7T+w9PUVvkyteObO9XU4ajjHDxA8DlS+EQl03Bp7PDjwMLotsdQazixrS59em0uX65QKOit3LfAY6TUmVVoUOH9IhyElD/sLocJkAn3XDD1mzolcxs06ajeDl23dJ30pzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736296238; c=relaxed/relaxed;
	bh=vx9EdJsNBcRIpz/ADVbnPQyQLhZV+V1R6yfVIWa60vw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CM9KgGRTDAsvpUCutwAoAOfe1bfU7f4R8yIZaTC0996vc3N4absMCvO0rEFADX5bNVux490GDTUf1aYwixAsPsakXJi+6+DDW60VSIwTeRhyyLWoA5JtpjCAYG5H9TTgTivHgNheYTdvP5q0dNvDp1TwD33TO6mYziCkPnGenafbRigu8rDo+CFDUXfOmDKdxrMuWpNF0dC4o/M5IUa3QYEIk+zk/bCloombL+8pNrfhdMT8Gn4UFqyi02efZAb1iJd3fgrEIM3aq1V4nxJc3nDOrbmU04/CKU8UsVeFVP6SibOBQQDroonyeEtdzFqlfq7pSpJ6slZYSyy5LNWvxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Jtms8Rdj; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Jtms8Rdj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSTNF2Bbbz305c
	for <linux-aspeed@lists.ozlabs.org>; Wed,  8 Jan 2025 11:30:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1736296236;
	bh=vx9EdJsNBcRIpz/ADVbnPQyQLhZV+V1R6yfVIWa60vw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Jtms8RdjwKm/KLZV7eXQhHgkPq5ONs3LP5R2RBqkaJUL1Rq4h7bB+IjQsAEIaS/cf
	 8KObp78BnCS+z+UvbWP7i8Tv/UF6I4p2rimJ1yFRKRnkCdYNjlJ/hLPZmITF7VJ5Pp
	 8eTIauA0372S3VD0riVvzVKQc/r4faMWbm3ID/4lQIhMdvoj+B//sYWffvxmH74yQs
	 o/o2X8abIYRJwok0Wu832CNuipDEh8LbdGyhUpRxQ4SKzMeJHXJkLK38n6sV5XYuPa
	 cirPCuYjBo35fm64HQDeN1GGw0Ou1ErdChk4tyh/vFuyfjcu8tOguM+LWA+sa0ChXJ
	 LZboxPuE10QhA==
Received: from [192.168.68.112] (ppp118-210-64-24.adl-adc-lon-bras32.tpg.internode.on.net [118.210.64.24])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3641C70801;
	Wed,  8 Jan 2025 08:30:36 +0800 (AWST)
Message-ID: <a180245323d06ce09697abb1ee9e83cc66e73db1.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: yosemite4: adjust secondary flash name
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Date: Wed, 08 Jan 2025 11:00:35 +1030
In-Reply-To: <Z31VRZg2LTd36S4n@heinlein>
References: <20241218212458.3050775-1-patrick@stwcx.xyz>
	 <e3279e0c41259f165a0cde0195b196f416ac566a.camel@codeconstruct.com.au>
	 <Z31VRZg2LTd36S4n@heinlein>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
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
MIME-Version: 1.0

T24gVHVlLCAyMDI1LTAxLTA3IGF0IDExOjI0IC0wNTAwLCBQYXRyaWNrIFdpbGxpYW1zIHdyb3Rl
Ogo+IE9uIFR1ZSwgSmFuIDA3LCAyMDI1IGF0IDAzOjQ0OjA0UE0gKzEwMzAsIEFuZHJldyBKZWZm
ZXJ5IHdyb3RlOgo+ID4gCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3Rh
dHVzID0gIm9rYXkiOwo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG0yNXAs
ZmFzdC1yZWFkOwo+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbGFiZWwgPSAi
Ym1jMiI7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsYWJlbCA9ICJhbHQt
Ym1jIjsKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzcGktcngtYnVzLXdp
ZHRoID0gPDQ+Owo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNwaS1tYXgt
ZnJlcXVlbmN5ID0gPDUwMDAwMDAwPjsKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoH07Cj4gPiAKPiA+
IEknbSBoaXR0aW5nIGNvbmZsaWN0cyAoPykgd2hlbiBJIGFwcGx5IHRoaXMgb24gdG9wIG9mWzFd
LiBEbyB5b3UKPiA+IG1pbmQKPiA+IHJlYmFzaW5nIGl0Pwo+ID4gCj4gPiBbMV06IGh0dHBzOi8v
Z2l0aHViLmNvbS9hbWJvYXIvbGludXgvdHJlZS9mb3IvYm1jL2FzcGVlZC9kdAo+IAo+IFN1cmUu
wqAgSXQgbG9va3MgbGlrZSBzb21lb25lIGVsc2V3aGVyZSBjaGFuZ2VkIHRoZSBzcGktcngtYnVz
LXdpZHRoCj4gd2hpY2ggaXMgY2F1c2luZyB0aGUgY29uZmxpY3QuwqAgSSdsbCByZXNlbnQgYSBy
ZWJhc2UuCj4gCj4gSSdkIGxpa2UgdGhpcyBiYWNrcG9ydGVkIHRvIHRoZSBvcGVuYm1jIHRyZWUg
YWxzby7CoCBOb3Qgc3VyZSB3aGljaAo+IHZlcnNpb24gaXMgYmVzdCBmb3IgdGhhdCB0cmVlIHJp
Z2h0IG5vdy4KPiAKCkkndmUgYXBwbGllZCB0aGUgcmViYXNlZCBwYXRjaCB0byBib3RoICh0aGUg
YmFja3BvcnQgZGlkbid0IGNvbmZsaWN0KS4KCkFuZHJldwo=


