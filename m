Return-Path: <linux-aspeed+bounces-240-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F32E7716A
	for <linux-aspeed@archiver.kernel.org>; Sat, 14 Dec 2024 21:24:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y9fN660gfz2xpl;
	Sun, 15 Dec 2024 08:24:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.58.85.151
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734211446;
	cv=none; b=A5lJYgo2GsLkzhpLyaNFA5vExdNh3vgKALknE2Zlo/h+RihAyne38PUv7RNGhKomP3Z/Ue/1GE7bVwgyj469NG4z8TxFTv1cccLO2/1gctwMJnWNaJnEz3u5LFDyZakJLfR54nrUX27sOx+Qwa820Ztiv0CVY23rN7dMCIf0X2PWO+M5ameEupsBi6U1gVyevvmUUPCZ91SRQ8+LgNxCgAFNQqwetpZHpkLP5rqGp+q2WQE82Ofjy1BODp2UF95xFd/TD09EUqiT++Imic5Zdo1XKPkYAkP9aeonfk2BWpkQj7mPfNHXe/Nfdtz1ygiS1Rg8NaeWVa6FfhpY24jstg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734211446; c=relaxed/relaxed;
	bh=8GG0RjcNGNE2OK3lCVeZBPxKNfW8B/oXmAkc+WuOPYA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=LTZgc9cFemUSOzgmpvSuLvl2Sbqd9u5uabyTYxIuUsMqGdbwjYZMSBGgm7eKxmyLGBLRXqhPmp7Z8WjhwMQ+2ymEdnEhctMfuzyGFx6rZ8va1YMz1/b6cRJeNncXZixesA+Qkm0rIgFHtl7uubFg45OPJNNSZWSW0ehO0OibFe6fHGBFNpjo7LQAMfZnpYZvoQJT2BS8YeVv2y/7+YWH2k2BUiGPU26/Zk8BIOBUOGbv77bhxcW21zE/TJxLvdAzOhlKotQynfHJHfkPHdfNCZWe3o9QfFMWFKtoNqWf4zod82xtG5fBZjCVwtrHMqKGuAGKB+qMQLpapffIbCjg1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass (client-ip=185.58.85.151; helo=eu-smtp-delivery-151.mimecast.com; envelope-from=david.laight@aculab.com; receiver=lists.ozlabs.org) smtp.mailfrom=aculab.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aculab.com (client-ip=185.58.85.151; helo=eu-smtp-delivery-151.mimecast.com; envelope-from=david.laight@aculab.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 106 seconds by postgrey-1.37 at boromir; Sun, 15 Dec 2024 08:24:05 AEDT
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y9fN50W8lz2xpf
	for <linux-aspeed@lists.ozlabs.org>; Sun, 15 Dec 2024 08:24:04 +1100 (AEDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-58-sktCOR70PYGp0bebtytxiw-1; Sat, 14 Dec 2024 21:22:09 +0000
X-MC-Unique: sktCOR70PYGp0bebtytxiw-1
X-Mimecast-MFC-AGG-ID: sktCOR70PYGp0bebtytxiw
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 14 Dec
 2024 21:21:12 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 14 Dec 2024 21:21:12 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Guenter Roeck' <linux@roeck-us.net>, Phil Eichinger <phil@zankapfel.net>,
	"wim@linux-watchdog.org" <wim@linux-watchdog.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] watchdog: aspeed: replace mdelay with msleep
Thread-Topic: [PATCH] watchdog: aspeed: replace mdelay with msleep
Thread-Index: AQHbTJ2DHVjYGoChYUCL8UX75YmbgrLmQtrQ
Date: Sat, 14 Dec 2024 21:21:12 +0000
Message-ID: <d7ab80332def4a328cb9492fddcb8bef@AcuMS.aculab.com>
References: <20241212113014.1075414-1-phil@zankapfel.net>
 <3fe75eab-e700-4ae2-984b-42342ec7d784@roeck-us.net>
In-Reply-To: <3fe75eab-e700-4ae2-984b-42342ec7d784@roeck-us.net>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
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
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6Nw8QZTt2tZy_jC6IDVHPxcnnjaNCHaxtRRzp1ltFhg_1734211329
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogR3VlbnRlciBSb2Vjaw0KPiBTZW50OiAxMiBEZWNlbWJlciAyMDI0IDEzOjU2DQo+IFRv
OiBQaGlsIEVpY2hpbmdlciA8cGhpbEB6YW5rYXBmZWwubmV0Pjsgd2ltQGxpbnV4LXdhdGNoZG9n
Lm9yZzsgam9lbEBqbXMuaWQuYXU7DQo+IGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdTsgbGlu
dXgtd2F0Y2hkb2dAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7DQo+IGxpbnV4LWFzcGVlZEBsaXN0cy5vemxhYnMub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHdhdGNoZG9nOiBhc3BlZWQ6
IHJlcGxhY2UgbWRlbGF5IHdpdGggbXNsZWVwDQo+IA0KPiBPbiAxMi8xMi8yNCAwMzozMCwgUGhp
bCBFaWNoaW5nZXIgd3JvdGU6DQo+ID4gU2luY2UgaXQgaXMgbm90IGNhbGxlZCBpbiBhbiBhdG9t
aWMgY29udGV4dCB0aGUgbWRlbGF5IGZ1bmN0aW9uDQo+ID4gY2FuIGJlIHJlcGxhY2VkIHdpdGgg
bXNsZWVwIHRvIGF2b2lkIGJ1c3kgd2FpdC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBoaWwg
RWljaGluZ2VyIDxwaGlsQHphbmthcGZlbC5uZXQ+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3dh
dGNoZG9nL2FzcGVlZF93ZHQuYyB8IDIgKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvd2F0
Y2hkb2cvYXNwZWVkX3dkdC5jIGIvZHJpdmVycy93YXRjaGRvZy9hc3BlZWRfd2R0LmMNCj4gPiBp
bmRleCBiNDc3M2E2YWFmOGMuLjk4ZWYzNDE0MDhmNyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L3dhdGNoZG9nL2FzcGVlZF93ZHQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvd2F0Y2hkb2cvYXNwZWVk
X3dkdC5jDQo+ID4gQEAgLTIwOCw3ICsyMDgsNyBAQCBzdGF0aWMgaW50IGFzcGVlZF93ZHRfcmVz
dGFydChzdHJ1Y3Qgd2F0Y2hkb2dfZGV2aWNlICp3ZGQsDQo+ID4gICAJd2R0LT5jdHJsICY9IH5X
RFRfQ1RSTF9CT09UX1NFQ09OREFSWTsNCj4gPiAgIAlhc3BlZWRfd2R0X2VuYWJsZSh3ZHQsIDEy
OCAqIFdEVF9SQVRFXzFNSFogLyAxMDAwKTsNCj4gPg0KPiA+IC0JbWRlbGF5KDEwMDApOw0KPiA+
ICsJbXNsZWVwKDEwMDApOw0KPiA+DQo+ID4gICAJcmV0dXJuIDA7DQo+ID4gICB9DQo+IFRoaXMg
aXMgYSBfcmVzdGFydF8gaGFuZGxlci4gVGhlIG9ubHkgcHVycG9zZSBvZiB0aGUgZGVsYXkgaXMg
dG8gd2FpdA0KPiBmb3IgdGhlIHJlc2V0IHRvIHRyaWdnZXIuIEl0IGlzIG5vdCBzdXBwb3NlZCB0
byBzbGVlcC4NCg0KV2l0aCB0aGUgcmVjZW50IHNjaGVkdWxlciBjaGFuZ2VzIGlzbid0IHRoZSBj
b2RlIGxpa2VseSB0byBnZXQNCnByZS1lbXB0ZWQ/DQpXaGljaCAoZWZmZWN0aXZlbHkpIGNvbnZl
cnRzIGlzIHRvIGEgc2xlZXA/DQoNCglEYXZpZA0KIA0KPiANCj4gTkFDSy4NCj4gDQo+IEd1ZW50
ZXINCj4gDQo+IA0KPiANCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5
IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRp
b24gTm86IDEzOTczODYgKFdhbGVzKQ0K


