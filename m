Return-Path: <linux-aspeed+bounces-3764-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A924FFEA838
	for <linux-aspeed@archiver.kernel.org>; Wed, 25 Mar 2026 09:16:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgh8w2b76z2xPL;
	Wed, 25 Mar 2026 20:16:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774430160;
	cv=none; b=P3Lwbu9Pkbwo1fKHwSY5qTpBp8CAqh497iuD3+4VBQCrEYwZxNotjCluSHJfMIqnhqyBYn/RGKvUxdRj4v9gp8+F8Nb/Xq4hX+Xe76r8HXzusoPGwYoyrcOfn+dbq9TRx9Iwlv0u5DrccUF3jWdRcQ5Y8OstpqRSr9yJ7vE0AMa+bM5It+RJ+2ckJ8UzfK6qVXB2+0h7zLlC6Bzm/HjFjj1Vd3DEqGkfipT+VLFyFv7bNC/irDXz3+C2KFZ1QtEr0bTAb6YMzNlPolnG7wZnyFtTa6R+7aNubCVusjzDPi17QptmJ7/AQTenYtpW7DTTZ7CbO4WRn+/zllmKPpnWcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774430160; c=relaxed/relaxed;
	bh=gK91G0Kh3+mdj3OrhSUyPB44TdtMO6pJoTRl9mo39qQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Npk8lb9fwMo6VBG/nnVvyNlIMgYhoFBfzRUokcpmgwSxkwKvpXcUUZtUxyqcCb72/py4eUQacj2Q7GtbEXRATFG5ZPlzPqSKdTdPxd6ZlrN9Zt0ptQ3GryiL4h1rVxqgFYO7cksdfljuzL1ES7sxy+oj2VDpAfPi89AI660Xj0I4PhnjKcMcia2HLTmlVP29pTbuVGTWo3xrnb4UeAcdZc6KwpYExSGkTRjd3x5UFTPT0ZTWnJJh7KoFy2tMUBH5v0rG5cAaT+MS1TKtlwdmq9jUOTH69urrE7bzcC2wI+qQGgxB+Mi+iYmvgoX/3S7lGsMZd+iXxiwffaL8ZZNphw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ZnphFnjB; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=jk@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ZnphFnjB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=jk@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgh8t5Q8Tz2xMt;
	Wed, 25 Mar 2026 20:15:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1774430157;
	bh=gK91G0Kh3+mdj3OrhSUyPB44TdtMO6pJoTRl9mo39qQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZnphFnjBKvQXgZewq1BcRIyvVp/KbXTSwy5zs660K1Q/BPNeFqfRZfvVEdKoK67iR
	 OVB8Y5kuoKvgaLyJk0RFnEfYhPhmM5xSgFwWqE1TQfZ4A8Q5LHrsPY6L3C4c+y0StC
	 OEkHNOg8VK9kjYfrF6V0ZUlbncIGBOaC+LfLuQHDTj3IvZtyI9FzdhjcbzZW6Wq7Wh
	 13E+wFO/y6QXMrBDMmSuEOtMAhnAcwCycyfzTWRKxalbbA2FES4fnkF+y9troHKI2j
	 dt7XWyY2nv5lSC77qVcjwQtL3Wz5wItkd8JRLeHrf/KKGBum3zbKOG2EP+L8cZhcCQ
	 2mYJfLdMxno2w==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7D3296452E;
	Wed, 25 Mar 2026 17:15:54 +0800 (AWST)
Message-ID: <28eee6d05ed1e1814f09ec907d56798a279f226d.camel@codeconstruct.com.au>
Subject: Re: [PATCH v27 3/4] i2c: ast2600: Add controller driver for AST2600
 new register set
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Ryan Chen <ryan_chen@aspeedtech.com>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>,  Philipp Zabel <p.zabel@pengutronix.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, 
	"devicetree@vger.kernel.org"
	 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	 <openbmc@lists.ozlabs.org>
Date: Wed, 25 Mar 2026 17:15:54 +0800
In-Reply-To: <TY2PPF5CB9A1BE6D451E8AFDBA03B81AFB4F249A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260324-upstream_i2c-v27-0-f19b511c8c28@aspeedtech.com>
	 <20260324-upstream_i2c-v27-3-f19b511c8c28@aspeedtech.com>
	 <db921d6b820a13d59d0ffb0ab042dc6c8c11897f.camel@codeconstruct.com.au>
	 <TY2PPF5CB9A1BE6D451E8AFDBA03B81AFB4F249A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2+deb12u1 
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

SGkgUnlhbiwKCj4gPiBJIHdvdWxkIHN1Z2dlc3Qgc2VwYXJhdGluZyB0aGUgc3RyaW5nIHBhcnNp
bmcgZnJvbSB0aGUgImlzIHRoZSBtb2RlIGF2YWlsYWJsZSIKPiA+IGxvZ2ljLCBtb3JlIG9uIHRo
YXQgYmVsb3cuCj4gPiAKPiBJIHdpbGwgc2VwYXJhdGUgd2l0aCBmb2xsb3dpbmcuCj4gwqAKPiBz
dGF0aWMgaW50IGFzdDI2MDBfaTJjX3hmZXJfbW9kZV9wYXJzZShjb25zdCBjaGFyICpidWYsIGVu
dW0geGZlcl9tb2RlICptb2RlKQo+IHsKPiDCoMKgwqAgaWYgKHN5c2ZzX3N0cmVxKGJ1ZiwgImJ5
dGUiKSnCoMKgIHsgKm1vZGUgPSBCWVRFX01PREU7IHJldHVybiAwOyB9Cj4gwqDCoMKgIGlmIChz
eXNmc19zdHJlcShidWYsICJidWZmZXIiKSkgeyAqbW9kZSA9IEJVRkZfTU9ERTsgcmV0dXJuIDA7
IH0KPiDCoMKgwqAgaWYgKHN5c2ZzX3N0cmVxKGJ1ZiwgImRtYSIpKcKgwqDCoCB7ICptb2RlID0g
RE1BX01PREU7wqAgcmV0dXJuIDA7IH0KPiDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4gfQoKT0ss
IGJ1dCB3aXRoIGtlcm5lbC1zdHlsZSBmb3JtYXR0aW5nLgoKPiAKPiBzdGF0aWMgaW50IGFzdDI2
MDBfaTJjX3hmZXJfbW9kZV9jaGVjayhzdHJ1Y3QgYXN0MjYwMF9pMmNfYnVzICppMmNfYnVzLAo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZW51bSB4ZmVyX21vZGUgbW9kZSkKPiB7Cj4gwqDCoMKgIGlm
IChtb2RlID09IEJVRkZfTU9ERSAmJiAhaTJjX2J1cy0+YnVmX2Jhc2UpCj4gwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIC1FSU5WQUw7Cj4gwqDCoMKgIGlmIChtb2RlID09IERNQV9NT0RFICYmICFpMmNf
YnVzLT5kbWFfYXZhaWxhYmxlKQo+IMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+IMKg
wqDCoCByZXR1cm4gMDsKPiB9Cj4gCj4gPiA+ICsKPiA+ID4gK3N0YXRpYyBjb25zdCBjaGFyICph
c3QyNjAwX2kyY194ZmVyX21vZGVfbmFtZShlbnVtIHhmZXJfbW9kZSBtb2RlKSB7Cj4gPiA+ICvC
oMKgwqDCoMKgwqDCoHN3aXRjaCAobW9kZSkgewo+ID4gPiArwqDCoMKgwqDCoMKgwqBjYXNlIEJZ
VEVfTU9ERToKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAiYnl0
ZSI7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoGNhc2UgRE1BX01PREU6Cj4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gImRtYSI7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoGNh
c2UgQlVGRl9NT0RFOgo+ID4gPiArwqDCoMKgwqDCoMKgwqBkZWZhdWx0Ogo+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuICJidWZmZXIiOwo+ID4gPiArwqDCoMKgwqDC
oMKgwqB9Cj4gPiA+ICt9Cj4gPiA+ICsKPiA+ID4gK3N0YXRpYyBzc2l6ZV90IHhmZXJfbW9kZV9z
aG93KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0Cj4gPiA+ICtkZXZpY2VfYXR0cmlidXRlICph
dHRyLCBjaGFyICpidWYpIHsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGFzdDI2MDBfaTJj
X2J1cyAqaTJjX2J1cyA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOwo+ID4gPiArCj4gPiA+ICvCoMKg
wqDCoMKgwqDCoHJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIiVzXG4iLAo+ID4gPiArYXN0MjYwMF9p
MmNfeGZlcl9tb2RlX25hbWUoaTJjX2J1cy0+bW9kZSkpOwo+ID4gPiArfQo+ID4gPiArCj4gPiA+
ICtzdGF0aWMgc3NpemVfdCB4ZmVyX21vZGVfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LAo+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwKPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3QgY2hhciAq
YnVmLCBzaXplX3QgY291bnQpCj4gPiB7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBhc3Qy
NjAwX2kyY19idXMgKmkyY19idXMgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKPiA+ID4gK8KgwqDC
oMKgwqDCoMKgZW51bSB4ZmVyX21vZGUgbW9kZTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgaW50IHJl
dDsKPiA+ID4gKwo+ID4gPiArwqDCoMKgwqDCoMKgwqByZXQgPSBhc3QyNjAwX2kyY194ZmVyX21v
ZGVfcGFyc2UoaTJjX2J1cywgYnVmLCAmbW9kZSk7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChy
ZXQpCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+ID4g
PiArCj4gPiA+ICvCoMKgwqDCoMKgwqDCoGkyY19sb2NrX2J1cygmaTJjX2J1cy0+YWRhcCwgSTJD
X0xPQ0tfUk9PVF9BREFQVEVSKTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgYXN0MjYwMF9pMmNfc2V0
X3hmZXJfbW9kZShpMmNfYnVzLCBtb2RlKTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgaTJjX3VubG9j
a19idXMoJmkyY19idXMtPmFkYXAsIEkyQ19MT0NLX1JPT1RfQURBUFRFUik7Cj4gPiA+ICsKPiA+
ID4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIGNvdW50Owo+ID4gPiArfQo+ID4gPiArCj4gPiA+ICtz
dGF0aWMgREVWSUNFX0FUVFJfUlcoeGZlcl9tb2RlKTsKPiA+IAo+ID4gVGhpcyB3aWxsIG5lZWQg
c3lzZnMgQUJJIGRvY3VtZW50YXRpb24uCj4gCj4gU2luY2UgaXQgaXMgaW4gc3lzZnMgL3N5cy9i
dXMvcGxhdGZvcm0vZHJpdmVycy9pMmNfYXN0MjYwMAo+IFNvIEkgYWRkIERvY3VtZW50YXRpb24v
QUJJL3Rlc3Rpbmcvc3lzZnMtYnVzLXBsYXRmb3JtLWRyaXZlcnMtaTJjLWFzdDI2MDAgCj4gYW0g
SSByaWdodD8KCkkgd291bGQgc3VnZ2VzdCBEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2Zz
LWRyaXZlci1hc3QyNjAwLWkyYwoKPiAKPiBXaGF0OsKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvc3lz
L2J1cy9wbGF0Zm9ybS9kcml2ZXJzL2kyYy1hc3QyNjAwLy4uLi94ZmVyX21vZGUKPiBEYXRlOsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBNYXJjaCAyMDI2Cj4gS2VybmVsVmVyc2lvbjrCoMKgNi54CgpL
ZXJuZWxWZXJzaW9uIGlzIG9wdGlvbmFsLCBidXQgaWYgeW91IGluY2x1ZGUgaXQsIGl0IHdvdWxk
IGJlIDcueC4KCj4gQ29udGFjdDrCoMKgwqDCoMKgwqDCoMKgUnlhbiBDaGVuIDxyeWFuX2NoZW5A
YXNwZWVkdGVjaC5jb20+Cj4gRGVzY3JpcHRpb246CgpLZWVwIHRoZSBmaXJzdCBsaW5lIG9mIHRo
ZSBkZXNjcmlwdGlvbiBvbiB0aGUgc2FtZSBsaW5lLgoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoFNob3dzIG9yIHNldHMgdGhlIHRyYW5zZmVyIG1vZGUgZm9yIHRoZSBBU1BFRUQg
QVNUMjYwMCBJMkMKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbnRyb2xsZXIu
IFZhbGlkIHZhbHVlcyBhcmU6Cj4gCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAt
ICJieXRlIjrCoMKgIFByb2dyYW1tZWQgSS9PLCBvbmUgYnl0ZSBhdCBhIHRpbWUuCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAtICJidWZmZXIiOiBQcm9ncmFtbWVkIEkvTyB1c2lu
ZyB0aGUgaGFyZHdhcmUgRklGTyBidWZmZXIuCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAtICJkbWEiOsKgwqDCoCBETUEgdHJhbnNmZXIgKG9ubHkgYXZhaWxhYmxlIGlmIGFzcGVl
ZCxlbmFibGUtZG1hCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGlzIHNldCBpbiB0aGUgZGV2aWNlIHRyZWUpLgoKRGVjb3VwbGUgdGhpcyBm
cm9tIHRoZSBkZXZpY2UgdHJlZSBjb25maWd1cmF0aW9uIG1lY2hhbmlzbToKCiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoC0gImRtYSI6wqDCoMKgIERNQSB0cmFuc2ZlciAoaWYgRE1B
IGlzIGF2YWlsYWJsZSBmb3IgdGhpcwogICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRy
b2xsZXIpCgo+IGkyY19idXMtPmJ1Zl9iYXNlID0gZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVt
YXBfcmVzb3VyY2UocGRldiwgMSwgJnJlcyk7Cj4gaWYgKCFJU19FUlIoaTJjX2J1cy0+YnVmX2Jh
c2UpKQo+IMKgwqDCoCBpMmNfYnVzLT5idWZfc2l6ZSA9IHJlc291cmNlX3NpemUocmVzKSAvIDI7
Cj4gZWxzZQo+IMKgwqDCoCBpMmNfYnVzLT5idWZfYmFzZSA9IE5VTEw7CgpJIHdvdWxkIHN1Z2dl
c3QgYSB0ZW1wb3JhcnksIHNvIHRoZXJlJ3Mgbm8gY2hhbmNlIHRoYXQgZnV0dXJlIGNoYW5nZXMK
Y291bGQgc2VlIGFuIEVSUl9QVFIgdmFsdWUgaW4gaTJjX2J1cy0+YnVmX2Jhc2U6CgogICAgYnVm
X2Jhc2UgPSBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZShwZGV2LCAxLCAm
cmVzKTsKICAgIGlmICghSVNfRVJSKGJ1Zl9iYXNlKSkgewogICAgICAgIGkyY19idXMtPmJ1Zl9i
YXNlID0gYnVmX2Jhc2UKICAgIMKgwqDCoCBpMmNfYnVzLT5idWZfc2l6ZSA9IHJlc291cmNlX3Np
emUocmVzKSAvIDI7CiAgICB9CgphbmQgeW91IGhhdmUga3phbGxvYygpZWQsIHNvIG5vIG5lZWQg
Zm9yIHRoZSBOVUxMIGluaXQgaW4gdGhlIGVycm9yIHBhdGguCgpDaGVlcnMsCgoKSmVyZW15Cg==


