Return-Path: <linux-aspeed+bounces-2189-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C082CA101F
	for <linux-aspeed@archiver.kernel.org>; Wed, 10 Sep 2025 06:58:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cMBPC6k6hz3clh;
	Wed, 10 Sep 2025 16:58:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757487535;
	cv=none; b=aayOarkCCSBYJBIx/TaB8V5y1y5Urla64PnQyl7Bh3Ibs/y3Py1AgVlWPQ5ht0hcqteHFTcvmSxGIUsds2fEGZlG3LvPWikkZt2NpVvXGerCTDA8CHsQLvc70EWqQLgtUUuAWh6P/RHWtPvxJY+bXVMKP0yWRDy7GA4BqxesQ1pyjobQ0ILxmBI5GkUuRAp78j3CP5jrFJxoBAv4p4RKdNRBUhYyjikv1oMcyM801tqzwKimxTPBLjxbe5i6ifznt7qMBDBlG+FcWkZCLhJ9OEAEtadgAP+liCc885uaMIvHEknmIF8EbbInN/AUmcBHbuFg7b8K1rB0FYFLv9cNEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757487535; c=relaxed/relaxed;
	bh=KtbgRtg//fqWfjWdTmRs7c1F/bK6SAHJGEEEnummDn4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HozJWD1yZ5jBxpMfhryMLFpZ5OvDcfRrbYXbPWjqZ3LPGRNRR8W8wkq/9Lw10QlykbJ1qgXwtF3CuZzVJuFAVJXnqKVBnfi/kfxly3ZPjP20tkSk867ovGjdOQKIebN8n9YF8csgp7ZdWriD/65Hb0C4o0D3PKTCIIXVgEY6i2YJ5kYFJgFc6VhD934MB4WtQAFzG/Py5zYLWm8uXaP21ImUL4HrFasi/ZTBGv62yEYKgdyVX2zeFsghkI/im6/K92f5pouTy53nlkJDS3iQ/o8VK/yIOfQp8IDhENtMXYSa4Xnzryz8ZNzsblBV13lKLn1OPOjPDXsnmJkRaNrx7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=NkFW3CiV; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=NkFW3CiV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cMBPC2BHyz3ckL
	for <linux-aspeed@lists.ozlabs.org>; Wed, 10 Sep 2025 16:58:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1757487534;
	bh=KtbgRtg//fqWfjWdTmRs7c1F/bK6SAHJGEEEnummDn4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NkFW3CiVPTwd0wTpMajw9sGYLPA6GzaOFZrdG6scboFuIUzmRb5nZAlcTptUZynta
	 UyGNdUUDSJPeerKSdsIH6NdXx3jvs+5TrzZnT3bL+yVHAD0XLOu7JsmdkbXppxIgU5
	 5wOx6xH6lkE7XPOy3sknrTy3RHq+f2kSBsJn0xLstyvKHXuG8vr/lSMGXK6oeaeHgs
	 OFj0aTU3RbWIGpUiB3Tj3jIfyGqT9NRs32kZC+CpJs1I1iiiHC6+z2OtK0j5MrI3Qp
	 cD40/Ot5ji962Nx43M4FJW7ev58n6TC3fjcjpPamLxqkg/u/a9YJO3WDY6wpOZ0juH
	 D5HVjxJCP30IQ==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2B54E6443C;
	Wed, 10 Sep 2025 14:58:53 +0800 (AWST)
Message-ID: <8d7b13b2eb51929ca2c1c3040b9fcf9f7dd16412.camel@codeconstruct.com.au>
Subject: Re: [PATCH] crypto: aspeed - Fix dma_unmap_sg() direction
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Neal Liu <neal_liu@aspeedtech.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 Joel Stanley <joel@jms.id.au>, Dhananjay Phadke
 <dphadke@linux.microsoft.com>, Johnny Huang <johnny_huang@aspeedtech.com>,
 linux-aspeed@lists.ozlabs.org,  linux-crypto@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org
Date: Wed, 10 Sep 2025 16:28:42 +0930
In-Reply-To: <20250905115112.26309-2-fourier.thomas@gmail.com>
References: <20250905115112.26309-2-fourier.thomas@gmail.com>
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

T24gRnJpLCAyMDI1LTA5LTA1IGF0IDEzOjUxICswMjAwLCBUaG9tYXMgRm91cmllciB3cm90ZToK
PiBJdCBzZWVtcyBsaWtlIGV2ZXJ5d2hlcmUgaW4gdGhpcyBmaWxlLCB3aGVuIHRoZSByZXF1ZXN0
IGlzIG5vdAo+IGJpZGlyZWN0aW9uYWwsIHJlcS0+c3JjIGlzIG1hcHBlZCB3aXRoIERNQV9UT19E
RVZJQ0XCoAo+IAoKT2theSwgaG93ZXZlcjoKCj4gYW5kIHJlcS0+c3JjIGlzCj4gbWFwcGVkIHdp
dGggRE1BX0ZST01fREVWSUNFLgoKQnkgdGhlIHBhdGNoIGl0c2VsZiwgb25lIHNob3VsZCByZWZl
ciB0byByZXEtPmRzdD8KCkFuZHJldwoKPiAKPiBGaXhlczogNjJmNThiMTYzN2I3ICgiY3J5cHRv
OiBhc3BlZWQgLSBhZGQgSEFDRSBjcnlwdG8gZHJpdmVyIikKPiBDYzogPHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmc+Cj4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIEZvdXJpZXIgPGZvdXJpZXIudGhvbWFz
QGdtYWlsLmNvbT4KPiAtLS0KPiDCoGRyaXZlcnMvY3J5cHRvL2FzcGVlZC9hc3BlZWQtaGFjZS1j
cnlwdG8uYyB8IDIgKy0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0by9hc3BlZWQvYXNwZWVkLWhh
Y2UtY3J5cHRvLmMgYi9kcml2ZXJzL2NyeXB0by9hc3BlZWQvYXNwZWVkLWhhY2UtY3J5cHRvLmMK
PiBpbmRleCBhNzJkZmViYzUzZmYuLmZhMjAxZGFlMWY4MSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2NyeXB0by9hc3BlZWQvYXNwZWVkLWhhY2UtY3J5cHRvLmMKPiArKysgYi9kcml2ZXJzL2NyeXB0
by9hc3BlZWQvYXNwZWVkLWhhY2UtY3J5cHRvLmMKPiBAQCAtMzQ2LDcgKzM0Niw3IEBAIHN0YXRp
YyBpbnQgYXNwZWVkX3NrX3N0YXJ0X3NnKHN0cnVjdCBhc3BlZWRfaGFjZV9kZXYgKmhhY2VfZGV2
KQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoH0gZWxzZSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBkbWFfdW5tYXBfc2coaGFjZV9kZXYtPmRldiwgcmVxLT5kc3QsIHJjdHgtPmRz
dF9uZW50cywKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIERNQV9UT19ERVZJQ0UpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRE1BX0ZST01fREVWSUNFKTsKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRtYV91bm1hcF9zZyhoYWNlX2Rldi0+ZGV2LCByZXEtPnNy
YywgcmN0eC0+c3JjX25lbnRzLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIERNQV9UT19ERVZJQ0UpOwo+IMKgwqDCoMKgwqDCoMKgwqB9
Cgo=


