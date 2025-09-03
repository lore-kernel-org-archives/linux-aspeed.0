Return-Path: <linux-aspeed+bounces-2118-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D512BCA1007
	for <linux-aspeed@archiver.kernel.org>; Wed,  3 Sep 2025 04:31:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cGqSH3GTTz2xQ1;
	Wed,  3 Sep 2025 14:31:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756873887;
	cv=none; b=ihRNXH9UnlHTa/dLA8y4fw5GGtaMDAEUIqn7r4mhWCxEyZ+D+1ra6W173iJ1Ly0uQVUKB06YD/6y4H3vz9a2oq8osTmJXBfRLJG3zPYmHoeIpHTw/Xu8t4S/UbHdzDvZSeuzc2RvXd1INH2hbpe374RbUiqfkjXi3ovSN3cP+IWgEG1fNuqZc628Muedp/3cPds7vxeOGQf4DS9yetJnbyjUeGbCE4fhypnCQrsfdSRNN/POBVl3s+6vnA/DOGtuxKhfQaLQBoPXysXyBEpO1MWUtuYbVJxOldOzmktyg/LqAoD90Eg9CcpXe+SKZh6ov7cxw8YM7FRxety3u9DwlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756873887; c=relaxed/relaxed;
	bh=zOfqp69JcHUenStvsJhSWzm74vh4e1gjzLYrUutW6B4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CCuWj4/+5thoc5UsBI8EP4hK5Tk4BHm3HRz/3Db3CQ6IoYMAIjqe67zQI3hsj+1XnSm3G5eMjl0ASN9DeSJ0VW/wXWGNI93F1Py46fCatlwRy4yrTdpOEQ7sBmaCbzCPDoh34Gw95DMO1VeKeJJI4FXNAddx61O59Utvdw5iMw077m9FrZ4hHm3vVjE7m0wStII2v5AlTP+kZrUaCMrDI3EhodukwxZ/Xmcw8dd6ngpzJpgPSdgPeqX4QeDS8wE1FKXo/AGqPy6t+b162yPWTIsRlzdg/gG0U6jE0ZynUFe5ryN/jTnmQ5kXT1ccB3Y1mQWFwYCsHPIwyJezs1U+EA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=O/Q0+huT; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=O/Q0+huT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cGqSH01v1z2xK4
	for <linux-aspeed@lists.ozlabs.org>; Wed,  3 Sep 2025 14:31:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756873885;
	bh=zOfqp69JcHUenStvsJhSWzm74vh4e1gjzLYrUutW6B4=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=O/Q0+huTqBG5Gci+NR6iWMVRDmD/ivXH9zJMQTBvhMosT3ddDaIrwYrEpax1mEsGU
	 uOudqMsjwzGhx4g8z5V+Il3mXfk9JbMAx/FG/leY6hYZkSmMzgiS7oSwKqan6oXMtW
	 eC7PHv+6g+iQBPqU1R/QL41KA7ruDcywh8LzH+J4m+vQfQMGC+K3BBTvCl3doU/O8v
	 YeJqwZ6/lWTREgVFa0M6gQt7kl5c1NvlcOLkYJGczMXSZb8UGT6bfVBYoEEeg1XlmK
	 1S0ZXDTD3W5CgV8AgqSZMxTXM3AiuaFA5sIFFQVA9wjRrvWSD4YP+km8nJs9Wfinyy
	 lQ4Ych5bkaZJg==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D50876E02C;
	Wed,  3 Sep 2025 12:31:23 +0800 (AWST)
Message-ID: <3a65d568540e9ca43d3bfc24cfe5f72d2bb12b3b.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 3/3] ARM: dts: aspeed: harma: add mp5990
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Peter Yin <peteryin.openbmc@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 03 Sep 2025 14:01:22 +0930
In-Reply-To: <20250828074955.542711-4-peteryin.openbmc@gmail.com>
References: <20250828074955.542711-1-peteryin.openbmc@gmail.com>
	 <20250828074955.542711-4-peteryin.openbmc@gmail.com>
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

SGkgUGV0ZXIsCgpPbiBUaHUsIDIwMjUtMDgtMjggYXQgMTU6NDkgKzA4MDAsIFBldGVyIFlpbiB3
cm90ZToKPiBBZGQgc3VwcG9ydCBmb3IgdGhlIEhTQyBNUDU5OTAgZGV2aWNlIG9uIHRoZSBIYXJt
YSBwbGF0Zm9ybS4KPiAKPiBUaGlzIGNoYW5nZSB1cGRhdGVzIHRoZSBkZXZpY2UgdHJlZSB0byBp
bmNsdWRlIHRoZSBNUDU5OTAgSFNDCj4gKEhvdCBTd2FwIENvbnRyb2xsZXIpLCBhbGxvd2luZyBw
cm9wZXIgY29uZmlndXJhdGlvbiBhbmQgaW50ZWdyYXRpb24KPiB3aXRoIHRoZSBwbGF0Zm9ybS4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBZaW4gPHBldGVyeWluLm9wZW5ibWNAZ21haWwuY29t
Pgo+IC0tLQo+IMKgYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMtZmFjZWJvb2st
aGFybWEuZHRzIHwgNCArKysrCj4gwqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4g
Cj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtYm1jLWZhY2Vi
b29rLWhhcm1hLmR0cwo+IGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMtZmFj
ZWJvb2staGFybWEuZHRzCj4gaW5kZXggODEyNzhhNzcwMmRlLi4yM2VhZjQ3YTM4ZTggMTAwNjQ0
Cj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMtZmFjZWJvb2staGFy
bWEuZHRzCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMtZmFjZWJv
b2staGFybWEuZHRzCj4gQEAgLTUyMCw2ICs1MjAsMTAgQEAgaW11eDI4OiBpMmNAMCB7Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgI2FkZHJlc3MtY2Vs
bHMgPSA8MT47Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgI3NpemUtY2VsbHMgPSA8MD47Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcmVnID0gPDA+Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcG93ZXItc2Vuc29yQDIwIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0g
Im1wcyxtcDU5OTAiOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZyA9IDwweDIwPjsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH07Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcG93ZXItbW9uaXRvckA2MSB7Cj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBh
dGlibGUgPSAiaXNpbCxpc2w2OTI2MCI7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZyA9IDwweDYxPjsKCkkndmUgYXBw
bGllZCB0aGUgc2VyaWVzLCBob3dldmVyLCBjYW4geW91IHBsZWFzZSBzZW5kIGEgZm9sbG93LXVw
IHBhdGNoCmFkZGluZyBuZXctbGluZXMgYmV0d2VlbiB0aGUgY2hpbGQgbm9kZXMgb2YgaW11eDI4
PyBJdCdzIG5vdCBjb25zaXN0ZW50CndpdGggdGhlIHJlc3Qgb2YgdGhlIGRldmljZXRyZWUgYW5k
IGlzIGEgYml0IGRlbnNlLgoKVGhhbmtzLAoKQW5kcmV3Cgo=


