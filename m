Return-Path: <linux-aspeed+bounces-1835-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6301C87FCA
	for <linux-aspeed@archiver.kernel.org>; Fri, 25 Jul 2025 10:42:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bpPZs3RYSz3bTf;
	Fri, 25 Jul 2025 20:42:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753440149;
	cv=pass; b=ZMpo6D7NAY8YiFHaHfwC+icDWwzwoKTyB3Qb13mmnqTjvaviHa+Muy9t0S5tal48j1Pt/IUVrGNwC8ZTFcs2X/GNBW+R9rQ0HrEUtHcpxkBCHWXdSZ9Ta8IxzA46zQhKO/BvQJnReJ/zxIFokuQPYotmKZmBO3U4462d5DvxW/lB/79E2fS9Ui4v2HX/ORvMQ7BCXh9j8iBw2eYoxJ+4dQRhB5ojb5Jw0Y95T58z5MVbEm7QCf23QZ371hKE+20rF9kedsYuPKF9Q8wMgiB88bq8m+fkw6CbNx7d2hZLAfg2PtIuMFSbpMrXrBA1a+oNpv7ovcE+zYTmrQNEBG+V6A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753440149; c=relaxed/relaxed;
	bh=t9H7qMPUhOR7usgf5ObGW69JJEkZAEtyBuBcCM6bXi0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Oz/jK0nDjngqbVIIqITyr3Db1O4LQ5iYjmwXlqO2RrmIWUev/XKAicjgrfKVMW8jx52G1AL4mhAUgW2tOPOmIBQ96M8o/tTzDyW55K6lH1N9Fu1pCGEopFaYPBJOSnhOGy7xH3xT8jdRkpjPVbk9GKq4hTHoHsYeTelmM0JhytlltWzMLFlNB417mtkq/BVcFwTiosq6LcaSKG9R0ZQQ57Zv6TzFjpQrqPyjwVy/Ffrsb5R+E4vy2mpPjZpFNDHx4BapnyeDDaB51EcoJW9oiAoLbbZ4QQnj86UnhMds7QAI2CTZdScU39uaX1XlWrCoop1X1mwqv83jPVvK1w7Yng==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=gVuxAjj9; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::7; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=gVuxAjj9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::7; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bpPZp6R1Pz30Qk
	for <linux-aspeed@lists.ozlabs.org>; Fri, 25 Jul 2025 20:42:26 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FwoUZOkuFpikeY4mwesQSIp+GvL6XIXSN2cgBwd50/5YTvWKDDtCoNlUimO2qwV8DNPhUqKNqes2qSDYpmMnzQPwx5eP9y1KPnk2a9ZXScWxa+Ueolx8wSGeS4ppiUcpNxgnhANR81LuYpx7AxU01lrDMyMiFLFkdRz1YQ9QcIaNwI0A9aw+7Fv0BPAYKFkY5TH59MiG/HsQxkJq8bxf+LzaCcogrpx1WBzsIqEB1pMAMEuskY35J8Cyi2yY+PqgYlxVDEGUgm0qzyk/F1+n7CStaoz5R+06Itep4NfnDCol/Zk1xzb9F6Xp4lFsmNPMiNqIXFB84i5NhQRQnWEnng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9H7qMPUhOR7usgf5ObGW69JJEkZAEtyBuBcCM6bXi0=;
 b=b2N0WuZhbhvc1ZcND0LL8zi2GOCN5o0992Mj1MP76UDch+bzpteWynPjlcFMFzhhSj+0ng7nLkrEU6/pJ3RRUCK5b+M0lIKbGVfeAnB0kZUMDqUjWT/UoPbJpgB6jvz2y+Z/EL4TdXyjl0jynvB731rsHvDxUMAJrWlOy+eW6PnOpds+n5bv7hZ7hWi7uCrw0VnYmJ3HmZQAN1UpbNMIk+R4p7o8ohGwE3f5LKNzUhsWfrZt7jRRIlXNQ86QT+v4176E/FPvIEA3Qf6NqW6UnOEnPxPDGhexB6fXIWf153cB/5Pss4XaezpylyF8u1DcnFHMVc0BkL+LX5JKGHBVdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9H7qMPUhOR7usgf5ObGW69JJEkZAEtyBuBcCM6bXi0=;
 b=gVuxAjj9e3kpalsM+XxfZb2ns+Yps0yyCampZfwBcwXAzKnf20LKry6LkmNI5uvyJxB5RUwPHmgamHwoDxlmty6Rhjmb2nqL15bt38tpZt3b6J6c77rUKlFxvgD7NH+gjAsdGYH64Japazlrr914NPkLOfSkG3p3WAy4ZKnBjI6x+KXMkzaxRR+B0nalRi47RyUsu+MLmlRDew06rqUrDG7zqEorexVNXSenWn3cfQebNUzCbh3s/eKGgv51AvvM/gPFcIwPx4oLXu1ba5/FOBtF7qGqbtmMCWDD2/cb3rZ41I66I/7JmAWGog0ddjeUyeOaCFgylCxSBI5oVIvlug==
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com (2603:1096:400:45f::6)
 by SG2PR06MB5106.apcprd06.prod.outlook.com (2603:1096:4:1c9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 10:24:57 +0000
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b]) by TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b%5]) with mapi id 15.20.8943.029; Fri, 25 Jul 2025
 10:24:57 +0000
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: Jassi Brar <jassisinghbrar@gmail.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v6 2/2] mailbox: aspeed: add mailbox driver for AST27XX
 series SoC
Thread-Topic: [PATCH v6 2/2] mailbox: aspeed: add mailbox driver for AST27XX
 series SoC
Thread-Index: AQHb+a+f17UQvucgWEGM4OCtCylrnrRCqSVA
Date: Fri, 25 Jul 2025 10:24:57 +0000
Message-ID:
 <TYZPR06MB656867AD5FF1FCA04E770BBCF159A@TYZPR06MB6568.apcprd06.prod.outlook.com>
References: <20250702011956.47479-1-jammy_huang@aspeedtech.com>
 <20250702011956.47479-3-jammy_huang@aspeedtech.com>
 <CABb+yY1kyZdMqcMRUEdqCYByQE=DurfnejtvuQsMf9wfLiij2g@mail.gmail.com>
In-Reply-To:
 <CABb+yY1kyZdMqcMRUEdqCYByQE=DurfnejtvuQsMf9wfLiij2g@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6568:EE_|SG2PR06MB5106:EE_
x-ms-office365-filtering-correlation-id: 388e0ca7-88c8-45b0-ffdf-08ddcb658141
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UEplSWYwcnRPbXNGU0NWVGRNQjlMeGtOb1dQVWJKSWZPSU9CTGFNWkVHbS9H?=
 =?utf-8?B?T3lpR2hkRVdEL2IyVHdQcWUxODVMa2ZFMU9VQmhSeHQxN1NjM0VzNDJpSU5s?=
 =?utf-8?B?V2wrREw0Q2FkRkRoY1FGRVJZNUpoYWdUbUgzeDd1UFJFS2tXaUhMTE1hM0xY?=
 =?utf-8?B?d2hlbTg2VCtxbS9hTnczVTh6U2tBWDVZTHRkRHRXTXZ5eWlRcjZ4MlU2blBj?=
 =?utf-8?B?TWlHSWtYdTA5dVd0WWRDWmVvMEVYZWt0MXZ5TXMvTXhCa21YRjRRQm1HUy80?=
 =?utf-8?B?TDJoMGpIQ29Ga1ZkMnhsRmNQMVc0SUtmS2NrbDRUZk9HNFhDRG5jTjQyb01s?=
 =?utf-8?B?TmkyVzZUeGZVczFEb0IzaHlJZy9pQTNqUUdDMG9hTEVqa3NqbEhZRnczekFs?=
 =?utf-8?B?d25sYzc3dU5KejZYbjJkSllwRWJlaUpGVEdCdFZLcFdDUkZ5bmlKZkNQdGVC?=
 =?utf-8?B?V2kvUFJjNElibEJBZ3Z2ZHNuRmwrUlFaMGREbnFQU2NJeGhlMk5TR0hPWE9o?=
 =?utf-8?B?V1VRRVRyMTJOOExvZyt2QWQ2OTY0MWl6NFNnWFhpeHVyV1NKNWI3N3VnK1Vq?=
 =?utf-8?B?Nk15ZE11citibkpHMG9ISkpPVVlYVFltQnI2NmhNT0RFZGhHaVVlR29EbC95?=
 =?utf-8?B?UnI5ZnoxVCtwWXlXZzFUa2xEMlF2TnlpemdiMW0zTjVRL2lHTlU4OUpoeDMr?=
 =?utf-8?B?cEZrZ1ZuM0JlcFcvb05pRzJNbGRxaGRWVmU3ckx5VTVqSDhLOEsrbTVxc3Ev?=
 =?utf-8?B?eE55amRFN3ZseGttbDBoVGZoL1I0amlZWW1Ib012RXR4aG0zRTZsUmNtTTNi?=
 =?utf-8?B?MS9kanpGUUhGcXhqVFd1cTdpS0RabGFROUViUWYva2ZWQXhkTWdCWi9xWWxP?=
 =?utf-8?B?dGoweUl5M1o4dlE2Qm1RdUIxcVNyT1pML29LRXpiVmZ5SUZTbkFDY3JLTUpQ?=
 =?utf-8?B?YmJrOXphZ1NuWWNYN2YxWTJ6cVBkUjlMRkh6K3ZNbGxJMmhhNkRPR0lLUi85?=
 =?utf-8?B?YWpUWlFYb29PUFVJQ2RraWN5ZWhHRWJQc0JFM2JCbUUyT3p4VFRtck4rWFNE?=
 =?utf-8?B?MXc1TDFndnd2aXVIUFp0dW0rNnR2NHNIV01ESDhIaThLb2k1NERsQ0lzTXor?=
 =?utf-8?B?MmxLWTBkMlZiV2M1OEZCcmk2ektmOTZNUTkrVzdRS1prSGtBNmJKNHJrOHZS?=
 =?utf-8?B?eUdtbDNLaXVwdjg3eTk1VnBvQUlOZ21iRGpoSUJiOU1CSERsRlBKY1FEQkxm?=
 =?utf-8?B?SVFDamIxZ3ZsVUo0bjY2Vk10c0JjNnU0bFl3c2EvQmlJQW8rR1V3N3NnMlVY?=
 =?utf-8?B?WGVpeFVVWjkxakVhMnlrWm9iUUY1anZicmtiLzA0M1ZLYmV0dFl1Y0NlaHQ3?=
 =?utf-8?B?Q0VVNXV5aHFONHZMdWx4aFFQYktVOW5odHdPZFB1OWt5RFBGa3U3V295MWpq?=
 =?utf-8?B?N1AySmhWY295Uit2K2ZCU3lKZFpYZk5ENTlRcjVOS0VTQkd0cWNSeDdzVXZz?=
 =?utf-8?B?d0xRN1J0bEQ4Vnh3NGlmQjkrSGc1aTNCcGFubUl1eS8raml5K291eGJRZ3ZY?=
 =?utf-8?B?Ly9jckludlVhOVJjRGRYMXdRQllhVnpRb0xuTmY5aThKQzRieWtuYmh5ZEhv?=
 =?utf-8?B?RS9IUkNjNXI2S1JoUTNIeDhOQXFlTmlmVmQ0Z1FWemNrWlJnYnZ3djlBWmpN?=
 =?utf-8?B?V013UnJpV0ZCWm1IbHlJR0dCc0xrQW5QOUVSNEo5VnQrWEVydjhJekZhSXFu?=
 =?utf-8?B?NFB1cVVGVTdhSUdEMjgvT1FCQndYUzN4OE9SYS83c0V6bDlTVkJXS3BZRElH?=
 =?utf-8?B?b2ZUMkxzdlJNSnBKN0hmM0ZqSlptdDNyandGWEpDUVFGaTAzd2FhRE9iTXFK?=
 =?utf-8?B?M3NUZm9LbUx3dXZxN3diejhQNlhCR0NrVE15WHNiTVFuLzRMNmkzOStGaEl1?=
 =?utf-8?B?TXo1WjZCRWp0dHpkdzF2UXJPNC8vUXQyWWpqRE9aYUt5NDdGQTJVTlQ2Z0k4?=
 =?utf-8?B?bEc2cXhFL0ZBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6568.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TDdRRjE2UWRYekJsN2NBa0gwaWZFUWhqQ29abU40SWJwTDJNeEM2QzE3bE9m?=
 =?utf-8?B?TW1DL2dNNHFSOUNLUUpybmVTUEdVeG0zMmpUOXNvUENlTGk3ekp3a2crNll2?=
 =?utf-8?B?Vm4rQzJIZ0gzL0xrb0RST1hOZzNBY1luTmNjTGpVcXY1cm5zRy9uYkNRUmRv?=
 =?utf-8?B?TEZ4YXlSSXRkeGVRQ3hYWE1NRGhJUlRCRFRsSGttcmZ0dFpsRUZSVVl4Z05o?=
 =?utf-8?B?UzNUTW9TLzd6T1VVUEdyNmJ2ZDd2ZUlHcWNUUU14RW9aQ2V4S01qMHB2SldR?=
 =?utf-8?B?eVJwSHZXbTVnSFZibzBHZGQwM3N2RVQvL09SdXVWayttRVNQTWNld1ZIeUZs?=
 =?utf-8?B?L2hpanJQSkFrUU5aSVN5UGsvNDJXUE8rY0hIUlAwR2tPWWlwemd5MVZKWjBj?=
 =?utf-8?B?WDd6YWpGa2VMdEFVeW9XQm9MT29JenJ4S2prb1VaS0hyNkdqT0hWKzdhNmVX?=
 =?utf-8?B?MzNkUTMwOWY1S0NJc0dEbmVveG5Hb2x5WSt5Z0dhNUZzUDhHUXhKMGZoODVv?=
 =?utf-8?B?TURrU0dLNytoY3VVRzRXKzZFYmo4VmErL3J5MGFCem04RkVFZkFqczZES3lH?=
 =?utf-8?B?Y3Z0aXRMMlkyVnlBR3ZZbnZiL3hiZG1kN2ZtaUZPYkFlQy9WbnZjTVlpUHJB?=
 =?utf-8?B?dXRVdEtRTmhRTjN5U1lCcVBIM1F1NnpKQUVHYS92YWtkRHhUYkRvd25vL1B0?=
 =?utf-8?B?eGhmYlRWL29aSWxOeWVJUEMwNENsUzRtMDZEdTZNWXRsMDB1YW1vcHhaZm5Y?=
 =?utf-8?B?aksvSjRHRWdNSTU0cFk0dUUrNnVKWkNTZlRpaEFCS3dkNzFEalFzQmhPQXEr?=
 =?utf-8?B?RmN1UGtLRDN3a0svU0kxNzJQRnNhbHZITXNudm1VTFRhWHZqb0FZUWtQNlI3?=
 =?utf-8?B?UDBRaVVMbmRWWFpJYUpDbDY5NDRXY2h1TitPdHEzUXE5U2dYTklDd09DcnBs?=
 =?utf-8?B?OFhLM0h2cnJVNi9Ya2hmL01DUlArVWtvSkR4Q3UrZXcwbFk1d1c2Y2laSWtB?=
 =?utf-8?B?aGt2Z1ljRlJrWHQvblFXZXhpaFVMYnE5cnZlTHFBN2h2RVpWeGZrSjJBcVIv?=
 =?utf-8?B?NDk3d3lQNFRDc0RuNlREWUlacElmUTdIQ3pwZGpQckcxSWJKMWhkQ1YvaC9h?=
 =?utf-8?B?RmpFc3RHMXROS3g0UUw5RE9qUmRzUEI3aEZmb1hha0VGaVNTTi9JM1NoaWdV?=
 =?utf-8?B?YmU2bGtPSlNnUnFLRlEzNW5oU3hzRzZlNGxrSVVxN0tKSlNtS0NobWxNWG5l?=
 =?utf-8?B?N2RsSlNjZWpudFdmUHhhMUl3ekdyalloMXlBWnlMK09xMVhuTEJDdjViaGt5?=
 =?utf-8?B?SDBpRzJFU05XQm9PYXZlSkI0Y2ZTL3U1VVd1NUJkQ0RMZ2lHMTAvbG1OZEIv?=
 =?utf-8?B?d3Z1YUt0WnU1cjFoODVOMkl1R3JLNGdZd3JsWDRVVGJ3dkhjSGZiVHVyUXNh?=
 =?utf-8?B?ODRCZGh2b2g3L1BUNzdtK1dONjh4ZkNsRnNjTUdHbjloN2h6bzIrQmV1bE9j?=
 =?utf-8?B?SWE5QW4wb2FJTmVnNGtaU0JKSEtpbVh1SUxCRUY2eUEzY0pZWHRoSFZsU3VM?=
 =?utf-8?B?bm9uMUozMzRJZ0tiNHl2TnoxVE84RFBLK0hOcHJvTG8rRy9rYWo5Vzd1aWpV?=
 =?utf-8?B?WkU5RmR3NWhiT3A0d005NFhZMzhMdFlpOFF4QStTU0ZlT3hWamVRakJUNFpx?=
 =?utf-8?B?UFRueVhuRDlKckR3YTg5cEVQMzJXYjBUYW9oS0JjbUhxWUgxR0JHWFQ5UHpJ?=
 =?utf-8?B?UDNsa1AxNE0yNkVLMVg4K1JGRWZLKzQ5UUhpR0FCSFFuR29pRFRDZ2VObDlN?=
 =?utf-8?B?bVlMVG52UWZLQzVxZ3IrdnpYcWpaYjMzWHgzdGNZaXpxMHVLUkM1aUhwdDZm?=
 =?utf-8?B?UWFQS3BvdFhDV0p5M2hocDZJUFhCT2pBZm9wUzVNWWFXTm5JRDVwYjUvMDZ2?=
 =?utf-8?B?NnI0QTNYeDE0dUI3dHJTamVzczVvMmxscGxHNks5L1hDLzBQMTNTd3EyZHBK?=
 =?utf-8?B?em9XMFZwblBVN21LcGZiek45YWg1SkdZVVR3R1RFZWpDVWk3bWQvblMwbzJC?=
 =?utf-8?B?bG9FcTF5a09zRy9lZHFXL2xSSndzZGd1S0JwVmxnaVpNWDljQnJvNUNUS0Fi?=
 =?utf-8?B?YkVEa0g5NnVWNTIzcm1EcDNiSm9CdlFaQTFCMTN6MWU0K3VBd1BTL3EwdDZw?=
 =?utf-8?B?S0E9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6568.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388e0ca7-88c8-45b0-ffdf-08ddcb658141
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2025 10:24:57.6651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sj5Hpym12kO1h/FnCmqrY2sgthC/JACm9N7O+/QE0ySLemqICPeyZD84UFPTRpMSdT/JA2W988edsM1zRATQD81Bzn1wpP8ML8pnNYzV9l0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5106

PiBPbiBUdWUsIEp1bCAxLCAyMDI1IGF0IDg6MTnigK9QTSBKYW1teSBIdWFuZw0KPiA8amFtbXlf
aHVhbmdAYXNwZWVkdGVjaC5jb20+IHdyb3RlOg0KPiANCj4gLi4uLi4NCj4gPiArICAgICAgICAg
ICAgICAgLyogUmVhZCB0aGUgbWVzc2FnZSBkYXRhICovDQo+ID4gKyAgICAgICAgICAgICAgIGZv
ciAoZGF0YV9yZWcgPSBtYi0+cnhfcmVncyArIElQQ1JfREFUQSArDQo+IG1iLT5tc2dfc2l6ZSAq
IG4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgd29yZF9kYXRhID0gY2hhbi0+Y29uX3ByaXYs
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgbnVtX3dvcmRzID0gKG1iLT5tc2dfc2l6ZSAvIHNp
emVvZih1MzIpKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICBudW1fd29yZHM7DQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgbnVtX3dvcmRzLS0sIGRhdGFfcmVnICs9IHNpemVvZih1MzIpLA0K
PiB3b3JkX2RhdGErKykNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAqd29yZF9kYXRhID0g
cmVhZGwoZGF0YV9yZWcpOw0KPiA+ICsNCj4gUGxlYXNlIGNsZWFuIHRoaXMgZm9yIGxvb3AuDQpP
Sywgd2lsbCBiZSB1cGRhdGVkIGluIGxhdGVyIHBhdGNoLg0KVGhhbmtzIGZvciBoZWxwLg0KDQo+
IA0KPiBUaGFua3MNCj4gLUphc3NpDQoNClJlZ2FyZHMuDQo=

