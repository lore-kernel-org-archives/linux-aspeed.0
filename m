Return-Path: <linux-aspeed+bounces-1761-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8415AC83F27
	for <linux-aspeed@archiver.kernel.org>; Mon, 21 Jul 2025 03:52:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4blmgY1TDnz2yRD;
	Mon, 21 Jul 2025 13:52:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753069945;
	cv=none; b=QL4eX9EzDI66WsvMvwPowp2xxOyM8tffAWscVVNtbRALBkoK2SHKO4xCYaeoVzFttp/E2l1oVe2OxyntTxsLaIBvqebT5BXG3D9RHxk6uWrPw/986QlHlIIbZu2o/S2fDYwJwHyofFnTJXevlBwsG5oLWvB1eSdXVPhUrPfru6a+nlvFqKAIjgXMNbwBKmjzeZTyoxwclNvj9Iq526pxpCyqWriF86qlVVXmJCYGL1RRbNP8AhDiT1BvT+UMNebsdub6KBLww4GBdNyxF2BGTxjFSikKI61126O7LegfczMOmxNMQt1Q0kz7LyioDJyM3hnyuRvcRosk+9GpCcLjvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753069945; c=relaxed/relaxed;
	bh=Iu+5IVXA6pbzC+y9EyJIaWB0KxreFLrxpLXUy3Xbk7I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ft5bs7bht1Gq/ylKV7+D67I6k2V3SU0viWKMAc05sC64M+NyrBoWymrFx/GI20/ntJ4rAAoc17QFjT7ZQ6h0OMU96GtozzdLIghcJv6JSB/zAqgztlbpNtKUU3GdxXR0etE4VtgdCGTJgrtWOES43Z4d4mgjXRc8lK1ej+qFF7mpD1sqEkuVdt+S2NHQtZCHoIKkQZdL3DYSovlz2u89Kq/IAWyLj0f89MrWloSV9J8ZZZtYtAXFgS08tBaqCU5da1iR5u5zLVsuk1MJuW+gt4VZ22YVswfet0WiFU0BGt0GXQvh84iSNEYHEBWy2qvqG6Xdf4uSUz91St25R0DB+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=QnWEapU1; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=QnWEapU1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4blmgX3zqQz2yFQ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 21 Jul 2025 13:52:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1753069943;
	bh=Iu+5IVXA6pbzC+y9EyJIaWB0KxreFLrxpLXUy3Xbk7I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QnWEapU1KJwFhPi0H8SqC7IGQ+rS4thZas19e+89eSgYus/fFo7Erw5lkQzWhGobp
	 sEfzpXqR5pqjHveRlUktHBPgi7nCjeZMLX7QWc1Re9+yKWEAKLiOd7MZd45aj27zD9
	 SpXgFop+4zsNrVblzmb6rJqd1Hambs4C8wy1GdX8RtGxkJ5wz/Z0TYG80bMMxPwGYH
	 ZIdFYsYy5XVilJBjqjFME/lGXZrrrb9I9VuZ4UdN4MZ4Bdn23+sJDAC8rrbW9s+v7f
	 LiMwLStxZOnNEQVxsvrRzWGMkbxy5LIYpQExqsR/sPzgWnGECjS6ComyetMO0oCTfK
	 Xihalh19KCsaQ==
Received: from [192.168.68.112] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7E777640A2;
	Mon, 21 Jul 2025 11:52:20 +0800 (AWST)
Message-ID: <c980c6c55f3a4914f1393498763bdf9cfb109ad2.camel@codeconstruct.com.au>
Subject: Re: [PATCH v8 2/2] ARM: dts: aspeed: clemente: add Meta Clemente BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Leo Wang <leo.jt.wang@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Kees Cook
 <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,  "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus
 Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	leo.jt.wang@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
	bruce.jy.hung@fii-foxconn.com
Date: Mon, 21 Jul 2025 13:22:19 +0930
In-Reply-To: <20250717-add-support-for-meta-clemente-bmc-v8-2-2ff6afb36b0e@fii-foxconn.com>
References: 
	<20250717-add-support-for-meta-clemente-bmc-v8-0-2ff6afb36b0e@fii-foxconn.com>
	 <20250717-add-support-for-meta-clemente-bmc-v8-2-2ff6afb36b0e@fii-foxconn.com>
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
Precedence: list
MIME-Version: 1.0

T24gVGh1LCAyMDI1LTA3LTE3IGF0IDIyOjU5ICswODAwLCBMZW8gV2FuZyB3cm90ZToKPiBGcm9t
OiBMZW8gV2FuZyA8bGVvLmp0LndhbmdAZ21haWwuY29tPgo+IAo+IEFkZCBsaW51eCBkZXZpY2Ug
dHJlZSBlbnRyeSBmb3IgTWV0YSBDbGVtZW50ZSBjb21wdXRlLXRyYXkKPiBCTUMgdXNpbmcgQVNU
MjYwMCBTb0MuCj4gCj4gU2lnbmVkLW9mZi1ieTogTGVvIFdhbmcgPGxlby5qdC53YW5nQGdtYWls
LmNvbT4KPiAKClsuLi5dCgo+ICvCoMKgwqDCoMKgwqDCoH07Cj4gKwo+ICsvLyBQREIgVEVNUCBT
RU5TT1IKClRoaXMgY29tbWVudCBzaG91bGQgYmUgaW5kZW50ZWQgYXBwcm9wcmlhdGVseT8KCj4g
K8KgwqDCoMKgwqDCoMKgdGVtcGVyYXR1cmUtc2Vuc29yQDRlIHsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJ0aSx0bXAxMDc1IjsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmVnID0gPDB4NGU+Owo+ICvCoMKgwqDCoMKgwqDCoH07Cj4gCgpb
Li4uXQoKPiArCj4gKyZpMmMxMSB7Cj4gK8KgwqDCoMKgwqDCoMKgc3RhdHVzID0gIm9rYXkiOwo+
ICvCoMKgwqDCoMKgwqDCoGFzcGVlZCxlbmFibGUtYnl0ZTsKClRoaXMgaXMgbm90IGEgcHJvcGVy
dHkgc3BlY2lmaWVkIGluIGFueSBhY2NlcHRlZCBiaW5kaW5nLCBwbGVhc2UgZHJvcAppdC4KCiAg
IGFyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtYm1jLWZhY2Vib29rLWNsZW1lbnRlLmR0
YjogaTJjQDYwMCAoYXNwZWVkLGFzdDI2MDAtaTJjLWJ1cyk6IFVuZXZhbHVhdGVkIHByb3BlcnRp
ZXMgYXJlIG5vdCBhbGxvd2VkICgnYXNwZWVkLGVuYWJsZS1ieXRlJyB3YXMgdW5leHBlY3RlZCkK
ICAgCWZyb20gc2NoZW1hICRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvaTJjL2Fz
cGVlZCxpMmMueWFtbCMKCj4gKwo+ICvCoMKgwqDCoMKgwqDCoHNzaWYtYm1jQDEwIHsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJzc2lmLWJtYyI7Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZyA9IDwweDEwPjsKPiArwqDCoMKgwqDCoMKg
wqB9Owo+ICt9Owo+IAoKWy4uLl0KCj4gKwo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0
cy9hc3BlZWQvYXNwZWVkLWc2LXBpbmN0cmwuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVl
ZC9hc3BlZWQtZzYtcGluY3RybC5kdHNpCj4gaW5kZXggMjg5NjY4ZjA1MWViNDI3MWFjNDhhZTNj
ZTliODI1ODc5MTE1NDhlZS4uNjFiMWQxYzUwNDBjODIwZjhjOTk1MTMyNzM5YmVjZGU4MGUwNjli
YiAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWc2LXBpbmN0
cmwuZHRzaQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtZzYtcGluY3Ry
bC5kdHNpCj4gQEAgLTQxMiw2ICs0MTIsMTYgQEAgcGluY3RybF9tZGlvNF9kZWZhdWx0OiBtZGlv
NF9kZWZhdWx0IHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdyb3VwcyA9ICJN
RElPNCI7Cj4gwqDCoMKgwqDCoMKgwqDCoH07Cj4gwqAKPiArwqDCoMKgwqDCoMKgwqBwaW5jdHJs
X25jc2kzX2RlZmF1bHQ6IG5jc2kzX2RlZmF1bHQgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBmdW5jdGlvbiA9ICJSTUlJMyI7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGdyb3VwcyA9ICJOQ1NJMyI7Cj4gK8KgwqDCoMKgwqDCoMKgfTsKPiArCj4gK8KgwqDCoMKg
wqDCoMKgcGluY3RybF9uY3NpNF9kZWZhdWx0OiBuY3NpNF9kZWZhdWx0IHsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgZnVuY3Rpb24gPSAiUk1JSTQiOwo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBncm91cHMgPSAiTkNTSTQiOwo+ICvCoMKgwqDCoMKgwqDCoH07Cj4g
KwoKQ2FuIHlvdSBwbGVhc2UgbWFrZSB0aGlzIGEgc2VwYXJhdGUgcGF0Y2g/CgpUaGFua3MsCgpB
bmRyZXcK


