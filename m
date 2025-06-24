Return-Path: <linux-aspeed+bounces-1557-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E097EC77B7F
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Jun 2025 23:44:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bRhP61Gl4z2xKh;
	Wed, 25 Jun 2025 09:44:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750808650;
	cv=none; b=VZY5y5UTgypFDxztaPdaVknyBHa0JRnSlux73tfF2lSkqPZKvFA+GnseRbRhkTsMcPOEOyzoMawtUMgBHHzGX5KTXaTTUjb4Se6cxQZw+sz9FWLzpjhPkzfxfb5+E8Cay1vdjoxE0/kVk2ci3FndwMHflXEm4JQZDm682eoXf9X9Yyqoh0176NpcOx1zZbmujfVBhC9s05e6/MqPrGUju144eZs3J5TAYWLGivPhiHDbTUgJJbpw9+J+66C8T4qo194H1RZWkoWvljpBGnIs0FmS7WMRBA57PR19U/1PXuMnabFnNDrnSGHP4xkBrXwDHNy/lcc5MKmeekPMYyG9JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750808650; c=relaxed/relaxed;
	bh=gJ2Y39ij81lvq+iKRiDDGSNRlRMdUnfqavwz1La/gMA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P5nE5A0J5Uprba9vWg+4pwmwUG2j97WUK63t2kR7wQ/YaDzszGE/KQBQoGT9W9fZB73T3YXn1lzGP+xxX55n9YAgzg9f3sZMI3kZGAr10sq9rTUMtnIO6KVV7Y7EldFRYwT/gBcAsYeXPtzJ6hvkpqCf6JjydcHmMgw6WKmQYazAVJoOVI1wugiXbhYPbGqwquhkVN84zsN9fsfuLz4PUcpktPznqMf0a3MXYI4dHBZslutspmYvmGHAGFLnuvwxZ1tT2aEYN65Nm1cK9UPPHw5ERjsAaLn36J1ayWeMRrTym8FKbWJcqzXzjMin62TkyjSxMuIKx7lhq1yO771EsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=e/RG7Gxt; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=e/RG7Gxt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bRhP4539Dz2xHv
	for <linux-aspeed@lists.ozlabs.org>; Wed, 25 Jun 2025 09:44:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750808648;
	bh=gJ2Y39ij81lvq+iKRiDDGSNRlRMdUnfqavwz1La/gMA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=e/RG7Gxtw5W3CBuHcYNGv/w6plOoXdvuDnYyw33OMFnLPx72CtSGk/mZVXDr7kvvQ
	 lQvvNjIR1z8+dP7hIHuOSYtYQD69z1shXUbod2f8a7IMnm825YwQtkOHMr+yELaxul
	 yHnm2INU8nEpzKBuh2vJh8kEUimMut/n87IO40InhzIg+jyeGaAHddunxB9jbcMnPe
	 CJ5D7W+W3MQclg+FTgFRnR9fCt7vYXSiUcHhmJMZc9tDY4hV2wBBE/5Kkgn7eZSp9l
	 IT4B8PjYymsEerPDdo/Ios43uN7yJ3Tqmm6H7hD3myXFMDgpvEPP+Pcaxzkrs5xhDd
	 S8K/nYPNmn1Uw==
Received: from [192.168.68.112] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2047A640CD;
	Wed, 25 Jun 2025 07:44:06 +0800 (AWST)
Message-ID: <0f495eec39fd25d71a59a56876f6142e6fe786f3.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: clemente: add Meta Clemente BMC
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
	bruce.jy.hung@fii-foxconn.com, george.kw.lee@fii-foxconn.com, Leo Wang
	 <leo.jt.wang@fii-foxconn.com>
Date: Wed, 25 Jun 2025 09:14:05 +0930
In-Reply-To: <20250621-add-support-for-meta-clemente-bmc-v2-2-6c5ef059149c@fii-foxconn.com>
References: 
	<20250621-add-support-for-meta-clemente-bmc-v2-0-6c5ef059149c@fii-foxconn.com>
	 <20250621-add-support-for-meta-clemente-bmc-v2-2-6c5ef059149c@fii-foxconn.com>
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

T24gU2F0LCAyMDI1LTA2LTIxIGF0IDE1OjUxICswODAwLCBMZW8gV2FuZyB3cm90ZToKPiBGcm9t
OiBMZW8gV2FuZyA8bGVvLmp0LndhbmdAZ21haWwuY29tPgo+IAo+IEFkZCBsaW51eCBkZXZpY2Ug
dHJlZSBlbnRyeSBmb3IgTWV0YSBDbGVtZW50ZSBjb21wdXRlLXRyYXkKPiBCTUMgdXNpbmcgQVNU
MjYwMCBTb0MuCj4gCj4gU2lnbmVkLW9mZi1ieTogTGVvIFdhbmcgPGxlby5qdC53YW5nQGZpaS1m
b3hjb25uLmNvbT4KPiAtLS0KPiDCoGFyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC9NYWtlZmlsZcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoCAxICsKPiDCoC4uLi9kdHMv
YXNwZWVkL2FzcGVlZC1ibWMtZmFjZWJvb2stY2xlbWVudGUuZHRzwqDCoMKgIHwgMTI1NCArKysr
KysrKysrKysrKysrKysrKwo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxMjU1IGluc2VydGlvbnMoKykK
PiAKPiAKCipzbmlwKgoKPiArCj4gKyZpMmMyIHsKPiArwqDCoMKgwqDCoMKgwqBzdGF0dXMgPSAi
b2theSI7Cj4gK8KgwqDCoMKgwqDCoMKgLy8gTW9kdWxlIDAsIEV4cGFuZGVyIEAweDIwCj4gK8Kg
wqDCoMKgwqDCoMKgaW9fZXhwYW5kZXIwOiBncGlvQDIwIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJueHAscGNhOTU1NSI7Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJlZyA9IDwweDIwPjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZ3Bpby1jb250cm9sbGVyOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAj
Z3Bpby1jZWxscyA9IDwyPjsKPiArwqDCoMKgwqDCoMKgwqB9Owo+ICsKCipzbmlwKgoKPiArCj4g
KyZpb19leHBhbmRlcjAgewo+ICvCoMKgwqDCoMKgwqDCoGdwaW8tbGluZS1uYW1lcyA9Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCJGUEdBX1RIRVJNX09WRVJUX0wtSSIsCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCJGUEdBX1JFQURZX0JNQy1JIiwKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIkhNQ19CTUNfREVURUNULU8iLAo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAiSE1DX1BHT09ELU8iLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAiIiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIkJNQ19TVEJZ
X0NZQ0xFLU8iLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAiRlBHQV9FUk9UX0ZB
VEFMX0VSUk9SX0wtSSIsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCJXUF9IV19F
WFRfQ1RSTF9MLU8iLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAiRVJPVF9GUEdB
X1JTVF9MLU8iLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAiRlBHQV9FUk9UX1JF
Q09WRVJZX0wtTyIsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCJCTUNfRVJPVF9G
UEdBX1NQSV9NVVhfU0VMLU8iLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAiVVNC
Ml9IVUJfUlNUX0wtTyIsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCIiLAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAiU0dQSU9fRU5fTC1PIiwKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIkIyQl9JT0VYUF9JTlRfTC1JIiwKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIkkyQ19CVVNfTVVYX1JFU0VUX0wtTyI7Cj4gK307Cgppb19leHBh
bmRlcjAgaXMgYSBub2RlIGxhYmVsIHRoYXQgeW91J3JlIGRlZmluaW5nIGluIHRoaXMgc2FtZSBz
b3VyY2UKZmlsZS4gVGhlIGNvZGluZyBzdHlsZSBleHBlY3RhdGlvbiBpcyB0aGF0IHlvdSBkZWZp
bmUgYWxsIHRoZQpwcm9wZXJ0aWVzIGluIHRoZSBub2RlIGl0c2VsZi4gTGFiZWwgcmVmZXJlbmNl
cyBsaWtlIHRoZSBvbmUgYWJvdmUKc2hvdWxkIGJlIHVzZWQgd2hlbiByZWZlcmVuY2luZyBub2Rl
cyBmcm9tIGluY2x1ZGVkIGZpbGVzLgoKUGxlYXNlIGZpeCB0aHJvdWdob3V0IChlLmcuIGF0IGxl
YXN0IGlvX2V4cGFuZGVyMSAtIGlvX2V4cGFuZGVyMTMsIGJ1dAphbnkgb3RoZXIgaW5zdGFuY2Vz
IGFzIHdlbGwpLgoKPiArCj4gKyZwaW5jdHJsIHsKPiArwqDCoMKgwqDCoMKgwqBwaW5jdHJsX25j
c2kzX2RlZmF1bHQ6IG5jc2kzX2RlZmF1bHQgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBmdW5jdGlvbiA9ICJSTUlJMyI7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGdyb3VwcyA9ICJOQ1NJMyI7Cj4gK8KgwqDCoMKgwqDCoMKgfTsKPiArCj4gK8KgwqDCoMKgwqDC
oMKgcGluY3RybF9uY3NpNF9kZWZhdWx0OiBuY3NpNF9kZWZhdWx0IHsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZnVuY3Rpb24gPSAiUk1JSTQiOwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBncm91cHMgPSAiTkNTSTQiOwo+ICvCoMKgwqDCoMKgwqDCoH07CgpDYW4g
eW91IHBsZWFzZSByYXRoZXIgYWRkIHRoZXNlIHRvIGFyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC9h
c3BlZWQtZzYtCnBpbmN0cmwuZHRzaSBzbyBvdGhlciBib2FyZHMgY2FuIG1ha2UgdXNlIG9mIHRo
ZW0/CgpUaGFua3MsCgpBbmRyZXcK


