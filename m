Return-Path: <linux-aspeed+bounces-4075-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115E0CD4F4A
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 23:51:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKF2H5vdzz2yLB;
	Tue, 19 May 2026 09:51:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip="2a01:111:f403:c111::5"
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779094918;
	cv=fail; b=NXmejVgOVetoR3tj2yu5DxEHWehnc4x8XTeJBYlwd514pJkdmAkASbsy4luRUvYQhMciX/rri3cz7VUQAxLarNppNH6YdmjAxpV4pl3wfN91JmwuTd4loXf6dNObwRm/JZCCj3gnkscJ0I3Nkyk1nAY10UijJmT2sHa87hH7rrJiWUZ19gPluHppION40r8VPBsygnWVR84gAbZd1iUEP0dSrNxXQ3y28se220i50WP15nQKhwJQw9r9qsTlmJygN1WKL3dCbGHlrfRQYkpOG+MPjJ8cIeDCsmvDRFokc1+ad/KdyyNqDwzGa219eq5NPaVnrhnEvh8qv+8X6IfcLw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779094918; c=relaxed/relaxed;
	bh=GrZBPSxLkW0AkrfTdodxkO9szE1nwqGlCG9zccC7o70=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cLLQ9qGj0yF/McjAzUliilmcR/Gurx0D85ykaaO+hnZza5ufeAvMd9dE82vh2kaz/eK+NraVJixmbTxvZCXixrDVyylrW4cYMOPMIU1o+wSnUpNfS6Cyuh9Gf10bqiVn41dTxTLNeRtODYlFMu8eFhQkhvyzhn2Nia+L+IieNi6rebIaCaRyW20bsRty55kZj/q81687bHoq+usJJIy/qd1C2YC5sdVhDHqC/9vfHdmxeaZHEYr7jfHO5JGONrhm1LlqJCkWetfvNbqpczUD7A9rbovzRh+0eWSrq2lxWNkSpj73y516VHAxAFITTlisuB1+7+aD3vOAmlg3yN2esQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oAbo//ol; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c111::5; helo=dm1pr04cu001.outbound.protection.outlook.com; envelope-from=rex.fu@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oAbo//ol;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c111::5; helo=dm1pr04cu001.outbound.protection.outlook.com; envelope-from=rex.fu@amd.com; receiver=lists.ozlabs.org)
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJsHm72Tnz2xPb
	for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 19:01:56 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAab+el9csfqsdDvQKJF3tCd0b+cDbAQO5gMB6tRsS/e1PYY1ORNXn/CwtgtjrlfQa6m3ey0DVH/LacUYG1DXOQO+Y122bcvB1Duvja6n1bgdTu5sG20ywwZ/BOCGnN6xs8JeleOzP+7MoZiHS/zFygfVZvWEN9PtWfIQ8Yjn1oSYvfevINpXf2TCWCppo3Y7Ev2OQzV6eC5OSzzq+nPTiEANwESEM27egBM2T5MzhKnhYzbUsEI7M+MV2NMYyi6GOq2zyqNzmcmuRWqZS7uJrNx3GnMY3P0kIbYJiOvmt32tvz5VuZ3qlB2qhfxn0+ckQa42FyXXr4kzK0pFUGtlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrZBPSxLkW0AkrfTdodxkO9szE1nwqGlCG9zccC7o70=;
 b=Lz9QmpIYNE3+gHyHjFsrF+7pR4fTapqT5WNB3EvFhgYuOpVvo7m5OW6Z1lwyhmz9x1ot4dCYqs5F5N41MIQzDigQND6oRfk1KRAUA8SHPj4Plur+thDDc06Wel45EB46wDVkMiw+xOGi58yMBmrPi4eOTHrD3KwmB2fPJoReQlqinsVAtrgjY5xhHlplssiR26qLRa7C00ug8xh0xyfq0GUQR7CR3i8BVqRxQolxCo0LmDLBwHnjXDrWRvAgM+Ch53sn3EzRpqG9Is3TSKw2hqCDfFCuLC6vdw/2MTpr6gCLpGpp5igJo5lNqry0U1lwc72Tk24ycLV3pLFT5lU7VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrZBPSxLkW0AkrfTdodxkO9szE1nwqGlCG9zccC7o70=;
 b=oAbo//ol6/dmVz7Frygv+Fg6Ymms4lCKPCmyLXghkgtpvWYonBKcWDU2lL4RI9gOIxURHp+Jj7t19jHph9jhdm7eedbTUsWYcdgqW3oDgH91fHn01BH4dCA282AM41RMhzwLxHl4KsSBZOQFNUbLzKz9T4kyliiWqLYj/FPfNdE=
Received: from DS4PR12MB9706.namprd12.prod.outlook.com (2603:10b6:8:277::8) by
 SN7PR12MB6691.namprd12.prod.outlook.com (2603:10b6:806:271::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.23; Mon, 18 May 2026 09:01:32 +0000
Received: from DS4PR12MB9706.namprd12.prod.outlook.com
 ([fe80::5f2d:b44:e38d:63f3]) by DS4PR12MB9706.namprd12.prod.outlook.com
 ([fe80::5f2d:b44:e38d:63f3%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 09:01:31 +0000
From: "Fu, Rex" <Rex.Fu@amd.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ARM: dts: aspeed: anacapa: name EDSFF and thermtrip SGPIO
 lines
Thread-Topic: [PATCH] ARM: dts: aspeed: anacapa: name EDSFF and thermtrip
 SGPIO lines
Thread-Index: AQHc2GSbPA7avnS0lkWo8IKZE58UxrYTc76AgAAkoDA=
Date: Mon, 18 May 2026 09:01:30 +0000
Message-ID:
 <DS4PR12MB9706E6033B3BD469A94062FB8F032@DS4PR12MB9706.namprd12.prod.outlook.com>
References: <20260430-anacapa-sgpio-edsff-thermtrip-v1-1-2fd5e72435d0@amd.com>
 <bae3a186da639118d88ad2632c5edf8963946dc1.camel@codeconstruct.com.au>
In-Reply-To:
 <bae3a186da639118d88ad2632c5edf8963946dc1.camel@codeconstruct.com.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-18T08:59:04.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PR12MB9706:EE_|SN7PR12MB6691:EE_
x-ms-office365-filtering-correlation-id: b97f803a-2af7-4e88-ee21-08deb4bc0db8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003|38070700021|4143699003|11063799003;
x-microsoft-antispam-message-info:
 bKymhlcay4EQRNuASSDQyxykWAf3Zo1wyWwoPdjI+nz/zgAGUnXrkkbaqCdnE+kCnjZ59pfO5XZ0WIMvzXAHohet1zVFyC+Wjyx5QCBQonkcRdUQRZsfUpgcO3Xey0M/fa91LDY8ibLL3KIcLMZB5nMaHQSV7kmqdBY9DEDdkoMWLfaBHeNcI/H3660rB+K8ZHktZs57nav4ZZrKyIEIRsbLCyAt3u9HOXCaUug3kRU0FM4IibLrdhc/HMllYump7LWpzqywiMhoJn9rI9+5tzHika0BgHaBiun90sZD9y10Wn4S0nbmc6mwoI2lGQ9/tI6jVPNRkTuG0SyqV5lgBCcDVs2U/qJLRe/30jkYZRkNnKSs4lbByoEIh3bRnoPgRFyUtOuIeyu8ZyaVguBBfihmAraRy1gYopCJVYuXOpBPX1jd0sbEMNe0POnwFFi8HH/i730gDs+s3qkU5ErjHSg4KdhOT0g4/B3YeSCjma2KUvlHfUC90uSv57RzPK+FODsLNYAhEbp/1R6MAWXUfEWhGJJVb0+PFPez7ghTk23rU/VmZmX37DFzj7n6VkcLrb4XLBZJRBigc6q/Ifbx8dJyPR0GQflVRV4DClcooyDDl/9vyxUlk6sMKy724wUJfSb+LzAomhKTBNfVpWI7SbdNm7ij2Dp5xUNFUSNHMJSCjmWsBv2LGN6YlFOwLxnZHpLQTXKovwWNspiK2LVWUP76XEL/6SRwh0D+Jn6Iygn627zKoLdqPek/RBMeZkTh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9706.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021)(4143699003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWhsbnpOaHZzQUpTN1p5NjE3eUpkQndJaWJPSDYxZTRNUDNXbVBqWW1TdTdr?=
 =?utf-8?B?cFRVT0dwQWRzRGlWcnY3NnFjaUxNODZsZVZMT0RHd2ZxQ2lnTHFBcm1Za0VV?=
 =?utf-8?B?SlJYLzI5YzdSNTduOVpCc3FuRERlS09SMlF1VGtWWGNYRERtMGFCMHhvRTFY?=
 =?utf-8?B?ck1BajRvbXVURlpQbkVHZ2o4eWc0Vm9kbXJEVWNNRGxOQ3duNlZpd1REWGp0?=
 =?utf-8?B?bDNWZ1FvREdtRzJzOGlXQkllRml4Uis0ekgxMmJvd1JreWFPYWpnOVg4b3Js?=
 =?utf-8?B?TXBGUG8rNnNRSUJLd3Rjcmt6VzRxMW1WQ3RjaFJuOTgyRW1IalVMNGx2SlQ3?=
 =?utf-8?B?amJLVDQ1OVpmUHlpU0FDR1E2Mm1CUDBTV1pqMEFFVlRPTTNpV3lVYmphaHBz?=
 =?utf-8?B?OGpNMUEvTng1dFRSbTh2NDRjWnBEZmdIUWJnWXplZnBHT1NSYzh4RFdZZ0dC?=
 =?utf-8?B?MmYyVWl2SW11aWdiU3E4NzUzZWprcDNQNUVxemR1VzZWdVVveEhKbFFrZUZM?=
 =?utf-8?B?RTVqVUZNaTZMZkxkTDdTZVkyTytDNVorLzgzcGVFTlFaSzZrTDRvUC95NTkr?=
 =?utf-8?B?Vkl2eWFRbW9VNUY0WVg3V1lxb0VKVXhoVWtlSXlacmV1bm8wVlp3QUpqbm1R?=
 =?utf-8?B?ZWxqd0RnV3FudHBqbWFhaEpTWURUVThYQkt0djVtTEk1K0dUT0JDRUZGUjVP?=
 =?utf-8?B?MytoSEQzbjJnVjAxUUY5QzNPTndkQWRPWHNGeDhJTVRkS041NmxjRVJLejE1?=
 =?utf-8?B?SGZMYmNPQm5CL0dqOHdzNnExQVZuNVIydFdkblU0T2xZcFNnUDg5RWxxVjhH?=
 =?utf-8?B?WmZBSlJaYUpVQWZLZHEwSDdRU1JsbE5RMlJ5QVo2aytmNkhrWENkREJhUUJn?=
 =?utf-8?B?eHBQVkNmK216S2ErUzEzTXZlaFpYcDU1UmMvczRxYmNLVlR6aVpPY2ZRWkF3?=
 =?utf-8?B?VFdtN2w5K2tCWnFXYlFWb01WaEpjeS9jNlZ3OGxPYXJYTlhxdWtBVzlFL29U?=
 =?utf-8?B?eTJKS3NKTGZPWTRQa3hoc1ZyU3RqSXF6dHFzait0SDM1RDFXQ2RVSFo4UU1l?=
 =?utf-8?B?T1RYWUlRSk11UUtyRjhycFcrejY5bmpoQXdQQ0dleXI5RVE0RXhMbFlUVVJE?=
 =?utf-8?B?ZTBUQUZjSmNpWjZXbzFtZ2hCUTFrMy9qUjJYQzAyZnl6NXdWOGtSa1ZhRXBC?=
 =?utf-8?B?OWhYYzQ1TXg3eU1haG9VM2o1bEl4eDVyZXBEdGVsanFiMEY1cTNUSXUwd3V6?=
 =?utf-8?B?UXRRYXZITWlVcGZwYVBMUzE0SUVBZDNpbHNUUWNUZGVTRVhzT05GV3Jid0N1?=
 =?utf-8?B?TjNNdlpVT0YrVkJVc0RtTzNvM0IvWWEwbGJpN2YyTC92b0x2T2w4L24yNk9U?=
 =?utf-8?B?Y1ZScHlaREhuZy9VMStiZVozTmNUWXlSNVhBWWRqeWt0N3pkYzlrZzd3cmpG?=
 =?utf-8?B?UDB6ZkJKSWtURWlaeGlJTmJzblJ1QUlKOWdYVnZ5RXlDTGJvSndxNmwvYm1Z?=
 =?utf-8?B?QklXV1NYdWZtOVh6UXNYSnVRcXNQaSs4Q1JGeUoxQnNlcFNFRkZvL0ZNUFdz?=
 =?utf-8?B?VldESFlpUEpJSjVqSlplaVZHTk85U1FlQzYvL0dBcHMvSXIwVEk0N2JTNkNS?=
 =?utf-8?B?Z1F2NTc5Wmo4TFVORVphRDExOEx6OVJLejRYTE9SNXY3VHhvRC9UZGhLbXI2?=
 =?utf-8?B?a1d6dmdIcFFiaFp4WmJFb0s4WVRibXppbDI2cm01eXRGVGVZZVg2eGhDMG94?=
 =?utf-8?B?TURwTFNYZEFlenVyTWhVLzIwaDROcU9ZdGFxVmdpVUJhbHRqSlNabkt2bXI4?=
 =?utf-8?B?SU1ZKzcvbVhjNU9YSVZkdXVzbDRXYjljdXV6N1dZcVVibFdWWUlydlFCY3ZC?=
 =?utf-8?B?ZllyZ25VeU9OVmF3UUNsSU1McDd4c0J4cElUeTBoQk41cFFmNUo4Q2FESmdy?=
 =?utf-8?B?TkJJdlFab2xMNTlpOE5tdzFmbUR5anM0bVRhREYvSW9RNTV3SUZFbmZzYTRP?=
 =?utf-8?B?VUJnOWZqbkVSYjNoc3JaMTB6REpWYmxiM2xRcTROS2NodU0zeCtVM0ZXSFU4?=
 =?utf-8?B?SUg1N2NuZU8rYmhOL2ZVNTZxQ3ZBMkV1K0tCRE40aGFKSjYxdUhkYTUwQTV6?=
 =?utf-8?B?eTI3VGkrQXhJbGNxcE5kOU02a3o4dzFmWXp0cGdPTGVRU1prRGkwNGNheS9q?=
 =?utf-8?B?RWpZK09mN1BodXU0a082L2YvOE05Tyt2MHdwL1JONmJydU1rS2REdHc3eWl2?=
 =?utf-8?Q?lzPtcRVMkmIf9dEkCb+vCgDZ1vC5WlyJPE1TVqOVB4=3D?=
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
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9706.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97f803a-2af7-4e88-ee21-08deb4bc0db8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 09:01:30.9993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iha46kBJIGgbK+WuB/tp6WKsuXalDCV0EAiwHVycLgUeYS03u29nWIMl1PYEgy2D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6691

QU1EIEdlbmVyYWwNCg0KSGkgQW5kcmV3LA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCkkg
YWdyZWUgdGhhdCB0aGUgb3JpZ2luYWwgY29tbWl0IG1lc3NhZ2Ugd2FzIHRvbyB2YWd1ZSwgZXNw
ZWNpYWxseSBzaW5jZSB0aGVzZSBHUElPIGxpbmUgbmFtZXMgYXJlIHZpc2libGUgdG8gdXNlcnNw
YWNlLg0KDQpUaGVyZSBpcyBubyBuZXcgYm9hcmQgcmV2aXNpb24gb3IgdW5kZXJseWluZyBoYXJk
d2FyZSBjaGFuZ2UgaW52b2x2ZWQuIFRoaXMgaXMgYSBuYW1pbmcgY29ycmVjdGlvbiBmb3IgdGhl
IGV4aXN0aW5nIEFuYWNhcGEgaGFyZHdhcmUgZGVzaWduLg0KDQpJIHdpbGwgcmVtb3ZlIHRoZSAi
bGVnYWN5IG9yIHVudXNlZCIgd29yZGluZy4gVGhlIHByZXZpb3VzIG5hbWVzIGRvIG5vdCBtYXRj
aCB0aGUgYWN0dWFsIEFuYWNhcGEgdXNhZ2U6IHNvbWUgbGluZXMgd2VyZSBuYW1lZCBhcyBDUFUt
cmVsYXRlZCBzaWduYWxzIGJ1dCBhcmUgdXNlZCBmb3IgRURTRkYgcG93ZXItZ29vZCBtb25pdG9y
aW5nLCBhbmQgdGhlIHRoZXJtdHJpcCBsaW5lcyB1c2VkIHJhdyBhY3RpdmUtbG93IHNpZ25hbCBu
YW1lcyB3aGlsZSB1c2Vyc3BhY2UgbW9uaXRvcnMgdGhlIGFzc2VydGVkIGNvbmRpdGlvbi4NCg0K
Q2hhbmdpbmcgdGhlc2UgbmFtZXMgaXMgYXBwcm9wcmlhdGUgYmVjYXVzZSB0aGUgdXNlcnNwYWNl
IG1vbml0b3JpbmcgY29uZmlndXJhdGlvbiBpcyBiYXNlZCBvbiB0aGUgcGxhdGZvcm0gc2lnbmFs
IG5hbWVzLiBLZWVwaW5nIHRoZSBvbGQgbmFtZXMgd291bGQgbWFrZSB0aGUgRFRTIGluY29uc2lz
dGVudCB3aXRoIHRoZSBoYXJkd2FyZSBkZXNpZ24gYW5kIHVzZXJzcGFjZSBjb25maWd1cmF0aW9u
Lg0KDQpJIHdpbGwgc2VuZCBhIHYyIHdpdGggdGhlIGV4YWN0IG9sZC10by1uZXcgbWFwcGluZ3Mg
YW5kIGEgbW9yZSBwcmVjaXNlIGV4cGxhbmF0aW9uIGluIHRoZSBjb21taXQgbWVzc2FnZS4NCg0K
QmVzdCByZWdhcmRzLA0KUmV4IEZ1DQpCTUMgRW5naW5lZXIgIHwgIEFNRA0KRGF0YSBDZW50ZXIg
UGxhdGZvcm0gRW5naW5lZXJpbmcgR3JvdXANCk8gKzg4NiAoMikgMjY1NS04ODg1DQotLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQozRiwgTm8uIDMtMiBZdWFucXUgU3RyZWV0LCBOYW5nYW5nIERpc3RyaWN0LCBU
YWlwZWkgMTE1LCBUYWl3YW4NCkxpbmtlZEluICB8ICBJbnN0YWdyYW0gIHwgIFggIHwgIGFtZC5j
b20NCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQW5kcmV3IEplZmZlcnkg
PGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT4NClNlbnQ6IE1vbmRheSwgTWF5IDE4LCAyMDI2
IDI6NDggUE0NClRvOiBGdSwgUmV4IDxSZXguRnVAYW1kLmNvbT47IFJvYiBIZXJyaW5nIDxyb2Jo
QGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBD
b25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBKb2VsIFN0YW5sZXkgPGpvZWxAam1z
LmlkLmF1Pg0KQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWFzcGVlZEBsaXN0cy5vemxhYnMub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBBUk06IGR0czog
YXNwZWVkOiBhbmFjYXBhOiBuYW1lIEVEU0ZGIGFuZCB0aGVybXRyaXAgU0dQSU8gbGluZXMNCg0K
W1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20u
YXUuIExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFi
b3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KDQpDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2lu
YXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uIHdoZW4gb3Bl
bmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQoNCg0KSGVs
bG8gUmV4LA0KDQpPbiBUaHUsIDIwMjYtMDQtMzAgYXQgMTM6NDQgKzA4MDAsIFJleCBGdSB2aWEg
QjQgUmVsYXkgd3JvdGU6DQo+IEZyb206IFJleCBGdSA8UmV4LkZ1QGFtZC5jb20+DQo+DQo+IE5h
bWUgdGhlIEFuYWNhcGEgU0dQSU8gbGluZXMgdXNlZCBmb3IgRURTRkYgcG93ZXItZ29vZCBhbmQg
dGhlcm10cmlwDQo+IGFzc2VydGlvbiBzaWduYWxzLg0KPg0KPiBUaGUgYWZmZWN0ZWQgbGluZXMg
cmVwbGFjZSBsZWdhY3kNCj4NCg0KV2hpY2ggYXJlIGxlZ2FjeT8NCg0KPiAgb3IgdW51c2VkDQo+
DQoNCldoaWNoIGFyZSB1bnVzZWQ/DQoNCj4gQ1BVLXJlbGF0ZWQgbmFtZXMgd2l0aCB0aGUNCj4g
cGxhdGZvcm0gc2lnbmFsIG5hbWVzIHVzZWQgYnkgdXNlcnNwYWNlIG1vbml0b3JpbmcuDQoNClRo
aXMgaXMgdGhlIGtpbmQgb2YgY2hhbmdlIHRoYXQgaGFzIHRoZSBwb3RlbnRpYWwgdG8gYnJlYWsg
b2xkIHVzZXJzcGFjZS4gV2h5IGlzIGl0IGFwcHJvcHJpYXRlPyBJJ2QgbGlrZSBhIG1vcmUgcHJl
Y2lzZSBkaXNjdXNzaW9uIGluIHRoZSBjb21taXQgbWVzc2FnZS4NCg0KV2FzIHRoZXJlIHNvbWUg
b3RoZXIgdW5kZXJseWluZyBjaGFuZ2UgKGUuZy4gYSBuZXcgcmV2aXNpb24gb2YgdGhlIHBsYXRm
b3JtIGRlc2lnbik/DQoNCkFuZHJldw0KDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFJleCBGdSA8UmV4
LkZ1QGFtZC5jb20+DQo+IC0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1i
bWMtZmFjZWJvb2stYW5hY2FwYS5kdHMgfCAxMA0KPiArKysrKy0tLS0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMtZmFjZWJvb2stYW5hY2FwYS5kdHMN
Cj4gYi9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWJtYy1mYWNlYm9vay1hbmFjYXBh
LmR0cw0KPiBpbmRleCAyY2I3YmQxMjhkMjQuLmZlOTYwYmI3YmMyNyAxMDA2NDQNCj4gLS0tIGEv
YXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMtZmFjZWJvb2stYW5hY2FwYS5kdHMN
Cj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMtZmFjZWJvb2stYW5h
Y2FwYS5kdHMNCj4gQEAgLTkxMiw3ICs5MTIsNyBAQCAmc2dwaW9tMCB7DQo+ICAgICAgICJQV1JH
RF9QVkRESU9fUDAiLCAiIiwNCj4gICAgICAgIlBXUkdEX1BWRERJT19NRU1fUzNfUDAiLCAiIiwN
Cj4gICAgICAgIlBXUkdEX0NITVBfQ1BVMF9GUEdBIiwgIiIsDQo+IC0gICAgICJQV1JHRF9DSElM
X0NQVTBfRlBHQSIsICIiLA0KPiArICAgICAiSFBNX0VEU0ZGX1BHIiwgIiIsDQo+ICAgICAgICJQ
V1JHRF9DSEVIX0NQVTBfRlBHQSIsICIiLA0KPiAgICAgICAiUFdSR0RfQ0hBRF9DUFUwX0ZQR0Ei
LCAiRk1fQk1DX1JFQURZX1BMRCIsDQo+ICAgICAgICIiLCAiIiwNCj4gQEAgLTk1Nyw4ICs5NTcs
OCBAQCAmc2dwaW9tMCB7DQo+ICAgICAgICJQREJfQUxFUlRfUl9OIiwgIiIsDQo+DQo+ICAgICAg
IC8qIEwwLUw3IGxpbmUgMTc2LTE5MSAqLw0KPiAtICAgICAiQ1BVMF9TUDdSMSIsICIiLCAiQ1BV
MF9TUDdSMiIsICIiLA0KPiAtICAgICAiQ1BVMF9TUDdSMyIsICIiLCAiQ1BVMF9TUDdSNCIsICIi
LA0KPiArICAgICAiTF9FRFNGRjJfUEciLCAiIiwgIkxfRURTRkYzX1BHIiwgIiIsDQo+ICsgICAg
ICJSX0VEU0ZGMl9QRyIsICIiLCAiUl9FRFNGRjNfUEciLCAiIiwNCj4gICAgICAgIkNQVTBfQ09S
RVRZUEUwIiwgIiIsICJDUFUwX0NPUkVUWVBFMSIsICIiLA0KPiAgICAgICAiQ1BVMF9DT1JFVFlQ
RTIiLCAiIiwgIkZNX0JJT1NfUE9TVF9DTVBMVF9SX04iLCAiIiwNCj4NCj4gQEAgLTk4NCw4ICs5
ODQsOCBAQCAmc2dwaW9tMCB7DQo+ICAgICAgICJIUE1fUFdSX0ZBSUwiLCAiUG9ydDgwX2IwIiwN
Cj4gICAgICAgIkZNX0RJTU1fSVBfRkFJTCIsICJQb3J0ODBfYjEiLA0KPiAgICAgICAiRk1fRElN
TV9BSF9GQUlMIiwgIlBvcnQ4MF9iMiIsDQo+IC0gICAgICJIUE1fQU1DX1RIRVJNVFJJUF9SX0wi
LCAiUG9ydDgwX2IzIiwNCj4gLSAgICAgIkZNX0NQVTBfVEhFUk1UUklQX04iLCAiUG9ydDgwX2I0
IiwNCj4gKyAgICAgIkFNQ19USEVSTVRSSVBfQVNTRVJUIiwgIlBvcnQ4MF9iMyIsDQo+ICsgICAg
ICJDUFVfVEhFUk1UUklQX0FTU0VSVCIsICJQb3J0ODBfYjQiLA0KPiAgICAgICAiUFZERENSX1NP
Q19QMF9PQ1BfTCIsICJQb3J0ODBfYjUiLA0KPiAgICAgICAiQ1BMRF9TR1BJT19SRFkiLCAiUG9y
dDgwX2I2IiwNCj4gICAgICAgIiIsICJQb3J0ODBfYjciLA0KPg0KPiAtLS0NCj4gYmFzZS1jb21t
aXQ6IDk5NzQ5NjljMTQwMzFhMDk3ZDZiNDViY2I3YTA2YmI0YWE1MjVjNDANCj4gY2hhbmdlLWlk
OiAyMDI2MDQzMC1hbmFjYXBhLXNncGlvLWVkc2ZmLXRoZXJtdHJpcC1hY2IyMjhiZjYxYmUNCj4N
Cj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBSZXggRnUgPFJleC5GdUBhbWQuY29tPg0KPg0K

