Return-Path: <linux-aspeed+bounces-3916-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2496F433CD
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Apr 2026 00:01:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwyqB5T5cz303F;
	Thu, 16 Apr 2026 10:01:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776072718;
	cv=none; b=EbNpgzAr6ML0ohdvF/P9UrTjoONqW+bYkRkVmCFpcCd7NU4HwUK/UP2l5s3sbtCCeWBVuk/j3W5SrOCfaxaNDS/YdUJJavJRt4YQ/MaNzavdLQ9wrL9nM5xM4H0YTqZ1Ty/eDe3D9slhkZoIl754wKugC18Sc6J9vSWCil3NNpKPgnSI2f8JkSi3k5kdCg5ExW2/exMXwwnuA8IAYH+LOnRp7ppSKVDw0GzNMvR8FU8bzqzICWZUjo/rBsMQrI9FYXJUKbUTIHxzlwn8JQeUZiHvcVRV7hsXghHJyMfA8syq0EcJO2y4RhCXJHAvI1d7905V9QdQgci806shLgb1uA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776072718; c=relaxed/relaxed;
	bh=LyTRrutYnATzApAeFIWft4RRx7gSZRf923LkUajEI58=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cxf4MzEpyOmCaVZNJjdVbPyrhkWcTRsGOkM9VmotfJ1HnS4iKXG3OZrU1gvKde/ohQU9TCYXJ3CttkNoyHMLWA+4xOEOBdmTqtHyglYQr8y/2dc4TDSBqoG56vS1yLJfjuR+wyUaysydYxNImKhHd+0xYSa4uQQPTYJ8G2gwq5TeUXfhvP8k+n96LdXaLbpP6H2Utk+XQidxsEATzhKfjQbLsBxh8/wLrLyN07CLEYmHvV5PlJvYOxLB08UGT2yIcWb9eeEpBk63/aSezPjnMLn+50OPNlIwiw4gfJ58tgiE+/PwRQaQhlZ9bfB9aepoxVtC9og3JhKJaRZR/R3GGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=realtek.com; dkim=pass (2048-bit key; unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=QUOwRZ03; dkim-atps=neutral; spf=pass (client-ip=211.75.126.72; helo=rtits2.realtek.com.tw; envelope-from=eleanor.lin@realtek.com; receiver=lists.ozlabs.org) smtp.mailfrom=realtek.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=QUOwRZ03;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=realtek.com (client-ip=211.75.126.72; helo=rtits2.realtek.com.tw; envelope-from=eleanor.lin@realtek.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 340 seconds by postgrey-1.37 at boromir; Mon, 13 Apr 2026 19:31:55 AEST
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvMcW4XHKz2yjV;
	Mon, 13 Apr 2026 19:31:55 +1000 (AEST)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63D9ND4z83976123, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776072193; bh=LyTRrutYnATzApAeFIWft4RRx7gSZRf923LkUajEI58=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=QUOwRZ03s5JS1wgUz5eQ7+cw0w7zUStWcsVSVzMw5mnwen6pHeIyiVQ8pi5NdXGFb
	 B24djn7qgmar6G18riwNisBfCLvaLOotjWEsHRrrYfCWRS0AZOR3bOBcEDbukNrGqf
	 Osr1gZzLTfDlpNpLI/F+nA+HwzwTDsQjv2pGmOAAY1FU47amqCbkFDTXpqYtdoqw5q
	 tpoYLUYM1LmrgYjUotV3BkcVj0nuLMhJa8H3T+z81vbs4omCn5W+LRKLG5um0cbgUy
	 vw5BKPdO8n+nwjoWVJrhF+OCk1K9s3JlJEHTRok1E8cBX7FI2qulm8TfqmVMTIOYuL
	 wIAAE0nAROopg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63D9ND4z83976123
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 17:23:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 13 Apr 2026 17:23:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Mon, 13 Apr 2026 17:23:13 +0800
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
Subject: RE: [PATCH 4/4] ARM: realtek: MAINTAINERS: Include pin controller
 drivers
Thread-Topic: [PATCH 4/4] ARM: realtek: MAINTAINERS: Include pin controller
 drivers
Thread-Index: AQHcyOquo2WiRIDaMEumOWsAJK/C+LXctDBA
Date: Mon, 13 Apr 2026 09:23:13 +0000
Message-ID: <45866135c8a54e1d98cac51932ca8e1a@realtek.com>
References: <20260410-pinctrl-testing-v1-0-6f708c855867@oss.qualcomm.com>
 <20260410-pinctrl-testing-v1-4-6f708c855867@oss.qualcomm.com>
In-Reply-To: <20260410-pinctrl-testing-v1-4-6f708c855867@oss.qualcomm.com>
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

PiBObyBkZWRpY2F0ZWQgbWFpbnRhaW5lcnMgYXJlIHNob3duIGZvciBSZWFsdGVrIFNvQyBwaW4g
Y29udHJvbGxlcnMsIGV4Y2VwdA0KPiBwaW5jdHJsIHN1YnN5c3RlbSBtYWludGFpbmVyLCB3aGlj
aCBtZWFucyByZWR1Y2VkIHJldmlldyBhbmQgaW1wcmVzc2lvbiBvZg0KPiBhYmFuZG9uZWQgZHJp
dmVycy4gIFBpbiBjb250cm9sbGVyIGRyaXZlcnMgYXJlIGVzc2VudGlhbCBwYXJ0IG9mIGFuIFNv
Qywgc28gaW4NCj4gY2FzZSBvZiBsYWNrIG9mIGRlZGljYXRlZCBlbnRyeSBhdCBsZWFzdCBjb3Zl
ciBpdCBieSB0aGUgU29DIHBsYXRmb3JtDQo+IG1haW50YWluZXJzLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBvc3MucXVhbGNv
bW0uY29tPg0KPiANCj4gLS0tDQo+IA0KPiBUaGlzIHBhdGNoIHNob3VsZCBnbyB2aWEgUmVhbHRl
ayBTb0MgbWFpbnRhaW5lcnMsIG5vdCBwaW5jdHJsLg0KPiAtLS0NCj4gIE1BSU5UQUlORVJTIHwg
MSArDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQg
YS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+IGluZGV4IDEwZDEyYjUxYjFmNi4uMzc0Y2U1
NWU0ZmI2IDEwMDY0NA0KPiAtLS0gYS9NQUlOVEFJTkVSUw0KPiArKysgYi9NQUlOVEFJTkVSUw0K
PiBAQCAtMzM3Myw2ICszMzczLDcgQEAgRjoNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2FybS9yZWFsdGVrLnlhbWwNCj4gIEY6ICAgICBhcmNoL2FybS9ib290L2R0cy9yZWFs
dGVrLw0KPiAgRjogICAgIGFyY2gvYXJtL21hY2gtcmVhbHRlay8NCj4gIEY6ICAgICBhcmNoL2Fy
bTY0L2Jvb3QvZHRzL3JlYWx0ZWsvDQo+ICtGOiAgICAgZHJpdmVycy9waW5jdHJsL3JlYWx0ZWsv
DQo+IA0KPiAgQVJNL1JJU0MtVi9SRU5FU0FTIEFSQ0hJVEVDVFVSRQ0KPiAgTTogICAgIEdlZXJ0
IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+IA0KPiAtLQ0KPiAyLjUx
LjANCg0KQWNrZWQtYnk6IFl1LUNodW4gTGluIDxlbGVhbm9yLmxpbkByZWFsdGVrLmNvbT4NCg==

