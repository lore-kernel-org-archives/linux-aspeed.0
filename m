Return-Path: <linux-aspeed+bounces-107-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D34D12D59
	for <linux-aspeed@archiver.kernel.org>; Sun, 10 Nov 2024 23:45:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xmq7K10fZz2y8Z;
	Mon, 11 Nov 2024 10:45:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731282349;
	cv=none; b=jeVyGAnTJJrbLzIgBGUvM3+yEwpT24X4LQmb/YmGtx7hChboXvnOvoXrSGEA4PYQWdh6b5GluTa9KGbKyqOx+UeqMuqJNs3f/eDzQO5q/rcyDoYag9rTBGEfL1hBANBggoXTziIxCaHi5H9PaJoIdNNUGrJahONA92FYFPOlsaWorl0r4Jwnb0DDsf+O6VdXQflMWpgQVofmnyE9wd72COtH1t07rNRAm2FMnGyc1HrYXyE41TL808FO5E2ZvQRdSHJmJIwUsOQpCD130Vd6ApboB2/Zwz8wyOsZOfgukO/Sf984MK0S+0EkuafFT1/i6klCoHN6f+S4x9JgQJB3fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731282349; c=relaxed/relaxed;
	bh=CtE/2TzXKxCOgx8TvJHqD35OsC00+oFw8Pd4MfmWF1k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iDzX7N7sqdMBl26UDklgf0Ysc4/3E71EjXUUf9okTYXqUQKn6Li/8ffQ/7CPuH99YLLc2QkSj6zg0L0JWtUWwaL47TliGiZmf19fvO1PZTn1AnjmwlivVQDRKt9CjK15OPmqwfEdf4D2ik7l/cS0xn7fXuAtFt1QRAORKbAj9hMNb6nu653zJJxCTQ1wBZTAyaTTWmTSIADpl7FMb7vJiPNWUDuamB8IKnRNSERfR8THmL5H2GJZzAv79ix+kDSsIk62SwmVHbSFX0Yluh81T2OmyRQOpiqhcJVEeqYk8QmgTioGDZ5s6iEOvMQ5PfUvxDiC8ysJru7kSVGJmUDT+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=kdqScvdb; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=kdqScvdb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xmq7H1H48z2xxt
	for <linux-aspeed@lists.ozlabs.org>; Mon, 11 Nov 2024 10:45:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1731282344;
	bh=CtE/2TzXKxCOgx8TvJHqD35OsC00+oFw8Pd4MfmWF1k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kdqScvdbKNWzvUQOtZ8y4IJkVrDptpwzjGzuyO7c9xz2ZQyZ28TCXeX2HpyB5RBnL
	 k8Wr8bmUr7L14Ja/d9pqNNdIxeREt3khie9BtL0bWpuLgJFWd6o6+qyp8QfEj9FwLe
	 pjBrFrarmMdB6AtvTqU0pCkTBFMkjCJNQ8/WCPzFhyIfdW+hcYUz8vrhDwD7h/hmkR
	 17NNxq+S/o7+PGdqZr3IqzQdcFJY3D4yIuUwpe3oxsv2qDvjGjlhWwvqcxLwNJ1mwX
	 f52aRicZTaKScCqoFq3RBSHfSJpq8wLTg6aXx+gpXDPVGZNVljIFVPlHyphQdMQgAV
	 UyBWi8r99lOuA==
Received: from [192.168.68.112] (ppp118-210-186-64.adl-adc-lon-bras34.tpg.internode.on.net [118.210.186.64])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DE0216490A;
	Mon, 11 Nov 2024 07:45:42 +0800 (AWST)
Message-ID: <d4196567fc62a24922794b02adad1b6c47750760.camel@codeconstruct.com.au>
Subject: Re: [PATCH] arm: dts: aspeed: Blueridge and Rainer: Add VRM
 presence GPIOs
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Eddie James <eajames@linux.ibm.com>, linux-aspeed@lists.ozlabs.org
Cc: joel@jms.id.au, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 11 Nov 2024 10:15:40 +1030
In-Reply-To: <20241108145822.1365072-1-eajames@linux.ibm.com>
References: <20241108145822.1365072-1-eajames@linux.ibm.com>
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

T24gRnJpLCAyMDI0LTExLTA4IGF0IDA4OjU4IC0wNjAwLCBFZGRpZSBKYW1lcyB3cm90ZToKPiBB
ZGQgR1BJTyBsaW5lIG5hbWVzIHRvIHRoZSBHUElPIGV4cGFuZGVyIHRvIGRlc2NyaWJlIERDTSBh
bmQKPiBWUk0gcHJlc2VuY2UgZGV0ZWN0aW9uIGxpbmVzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEVk
ZGllIEphbWVzIDxlYWphbWVzQGxpbnV4LmlibS5jb20+Cj4gLS0tCj4gwqBhcmNoL2FybS9ib290
L2R0cy9hc3BlZWQvYXNwZWVkLWJtYy1pYm0tYmx1ZXJpZGdlLmR0cyB8IDQgKystLQo+IMKgYXJj
aC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMtaWJtLXJhaW5pZXIuZHRzwqDCoCB8IDQg
KystLQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
Cj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtYm1jLWli
bS1ibHVlcmlkZ2UuZHRzCj4gYi9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWJtYy1p
Ym0tYmx1ZXJpZGdlLmR0cwo+IGluZGV4IDVmOWE0NmMyYWJiOC4uZDUwNGFlODRkYjg5IDEwMDY0
NAo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtYm1jLWlibS1ibHVlcmlk
Z2UuZHRzCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMtaWJtLWJs
dWVyaWRnZS5kdHMKPiBAQCAtMTIzMiw4ICsxMjMyLDggQEAgbGVkLWNvbnRyb2xsZXJANjAgewo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgI2dwaW8tY2VsbHMgPSA8Mj47Cj4gwqAK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdwaW8tbGluZS1uYW1lcyA9Cj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAiIiwgIiIsICIiLCAi
IiwgIiIsICIiLCAiIiwgIiIsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAiIiwgIiIsICIiLCAiIiwgIiIsICIiLCAicG93ZXItY29uZmlnLWZ1bGwtCj4g
bG9hZCIsICIiOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIiIsICIiLCAiIiwgIiIsICIiLCAiIiwgIlAxMF9EQ00wX1BSRVMiLAo+ICJQMTBfRENNMV9Q
UkVTIiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCIi
LCAiIiwgIiIsICIiLCAiUFJFU0VOVF9WUk1fRENNMF9OIiwKPiAiUFJFU0VOVF9WUk1fRENNMV9O
IiwgInBvd2VyLWNvbmZpZy1mdWxsLWxvYWQiLCAiIjsKPiDCoMKgwqDCoMKgwqDCoMKgfTsKClRo
aXMgZW5kcyB1cCBnZW5lcmF0aW5nIGNoZWNrcGF0Y2ggd2FybmluZ3MgYWJvdXQgbG9uZyBsaW5l
cyB3aGVuIEkKYXBwbHkgaXQuCgpJIGRpZCBhIHF1aWNrLCBpbmNvbXBsZXRlIGFuZCByYW5kb20g
c3VydmV5IG9mIHNvbWUgb3RoZXIgZGV2aWNldHJlZXMsCmFuZCBwZXJoYXBzIGV4cGxvZGluZyBv
dXQgbGlrZSBpbiBbMV0gbWlnaHQgaGVscC4KClsxXTogaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9ZDg1
YjJhZDM1YTJhYgoKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBsZWQtY29udHJvbGxlckA2MSB7Cj4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtYm1jLWlibS1yYWlu
aWVyLmR0cwo+IGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMtaWJtLXJhaW5p
ZXIuZHRzCj4gaW5kZXggYTRhZWMzMDEwNDU2Li5lZWZjNjlkMGQwMzIgMTAwNjQ0Cj4gLS0tIGEv
YXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMtaWJtLXJhaW5pZXIuZHRzCj4gKysr
IGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMtaWJtLXJhaW5pZXIuZHRzCj4g
QEAgLTEyODAsOCArMTI4MCw4IEBAIHBjYV9wcmVzMzogcGNhOTU1MkA2MCB7Cj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAjZ3Bpby1jZWxscyA9IDwyPjsKPiDCoAo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ3Bpby1saW5lLW5hbWVzID0KPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCIiLCAiIiwgIiIsICIiLCAiIiwgIiIs
ICIiLCAiIiwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCIiLCAiIiwgIiIsICIiLCAiIiwgIiIsICJwb3dlci1jb25maWctZnVsbC0KPiBsb2FkIiwgIiI7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAiIiwgIiIs
ICIiLCAiIiwgIiIsICIiLCAiUDEwX0RDTTBfUFJFUyIsCj4gIlAxMF9EQ00xX1BSRVMiLAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIiIsICIiLCAiIiwg
IiIsICJQUkVTRU5UX1ZSTV9EQ00wX04iLAo+ICJQUkVTRU5UX1ZSTV9EQ00xX04iLCAicG93ZXIt
Y29uZmlnLWZ1bGwtbG9hZCIsICIiOwoKU2ltaWxhcmx5IGhlcmUuCgpBbmRyZXcK


