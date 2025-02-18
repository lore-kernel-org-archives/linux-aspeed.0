Return-Path: <linux-aspeed+bounces-760-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3918DC021A9
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Feb 2025 00:57:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yxh1n69t3z2xs7;
	Tue, 18 Feb 2025 11:57:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739840221;
	cv=none; b=kGS+//Owraj0Q16OI5A8PyCSG6INhurDREEYEvzrW8HzXnlB3m0F8Sot8yrO8Jqcyo8CipfUIaxyJEybLdg9H4jBoqM/4YqEZGQYlO9IIB1jx5y4bVF38yGgIwZVPB8iZwFRoM1juDzwdYdIsT15mCwttxqrKjoV5g5rMakmfKJdRbEfwYn68HWoJE6V57uXt1Vc3WfR5grDE9E00IfWKFl6PdSSfK391eeetfDeKCoptnYUXE/cec/7ePEC46o1Cz+6phcqOtbK+4HEz/6QEZgJyxB36C8BCi2dm45BOc+LxkJDvBKAxbR3/MbLM7gDzLGfr3Ge/a81ki9rzdWfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739840221; c=relaxed/relaxed;
	bh=EkQ8ik4KdAGTrmDROq1yWEvtaKgYAVb1rRwmJhpHbIY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OLNSK79CsYu5E3/Qo0aknVC/mj+jJvrZ3LJfqVz3ISFLEd6g74Jz6iv6YN3FrzOSroLb+RLS5TWYftuxwgZ63+ts4aRB/kn5p4WNrXMgnX8NM1Tu6ghIQV43Le/vq5OkU5p5FjkJz1EVbcnLhajxtLyQ7kBJzvcwCrxEyLRctQMYezAbcNWyR/PERyj6AjSgJVPxNTORpqabXyPHjUdw4qGRx6xyd5iWN8peKoWC8mzn6JzxCWc0IIIqFxXBLEek5smiD0hVLoDDg62F1PPOvaYdlG7zgkcMMpcKwGQTzRauWmwy9rHZ2fUBkq3KkZdCXi5kDG4i/GBBBY7+0ndonw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=PKHF027/; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=PKHF027/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yxh1m44ZYz2xrC
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Feb 2025 11:57:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739840217;
	bh=EkQ8ik4KdAGTrmDROq1yWEvtaKgYAVb1rRwmJhpHbIY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PKHF027/YqWI0hLDSpaf6m8oWe3aOeZOErMZjZyNQK/1VLMrsayuAOE9MEeeRmyeG
	 Zya4NJgfYPP7QoVHwEi25s3nATtH1x/QivmUGOdTzFfc/dSXlcdIedaSHkwfN/M0Q7
	 ISJ5sz/LA6WAvmEl3mFtlMXoCysBYbssI53AalZv5prualDQ3f4ENR+SdxHGpImIOZ
	 EoDpYyDX5UGmIG0L+Csp/Qu1AMif4DGQRpwp4a3vULIfLxUCnspSpP98Jurxmyr7Oj
	 y1F503EdhB5E1H/gwdiSnrVDzPjMTSxt5aDs+SX0qyp70hqIwAdNcyJ4uejTQ646mL
	 itPZMdMybTs+g==
Received: from [192.168.68.112] (ppp118-210-165-49.adl-adc-lon-bras34.tpg.internode.on.net [118.210.165.49])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5BB64759DD;
	Tue, 18 Feb 2025 08:56:54 +0800 (AWST)
Message-ID: <6fd7cd57261ddf9831f57dc4c637b24e9f8982d9.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Krzysztof Kozlowski <krzk@kernel.org>, Kevin Chen
 <kevin_chen@aspeedtech.com>, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org,  conor+dt@kernel.org, joel@jms.id.au,
 chiawei_wang@aspeedtech.com,  linux-aspeed@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org
Cc: "tomer.maimon" <tomer.maimon@nuvoton.com>
Date: Tue, 18 Feb 2025 11:26:53 +1030
In-Reply-To: <e43b5f8f-37e4-4468-b3ca-5059a5e6f3c3@kernel.org>
References: <20250217114831.3225970-1-kevin_chen@aspeedtech.com>
	 <20250217114831.3225970-4-kevin_chen@aspeedtech.com>
	 <e43b5f8f-37e4-4468-b3ca-5059a5e6f3c3@kernel.org>
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

T24gTW9uLCAyMDI1LTAyLTE3IGF0IDEzOjAwICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOgo+IE9uIDE3LzAyLzIwMjUgMTI6NDgsIEtldmluIENoZW4gd3JvdGU6Cj4gPiArCj4gPiAr
wqDCoMKgwqDCoMKgwqBwY2MtPm1kZXYucGFyZW50ID0gZGV2Owo+ID4gK8KgwqDCoMKgwqDCoMKg
cGNjLT5tZGV2Lm1pbm9yID0gTUlTQ19EWU5BTUlDX01JTk9SOwo+ID4gK8KgwqDCoMKgwqDCoMKg
cGNjLT5tZGV2Lm5hbWUgPSBkZXZtX2thc3ByaW50ZihkZXYsIEdGUF9LRVJORUwsICIlcyVkIiwK
PiA+IERFVklDRV9OQU1FLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBjYy0+bWRldl9pZCk7
Cj4gPiArwqDCoMKgwqDCoMKgwqBwY2MtPm1kZXYuZm9wcyA9ICZwY2NfZm9wczsKPiA+ICvCoMKg
wqDCoMKgwqDCoHJjID0gbWlzY19yZWdpc3RlcigmcGNjLT5tZGV2KTsKPiA+ICvCoMKgwqDCoMKg
wqDCoGlmIChyYykgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9lcnIo
ZGV2LCAiQ291bGRuJ3QgcmVnaXN0ZXIgbWlzYyBkZXZpY2VcbiIpOwo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gZXJyX2ZyZWVfa2ZpZm87Cj4gPiArwqDCoMKgwqDCoMKg
wqB9Cj4gCj4gWW91IGNhbm5vdCBleHBvc2UgdXNlci1zcGFjZSBpbnRlcmZhY2VzIGZyb20gU29D
IGRyaXZlcnMuIFVzZQo+IGFwcHJvcHJpYXRlIHN1YnN5c3RlbSBmb3IgdGhpcyB3aXRoIHByb3Bl
ciBBQkkgZG9jdW1lbnRhdGlvbi4KPiAKPiBTZWU6Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsL2JjNTExOGYyLTg5ODItNDZmZi1iYzc1LWQwYzcxNDc1ZTkwOUBhcHAuZmFzdG1haWwuY29t
Lwo+IGFuZCBtb3JlIGRpc2N1c3Npb25zIG9uIExLTUwKCkZ1cnRoZXIsIGRyaXZlcnMvbWlzYy9h
c3BlZWQtbHBjLXNub29wLmMgYWxyZWFkeSBleGlzdHM6CgpodHRwczovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD05
ZjRmOWFlODFkMGFmZmMxODJmNTRkZDAwMjg1ZGRiOTBlMGIzYWUxCgpLZXZpbjogRGlkIHlvdSBj
b25zaWRlciByZXdvcmtpbmcgaXQ/CgpOdXZvdG9uIGhhdmUgYSBzaW1pbGFyIGNhcGFiaWxpdHkg
aW4gdGhlaXIgTlBDTSBCTUMgU29DKHMpIHdpdGggdGhlCiJCUEMiICgiQklPUyBQT1NUIENvZGUi
IGNvbnRyb2xsZXIpLiBUaGVyZSBzaG91bGQgYmUgc29tZSBjb25zZW5zdXMgb24KdGhlIGJpbmRp
bmcgYW5kIHVzZXJzcGFjZSBpbnRlcmZhY2UuCgpBbmRyZXcK


