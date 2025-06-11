Return-Path: <linux-aspeed+bounces-1377-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2A4C677C4
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Jun 2025 08:02:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHJ6q2Pvzz307V;
	Wed, 11 Jun 2025 18:02:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749628963;
	cv=pass; b=gEB5meQOgX/9g8GKlHTEHmiBncX2ZwGGW/5jTN0zZg2P6L0OjYuzT+xZ6gvBCyBKdn9+bA58rP8flCxiywqg3qiuSg4WbFjLP8J728rjPy6KyYP+zhNSULhJJKt18ZQ56rpmGv0e1gj3HA064VrOftErgT6HtrXam72/7plz/RjzLEa40bqC515RyH9tdpibm5zCrPl82UDCJ4mTRLOWujOOP3zkpoblCi7D84r1jjehSoRqcDn393K3IcRBccvYyarzQ2ADTPFTlEIAqW7WVDVX8Vru4xxSBcHK+Z6JBeITNXVo12fxV73oe1dDQpX3fKObuQgqD5BGQbxlrYB3xg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749628963; c=relaxed/relaxed;
	bh=T6Z6HecyuTiFX0MzKiIAdevDfGT7Pgy0wICVU7mWFzo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MU74TMJypU9ryHiGEzfd4h1lizN49M0Ufz77d8+Rgdt9iXAXqTlqkwt2Weyav9jzu2x2JmK1CvsRNp0GWTPNP812/jyhUORJW/rPk4XoLGklxaS0NNOa1Lg8EEkbtJthiW7EE1Sl0DYgop3P/0FzCaqBWXXh60ZljrCE1xtS1kB2slJDhLdNQaY3BSEnL9/57qS033m4ZaFq5r+t7X5NopTDS0qy/Fv51FOD6c/vD6a/fVyOrzwEYUrxw/ZkXUO5Y0YuZjCXlTMmowc9C3Wn4Yk5nVj174RVps/jxbsQ9YLh7R4VXdEsLlxsCm/YN9/rVEh1a+tqBOd8C7FOTEYR4g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHJ6d6GLkz2yMt
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 18:02:33 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iW9++iWRpx8q4JMf+ISt8Su+J8HJ46Ws40jhU+/pSkhvD8b5bYR19vXJn76LoRNh0H3O0zw0XSAcWWjMtSRLIUuATNuPxrjUQ8hmUEU7WjLk4dCr8W+kR5UeljWBm3Ssd92uXTX5KBqbyLrfiugTczcqlt98t3d+6b2sxTLPacOiqrsqKXd9k/0EAUQ3BdufMtweYV68O80Gijg2cJBvIDgd61QUsYp+AZFA6us56eKlJ43WoqpyCBegO16QYBV84yY9o4kYGlacEZF6M/b2hLPDjobsapfQbTnHfqnTjF7mb2XsD+KrJpKjvlgdKXAPflIbY0WOC4SfqRUx2vuJDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6Z6HecyuTiFX0MzKiIAdevDfGT7Pgy0wICVU7mWFzo=;
 b=oGY8TpXAd27ZoaWdQmjKZJ7iLPYO0ZbyD6SfgMZd5FHvSN7s/2LtlveDPC8J9V+IPr+5QFhtoSIdVXz0XGhnNXplzojjuPi58lzbqeX+q/wkaQWnLuCcHTrjOhjGfid98IdTWpVEv5Af2gvKUtTbyrqvEeMjH+MgL+HAn1dxdU+E6e4VFR4c4d+p9So6uLr3wEODHg0iuvBA1VbqSFY16/Sttjo4sp+x8Y15L9NyUzYA1izmN7CdPiRsqwb4LHR6MkqlmpMiGgliSuyrX6Crnp4P9Y2wP77v00iClmJFP7Gss/Egy7CVO+2kCutm9p2KhWT5QnMJNW7DuAa9VUOjVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6Z6HecyuTiFX0MzKiIAdevDfGT7Pgy0wICVU7mWFzo=;
 b=qs9G+IO0RWOvjfzsXcdC5xRA78CTA0eQVMNZ0HAy1a/mDakj5Dh7rh8SIAMzdXMeWRxi1/YGR2pNIvVTYW/p56WWy50JxPr/S18nDtXAihDyWI8e62Gay/RQC3uKcTA7ow17gbsEJmfmWb/Usnrb/cB+YD141cYb3qYgFg+y5hhfI8oI/VlraUsIUGkXqIGnYro9z2kx3Uv1N/jPTWjZV7xPjJpfVfYYZGq82ethk+p0lVS2vLFuI+8Q7x3WbA0POOuVwYTUSJUHESkYk6NLX2bk8DVjmd6M3vGbJceVyNZKrcvlWdq+boAXz5UDnZLMAG4YKBqQjfAJEYxPUTnyBA==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by TYSPR06MB6900.apcprd06.prod.outlook.com (2603:1096:400:46e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 08:01:48 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%3]) with mapi id 15.20.8813.021; Wed, 11 Jun 2025
 08:01:48 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Mo Elbadry <elbadrym@google.com>, Rom
 Lemarchand <romlem@google.com>, William Kennington <wak@google.com>, Yuxiao
 Zhang <yuxiaozhang@google.com>, "wthai@nvidia.com" <wthai@nvidia.com>,
	"leohu@nvidia.com" <leohu@nvidia.com>, "dkodihalli@nvidia.com"
	<dkodihalli@nvidia.com>, "spuranik@nvidia.com" <spuranik@nvidia.com>
Subject: RE: [PATCH v10 1/3] dt-binding: clock: ast2700: modify soc0/1 clock
 define
Thread-Topic: [PATCH v10 1/3] dt-binding: clock: ast2700: modify soc0/1 clock
 define
Thread-Index: AQHb2qLj+PLM3wPM4Uuj7ZlIZbTcAbP9km8AgAAFozA=
Date: Wed, 11 Jun 2025 08:01:47 +0000
Message-ID:
 <OS8PR06MB754175814A31E7A4A094BBB9F275A@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250611073139.636724-1-ryan_chen@aspeedtech.com>
 <20250611073139.636724-2-ryan_chen@aspeedtech.com>
 <cdad0cff-3f45-4e91-800a-c94089def32a@kernel.org>
In-Reply-To: <cdad0cff-3f45-4e91-800a-c94089def32a@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|TYSPR06MB6900:EE_
x-ms-office365-filtering-correlation-id: fb9c24a9-a035-4c67-6bd4-08dda8be372e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?NkpFNzJmZHU5aVhUZTZsdzVSUWNmeVVWa3JiNDE3ZGJkcUIwZkx1d3lMU2RN?=
 =?utf-8?B?NHIyWGVhai9jc1M3YTB6dkd6MkNCeWwrenAxd0VVdUVoMEJQeSt2QVRDc0Qx?=
 =?utf-8?B?SUVIcElWaFlLNTk4NU9HbzRsUExrTTBkUktSWmNVUFo2RE9CdDJtb2RrVVRQ?=
 =?utf-8?B?SzN6R1JKZ3lZTlVueC9JVnV2NllhMU5pRE1PRGV2V3dFRkprT0RrMDFmTHhM?=
 =?utf-8?B?T3dtaStoWTNXRy9IZXpVQ2RoL1JnakFORng1U0ZuemczK3lKdDdFbEFIczg3?=
 =?utf-8?B?ejlOSTRxZzNFbHBKOHRFSjdud0pBVDdRVWdhMWdEV2hyU2h0YncvejJOaVk2?=
 =?utf-8?B?VG91cTdXNkExNmx2WitGckF6OHRrTlRLMFNHaEZCYWNXeHlnTHFtYllBenY3?=
 =?utf-8?B?QU1nUTZjS1dZTjlLSkxwM3hLNk5ENzNockoyeUdXVXQ1dStXSzNCRzg1QWFJ?=
 =?utf-8?B?M1BGSW1Lb3dNNzQxSys2MDVNWEE4dnVtaVBkR2RyZVVoVjlpSlIxeEFKb2xY?=
 =?utf-8?B?bkU0bFRUaUpjZWg1ZkdlTDh1bHVBUVZ4Z3pINU5sbWJBZ2owZkpDWDdjMStC?=
 =?utf-8?B?S05vSFRvZUpVRmdPYlNreTlkWjdHckhzdFRGOWRMbHFlRUpNQ1Z1QS9GWGxS?=
 =?utf-8?B?VEpZZEVBZ0lxZDJ6SnAra3NLY25SWVRVSlZSbEZ3M2dFdW1pclkxUk10UVlH?=
 =?utf-8?B?T0RRNU82MzNRR0J1SkJyU0VCSHRuQzU0Vkpsd1NPUWoraHQ3ck42REROQk1C?=
 =?utf-8?B?b3E4ZTl6cWt3TVJ3QmpRZ2g3cnFqK01FRXBmTEY1S282V1lENzNDMElKeDRN?=
 =?utf-8?B?em15YjlhdXF4WUV2dGRLd2Q0WERvd242Z1VBMkRhcmpkUW9LakVoMzFLSlJ2?=
 =?utf-8?B?N2tOOWJYQ0JQV3BNSFJYVU9wUjhKZmRDbTlnUGYrN2NvSkNidFVTeUl2VkRX?=
 =?utf-8?B?NU1iOHlOS21yb09oTmV6bnR6ZU1uTUdvcDJIOWN3S3NzMUwwTk92RTMzWUZE?=
 =?utf-8?B?TlpEcGVWWm1YL2lYR0FTZUwrRExKYjlnNXZoVDZoQzYzY05SMGI2aHZSRmtx?=
 =?utf-8?B?NGpLdUZkMzM2L014RXZzRkRFVG9qTkdtb1ZRUlVxZldQb0xXbi9pVFVSNWk4?=
 =?utf-8?B?K25pNmpTNU9abW11dVlmOHh3WHF1ZmVuSG00U2lxWlQzRi9mVkZ5UFRvQS9o?=
 =?utf-8?B?YTh5UVd5QjFGaW9remJxVjQ5NGdJWmsrckxwaFh6elplTjlzOUJ5Q3A1TDIw?=
 =?utf-8?B?bGhLYSszNTcyazdsOVRzdmVDMHVGaUpBdlQ4VmF5N0J6NVh3REtpaUhvOXEz?=
 =?utf-8?B?K1QyN3hrQVhCdnowVXgwN2drejM5SnlaWWMzVFpXcmN5Z2hzZEMwU1VLZUNF?=
 =?utf-8?B?ZlJUVFJrbm9oWm5PcUhqdU5GY0kzSk9TVlFzN05wQ21ZdkhJNFJUbzBpbERT?=
 =?utf-8?B?dFc4NlBUcE0zaXlOVVFhWmJKWXY0ZWMwajBxSFJON2p0cnRCNWo1MUNUYm1D?=
 =?utf-8?B?UmV5aGl3aFhsdG1YNzhDb05MNkxuOU5lQWdaWjZvSCtZeGNlVTU1NWE2OFI2?=
 =?utf-8?B?Vk5DMWxEVEFBQ2g0aDIwQ0wyMGFRdmdEUTlQSEVqc2hGOURPRUNxVytXbVQ3?=
 =?utf-8?B?cU41NDRINi9hbEhGeEFVY3RMU0plenRtU3RjQUIrZzJYTlFIVTdkdllkdy9Y?=
 =?utf-8?B?aGl4Yzkzb09CNGsrT3FlSERjLzYyVGNQNzZuU0NjdzlrWkNpUnlnK2JDMndD?=
 =?utf-8?B?a0hMY3R3SUUwY3E2UWljV0pyQnNORXFGSVVjeWU1TVZZTmxIaHRBSUdYeXRw?=
 =?utf-8?B?bzllaWswUmh1MHJPMit5RGlERlFSTXJYRy9BUFBpYWZENEdFeFZrZUxEaEcr?=
 =?utf-8?B?ck1SenBDOGw0eDhVa3lZNzY0U1Uyei9Ya0p3K1dTVXFyQVVaYXFPbjJaL1B1?=
 =?utf-8?B?cHZ4SXQwdTlySEpYUDJEZHVLZ0kraWVNYXlYQkFRN3l5VjZERCtKbHdPTnRt?=
 =?utf-8?B?bUpZWUZISTJxUFFlczFnK29lemZHNkQ3VURUQndhUk1IWDdiV1Y5U1RSaGRE?=
 =?utf-8?Q?VratSu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TlQzSkN0bEVrbE43SFpVM3k4RUx0SkNEaUdSZUFBL1Zib0FtaFEzUWVwbS80?=
 =?utf-8?B?bi93TGhSd1RSSlVGMEhKMXpEdklkNkZKckEzSy9WMzg1RkgvY01icGFoMm5U?=
 =?utf-8?B?T2c0VG9Ed2lJbnV0Tzk2NXAvMU1JSGh2bkxOc0xzVWZ5ZUNNRDBwQkNQVVNp?=
 =?utf-8?B?bTE5NDVQKytjMURjcklGWkVGTlVlZlhteHBpazJRdDVKSjBxa0plZEZzdDhD?=
 =?utf-8?B?NnRwUmVjenRDOWtJZCtZZzRuTDFvY2hUb0xPL3IraHJkWjNrU2ZBMFhBK0Ix?=
 =?utf-8?B?Z3U3TFE0TzEyL0ltanpQSlNjOTZ2ZWJ2V2lacjRtQkpZWGRFd0xPdWJKaXk3?=
 =?utf-8?B?dXU1dkVuL1NkR210NFYzMHJtc2Z2T3VmZmhPazR3TDVQalZ0WjJ4eHR3ZFl4?=
 =?utf-8?B?MmRtWVA5MC9BUUc3NVIwTjBmYmVSOTJJNThLSksvOG81KzF0Qlh6TDFEbThC?=
 =?utf-8?B?YjhZK1ozVkVnendJaEM0VkpEcmVybE01TzA1SnZFZ3NuQjVBRTExNFFLeFZU?=
 =?utf-8?B?d0J2RzJQWnVva21wU0c1SFN4SWNKellmdXdzZnVIMHJUeUtmVWRvckEwVndt?=
 =?utf-8?B?UHllMDFockRCKythcStvSW45UVEwSWpWdkFFNVhnWXBuTDdsUm16MGdvc2N6?=
 =?utf-8?B?N2lvUVh6ZitUM2gvQmpZUEZvVUxMVDBIQjMxWkFSeHF0aGoybVRTbnZYWGZT?=
 =?utf-8?B?amV2TlQ3emdBSzUxeWp4SmxMSnBtbTdVcStWS0p6MnI1cmp3V2xoZW5kd1FZ?=
 =?utf-8?B?cXZzNzNpVGNGaUpBSXkxZ3RMRmt3c1VhdzF5SFNXSnhvNzRYR2hYL1A0eVNo?=
 =?utf-8?B?ek42aGthQ1ZNc3hpSmtlNC9BeG1PeUp5VnJnZlgwdC9rRzZzWk1BVGFCb3VM?=
 =?utf-8?B?b2c5ejlnc0s0UnFuYlFweDBYL2R4UEg2VlJrRlN2czBPUEdEYmdDVVp3UWpo?=
 =?utf-8?B?QkkyRlIzRGkxUld4dDhRTWxsK1ZvblA3WFFZem1SUGVrMUFMc1ZrV2xyWUpT?=
 =?utf-8?B?TzhONnl2Q2Y3b1dwUDhNOHdtd0d2VnV2ZkZiVGUrWEdSRDhhODBxZ0dwOGNB?=
 =?utf-8?B?QU96MjA1OEZ0aFM4NTlVRGhVSGtabjA1WkhsN3g1bFpmcFpwVkovM0FXTXg2?=
 =?utf-8?B?bWFkU1FSb3g0dTVDTGEyUTVjYlhDWDd3V0NEUFpMUUgrejZZWVNPVWx2WFhu?=
 =?utf-8?B?VG9jZ2pDdWlrOTlvanlqRUlBUmU2OVpHa3FjTFF0bnlncldodG8zcjlSS0M0?=
 =?utf-8?B?KzV0aVgrb2FqN0hZWUVqY21ib04zUXpTNUF2UlNVVjE5SGtpTGc4OWg5Qndh?=
 =?utf-8?B?QzFNbHdMN0xMYkNCQmt1L0RHUld1eVFQUzV6M2JIOXFxQWdZd2F1SUd6QXhC?=
 =?utf-8?B?MGFGdTc1a1hnSDlCemdZZXpFMGhMMXZZTllmbjBEUk1mU2ZjMHVvYVBRVzlB?=
 =?utf-8?B?ZmdmNHcvWXNRYnphcmdyY284N1o3WEVGNGZYQTk1ZXdRMnRVa2QyTEJXYnNx?=
 =?utf-8?B?eFJ1NW00WUFBeWVOK0V0cUF3cVR1Mk9NNUJ4Rm5GNURjWkhVNkk4UGpsQTJN?=
 =?utf-8?B?Tk5RcWpRQ1czL2ppM0ZDZ05Ba2JESzhPRjVyVU1HOGp1TGlteHpjMHFaa05w?=
 =?utf-8?B?a3ExS3hsQzZuVzVkakszN1BJa2RoUW9qSUExRTk2UmN1c2VwYU9jTms0YUYw?=
 =?utf-8?B?U3ZLRHZhQ3g2VXk0N21hSGp2ZmZKKzd5S3JCWGIzdkFXVTRiZk9UMk5aMnlm?=
 =?utf-8?B?aWxYNWNLNlpIZ0xRdVNTb21tWUg2K3FzRjVmZXFkK28vVlMvQ21udm15RklM?=
 =?utf-8?B?dkZOSHkyQ2ZYa3RseG9rNE1YNXZYUVd6dmlNcWIxQ29zdUNHTjJtU3dzNzU4?=
 =?utf-8?B?a0JSSEh2WEEzZWR2ejhXZkJqSmRUdUdDSnZZa0hVa1JqSU04L3J1R082RlVt?=
 =?utf-8?B?SW8rOVFHSi9hT0ZydytVRDQvOVBMQjMzUHVjU1FoQk1QZVFRYjRXTVlxa2Jp?=
 =?utf-8?B?cHYrWVJJTnc0YmlrRG5DUlA1ditiYU05UFhqZytmbmQ4cWFWOXNETU8vVWND?=
 =?utf-8?B?OFhtYUFlMG9PUXJ4dDNPYmRvbFFPdUhNV1loRHplQVpxRWNMekU0L0JWQzlj?=
 =?utf-8?Q?uDI7rFpIQQRTiVWaxrRYtBdsf?=
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
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9c24a9-a035-4c67-6bd4-08dda8be372e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 08:01:47.8886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0OmDNV4GrYAEzqNRGwu31vSYN8WxcxQ1PkscMjYlfmmndDEmHmVF1h6YZjen/dSyzlG3SOV8Ut8Goa1Dssa4ZpMEtOxPdzn4VjkBog+ogd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6900

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxMCAxLzNdIGR0LWJpbmRpbmc6IGNsb2NrOiBhc3QyNzAw
OiBtb2RpZnkgc29jMC8xIGNsb2NrDQo+IGRlZmluZQ0KPiANCj4gT24gMTEvMDYvMjAyNSAwOToz
MSwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+IC1hZGQgU09DMF9DTEtfQUhCTVVYOg0KPiA+IGFkZCBT
T0MwX0NMS19BSEJNVVggZm9yIGFoYiBjbG9jayBzb3VyY2UgZGl2aWRlLg0KPiA+IG1wbGwtPg0K
PiA+ICAgICAgIGFoYl9tdXggLT4gZGl2X3RhYmxlIC0+IGNsa19haGINCj4gPiBocGxsLT4NCj4g
Pg0KPiA+IC1uZXcgYWRkIGNsb2NrOg0KPiA+ICBTT0MwX0NMS19NUEhZU1JDOiBVRlMgTVBIWSBj
bG9jayBzb3VyY2UuDQo+ID4gIFNPQzBfQ0xLX1UyUEhZX1JFRkNMS1NSQzogVVNCMi4wIHBoeSBj
bG9jayByZWZlcmVuY2Ugc291cmNlLg0KPiA+ICBTT0MxX0NMS19JM0M6IEkzQyBjbG9jayBzb3Vy
Y2UuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSeWFuIENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0
ZWNoLmNvbT4NCj4gDQo+IFN1YmplY3QgcHJlZml4IGlzOiBkdC1iaW5kaW5nczoNCj4gDQpUaGFu
ayB5b3UgZm9yIHRoZSByZXZpZXcgYW5kIGFjayEgDQpTaG91bGQgSSBzZW5kIGEgdjExIHdpdGgg
dGhlIHVwZGF0ZWQgc3ViamVjdD8NCg0KDQo+IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0
bWwvbGF0ZXN0L2RldmljZXRyZWUvYmluZGluZ3Mvc3VibWl0dGluZy1wYXRjaA0KPiBlcy5odG1s
I2ktZm9yLXBhdGNoLXN1Ym1pdHRlcnMNCj4gDQo+IA0KPiBBY2tlZC1ieTogS3J6eXN6dG9mIEtv
emxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiANCj4gQmVzdCByZWdh
cmRzLA0KPiBLcnp5c3p0b2YNCg==

