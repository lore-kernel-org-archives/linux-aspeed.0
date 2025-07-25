Return-Path: <linux-aspeed+bounces-1832-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351DFC87FCA
	for <linux-aspeed@archiver.kernel.org>; Fri, 25 Jul 2025 07:19:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bpK4j4yrjz3bTf;
	Fri, 25 Jul 2025 17:19:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753427973;
	cv=pass; b=fqyD6Dv7OYiG94+TDEIjC4UqRh2ZburTIJ4nhaZ8FJgYb7Lw6L6Z035IWegeTBwjpwGs2ePKAs5tisoellxr+27H1TTYRAJ6Yq829ra61jyFkin/caMsaF091m2jDzMkOOM+iZLAPIxuaj8VgfiQscDPcv+mL4heryIWsCWqYbScVCM+rUAY4w5EaNT4S+aU6xrgEOjmijIiZItPoBkAjteYvZvO/c9DIRyE5Bo9QUfN9vhThPFRUJTs/ftLNJ838I6BbjWtyEcDLItZOS2PsMyOL2PcOxLP7uaWw1oMiIy2uZnzadyz4VbPnDtWZwFalEOdB5K+VDcD+reYAUhyoA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753427973; c=relaxed/relaxed;
	bh=pOJgg2VUEhrGOJHfsyC333zorR7aT/R4qD3MASFsSgQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kg0yXkuHzHqTW4kPxTfkv/5li1QaOHwR1wkbaiE46zE1Fhj8FlfKlnYAohJm5krPpyRFUUBlreyOH+vjtrUIdp95zXAgnVxf5Ssd2C/hZcsOVEiZ9aj9qyksJD3ZvXyQLQRJEJyo3FbECbGXkMJDrNY90s/i5sTR0YdDRAjPm9WK95bFdQJXgxGM10nJ8RZjajV4E5+j1PRTPOF5LGUG+XCMJsqdGcnN4wkf8Pa1fKw8XN9yADKFPQMTOwlgrjwLh2xuaT6lqa10Z6WruUC6bTG6qibcQbfL7ppSwfarDxlevhGbeQON8/n7cVP+CvUnDqz6/RTTAiGAAAGTuiPIBw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=2a01:111:f403:c40f::7; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::7; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bpK481VTHz30Wn
	for <linux-aspeed@lists.ozlabs.org>; Fri, 25 Jul 2025 17:18:36 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCF/jThtpZUkEEcydxPPMTM1BkS9MYDvgbCcDFgtGW2zcGCVb2jEG/8ahTzKWXT5tdqa8wqDv5df3rxwV+J0suSmKg5G+3O8W61AIQjhRkvCArpUJJ7M250E7ROIN8KNiShLT8ec8/zb0Zfoafz1CcpNfU4DBTqbN3BiYNT+RaUoxVUWw48q2joemll6g6G9GiGZMbtTUd8FNeekFWMYoM99Tli+709QdJv6iR33h6FHutevCEGwyMMrI+XTqre7Jo0G+Lwh1nCvkoUM2f4jqkaDHkUDVHZByxKCVaXLkOkRBCESMLe37R2RRdFnHrYEHleHYSkyVVrThh9uzgR+2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOJgg2VUEhrGOJHfsyC333zorR7aT/R4qD3MASFsSgQ=;
 b=nlzR7wMpShNeF7qwDUmxccvJ48N4ZFuXYR5Cnhs3rpwzXkXZDNGM+uEjNHEW5EMV+OjqousXxkWZzDXYOjQunNIfkpF3ip/KbM4nS/aS0LcqvqgoLRcwkQ4YDu+T+Aj0MH5+Uu9CNLkkFqPSCC0xQzQvnOj646ihy67IZzeU7qzD3krw0udF2jBYGblc7Xgh9Z3G1cDVEQMGqy9l8ENKwbPTPLkZa7sFeECKRFs1gIqvQ2K3yYM66oeSkzs48i9LLAX0wJYFrW5ZRFSs2uKN7LTOzyNfYwF6dal+U9LB1H8cjkh68fcFQ4OQdu4wGXmOsoOiS+C5ZRyXha8AAVKF8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOJgg2VUEhrGOJHfsyC333zorR7aT/R4qD3MASFsSgQ=;
 b=iGdJhyZKJt25WcuXsfcw9NFPPyVzjU88xSpr5hMw+b6WfEqQP+/fmgdK0FW+jJi0en4o6+TSe8/WVDBl6+W8wuiqb1dBVukpbraQI+7OGkiw+quHORCcc9MGx6Gbw7qNYffs4t13mAaxALmpgUfBJ8q1RY37wfpsEX7KCyq/RycuCaj0Ryd4iV8b2eSU+RAKP/f3RH81eVck+0BVUhlpFIs/EnZ9fU8Wb8AUm3QPduRgfIKPfnDq/oTUz406VblL6PEH49to2pSKqiOBm4pALDLS1qNA7YiAGFY/tbtND2AEcoK0c2QYBFgnSQykMSOjM8wjdK3PWoYGb5cfr/FmiA==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by PS1PPF46A647402.apcprd06.prod.outlook.com (2603:1096:308::24c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 07:18:09 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 07:18:09 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Kevin Chen <kevin_chen@aspeedtech.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v3 1/2] dt-bindings: interrupt-controller: aspeed: Add
 parent node compatibles and refine documentation
Thread-Topic: [PATCH v3 1/2] dt-bindings: interrupt-controller: aspeed: Add
 parent node compatibles and refine documentation
Thread-Index: AQHb+u5GGJR1Lh1PR0C5h6er79qfsbQ/O3cAgAAieECAAxQ2oA==
Date: Fri, 25 Jul 2025 07:18:09 +0000
Message-ID:
 <OS8PR06MB75418DB8CDD04D506EB13215F259A@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250722095156.1672873-1-ryan_chen@aspeedtech.com>
 <20250722095156.1672873-2-ryan_chen@aspeedtech.com>
 <a9294387-ce7f-482e-89e1-7c85feaeeee9@kernel.org>
 <OS8PR06MB754125722911782DBB3CFEFCF25FA@OS8PR06MB7541.apcprd06.prod.outlook.com>
In-Reply-To:
 <OS8PR06MB754125722911782DBB3CFEFCF25FA@OS8PR06MB7541.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|PS1PPF46A647402:EE_
x-ms-office365-filtering-correlation-id: 12b06150-5691-4bbd-011d-08ddcb4b6887
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K28zcHJTOTdTVWh1TnJTd0t5N1ozczFEclprS1R4T0RtSDhhb1publJnemV6?=
 =?utf-8?B?a1pqczZySnE1RnZHZlBrUjZpRmEvOXF6SDczSUo4TnM0OG9SN0pEZGVvVTdr?=
 =?utf-8?B?OTNEZlMwZnBIMXdRSGZyOTR5NWhwaGNXbGRPSFphZlBTZklOc09NSG1NMkta?=
 =?utf-8?B?dmZscjRoUFQ0YWlxMndvRHVRMlJrS0hxMXdmaE9BbHBFZTN0ZHJVVkUvd2lW?=
 =?utf-8?B?bi9VTnJpRWhxdVhOdWZKelZUMUlkSnF6aDZSQlFhY0dYQTlNcWlkcFBKRmpm?=
 =?utf-8?B?ZWpIUUJmdkhQQ0tPQ05reU01bFpxaHYzV0x6MVR3WmFPOWtYQ0RHTStEWDIy?=
 =?utf-8?B?ZXJ5b0FCUlJTQnExcXhhcUFCT0MxSXMxME1CQ3VnSXlFVEZpbU9waExERmRn?=
 =?utf-8?B?K1QxWnlQWGwrZVNiNmpuK3hZU0oranFzd1BCanZzMXcyWHpRWmJRMk9ISWR1?=
 =?utf-8?B?MGdIck8vVXV4K29mR3MyRXhBVk93SDlzL0tWcU1lb05ReXRRYkJRZHJWN1BH?=
 =?utf-8?B?VmZhSEF3U2NaYlhEUHNCT3FQNzVON3h0U1hJazVtck1xNmpobVFVWFZtM0Fl?=
 =?utf-8?B?eDBuWEYzbEt2aXAvWGdZNjkveEc1N3o3OThJbWVCNW8yNjcrV2hKUERCcU5n?=
 =?utf-8?B?QmlTWUpBY3FqV1ByaFYxaUhaWFFDY1ZyUWhURVhUSjloQ3paL21ZMExzUHI0?=
 =?utf-8?B?UTl2Qk4rYnUzblZWRjNQc1htZWN1bGpaNThpZkJhSFZCRWhQZTZtSzZrZVdN?=
 =?utf-8?B?dGFuZU9TaHlwWHdNaHVML3ZDU2NrMGN1Z0RTSlpRWEo4Sk5IOWRldXIwUkE5?=
 =?utf-8?B?Kzk2RE5zZm9OR0NZYkN2NzhHSUM3a3R6VlF1eW9JQjUwK3BKVlNmVHZaZHFO?=
 =?utf-8?B?YTk2R0ZIY3haNGdaQWMreU1pdEtpRmdxblJjUEF3Tyt0U3NSdElxRE1mL05m?=
 =?utf-8?B?RWY3S2JGTnMyajVvWHE2cll1N0xNTHdnUnAyWmhRVHE4NEVLRDY1bUpyM0k1?=
 =?utf-8?B?M0QxVSt4cEFFUjdGSElDc3crMmF4MVdmZjl6MU9qSFNseEZybkhOMlhTR1Zl?=
 =?utf-8?B?bm0yWDdnOGdKS2g0UVRDdVZSSlJ6bk5TaXNzSDBzV3JJK0FvUVFxUUI5ZWxo?=
 =?utf-8?B?VGZwUGV6MngrSE1VdDlNcjlpWFFIaHoyZG1sNzd3R2IwOElET29Fd285NXFx?=
 =?utf-8?B?NGYxNHoycTFDdlVacVBteHg0MGpwU2k4Z0tyd0duSWZOcjhmS1YyNEcxU05U?=
 =?utf-8?B?K1BpT244TXZydXQ0Q1FDR2FxZzZlelpOSWZQT3pSNHQ0WXVFRTRodzlwcTJV?=
 =?utf-8?B?RW90dWNDUXRnVjg5TzJ4bVNVR21qZWJHekFVQ3V3NGdDVStoM3AvNTg0K2JF?=
 =?utf-8?B?VElxYzcwd05IVVlOTW1VL1lwWjlQSStNRVBTVnhBaCtDTm1tZFp3S1RJeVFs?=
 =?utf-8?B?R3Z6M3NpTnVUQ2tKZVU0bVVuTm9uVkNjUG1ZNUJNYVFNOEt1TU5YQ000TVpr?=
 =?utf-8?B?VzAzd2dBNHJrelJvTGtieE0wNWhwbWtvUDM2cHFodDI0TjNjZ3lrd0ljTlpE?=
 =?utf-8?B?VmRDUmlVSC96UlN5bm5IdmRubGVwd0xYRVE1bVRva3pzejZGcGJmS0M2NlJN?=
 =?utf-8?B?SnBPcnJYNHZIeEtDTHBGc3RPWlRKM2xrRUVTcHkxcDNESXpYMlEyWHNYaW9j?=
 =?utf-8?B?Q0pQR0FOa3pEV1lNSHE4aEVHbTJDVjh0WHhNbUU1TGVRUmdhVDJTNFhzeEFQ?=
 =?utf-8?B?OTl4VzJ5U2YwZUxJYityK0NGUXdtOWZVWCsvTHJJSUQvOVFrVzBrYXZyUjJq?=
 =?utf-8?B?UDRNeDF4S0RINTVMRy83dVJuaEF4Sm5RREtBRGRnL2Y3ZXlSZnFLN3cyZjdH?=
 =?utf-8?B?anhyM1o0VUt4eElKd0dMY1M5aGxTdEk5K21rc044L05TOGdlVXY5dnJtNXNr?=
 =?utf-8?Q?wlf9nP+t5z1eB3B+zIpgip8r0Afh1qgT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UHRkNVIvWW5HOVhiSDhCNldaMnpjYVVVR2NId2lOZ2FRRHdUeDd1U0prRVc0?=
 =?utf-8?B?UW84dHVxeFdJWEx4eTdyMTVWZmxpa2YzNjMrUzgrRmRWUDZxUmUreEVvTWNQ?=
 =?utf-8?B?WVJtQkNrY24yWXFralFHSjErNzEzV0hFdCsrL3ZiUkozbVpMWDB6QXZSNzZM?=
 =?utf-8?B?VmQ0b1REOGlRNU1nTWVzZ2NYemh5eUpBL3czbFZmcTBoa2VPcW9wbG9pNnE2?=
 =?utf-8?B?WFgwUThVZW1PRlNZbXp6ZDBhSmNKZ3pYSG5TbVI2S01QeTZBRW5wdS80N013?=
 =?utf-8?B?dzltaDVhaFhIdnQ5L1lVZkxiek4zNFMyb0R3VFdwQS9kRUVoR0JXZ3V5ZjZE?=
 =?utf-8?B?RVJwaTlIQUJPZUU1YWE1YmpFdXFYSWJSZXVJb1BpRU5INkptTEduVjJkdW5v?=
 =?utf-8?B?Q3dCME9lcGdoUEFYMmx3ZFB2WmFLZWhQVnY0alliOXVhUFJjVVhGVnJXekk3?=
 =?utf-8?B?WHhpaDdCV294RFpibUhUdElxL0xpc3VkMXlzd1dxNThMbzcrQmpIQWI3bWRo?=
 =?utf-8?B?QjN2YjRYWmxyT1JQa3EzUGMyWXlNMFd2NURzMllKaThTSEdvd0d0alVRSlZC?=
 =?utf-8?B?eDZ0SXU0aDRyMW9JOWFBTFMvS0VVUkFzK0kranJxVG5RMWVJR2huS1dFZW9S?=
 =?utf-8?B?eWFvSGQ2aS9IZmpNWEFEa2YrVkwrUlhsT1V1czU0NFJhYWlDWHVXS0tyalFM?=
 =?utf-8?B?bmJ0UUNjeEdZRVVHN01pWWZpcVJ0K2R2eDNCa1hZcHV0RnNzU0RmaFpQcWk1?=
 =?utf-8?B?TWEvOE9yRm5yUEovUUtiM3czZzJQTWVyYlRPMUdMR3UvL0IxcXZGdGVaUXla?=
 =?utf-8?B?MUkybFFpMDBmNGtWOVhPdHByN3REZ0FUTWhuVGJPOVYvODRjcndrM3RONkxl?=
 =?utf-8?B?Q01GOVhOMTFhYmpQd2xQSFREeS9WdlB1KzErazljQmNveTcwUWxLYjRROEMy?=
 =?utf-8?B?M1hmcExieEtlWEdIbTkvejdxV0lVaWQxb0FwQ05reTlGc0V4NlFsYTJUM3h0?=
 =?utf-8?B?elJJQTNTa3pzUWx1TFpCUk1pNjVSMTRwUFN0ZklSTlJ4S2JnZm5rRzZvbnV5?=
 =?utf-8?B?Y3JGdkVXblViaXRNMVc5Nk9nZldBSEI1SWc1Vm5FdU9LSGJhWkp2bEF5WExC?=
 =?utf-8?B?N1RYQTN1YWNPWC9ZcWdUcm1HTnJLRXVobXNZZGtKekNIQ2RZUVJhWjFBemtI?=
 =?utf-8?B?aFhXcWpVa0xpTjhha2JOdjBLYkpZZVdhRS9tNUhXaEd5RVY2d3lLYnVDUThL?=
 =?utf-8?B?T3VySHlLdVV6bHNNTWE2SWdmYWovOFhISjF0d2VocEwxeFc3THpDRHpSMVRQ?=
 =?utf-8?B?S00yM3ptOVNQYnN0Mkg4T0tZaTJwNS96MUlwblVDaFlaT01DY1dhS1RLQ1Nq?=
 =?utf-8?B?R1dqR09MQ21pSEIwTmVkZ1FqQlI3VGc5QVBrWE93UDFwdnpUOUZWWXVRMkNO?=
 =?utf-8?B?M1AwOEUyU1hFbzZOMThucCtqaEFYMklWY05XUjZCSWVSVWc0TzcxMEx0ZTlB?=
 =?utf-8?B?a3RUNFFnazljWTZqTEpkamV5bHJ5SUdjQVNVNnJhQ2szQk5lUVYzL0ZCWkhY?=
 =?utf-8?B?b096RGtzRnRYQmV2em16WUE1ZEUwN0hOdXljMlI0UzNBSU8xSVc2YUpZandP?=
 =?utf-8?B?V29Hb21VWGZGVENCU0FJb0lmNGYzek41d3M0MG5JV0d2RmJ1ZTlKbnJrS0dj?=
 =?utf-8?B?N1BXWmN0WlpadjZnZURmR2lNY2N1MnpjcmNGMHo5Zm9rdnJBYWJuVnlLM1BY?=
 =?utf-8?B?c0JSaWlsNENtbHFXeXJmalV2RDdNOGR6alVJOW1BQzFxNy9tZ0JTRW9PbXNL?=
 =?utf-8?B?UzNpdXlYWEFhbk00NUw0a2d5WExtWEdsNjdtclJuRk85cTNMMFFvaUl4Z1Bs?=
 =?utf-8?B?THJQRXgzaWJ5Ym1jQnBEd2J3S3EwT1RFVFFnYzE0dXZrMlQzczY5cW9WUGFJ?=
 =?utf-8?B?VFNwMjNjTXBsbkdSc3hFU0FkU2p2azJwNTJiWGp1ZVExVUVXTW4yUkdhR3JU?=
 =?utf-8?B?a1pHMVZ6RDhhczk0M0hhdCsyS2k0MWpPZStCdmpKOG9iLzAzK1ZuWmcvbkFx?=
 =?utf-8?B?VVR3YnVIclFHcGY2WG9ueGQ1YkdvOFNqdzdVTmJtVkROeXVGV25laVZFZVJp?=
 =?utf-8?Q?hWF0iwLmqb33Ch6f6uw1PYTMF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b06150-5691-4bbd-011d-08ddcb4b6887
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2025 07:18:09.2562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 18ioqFjgGdLf8zZjuhiUUFnyP460KPYTGlZbSyTKGi9o4y9n0pNr8JpwS9vGindhhXp0EuLIqgZ/LtiqtbALsMMXAUN9sEwnQBV34afeoHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF46A647402

DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjMgMS8yXSBkdC1iaW5kaW5nczogaW50ZXJydXB0LWNv
bnRyb2xsZXI6IGFzcGVlZDogQWRkIHBhcmVudA0KPiBub2RlIGNvbXBhdGlibGVzIGFuZCByZWZp
bmUgZG9jdW1lbnRhdGlvbg0KPiANCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvMl0gZHQt
YmluZGluZ3M6IGludGVycnVwdC1jb250cm9sbGVyOiBhc3BlZWQ6DQo+ID4gQWRkIHBhcmVudCBu
b2RlIGNvbXBhdGlibGVzIGFuZCByZWZpbmUgZG9jdW1lbnRhdGlvbg0KPiA+DQo+ID4gT24gMjIv
MDcvMjAyNSAxMTo1MSwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+ID4gVGhlIEFTVDI3MDAgU29DIGNv
bnRhaW5zIHR3byBpbmRlcGVuZGVudCB0b3AtbGV2ZWwgaW50ZXJydXB0DQo+ID4gPiBjb250cm9s
bGVycw0KPiA+ID4gKElOVEMwIGFuZCBJTlRDMSksIGVhY2ggcmVzcG9uc2libGUgZm9yIGhhbmRs
aW5nIGRpZmZlcmVudA0KPiA+ID4gcGVyaXBoZXJhbCBncm91cHMgYW5kIG9jY3VweWluZyBzZXBh
cmF0ZSByZWdpc3RlciBzcGFjZXMuIEFib3ZlDQo+ID4gPiB0aGVtLCBQU1AoQ0EzNSkgR0lDIGNv
bnRyb2xsZXIgYWN0cyBhcyB0aGUgcm9vdCBpbnRlcnJ1cHQNCj4gPiA+IGFnZ3JlZ2F0b3IuIEFj
Y3VyYXRlbHkgZGVzY3JpYmluZyB0aGlzIGhpZXJhcmNoaWNhbCBoYXJkd2FyZQ0KPiA+ID4gc3Ry
dWN0dXJlIGluIHRoZSBkZXZpY2UgdHJlZSByZXF1aXJlcyBkaXN0aW5jdCBjb21wYXRpYmxlIHN0
cmluZ3MgZm9yIHRoZSBwYXJlbnQNCj4gbm9kZXMgb2YgSU5UQzAgYW5kIElOVEMxLg0KPiA+ID4N
Cj4gPiA+IC0gQWRkcyAnYXNwZWVkLGFzdDI3MDAtaW50YzAnIGFuZCAnYXNwZWVkLGFzdDI3MDAt
aW50YzEnIGNvbXBhdGlibGUNCj4gPiA+IHN0cmluZ3MgZm9yIHBhcmVudCBpbnRlcnJ1cHQgY29u
dHJvbGxlciBub2Rlcy4gKGluIGFkZGl0aW9uIHRvIHRoZQ0KPiA+ID4gZXhpc3RpbmcgJ2FzcGVl
ZCxhc3QyNzAwLWludGMtaWMnIGZvciBjaGlsZCBub2RlcykNCj4gPg0KPiA+IEkgZG9uJ3QgdW5k
ZXJzdGFuZCBob3cgdGhpcyBzb2x2ZXMgeW91ciBwcm9ibGVtIGF0IGFsbC4gTG9vayBhdCBvbGQN
Cj4gPiBkaWFncmFtIC0gaXMgaXQgY29ycmVjdD8gSWYgbm90LCB3aGF0IG1ha2VzIHlvdSB0aGlu
ayB0aGF0IG5ldyBkaWFncmFtIGlzDQo+IGNvcnJlY3Q/DQo+ID4NCj4gPiBXaGF0IGlzIHRoZSBt
ZWFuaW5nIG9mIGV4aXN0aW5nIGJpbmRpbmcgYW5kIGV4aXN0aW5nIGludGMtaWMgY29tcGF0aWJs
ZT8NCj4gPg0KPiBUaGUgbmV3IHBhcmVudCBub2RlcyAoYXNwZWVkLGFzdDI3MDAtaW50YzAvaW50
YzEpIG1ha2UgdGhlIGRldmljZSB0cmVlIGxheW91dA0KPiBtYXRjaCB0aGUgYWN0dWFsIGhhcmR3
YXJlIHNlcGFyYXRpb24gc2hvd24gaW4gdGhlIFNvQyBkYXRhc2hlZXQuDQo+IFRoaXMgYWxsb3dz
IHVzIHRvIHJlZ2lzdGVyIHRoZSBmdWxsIHJlc291cmNlIHJlZ2lvbiwgYWxsb2NhdGUgcGxhdGZv
cm0gcmVzb3VyY2VzDQo+IHByb3Blcmx5LCBhbmQgY2xlYW5seSBleHRlbmQvZGVidWcgaW4gdGhl
IGZ1dHVyZS4NCj4gDQo+IFRoZSBwcmV2aW91cyAiYXNwZWVkLGFzdDI3MDAtaW50Yy1pYyIgY29t
cGF0aWJsZSBvbmx5IGRlc2NyaWJlcyB0aGUgaW50ZXJydXB0DQo+IGNvbnRyb2xsZXIgaW5zdGFu
Y2UsIG5vdCB0aGUgZnVsbCByZWdpc3RlciBibG9jay4gSW4gcHJhY3RpY2UsIHdpdGggb25seSBh
IHNpbmdsZSBjaGlsZA0KPiBub2RlLCB0aGVyZSBpcyBubyB3YXkgdG86DQo+IG1hcCBhbmQgbWFu
YWdlIHRoZSBlbnRpcmUgYWRkcmVzcyBzcGFjZSBmb3IgZWFjaCBJTlRDIGJsb2NrICgweDEyMTAw
MDAwIGFuZA0KPiAweDE0YzE4MDAwKSwgb3IgY2xlYW5seSBleHBvc2UgZGVidWcgZmVhdHVyZXMg
dGhhdCBtdXN0IGFjY2Vzcw0KPiByb3V0aW5nL3Byb3RlY3Rpb24gcmVnaXN0ZXJzIG91dHNpZGUg
dGhlIGludGMtaWMgcmFuZ2UuDQo+IA0KPiBUaGUgb2xkIGRpYWdyYW0gd2FzIGluY29tcGxldGUs
IHNpbmNlIGl0IGltcGxpZWQgdGhhdCB0aGUgaW50ZXJydXB0IGNvbnRyb2xsZXINCj4gYmxvY2sg
aGFkIG9ubHkgdGhlIGludGMtaWMgaW5zdGFuY2UsIGJ1dCBpbiBoYXJkd2FyZSBlYWNoIElOVEMg
cmVnaW9uIGNvbnRhaW5zDQo+IG11bHRpcGxlIGZ1bmN0aW9ucyBhbmQgcmVnaXN0ZXIgcmFuZ2Vz
Lg0KPiANCj4gVGhpcyBiaW5kaW5nIGNoYW5nZSBpcyBtYWlubHkgZm9yIGNsYXJpdHkgYW5kIGNv
cnJlY3RuZXNzLCBhbGlnbmluZyBEVCBhbmQgZHJpdmVyDQo+IHdpdGggdGhlIHJlYWwgU29DIHJl
Z2lzdGVyIG1hcCBhbmQgZnV0dXJlLXByb29maW5nIGZvciBkZWJ1Zy9tYWludGVuYW5jZS4NCj4g
Pg0KPiA+ID4gLSBDbGFyaWZpZXMgdGhlIHJlbGF0aW9uc2hpcCBhbmQgZnVuY3Rpb24gb2YgSU5U
QzAgcGFyZW50DQo+ID4gPiAgKGludGMwXzB+eDogY2hpbGQpLCBJTlRDMSBwYXJlbnQgKGludGMx
XzB+eDogY2hpbGQpLCBhbmQgdGhlIEdJQw0KPiA+ID4gaW4gdGhlIGRvY3VtZW50YXRpb24uDQo+
ID4gPiAtIFVwZGF0ZXMgYmxvY2sgZGlhZ3JhbXMgYW5kIGRldmljZSB0cmVlIGV4YW1wbGVzIHRv
IGlsbHVzdHJhdGUgIHRoZQ0KPiA+ID4gaGllcmFyY2h5IGFuZCBjb21wYXRpYmxlIHVzYWdlLg0K
PiA+ID4gLSBSZWZpbmVzIGRvY3VtZW50YXRpb24gYW5kIGV4YW1wbGUgZm9ybWF0dGluZy4NCj4g
PiA+DQo+ID4gPiBUaGlzIGNoYW5nZSBhbGxvd3MgdGhlIGRldmljZSB0cmVlIGFuZCBkcml2ZXIg
dG8gZGlzdGluZ3Vpc2ggYmV0d2Vlbg0KPiA+ID4gcGFyZW50ICh0b3AtbGV2ZWwpIGFuZCBjaGls
ZCAoZ3JvdXApIGludGVycnVwdCBjb250cm9sbGVyIG5vZGVzLA0KPiA+ID4gZW5hYmxpbmcgbW9y
ZSBwcmVjaXNlIGRyaXZlciBtYXRjaGluZyBTT0MgcmVnaXN0ZXIgc3BhY2UgYWxsb2NhdGlvbi4N
Cj4gPg0KPiA+IEFuZCBob3cgaXQgd2FzIG5vdCBwb3NzaWJsZSBiZWZvcmU/IFRoYXQncyBwb29y
IGFyZ3VtZW50IGVzcGVjaWFsbHkNCj4gPiB0aGF0IERUIGRvZXMgbm90IGhhdmUgdG8gZXZlciBk
aXN0aW5ndWlzaCB0aGF0Lg0KPiA+DQoNCkhpIEtyenlzenRvZiwNCg0KSSB3YW50ZWQgdG8gZm9s
bG93IHVwIG9uIG15IHByZXZpb3VzIGV4cGxhbmF0aW9uIGFib3V0IHNlcGFyYXRpbmcgcGFyZW50
IGFuZCBjaGlsZCBub2RlcyBmb3IgQVNUMjcwMCBJTlRDIGluIHRoZSBkZXZpY2UgdHJlZS4NClRo
ZXJlIGlzIG90aGVyIFNvQ3MsIHN1Y2ggYXMgTWFydmVsbOKAmXMgQ1AxMTAgSUNVLCBhbHNvIHVz
ZSBhIHNpbWlsYXIgYXBwcm9hY2ggdG8gc2VwYXJhdGUgcGFyZW50IGNvbnRyb2xsZXIgYW5kIGZ1
bmN0aW9uYWwgY2hpbGQgbm9kZXMgaW4gdGhlIGRldmljZSB0cmVlLCBhcyBzaG93biBoZXJlOg0K
aHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvbWFzdGVyL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9tYXJ2ZWxsJTJDY3Ax
MTAtaWN1LnlhbWwjTDc0LUw5OA0KRG8geW91IG5lZWQgbWUgdG8gcHJvdmlkZSBmdXJ0aGVyIGRl
dGFpbHMgb3IgYWRkaXRpb25hbCBhYm91dCBvdXIgU09DIGRlc2lnbiBpbmZvcm1hdGlvbj8NCk9y
IGlzIHRoZXJlIGFueXRoaW5nIHNwZWNpZmljIHlvdeKAmWQgbGlrZSBjbGFyaWZpZWQgcmVnYXJk
aW5nIHRoZSBtb3RpdmF0aW9uIG9yIHRoZSBiaW5kaW5nIHN0cnVjdHVyZT8NCg0KVGhhbmtzIGZv
ciB5b3VyIGZlZWRiYWNrIGFuZCBndWlkYW5jZS4NCg0KQmVzdCByZWdhcmRzLA0KUnlhbg0KPiA+
DQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+IEtyenlzenRvZg0K

