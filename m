Return-Path: <linux-aspeed+bounces-3915-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785D5F433D0
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Apr 2026 00:01:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwypr35Vkz2yrm;
	Thu, 16 Apr 2026 10:01:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776073905;
	cv=none; b=GUc+Oe37HNyuMRsaTcWYcbfwabcpXhO3dR89SKcv5YWtXUJrKnlXAFS8kvvdR5x9SL/jkIp596nGjNUOcfCLc+ByzCupXvzplcEk3m6/gPQu54Pw/Tmhm0tgGNinDRksohTy6zLecFRh2/jdUZsJz5Ma0f4vU0xYwG2fHO3nLby+mVMLX5AYDgX8BtbzYIzwlEOn7+0mGkfROodc83046ZU35IPaNV1HhhMDmbhS1P60r4evPtZ1MPiZgkyNvjCeMLCiYb+JX+4uFJyghoQp4hbRHuTLaihgBdSnU6P7u6d90sbDDHqgrtBvIolAVRHFr0KyY5YNodhJwtJj/U9T7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776073905; c=relaxed/relaxed;
	bh=OfaFHGW4BHXsCEKDLY2bYmYjd4tuxeBTjzOITav+K40=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kwn08N+UiyXIKY+wZPC2QWDsCWqgfYn8rZIRd5Lmnmz0yCCKDXkRgy7rr4zbJyRA5q1Vgmgju0sv1gY5TotCfN9SlZqmgYxbc12ghrn+tx7bFzQz+bZWebfMg8vPoApOmItGFSzX9hiDGMWY8cM06nXg3GdxqJKChjZiNiBwe2SbcR2hK5aGorONGX24obMJ/UJTWW1q9KdyCfeaNbX/u4ORqCsisu/T/nyjXPi7r64KRQ+cFvJYIA4GCk9yAuGNq1kn0HwSLQsEw7gKklNlAB4M6w5lexZOQ0HxEf1th+LcHO75KfeCa2rQfxZFaRan3Ud27iB0RpXCguD/znhT4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=realtek.com; dkim=pass (2048-bit key; unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=VQD7aqt2; dkim-atps=neutral; spf=pass (client-ip=211.75.126.72; helo=rtits2.realtek.com.tw; envelope-from=eleanor.lin@realtek.com; receiver=lists.ozlabs.org) smtp.mailfrom=realtek.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=VQD7aqt2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=realtek.com (client-ip=211.75.126.72; helo=rtits2.realtek.com.tw; envelope-from=eleanor.lin@realtek.com; receiver=lists.ozlabs.org)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvN3N3cJRz2xS3;
	Mon, 13 Apr 2026 19:51:43 +1000 (AEST)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63D9nA5s94021616, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776073751; bh=OfaFHGW4BHXsCEKDLY2bYmYjd4tuxeBTjzOITav+K40=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=VQD7aqt2XR9PJpPEIceqZ9cd1oxayPD/Gb6aeMAjLrQ2LwAr2Gf+M7FPIFXHrYMjL
	 /HgzlcDmTmtuIGxqe2qwHHTXUvGrAj/NYwQSb/E5xujCyEWacoIX0BDyiWawLyeqzh
	 xbszBRnBU7j0NCWKpWqV2/xVR7OFy80JjhTFMZbCsUdZZVoDzlrVCmI8rgMVPzKrBn
	 M9hCEjmQQd+5Ud7tMXPb2urUKV9/kNmQXeaouig7SR55y2t474QLiEYsR8l/bOj502
	 /Ota3JPsTe/NpMRYHrMSUVfvZ+iLT6AUqAv8puOhLwvgAiZl4oL72aag48tE8xgyUp
	 ELmNRui+C+PBw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63D9nA5s94021616
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 17:49:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 13 Apr 2026 17:49:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Mon, 13 Apr 2026 17:49:11 +0800
From: =?utf-8?B?WXUtQ2h1biBMaW4gW+ael+elkOWQm10=?= <eleanor.lin@realtek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Linus Walleij
	<linusw@kernel.org>,
        =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
CC: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Jeffery
	<andrew@codeconstruct.com.au>,
        "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>,
        "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        Joel Stanley <joel@jms.id.au>,
        "linux-realtek-soc@lists.infradead.org"
	<linux-realtek-soc@lists.infradead.org>,
        =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>
Subject: RE: [PATCH 1/4] pinctrl: realtek: Enable compile testing
Thread-Topic: [PATCH 1/4] pinctrl: realtek: Enable compile testing
Thread-Index: AQHcyOqp9cEi81by0U+J7Mg1UrX8w7XcwsLg
Date: Mon, 13 Apr 2026 09:49:11 +0000
Message-ID: <eda54aea98ba4ad58ba8fca0951dd714@realtek.com>
References: <20260410-pinctrl-testing-v1-0-6f708c855867@oss.qualcomm.com>
 <20260410-pinctrl-testing-v1-1-6f708c855867@oss.qualcomm.com>
In-Reply-To: <20260410-pinctrl-testing-v1-1-6f708c855867@oss.qualcomm.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.6.42]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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

PiBFbmFibGUgY29tcGlsZSB0ZXN0aW5nIGZvciBSZWFsdGVrIHBpbiBjb250cm9sbGVyIGRyaXZl
cnMgZm9yIGluY3JlYXNlZCBidWlsZA0KPiBhbmQgc3RhdGljIGNoZWNrZXJzIGNvdmVyYWdlLiAg
UElOQ1RSTF9SVEQgdXNlcw0KPiBwaW5jb25mX2dlbmVyaWNfZHRfbm9kZV90b19tYXAoKSwgdGh1
cyBuZWVkcyBPRi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGty
enlzenRvZi5rb3psb3dza2lAb3NzLnF1YWxjb21tLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3Bp
bmN0cmwvTWFrZWZpbGUgICAgICAgIHwgIDIgKy0NCj4gIGRyaXZlcnMvcGluY3RybC9yZWFsdGVr
L0tjb25maWcgfCAxMiArKysrKystLS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRp
b25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGluY3Ry
bC9NYWtlZmlsZSBiL2RyaXZlcnMvcGluY3RybC9NYWtlZmlsZSBpbmRleA0KPiA5ZDMzZmEyOGEw
OTYuLmIwNTRjZmI5OTM0OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9waW5jdHJsL01ha2VmaWxl
DQo+ICsrKyBiL2RyaXZlcnMvcGluY3RybC9NYWtlZmlsZQ0KPiBAQCAtODIsNyArODIsNyBAQCBv
YmoteSAgICAgICAgICAgICAgICAgICAgICAgICArPSBudXZvdG9uLw0KPiAgb2JqLXkgICAgICAg
ICAgICAgICAgICAgICAgICAgICs9IG54cC8NCj4gIG9iai0kKENPTkZJR19QSU5DVFJMX1BYQSkg
ICAgICArPSBweGEvDQo+ICBvYmoteSAgICAgICAgICAgICAgICAgICAgICAgICAgKz0gcWNvbS8N
Cj4gLW9iai0kKENPTkZJR19BUkNIX1JFQUxURUspICAgICAgKz0gcmVhbHRlay8NCj4gK29iai0k
KENPTkZJR19QSU5DVFJMX1JURCkgICAgICArPSByZWFsdGVrLw0KPiAgb2JqLSQoQ09ORklHX1BJ
TkNUUkxfUkVORVNBUykgICs9IHJlbmVzYXMvDQo+ICBvYmotJChDT05GSUdfUElOQ1RSTF9TQU1T
VU5HKSAgKz0gc2Ftc3VuZy8NCj4gIG9iai15ICAgICAgICAgICAgICAgICAgICAgICAgICArPSBz
b3BoZ28vDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BpbmN0cmwvcmVhbHRlay9LY29uZmlnIGIv
ZHJpdmVycy9waW5jdHJsL3JlYWx0ZWsvS2NvbmZpZw0KPiBpbmRleCAwNTRlODVkYjk5ZTcuLmEx
NTZjNGVmNTU2ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9waW5jdHJsL3JlYWx0ZWsvS2NvbmZp
Zw0KPiArKysgYi9kcml2ZXJzL3BpbmN0cmwvcmVhbHRlay9LY29uZmlnDQo+IEBAIC0yLDggKzIs
OCBAQA0KPiANCj4gIGNvbmZpZyBQSU5DVFJMX1JURA0KPiAgICAgICAgIHRyaXN0YXRlICJSZWFs
dGVrIERIQyBjb3JlIHBpbiBjb250cm9sbGVyIGRyaXZlciINCj4gLSAgICAgICBkZXBlbmRzIG9u
IEFSQ0hfUkVBTFRFSw0KPiAtICAgICAgIGRlZmF1bHQgeQ0KPiArICAgICAgIGRlcGVuZHMgb24g
QVJDSF9SRUFMVEVLIHx8IChDT01QSUxFX1RFU1QgJiYgT0YpDQo+ICsgICAgICAgZGVmYXVsdCBB
UkNIX1JFQUxURUsNCj4gICAgICAgICBzZWxlY3QgUElOTVVYDQo+ICAgICAgICAgc2VsZWN0IEdF
TkVSSUNfUElOQ09ORg0KPiAgICAgICAgIHNlbGVjdCBSRUdNQVBfTU1JTw0KPiBAQCAtMTEsMjIg
KzExLDIyIEBAIGNvbmZpZyBQSU5DVFJMX1JURA0KPiAgY29uZmlnIFBJTkNUUkxfUlREMTYxOUIN
Cj4gICAgICAgICB0cmlzdGF0ZSAiUmVhbHRlayBESEMgMTYxOUIgcGluIGNvbnRyb2xsZXIgZHJp
dmVyIg0KPiAgICAgICAgIGRlcGVuZHMgb24gUElOQ1RSTF9SVEQNCj4gLSAgICAgICBkZWZhdWx0
IHkNCj4gKyAgICAgICBkZWZhdWx0IEFSQ0hfUkVBTFRFSw0KPiANCj4gIGNvbmZpZyBQSU5DVFJM
X1JURDEzMTlEDQo+ICAgICAgICAgdHJpc3RhdGUgIlJlYWx0ZWsgREhDIDEzMTlEIHBpbiBjb250
cm9sbGVyIGRyaXZlciINCj4gICAgICAgICBkZXBlbmRzIG9uIFBJTkNUUkxfUlREDQo+IC0gICAg
ICAgZGVmYXVsdCB5DQo+ICsgICAgICAgZGVmYXVsdCBBUkNIX1JFQUxURUsNCj4gDQo+ICBjb25m
aWcgUElOQ1RSTF9SVEQxMzE1RQ0KPiAgICAgICAgIHRyaXN0YXRlICJSZWFsdGVrIERIQyAxMzE1
RSBwaW4gY29udHJvbGxlciBkcml2ZXIiDQo+ICAgICAgICAgZGVwZW5kcyBvbiBQSU5DVFJMX1JU
RA0KPiAtICAgICAgIGRlZmF1bHQgeQ0KPiArICAgICAgIGRlZmF1bHQgQVJDSF9SRUFMVEVLDQo+
IA0KPiAgY29uZmlnIFBJTkNUUkxfUlREMTYyNQ0KPiAgICAgICAgIHRyaXN0YXRlICJSZWFsdGVr
IERIQyAxNjI1IHBpbiBjb250cm9sbGVyIGRyaXZlciINCj4gICAgICAgICBkZXBlbmRzIG9uIFBJ
TkNUUkxfUlREDQo+IC0gICAgICAgZGVmYXVsdCB5DQo+ICsgICAgICAgZGVmYXVsdCBBUkNIX1JF
QUxURUsNCj4gICAgICAgICBoZWxwDQo+ICAgICAgICAgICBUaGlzIGRyaXZlciBlbmFibGVzIHN1
cHBvcnQgZm9yIHRoZSBwaW4gY29udHJvbGxlciBvbiB0aGUgUmVhbHRlaw0KPiAgICAgICAgICAg
UlREMTYyNSBTb0NzLg0KPiANCj4gLS0NCj4gMi41MS4wDQoNClJldmlld2VkLWJ5OiBZdS1DaHVu
IExpbiA8ZWxlYW5vci5saW5AcmVhbHRlay5jb20+DQo=

