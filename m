Return-Path: <linux-aspeed+bounces-1760-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73184C83F27
	for <linux-aspeed@archiver.kernel.org>; Mon, 21 Jul 2025 03:41:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4blmRR12bVz2yRD;
	Mon, 21 Jul 2025 13:41:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753069315;
	cv=none; b=ZK0zOJU4uRSZGKI5uKUjL4gHnipGeYa60P1VjKDvaM/XkuD3gMvvyCmdNYjkxrRUGvUhB8Cizco7wKlVOHirlA5+SHp90SzE7pY8ZvG1YsCgBgeiY1kHy48JCPMn8bRPkLtL5EXCAIGijVA5iNkjEOFCeWwHMX4nVEXy+51eNJFznqHVJXmgJPTLNhOBMiC85v+yX8GPZ+aZyDxNF4tCZGHcrwrS5er6n+r0WpWl6x9K6NwL9+inXVnaD/wkKUTiet7XqnVxcL0N+AgI1dJut5UDlvI5iWnScCwbvJdwtkLR+UF9sAlwCTprjn+fBWhxUpUp8BR6Trm8YrJXmd4Jzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753069315; c=relaxed/relaxed;
	bh=djinMyHrkJ5n7dzlbAD/6nrbYT2LBqXfvzxAjlsZNhE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L8lmvJW9NEjsTNM8QOou5FKWwFxgE11VecYNLFbC76fjwP9QCm7KGlq9yeXKIScfVvScaTomGsYs+ijwzQ/4VRVTFNFF8v/AADch1JcniMvu/DJUDQcEBn1ouTz9N7uuWa+JfrYd5Krvame6dyA0hsSKojp13wZTF+ycQaJAXsBZhh29zqyoPMHhKP5D0ZgGjl3HzPDTv0u8FwgjJEnFFQjjy2cqVS+4JBMvkwe6hk/381icGRNE+TAqZUyXqRyfGIK5ysU8Tjk6ME450QU00RUcmBUltYnu/4tsUdio6fngqCHSDG/RztF7pYBXOoJB0PgyOiC6FfQRTNyvCPMGhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=YGqGMQUe; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=YGqGMQUe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4blmRQ3r6hz2yFQ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 21 Jul 2025 13:41:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1753069313;
	bh=djinMyHrkJ5n7dzlbAD/6nrbYT2LBqXfvzxAjlsZNhE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YGqGMQUeegslztTz2EaY2w+T1MacbjFXR57eOOgspIan1d8R+KiKaarqX6Zoesoo8
	 wfhnykLpHc0NncsbSHaUaugzatffDreXLcY37hbVJctXxpw33uolytrVIqATUmM09o
	 1/JVF3jbmnlE9jZKWTGTpJRlZak/moj7j8JOr67qaW2GQvGVj6KP9APpZcTxcnauw4
	 RuaatlxjRQBDBe+hbEsadtmEyy5BBNodfYyUq6id5w/QjrFHSX/6drPR/0GFL9MSLZ
	 RII1FFM5CYvLPlC2Ysh2OnXB56CyAalVske1h/+x2Piymy27eygzRLl9VLsuGkQT5M
	 B/HMLYuzTI95w==
Received: from [192.168.68.112] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7FDBF640A2;
	Mon, 21 Jul 2025 11:41:52 +0800 (AWST)
Message-ID: <6b1ade72e11089b0fab13a4f6ef53a1ea65fa732.camel@codeconstruct.com.au>
Subject: Re: [PATCH v9 2/2] ARM: dts: aspeed: ventura: add Meta Ventura BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "P.K. Lee" <pkleequanta@gmail.com>, robh@kernel.org, krzk+dt@kernel.org,
  conor+dt@kernel.org, joel@jms.id.au, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, patrick@stwcx.xyz
Cc: Jerry.Lin@quantatw.com, Jason-Hsu@quantatw.com, yang.chen@quantatw.com, 
	p.k.lee@quantatw.com
Date: Mon, 21 Jul 2025 13:11:51 +0930
In-Reply-To: <20250716094329.1069203-3-pkleequanta@gmail.com>
References: <20250716094329.1069203-1-pkleequanta@gmail.com>
	 <20250716094329.1069203-3-pkleequanta@gmail.com>
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

T24gV2VkLCAyMDI1LTA3LTE2IGF0IDE3OjQzICswODAwLCBQLksuIExlZSB3cm90ZToKPiBBZGQg
TGludXggZGV2aWNlIHRyZWUgcmVsYXRlZCB0byBNZXRhIChGYWNlYm9vaykgVmVudHVyYSBzcGVj
aWZpYwo+IGRldmljZXMgY29ubmVjdGVkIHRvIHRoZSBCTUMgKEFTVDI2MDApIFNvQy4gVGhlIHB1
cnBvc2Ugb2YgVmVudHVyYSBpcyB0bwo+IGRldGVjdCBsaXF1aWQgbGVha2FnZSBmcm9tIGFsbCBj
b21wdXRlIHRyYXlzLCBzd2l0Y2ggdHJheXMgYW5kIHJhY2sKPiBzZW5zb3JzIHdpdGhpbiB0aGUg
cmFjaywgbG9nIHRoZSBldmVudHMsIGFuZCB0YWtlIG5lY2Vzc2FyeSBhY3Rpb25zCj4gYWNjb3Jk
aW5nbHkuCj4gCj4gU2lnbmVkLW9mZi1ieTogUC5LLiBMZWUgPHBrbGVlcXVhbnRhQGdtYWlsLmNv
bT4KPiAtLS0KPiDCoGFyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC9NYWtlZmlsZcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8wqDCoMKgIDEgKwo+IMKgLi4uL2FzcGVlZC9hc3BlZWQtYm1jLWZhY2Vi
b29rLXZlbnR1cmEuZHRzwqDCoMKgIHwgMTU1MyArKysrKysrKysrKysrKysrKwo+IMKgMiBmaWxl
cyBjaGFuZ2VkLCAxNTU0IGluc2VydGlvbnMoKykKPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNo
L2FybS9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWJtYy1mYWNlYm9vay12ZW50dXJhLmR0cwo+IAo+
IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQvTWFrZWZpbGUgYi9hcmNoL2Fy
bS9ib290L2R0cy9hc3BlZWQvTWFrZWZpbGUKPiBpbmRleCBjNGYwNjRlNGIwNzMuLjVlZDYwNDJl
ZWE5NyAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQvTWFrZWZpbGUKPiAr
KysgYi9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQvTWFrZWZpbGUKPiBAQCAtMjcsNiArMjcsNyBA
QCBkdGItJChDT05GSUdfQVJDSF9BU1BFRUQpICs9IFwKPiDCoMKgwqDCoMKgwqDCoMKgYXNwZWVk
LWJtYy1mYWNlYm9vay1taW5lcnZhLmR0YiBcCj4gwqDCoMKgwqDCoMKgwqDCoGFzcGVlZC1ibWMt
ZmFjZWJvb2stbWluaXBhY2suZHRiIFwKPiDCoMKgwqDCoMKgwqDCoMKgYXNwZWVkLWJtYy1mYWNl
Ym9vay10aW9nYXBhc3MuZHRiIFwKPiArwqDCoMKgwqDCoMKgwqBhc3BlZWQtYm1jLWZhY2Vib29r
LXZlbnR1cmEuZHRiIFwKCkknbSBoaXR0aW5nIGEgY29uZmxpY3QgaGVyZSwgY2FuIHlvdSBwbGVh
c2UgcmViYXNlIHRoaXMgc2VyaWVzIG9uIHRvcApvZiBhc3BlZWQvZHQgZnJvbSBbMV0/CgpbMV06
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2JtYy9saW51
eC5naXQvCgoKPiArCj4gK8KgwqDCoMKgwqDCoMKgbWVtb3J5QDgwMDAwMDAwIHsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2aWNlX3R5cGUgPSAibWVtb3J5IjsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVnID0gPDB4ODAwMDAwMDAgMHg4MDAwMDAwMD47Cj4g
K8KgwqDCoMKgwqDCoMKgfTsKPiArCj4gK8KgwqDCoCBwMXY4X2JtY19hdXg6IHJlZ3VsYXRvci1w
MXY4LWJtYy1hdXggewoKQ2FuIHlvdSBwbGVhc2UgZml4IHRoZSBpbmRlbnRhdGlvbiBoZXJlPwoK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJyZWd1bGF0b3It
Zml4ZWQiOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWd1bGF0b3ItbmFtZSA9
ICJwMXY4X2JtY19hdXgiOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWd1bGF0
b3ItbWluLW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MTgwMDAwMD47Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHJlZ3VsYXRvci1hbHdheXMtb247Cj4gK8KgwqDCoMKgwqDCoMKg
fTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgcDJ2NV9ibWNfYXV4OiByZWd1bGF0b3ItcDJ2NS1ibWMt
YXV4IHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJyZWd1
bGF0b3ItZml4ZWQiOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWd1bGF0b3It
bmFtZSA9ICJwMnY1X2JtY19hdXgiOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBy
ZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwyNTAwMDAwPjsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MjUwMDAwMD47Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZ3VsYXRvci1hbHdheXMtb247Cj4gK8KgwqDCoMKg
wqDCoMKgfTsKPiArCj4gK8KgwqDCoCBzcGkxX2dwaW86IHNwaSB7CgpBbmQgYWdhaW4gaGVyZT8K
ClBsZWFzZSBjaGVjayB0aGUgZW50aXJlIGRldmljZXRyZWUgZm9yIHNpbWlsYXIgaXNzdWVzLgoK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJzcGktZ3BpbyI7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCNhZGRyZXNzLWNlbGxzID0gPDE+Owo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAjc2l6ZS1jZWxscyA9IDwwPjsKPiArCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNjay1ncGlvcyA9IDwmZ3BpbzAgQVNQRUVE
X0dQSU8oWiwgMykgR1BJT19BQ1RJVkVfSElHSD47Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoG1vc2ktZ3Bpb3MgPSA8JmdwaW8wIEFTUEVFRF9HUElPKFosIDQpIEdQSU9fQUNUSVZF
X0hJR0g+Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtaXNvLWdwaW9zID0gPCZn
cGlvMCBBU1BFRURfR1BJTyhaLCA1KSBHUElPX0FDVElWRV9ISUdIPjsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgY3MtZ3Bpb3MgPSA8JmdwaW8wIEFTUEVFRF9HUElPKFosIDApIEdQ
SU9fQUNUSVZFX0xPVz47Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG51bS1jaGlw
c2VsZWN0cyA9IDwxPjsKPiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRwbUAw
IHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBh
dGlibGUgPSAiaW5maW5lb24sc2xiOTY3MCIsICJ0Y2csdHBtX3Rpcy1zcGkiOwo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3BpLW1heC1mcmVxdWVuY3kg
PSA8MzMwMDAwMDA+Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmVnID0gPDA+Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Owo+ICvC
oMKgwqDCoMKgwqDCoH07Cj4gK307Cj4gKwoKWy4uLl0KCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGkyYzNtdXgwY2gzOiBpMmNAMyB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAjYWRkcmVzcy1jZWxscyA9IDwxPjsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCNzaXplLWNlbGxzID0gPDA+Owo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVnID0gPDM+
Owo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8v
IEZhbiBCb2FyZCAwIEZSVQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgZWVwcm9tQDU2IHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0gImF0bWVsLDI0YzEyOCI7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmVnID0gPDB4NTY+Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgfTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBmYW5fbGVkc19nMV9ncGlvOiBncGlvQDIxIHsKClBsZWFzZSBtYWtlIHN1
cmUgdGhlIGRldmljZXRyZWUgbWVldHMgdGhlIHN0eWxlIGd1aWRlWzJdLCBwYXJ0aWN1bGFybHkK
dGhlIG9yZGVyIG9mIG5vZGVzOgoKaHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcvZGV2aWNldHJlZS9i
aW5kaW5ncy9kdHMtY29kaW5nLXN0eWxlLmh0bWwjb3JkZXItb2Ytbm9kZXMKCkhlcmUsIGRldmlj
ZXMgc2hvdWxkIGJlIGxpc3RlZCBpbiBhc2NlbmRpbmcgb3JkZXIgb2YgYWRkcmVzcy4KClBsZWFz
ZSBjaGVjayB0aGUgZW50aXJlIGRldmljZXRyZWUuCgpbMl06IGh0dHBzOi8vZG9jcy5rZXJuZWwu
b3JnL2RldmljZXRyZWUvYmluZGluZ3MvZHRzLWNvZGluZy1zdHlsZS5odG1sCgpBbmRyZXcK


