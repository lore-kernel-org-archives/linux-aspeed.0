Return-Path: <linux-aspeed+bounces-772-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC72C021AF
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Feb 2025 01:12:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YyJKd5Gngz2yFQ;
	Wed, 19 Feb 2025 12:12:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739927573;
	cv=none; b=ZNkyk4hXQKGJYmv0IjIIRBclt/Tlbjlcvt6HH9iD6ybYuIsftfJYYxrdSYQEMWfH+0RDiBq0nND4UqG1SxsCDfBwX6hbRDwKlKgtg+j5Xr1P2ygmIG6OKGVhxkokrPkG6ik+2edn3hkb8bWD0e8OJO5xezZJDa9fybcooe7K9jJD0rVjKWT8mMg0sI6UstELkGNA26Z7Ln9/W67VkJwjZNAObRtTpkQBzSZq1+uszFcFW7RC/ECd9W3ZPu/EPFdGkT3mZEo/ORqJqlg3b+LCM7vss8XcNgx0mn2wtqoqzgkLJBk0EbBbj1v79o2C/QP+sLqMPzOerMt9xtxMGJXJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739927573; c=relaxed/relaxed;
	bh=Ni1r638kXhz6gOBSh0GzjFMf1Ey2XUVcA0yKk/KtpJY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KPppSEEnwdDsGov+wOdublRFReDiAn3cGXJTzbUNGi0eoZILBoeK7pAdqIvYgvkTHIryaIcG9IKiGgD4/1SPmfLPzwYJWkB+rO0se5SXEohsdOFbKP3yZ/itdXvkStREX3WbFv/LXdq7azddT2UmlXD1+CILHY69nE6DJFqfatfRNNXp+Wk5hiA6kpTMwTQBUtd8k/Cv2SIVx/AkoV/n7CfpNahIsnZfgdXciwOIlApqUMxLtxCrMVtY9eVhhVzv/rvaPx0CO3nqAAtgTbgjpJA/Dt0E13B0HF8JJ235H6PN2YIu2VpuMxCEfA6t+mZMxkzN952RTXWeEtFObX40GA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=GG4Nw1bv; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=GG4Nw1bv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YyJKd1m9dz2xG5
	for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Feb 2025 12:12:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739927572;
	bh=Ni1r638kXhz6gOBSh0GzjFMf1Ey2XUVcA0yKk/KtpJY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GG4Nw1bvSKh8tDf3E+2t/uMIf7OolfOAl6mSmUWL6zpk45Zsy2/B31/S+KrMPCKx4
	 ptMe2y+TaQ2da9TTRW4kF91rgL/iQlVLR8uTcQTUm/mkyAlBGk2h+6SjjiBPdty042
	 h6X9e2gKDVlq9GIMEyIiGdMm2RHoRjy9z9B9qsjsIku2Ec1nKqcf7b75A5v1Nw7cR5
	 3XUMMv21fA2X652KA2KlzJ3oMwWKUiie9gAbHsrtYmI3bTWaF8gzoZDIEvzvccX30x
	 2uoYuiCFfVP9hCm3IzcbGoVzFO5AHfBXbNNAq3JxbEULwt1kbNRAwVTXLg2nANYCZJ
	 SBKyx4CtVg8PA==
Received: from [192.168.68.112] (203-173-1-6.dyn.iinet.net.au [203.173.1.6])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id ECA6176191;
	Wed, 19 Feb 2025 09:12:51 +0800 (AWST)
Message-ID: <a7df160add1563a69573e00af44caf8bb73f520b.camel@codeconstruct.com.au>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: aspeed-g6.dtsi: enable IRQ for
 watchdogs
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Heyi Guo <guoheyi@linux.alibaba.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Date: Wed, 19 Feb 2025 11:42:51 +1030
In-Reply-To: <20250218031709.103823-2-guoheyi@linux.alibaba.com>
References: <20250218031709.103823-1-guoheyi@linux.alibaba.com>
	 <20250218031709.103823-2-guoheyi@linux.alibaba.com>
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

SGkgSGV5aSwKCk9uIFR1ZSwgMjAyNS0wMi0xOCBhdCAxMToxNiArMDgwMCwgSGV5aSBHdW8gd3Jv
dGU6Cj4gVG8gZmluYWxseSBlbmFibGUgd2F0Y2hkb2cgcHJldGltZW91dCBmdW5jdGlvbi4KPiAK
PiBTaWduZWQtb2ZmLWJ5OiBIZXlpIEd1byA8Z3VvaGV5aUBsaW51eC5hbGliYWJhLmNvbT4KPiAK
PiBDYzogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4KPiBDYzogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6aytkdEBrZXJuZWwub3JnPgo+IENjOiBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtl
cm5lbC5vcmc+Cj4gQ2M6IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+Cj4gQ2M6IEFuZHJl
dyBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+Cj4gLS0tCj4gwqBhcmNoL2Fy
bS9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWc2LmR0c2kgfCA0ICsrKysKPiDCoDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMv
YXNwZWVkL2FzcGVlZC1nNi5kdHNpCj4gYi9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQvYXNwZWVk
LWc2LmR0c2kKPiBpbmRleCA4ZWQ3MTViZDUzYWEuLmVmN2NlZDI4NWM0NCAxMDA2NDQKPiAtLS0g
YS9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWc2LmR0c2kKPiArKysgYi9hcmNoL2Fy
bS9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWc2LmR0c2kKPiBAQCAtNTM4LDIzICs1MzgsMjcgQEAg
dWFydDU6IHNlcmlhbEAxZTc4NDAwMCB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgd2R0MTogd2F0Y2hkb2dAMWU3ODUwMDAgewo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21w
YXRpYmxlID0gImFzcGVlZCxhc3QyNjAwLXdkdCI7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZyA9IDwweDFlNzg1MDAw
IDB4NDA+Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGludGVycnVwdHMgPSA8R0lDX1NQSSAyNAo+IElSUV9UWVBFX0xFVkVM
X0hJR0g+OwoKVGhlIGJpbmRpbmcgd2lsbCBuZWVkIGFuIHVwZGF0ZSB0byBhbGxvdyAnaW50ZXJy
dXB0cycgYXMgYW4gb3B0aW9uYWwKcHJvcGVydHkuCgpBbmRyZXcK


