Return-Path: <linux-aspeed+bounces-1840-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19851C87FCC
	for <linux-aspeed@archiver.kernel.org>; Mon, 28 Jul 2025 02:55:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4br34T5gb3z307K;
	Mon, 28 Jul 2025 12:55:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753671321;
	cv=pass; b=nmNFbY5wY6VPI5bG9gmo/SV8OZEBB9CMy9n3LTE2P8k5ZiiW9QXCb+G4A8eMhD/O0gbYD6wmfkkUXy0rDXGZzrYlpVRdryz/IWR3CrO0IOcJ5rAlhzZjqgZMIreGka99b/90NIxt2vSYb9Jx4gazP0yast4wxDm/gr05KOOxQ99GZZUUiDSAUqsAn9lr1+wVp7F+AMbzE4p9wutShcA5WYme7WiMzbSEpkuW43S8SOmrXNKbT/Pks3kasc9xdcYfqN/CRGJSNsBzJ8Go1IxgAe/kjM/UzqRbvPFYZQq7XzZKFrqCx3Btp/DYvOmr/WmTHv2HGUOK0GZBIMznrpAb0Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753671321; c=relaxed/relaxed;
	bh=iz41eiXS/mCFIrLPvwbhLoEjG4uy4D9l3HyOK75U1QM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XAkVwIYzaNuetAeUZ/XutLIidLlCXcSEa2ADZxenICT77L4oXjpYFY+rjcESxIPqzERC4D/I8nJhyvGdLrM//Mu5QvKOmZLSov7cPCgWYruw7+6N5ETWgfGmhPp1YrYgthVd/P1XV5rEvxPXZLNNc3pj3VCiKjGhi0p6UHp8g46EK1LlVqpkIPLcAm5F5K0if1wB3htBtxomhRMxpR4qJdpykj2ufiVK5gWgKW4FWny30Nq7Qaha2Hjniq4LPC59mMlb4RzlR5Fxz4JAUf5LMIl5vLjPY9WpLkRTeXQDGxRZSPmZS2kjlKVfksNNPq6KUAjDcIzApF3oaKtE/DuDKA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=fail header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=CMfaIzST reason="key not found in DNS"; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="key not found in DNS" header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=CMfaIzST;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4br34S0C16z2xRq
	for <linux-aspeed@lists.ozlabs.org>; Mon, 28 Jul 2025 12:55:19 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srRBCEh1zpIod6YnSA0RzYI58bO7yWanGA2PN8FN/0x+LAMuKFWHlK3KnXoWORdODuaEizdtwPb0+XmWI9Wyg7oWG1ah7KqdFEiCTYwzcDIcilkuO0HeYOJmEuosYajlUlKuREHQq0bgzD2NG5Se+MqELVhOzfOSGvq26jpOK/QsXe1R0PYnCjpRdLLjpYr23SbZnpUo35r9cfyAsfEAPsmV3GOb4/DzztrmML/b1DyX5+IxObT96LrdoxQIQgyi/xqYtTOJTPrmBsry0F1N5AM/w4rIQGAMIIFKJ+FxhrHNU7tgneVM03xfo7nIfGk1WOed0KV0w5+O9i0PkJetrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iz41eiXS/mCFIrLPvwbhLoEjG4uy4D9l3HyOK75U1QM=;
 b=cArvmJrUxDda6DPLkCZkD+HyG2tv6OaxaQ1aYD9Cwg4YETrG36K2FCxRP6GRc+xvOvZPwZyWB/OR7LMuK09fzHDHxDg7eGQukbttrhOGniPDWidlZkvN3Q5ltgfn11nMtxGwacQ3kUkr76rUFXjDUt/3Vc2CUntayNJhZkresCmrYqxPP24zVI6xb8YEPt37Z2EGHp8Wf36m7tGENQLl62BCgiawvqN27R/fLZheDX66X2kMXO7aCSXgcsDtfyiJcXaFn7B7WS/sUVdOt49ApSwhgRiUhCLhj6s7kzvazc1TC8hSvB7j5Tnt4ARmaNEVydWLZYlO8Me+g1sNs4hHkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iz41eiXS/mCFIrLPvwbhLoEjG4uy4D9l3HyOK75U1QM=;
 b=CMfaIzST6QdXYvRA+u2ykuN/Xdd4L0r9Lo+W/OQqKjIkumTLH5PQO6wa8krzCK7GuSEBX5RZ6W3s0UowYHJMBqh9ADR3s0McCJ+oYdpoGG5OjxlB0U/jmU5tEcVw9azcKOw+kONF7n+GkDFliygderlqoMsbEdgbu4Zvt/bR2ugmIdIYuzyyg0nq27SyNMJkeVpLt/tDO6aqEFRhLitHoO8/0z9pFASWfRLdmuZyYqiBFuKqpjhU9cLbGGPxFZN9dSzp4aMOOGIqV0z+pyV3yKUfeTc2dT+emlnu8NIinWwDxEB/2S/3NsMMVhZhOioC9r0+G0J2uaw4ZMur7v3avw==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by PS1PPFEF7C8A25D.apcprd06.prod.outlook.com (2603:1096:308::26c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Mon, 28 Jul
 2025 02:54:53 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 02:54:53 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Kevin Chen
	<kevin_chen@aspeedtech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v3 1/2] dt-bindings: interrupt-controller: aspeed: Add
 parent node compatibles and refine documentation
Thread-Topic: [PATCH v3 1/2] dt-bindings: interrupt-controller: aspeed: Add
 parent node compatibles and refine documentation
Thread-Index:
 AQHb+u5GGJR1Lh1PR0C5h6er79qfsbQ/O9gAgAAebjCAAx6NAIACvGYQgACIv4CAARPLIA==
Date: Mon, 28 Jul 2025 02:54:52 +0000
Message-ID:
 <OS8PR06MB7541D83FEAC1CC03CB98909DF25AA@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250722095156.1672873-1-ryan_chen@aspeedtech.com>
 <20250722095156.1672873-2-ryan_chen@aspeedtech.com>
 <001d37c7-f704-4554-a4db-0cc130e07dd6@kernel.org>
 <OS8PR06MB7541F8D3AEE1A618DB31F07BF25FA@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <384635a3-c6ed-44f8-a54a-2b20e20694cd@kernel.org>
 <OS8PR06MB75418BD29DCD6E93F2A44903F25BA@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <b8e570ab-313f-4f20-bedb-a1191c672435@kernel.org>
In-Reply-To: <b8e570ab-313f-4f20-bedb-a1191c672435@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|PS1PPFEF7C8A25D:EE_
x-ms-office365-filtering-correlation-id: f7faaf5e-891a-4310-d20f-08ddcd822078
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?NFpZd1JBb2k3cFh1L1RvVy9mZFRseWx6Zyt5dzZsZ2ZQNEhvZm55MXJiV1ln?=
 =?utf-8?B?K2pSNnNlVjVTUytNVFVDU2Y2TVRqUkJSOGZNN042Rml0VnF1YjR4aDVrYkpY?=
 =?utf-8?B?ZjBuR2JOekVmRlg5NHFSemY3am9KK0R4SHltWXhkcGprR2NSY0wrMm85WXMw?=
 =?utf-8?B?cE5SWnJGYXBXZTZLc0FVdVcvWTU3VWhpcnJhRG1lbThhOGhPUk1nOTVFb05V?=
 =?utf-8?B?VGVhdEVLUzQvRGFhK082aGlxZXZZbVU4bkZSQnJIVmlKMVowbFJ0WGZDd1ll?=
 =?utf-8?B?UmxzMThoZ1d2KzloejkzZzVwWUlWdFEzMVp1UGxmNVZwaVRZSmNDVjJ1d01Y?=
 =?utf-8?B?cktMZ0l2SmNReCtyVjgzVmZaYUhiRVozT2x4ZmJ4clJ4SkFoNjBuWHl6TGNY?=
 =?utf-8?B?QnpZZWZHSUpRcXArRTVNamw3dmdlREl0eVVrWS9pMDNQbXdGb0FTQndlRUV6?=
 =?utf-8?B?M1hDOGVsWnhQK2U2WkVWbVdHcGpGZ3pJN0pLUW1TWGRhZEt3Y05kanRkTDB0?=
 =?utf-8?B?djYxZUZEdHlNUjhkL0d2VGhhU2xyV0xBMUF1akdlS1VkQ2lVRnpLRVhSMWF4?=
 =?utf-8?B?VWNtTlduRDJGRTI2bUp4bitUWnlDWURkQjYxekFrOEEwcm4rVXo1aFRDd2hB?=
 =?utf-8?B?WGlCT3laUFdnYUVtOWthcGxXdzJxeUFqcitwdE0raXprL1ozOEI1L1BXNVB6?=
 =?utf-8?B?d0pMbEYvaC9QWmcwdFI1L3d1aWMxVm80SU9SQndJdmJQTW04ZEJHMlBvTzFt?=
 =?utf-8?B?ZlNYQVBHVEEwU2habi9WUXVrL3BPSUUwSDNzdDE4R3VnYUhQNm1LcXg2VFI2?=
 =?utf-8?B?dDJpY1ZxbWM1MFJZMTgxaWUvY0FaSU5BUXFaMFhXTnpQRWIxbFVMcjYwREU3?=
 =?utf-8?B?WUphTkowbFM3LytzVWVoVSs2bkF5RUt0VHFrd0h6YURFWXJDT3BjdW5ZcFRW?=
 =?utf-8?B?VVc1ckgya2NpN0RVLzkyQXB6a0lkQ0xiSURzOGg5TVBCUWkvQWxOdmltVlEw?=
 =?utf-8?B?eDhMa3plVE5RSGhzQURwKzdDdnpLZG1aaTBSL2NPcjJpdzd5SlpoTGxCdG9C?=
 =?utf-8?B?Sk9CU2RSMVpnRkRrYXlyRTliOE9tR3AycWNXU3FNR1RCU3paNzk0UGRNbUl2?=
 =?utf-8?B?NGpYdW5tdGJwNXdBalNlblNYVkkwZGdiSTU4YzBTS3Y1aVdidzdVaisra2lp?=
 =?utf-8?B?NWJ1Z092WDJIaENRMlkvQlFNb1k2RGw3SmR4eXRLZkJEN1d1Tkc3d2dqWVlw?=
 =?utf-8?B?RnkzdEQzWUpidjdNbGNjdnozc2JFdVZLTk1QNExMOFdzL0I4RDUzYzg4MkFS?=
 =?utf-8?B?NWZPcDIrVVVERU1pSHRYY0xSRnV5L3Q1K3kreXVIelpVS3B3bDNmaGpMUG5p?=
 =?utf-8?B?VWVGWmVYdGhWcDkvMWJpMUpORU41dytlYndZQkZrTDJrK1Z3VWNUWXhyT1FQ?=
 =?utf-8?B?WkJNZ1NIUWl5QVh0VGJNNmV1eXBaQzI3R29zT0FycWczMmVINENLQ0s0cWpU?=
 =?utf-8?B?UU9QVlU5b1Y5bjRpMW56T1hseGdURDRjNTBsOHRZSTk1QUlCWUZkeTFFeGgv?=
 =?utf-8?B?NlB0TDJ5UVhkbzUzSjdObGhCZDdkV250V1MvVVRGTHpvSkpRbWRpSnVTVHVs?=
 =?utf-8?B?VmRWUWFPZlpZUG1rMVk3NC9JUkZrS3RoNzdXa0dkY3ZUWVlQTVVEZWtxYTFj?=
 =?utf-8?B?MXRYa0dlYnVocVN0aVBRM1YyeHQrM3hEMDI2L0tnZDhuZ3lDRXRsenBvL213?=
 =?utf-8?B?Mmt1Z2hzMkN3TWFzYWVtM1k4K0FsbS9tV1ZiUEZSNmJwczRPMHpmWDlGMVVz?=
 =?utf-8?B?eEV6VUZ5TDVEcW83c28vN21xL3dEeW1yYkllV1Fmc3ViNmZOMmFYcTUxSmQ0?=
 =?utf-8?B?ZUNBdkQzQXljL0xhYmdGdnJLVjFIUE5mRWtjMlpiR1lnN0hiM1I2VW9oVThT?=
 =?utf-8?B?akpMWVA4OXRBM0ZrcVp6MnVTUTZZOXhrSCtUSjFkaVhPS2srbFgwb3RiY012?=
 =?utf-8?Q?qMZ2BKfTsY7iss95j75b14dJqJbFec=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TXBsMmRVaUd1WE9YNS82SnpEdTRZdW9mSlN0ektSWEk0ZzlrTExmOEt1UVE3?=
 =?utf-8?B?NnhHZm90YzhiUldnWEZDdEVuU2RYWk53bEpzQVZzaGJCWWp6L0R4QWxQSXk0?=
 =?utf-8?B?eEtaNngrdGJDanpOZG1USzJ2ZlZZMEkvTTA3d3VjUzdqdDNVQk1UZWY0TDR6?=
 =?utf-8?B?bjZVUXlqMzQxdWMxRTRTdG1QRzRmbXlFMjRIMGd4SjlMM0FBT0YwS2REREIx?=
 =?utf-8?B?aklUZVhpd3RRN3ZOMmlFeHh5K0dzQWJMVDJWT3JpQlh0NzdOTjI5OXJZenFK?=
 =?utf-8?B?SG9uaFExcitoaFhoNnVOeEtCQTlyK0RxWTc2cS9iTjBoMUh1UnBPVXFqQmxq?=
 =?utf-8?B?YnZDTEl1WU1hUDgra05EZ2pQbUhIV0h4OE12UCtIR2FMbGlSUnpUVytmZDJV?=
 =?utf-8?B?ck1MZ1ZjREh6c1haUGNWZEtWR1ZQeGwxdWs2UGNPRkE2ZkJpZ2lySlRVRFJ1?=
 =?utf-8?B?QWZVN1B1WEQ0NjNrT3FtMkFQZ3I3NXVLbkJHNVBHcy9YWHNoVW5jYkcvWGtO?=
 =?utf-8?B?VlpNREVHM1NvWXZ3blBkM05HS3F0UVUrajN0SCtiM2JFNlFsQWxKR1JNMHo2?=
 =?utf-8?B?NTJ3MkhXMUtHTXRoeVlTVFhqcEJYMWNJeW5DMFFOdWtKVnJpMDZrN1pEdng2?=
 =?utf-8?B?cXV1VTZJMElMMTZ3T0NyZzFQZUd2OTRsbjU5dVVIK2ZDNmNaNHNlbGxMK3E1?=
 =?utf-8?B?OEh3K3M4QXNwcnJWb3hkTDV6dW5nTnJFc2lVblRZY3JrYTVxaTdOMTM2THNZ?=
 =?utf-8?B?RTdzRm1HV0VrRklhYmFuZW16RmRnWXhBZnNVcXNQQTNuZ3V6T2Q5cmQwVnhI?=
 =?utf-8?B?L2VtbGlicmY2Z2lXRitnKytodG5mTWpQV2RSa2NOeHRjZW91S3VGZDN3Ukxp?=
 =?utf-8?B?MWU3MVQ2dWd5VmFKUys5a1paa2EvWmRoMm5ZQXNhKzhTdENCZmRBZlQrSldt?=
 =?utf-8?B?RUQwMWNUZ2FJSkw1K09lbmJ2K040L3Mvczl4d3d5TDFxUzNhK3dFSDYvK0lE?=
 =?utf-8?B?REJtbEJCWmpDaGJMclZGYlJKR2VpczF3dVpsa2NXTm5GbTNTUVpUUVB6WUox?=
 =?utf-8?B?bUJxSUQ2eFB3Wjh1N24zOFlYdFlYTEZOSGpsM2I2RmppcjdJVDgyL2tQN2pq?=
 =?utf-8?B?UXNKWWMzY3YvbTlQK3AvZ1dqQVdwcEhLdVFtQUZPQUJneElWSmo2dHZ2STcy?=
 =?utf-8?B?b3h1Z1g0V2dZbE4yb21YQXBsNXhLVjUrSU92cEFUdFh3cTYwT3pjSU50TEtU?=
 =?utf-8?B?THNVbzBWTGdrZXVqZzYrK3lLWUc3MG9HcHZsYXU5R1BsckhaMjRROGlIWXdO?=
 =?utf-8?B?YTdCN0RKMjcrb1BGZTgvU3FwWUptVXoyM0JPZlk3UkpVN0tRcTJ4dy9hOURs?=
 =?utf-8?B?RDhjeWVuQUg0T05jY0FRbmZjelVjODVXTzdRQUZuMXl4K3hlakRTa2hCclQx?=
 =?utf-8?B?ZC94aFM1K25DdHR3K1oxcms2Z0hLWUNob0Vuc1F0UkhqdVAyVmlkVklmY3Ja?=
 =?utf-8?B?UXpYWlZ5azYzQnJqVE5xNVliYkVLTUF3KzUrZWM5amZTQ0RRMXFpdlB6T0x2?=
 =?utf-8?B?VitvM2k1WlZLeEVmT1FqR0szanJZb0JoRVBoa3Q2amZtelFXTTlOQ095Vkhk?=
 =?utf-8?B?WHVkNUZuRHlQbFo3UU5Sd0p3OHVxUW1IekFtbDk1dHFFS2N3K29WajVnQUJQ?=
 =?utf-8?B?R0oxeExoWlZjZlFoME1adEgxbCthN1lGOUxYK3U1QmpQR2RicjN0M1dTYVhU?=
 =?utf-8?B?T3UrZ3ZkTHpuWWRWZld3UnZ4Q3NRcmxWbXIvR0d6bFpseGR6TDRhRTVudWJk?=
 =?utf-8?B?Ujk5NWdpMWZ0V0o5UzNSRmlxS01Na2N4R3NnT2U2ZXovUmUweEdnUzVBSjZG?=
 =?utf-8?B?MCtXcVRTT2pHdFZOZmNmMW5OaEx6dmJIQU42UHdQSDZoQU9vc0pIZEp1eGZ0?=
 =?utf-8?B?cG16cXlEV0pSMFFzNjRPRCs0aTJwYTJlaWZKc2tWSW9vZGg2MTRCTnFwbFFR?=
 =?utf-8?B?R2QrOXJHVVV5bnRVSXZTUDlvemdncGpkTzNwcWZUMVRuYjlXWGZWTXhzRjdy?=
 =?utf-8?B?bkJISjhXS2ZiTnNHQWo5TFZEbTdCMXozMGV5RkNCTnZSREdPb3FwbTVIMU9u?=
 =?utf-8?Q?NHuO2av6ZejqO79DdVDdG9uUM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f7faaf5e-891a-4310-d20f-08ddcd822078
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 02:54:53.0266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: opDjfn7CEDtHUgraOq2OKfSp9GU+aP+BKUMG3m/h1dMqCoXFHyQvRqUWtGNUbfA7Up7z60T1xshs9eGIBsHykiLFCbsHLwmXJoAYVyoLsbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPFEF7C8A25D

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvMl0gZHQtYmluZGluZ3M6IGludGVycnVwdC1jb250
cm9sbGVyOiBhc3BlZWQ6IEFkZCBwYXJlbnQNCj4gbm9kZSBjb21wYXRpYmxlcyBhbmQgcmVmaW5l
IGRvY3VtZW50YXRpb24NCj4gDQo+IE9uIDI3LzA3LzIwMjUgMDM6NDcsIFJ5YW4gQ2hlbiB3cm90
ZToNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzJdIGR0LWJpbmRpbmdzOiBpbnRlcnJ1
cHQtY29udHJvbGxlcjoNCj4gPj4gYXNwZWVkOiBBZGQgcGFyZW50IG5vZGUgY29tcGF0aWJsZXMg
YW5kIHJlZmluZSBkb2N1bWVudGF0aW9uDQo+ID4+DQo+ID4+IE9uIDIzLzA3LzIwMjUgMTA6MDgs
IFJ5YW4gQ2hlbiB3cm90ZToNCj4gPj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvMl0gZHQt
YmluZGluZ3M6IGludGVycnVwdC1jb250cm9sbGVyOg0KPiA+Pj4+IGFzcGVlZDogQWRkIHBhcmVu
dCBub2RlIGNvbXBhdGlibGVzIGFuZCByZWZpbmUgZG9jdW1lbnRhdGlvbg0KPiA+Pj4+DQo+ID4+
Pj4gT24gMjIvMDcvMjAyNSAxMTo1MSwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+Pj4+PiArICBJTlRD
MCBpcyB1c2VkIHRvIGFzc2VydCBHSUMgaWYgaW50ZXJydXB0IGluIElOVEMxIGFzc2VydGVkLg0K
PiA+Pj4+PiArICBJTlRDMSBpcyB1c2VkIHRvIGFzc2VydCBJTlRDMCBpZiBpbnRlcnJ1cHQgb2Yg
bW9kdWxlcyBhc3NlcnRlZC4NCj4gPj4+Pj4gKyAgKy0tLS0tKyAgICstLS0tLS0tLS0rDQo+ID4+
Pj4+ICsgIHwgR0lDIHwtLS18ICBJTlRDMCAgfA0KPiA+Pj4+PiArICArLS0tLS0rICAgKy0tLS0t
LS0tLSsNCj4gPj4+Pj4gKyAgICAgICAgICAgICstLS0tLS0tLS0rDQo+ID4+Pj4+ICsgICAgICAg
ICAgICB8ICAgICAgICAgfC0tLW1vZHVsZTANCj4gPj4+Pj4gKyAgICAgICAgICAgIHwgSU5UQzBf
MCB8LS0tbW9kdWxlMQ0KPiA+Pj4+PiArICAgICAgICAgICAgfCAgICAgICAgIHwtLS0uLi4NCj4g
Pj4+Pj4gKyAgICAgICAgICAgICstLS0tLS0tLS0rLS0tbW9kdWxlMzENCj4gPj4+Pj4gKyAgICAg
ICAgICAgIHwtLS0uLi4uICB8DQo+ID4+Pj4+ICsgICAgICAgICAgICArLS0tLS0tLS0tKw0KPiA+
Pj4+PiArICAgICAgICAgICAgfCAgICAgICAgIHwgICAgICstLS0tLS0tLS0rDQo+ID4+Pj4+ICsg
ICAgICAgICAgICB8IElOVEMwXzExfCArLS0tfCBJTlRDMSAgIHwNCj4gPj4+Pj4gKyAgICAgICAg
ICAgIHwgICAgICAgICB8ICAgICArLS0tLS0tLS0tKw0KPiA+Pj4+PiArICAgICAgICAgICAgKy0t
LS0tLS0tLSsgICAgICstLS0tLS0tLS0rLS0tbW9kdWxlMA0KPiA+Pj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgSU5UQzFfMCB8LS0tbW9kdWxlMQ0KPiA+Pj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICAgICAgICB8LS0tLi4uDQo+ID4+Pj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKy0tLS0tLS0tLSstLS1tb2R1bGUzMQ0KPiA+Pj4+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIC4uLg0KPiA+Pj4+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICstLS0tLS0tLS0rLS0tbW9kdWxlMA0KPiA+Pj4+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgSU5UQzFfNSB8LS0tbW9kdWxlMQ0KPiA+Pj4+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICAgICAgICB8LS0tLi4uDQo+ID4+Pj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKy0tLS0tLS0tLSstLS1tb2R1bGUzMQ0KPiA+Pj4+DQo+ID4+Pj4gWW91IGJp
bmRpbmcgYWxzbyBzYWlkIGludGMxIGlzIHRoZSBwYXJlbnQgb2YgaW50Yy1pYywgc28gd2hlcmUg
aXMgaGVyZSBpbnRjLWljPw0KPiA+Pj4+DQo+ID4+Pj4gVGhpcyBkaWFncmFtIGFuZCBuZXcgYmlu
ZGluZyBkbyBub3QgbWF0Y2ggYXQgYWxsLg0KPiA+Pj4NCj4gPj4+IFRoZSBjb3JyZXNwb25kZWQg
Y29tcGF0aWJsZSBpcyBmb2xsb3dpbmcuDQo+ID4+Pg0KPiA+Pj4gICArLS0tLS0rICAgKy0tLS0t
LS0tLSsNCj4gPj4+ICAgfCBHSUMgfC0tLXwgIElOVEMwICB8IC0+IChwYXJlbnQgOiBhc3BlZWQs
YXN0MjcwMC1pbnRjMCkNCj4gPj4+ICAgKy0tLS0tKyAgICstLS0tLS0tLS0rDQo+ID4+PiAgICAg
ICAgICAgICArLS0tLS0tLS0tKw0KPiA+Pj4gICAgICAgICAgICAgfCAgICAgICAgfC0tLW1vZHVs
ZTANCj4gPj4+ICAgICAgICAgICAgIHwgSU5UQzBfMCB8LS0tbW9kdWxlMQ0KPiA+Pj4gCQkJKGNo
aWxkIDogYXNwZWVkLGFzdDI3MDAtaW50Yy1pYykNCj4gPj4+ICAgICAgICAgICAgIHwgICAgICAg
IHwtLS0uLi4NCj4gPj4+ICAgICAgICAgICAgICstLS0tLS0tLS0rLS0tbW9kdWxlMzENCj4gPj4+
ICAgICAgICAgICAgIHwtLS0uLi4uICB8DQo+ID4+PiAgICAgICAgICAgICArLS0tLS0tLS0tKw0K
PiA+Pj4gICAgICAgICAgICAgfCAgICAgICAgIHwgICAgCQkJCQkgKy0tLS0tLS0tLSsNCj4gPj4+
ICAgICAgICAgICAgIHwgSU5UQzBfMTEgfCArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQl8
IElOVEMxICAgfCAgLT4gLT4NCj4gPj4gKHBhcmVudCA6IGFzcGVlZCxhc3QyNzAwLWludGMxKQ0K
PiA+Pg0KPiA+PiBBR0FJTiAoc2Vjb25kIHRpbWUpOiB0aGF0J3Mgbm90IHdoYXQgeW91ciBiaW5k
aW5nIHNhaWQuDQo+ID4+DQo+ID4+IFlvdXIgYmluZGluZyBpcyBleHBsaWNpdCBoZXJlLCB3aGlj
aCBpcyB3aGF0IHdlIHdhbnQgaW4gZ2VuZXJhbC4gSXQNCj4gPj4gc2F5cyB0aGF0IGluY3QxIGlz
IG9uZSBvZiB0aGUgcGFyZW50cyBvZiBpbnRjLWljLg0KPiANCj4gLi4uIGFuZCB5b3UgbmV2ZXIg
YWRkcmVzc2VkIHRoYXQuIDovDQoNClRoZSBmb2xsb3dpbmcgaXMgZGF0YXNoZWV0IGRlc2NyaXB0
aW9uLiANCg0KQVNUMjcwMCBJbnRlcnJ1cHQgQ29udHJvbGxlciBIaWVyYXJjaHkgKGZyb20gZGF0
YXNoZWV0KToNCg0KSU5UQzAgYW5kIElOVEMxIGFyZSBBTUJBIHNsYXZlIGRldmljZXMgb24gdGhl
IEFIQiBidXMsDQplYWNoIHdpdGggdGhlaXIgb3duIHJlZ2lzdGVyIHNwYWNlLiA0ODAgaW50ZXJy
dXB0IHNvdXJjZXM6IElOVG4gKG49MH40NzkpDQpJTlQwfjEyNyBjYW4gYmUgcm91dGVkIGRpcmVj
dGx5IHRvIFBTUCwgU1NQLCBvciBUU1AuDQpJTlQxMjh+MzE5IGFyZSBoYW5kbGVkIGJ5IElOVEMx
LCB3aGljaCBoYXZlIG11bHRpcGxlIGluc3RhbmNlcw0KKElOVEMxXzAsIElOVEMxXzEsIC4uLikN
CklOVEMxIG91dHB1dHMgYXJlIHJvdXRlZCBpbnRvIElOVEMwOyBJTlRDMCBvdXRwdXRzIGdvIHRv
IHRoZSBHSUMuDQoNClRoaXMgc3RydWN0dXJlIG1lYW5zOg0KSU5UQzAgcmVjZWl2ZXMgSU5UMH4x
MjcgYW5kIGFsc28gYWxsIG91dHB1dHMgZnJvbSBJTlRDMS4NCklOVEMxIGhhbmRsZXMgYSBzdWJz
ZXQgb2YgaW50ZXJydXB0IHNvdXJjZXMsIGFuZCBpdHMgb3V0cHV0IA0KaXMgcm91dGVkIGFzIGFu
IGlucHV0IHRvIElOVEMwLg0KDQpCbG9jayBEaWFncmFtIC8gSW50ZXJydXB0IENoYWluOg0KR0lD
DQogfA0KIHYNCklOVEMwIChwYXJlbnQsIGFzcGVlZCxhc3QyNzAwLWludGMwKQ0KIHwNCiArLS0g
SU5UQzBfMCAoYXNwZWVkLGFzdDI3MDAtaW50Yy1pYykgLS0+IFttb2R1bGUwLCBtb2R1bGUxLCAu
Li5dDQogfA0KICstLSAuLi4NCiB8DQogKy0tIElOVEMwXzExIChhc3BlZWQsYXN0MjcwMC1pbnRj
LWljKQ0KICAgICAgfA0KICAgICAgdg0KICAgSU5UQzEgKHBhcmVudCwgYXNwZWVkLGFzdDI3MDAt
aW50YzEpDQogICAgfA0KICAgICstLSBJTlRDMV8wIChhc3BlZWQsYXN0MjcwMC1pbnRjLWljKSAt
LT4gW21vZHVsZUEsIG1vZHVsZUIsIC4uLl0NCiAgICB8DQogICAgKy0tIC4uLg0KICAgIHwNCiAg
ICArLS0gSU5UQzFfNSAoYXNwZWVkLGFzdDI3MDAtaW50Yy1pYykgLS0+IFttb2R1bGVZLCBtb2R1
bGVaLCAuLi5dDQoNCnwgRGV2aWNlIFRyZWUgTm9kZSB8IEhhcmR3YXJlIEJsb2NrICB8IE91dHB1
dCBSb3V0ZWQgVG8gICAgfA0KfCAtLS0tLS0tICAgICAgICAgIHwgLS0tLS0tLS0tLS0tLS0tICAg
ICAgfCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tICAgICB8DQp8IGludGMwICAgICAgICAgIHwgSU5U
QzAgQDEyMTAwMDAwIHwgR0lDICAgICAgICAgICAgICAgfA0KfCBpbnRjMSAgICAgICAgICB8IElO
VEMxIEAxNGMxODAwMCB8IElOVEMwIGlucHV0IChjYXNjYWRlZCl8DQoNCmludGMwIHVzZXMgaW50
ZXJydXB0cyB0byBjb25uZWN0IHRvIHRoZSBHSUMgKHRvcC1sZXZlbCBwYXJlbnQpDQppbnRjMSB1
c2VzIGludGVycnVwdHMtZXh0ZW5kZWQgdG8gY29ubmVjdCB0byBhbiBpbnB1dCBvbiBJTlRDMA0K
KHNlY29uZC1sZXZlbCwgY2FzY2FkZWQpDQoNClRoaXMgYXBwcm9hY2ggZW5zdXJlcyB0aGUgc29m
dHdhcmUgYW5kIGRldmljZSB0cmVlIHJlZmxlY3QgdGhlDQphY3R1YWwgaGFyZHdhcmUgaW50ZXJy
dXB0IHBhdGhzLg0KSXQgYWxsb3dzIHRoZSBrZXJuZWwgdG8gY29ycmVjdGx5IG1hcCByZWdpc3Rl
ciBzcGFjZSBhbmQgaGFuZGxlIGludGVycnVwdA0KZGVsaXZlcnksIGFuZCBtYWtlcyBmdXR1cmUg
ZGVidWcvbWFpbnRlbmFuY2Ugc3RyYWlnaHRmb3J3YXJkLg0KDQpJZiB0aGVyZSBhcmUgYW55IGRl
dGFpbHMgeW91J2QgbGlrZSBjbGFyaWZpZWQgb3IgaWYgeW91IHJlY29tbWVuZCBhIA0KZGlmZmVy
ZW50IGRldmljZSB0cmVlIHN0cnVjdHVyZSwgcGxlYXNlIGxldCBtZSBrbm93IQ0KDQo+IA0KPiA+
Pg0KPiA+PiBMZXQgbWUgYmUgY2xlYXIsIGJlY2F1c2UgeW91IHdpbGwgYmUgZHJhZ2dpbmcgdGhp
cyB0YWxrIHdpdGgNCj4gPj4gaXJyZWxldmFudCBhcmd1bWVudHMgZm9yZXZlciAtIGNoYW5naW5n
IHRoaXMgYmluZGluZyBpcyBjbG9zZSB0byBuby4NCj4gPj4gSWYgeW91IGNvbWUgd2l0aCBjb3Jy
ZWN0IGFyZ3VtZW50cywgbWF5YmUgd291bGQgd29yay4gQnV0IHRoZSBtYWluDQo+ID4+IHBvaW50
IGlzIHRoYXQgeW91IHByb2JhYmx5IGRvIG5vdCBoYXZlIHRvIGV2ZW4gY2hhbmdlIHRoZSBiaW5k
aW5nIHRvIGFjaGlldmUNCj4gcHJvcGVyIGhhcmR3YXJlIGRlc2NyaXB0aW9uLiBXb3JrIG9uIHRo
YXQuDQo+ID4+DQo+ID4NCj4gPiBJZiBJIGRvIG5vdCBjaGFuZ2UgdGhlIGJpbmRpbmcsIEkgdGhp
bmsgdGhlIHlhbWwgYW5kIGR0cyBjYW4gc3RpbGwgZml0DQo+ID4gdGhlIGludGVycnVwdCBuZXN0
aW5nIGFyY2hpdGVjdHVyZSBieSB1c2luZyBib3RoIGludGVycnVwdHMgYW5kDQo+IGludGVycnVw
dHMtZXh0ZW5kZWQuDQo+ID4NCj4gPiBGb3IgZmlyc3QtbGV2ZWwgY29udHJvbGxlcnMsIHVzZSB0
aGUgc3RhbmRhcmQgaW50ZXJydXB0cyBwcm9wZXJ0eQ0KPiA+IChlLmcuIHdpdGggdGhlIEdJQyBh
cyB0aGUgcGFyZW50KS4NCj4gPg0KPiA+IEZvciBzZWNvbmQtbGV2ZWwgSU5UQy1JQyBpbnN0YW5j
ZXMsIHVzZSBpbnRlcnJ1cHRzLWV4dGVuZGVkIHRvIHJlZmVyDQo+ID4gdG8gdGhlIGZpcnN0LWxl
dmVsIElOVEMtSUMsIGZvbGxvd2luZyBjb21tb24gTGludXggcHJhY3RpY2UgZm9yIHN0YWNrZWQg
aW50ZXJydXB0DQo+IGNvbnRyb2xsZXJzLg0KPiA+IEZvciBleGFtcGxlOg0KPiA+IGR0cw0KPiA+
IC8vIEZpcnN0IGxldmVsDQo+ID4gaW50YzBfMTE6IGludGVycnVwdC1jb250cm9sbGVyQDEyMTAx
YjAwIHsNCj4gPiAgICAgY29tcGF0aWJsZSA9ICJhc3BlZWQsYXN0MjcwMC1pbnRjLWljIjsNCj4g
PiAgICAgcmVnID0gPC4uLj47DQo+ID4gICAgIGludGVycnVwdC1jb250cm9sbGVyOw0KPiA+ICAg
ICAjaW50ZXJydXB0LWNlbGxzID0gPDI+Ow0KPiA+ICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkg
MTkyIElSUV9UWVBFX0xFVkVMX0hJR0g+LCAuLi47IH07DQo+ID4NCj4gPiAvLyBTZWNvbmQgbGV2
ZWwsIGNhc2NhZGVkDQo+ID4gaW50YzFfMDogaW50ZXJydXB0LWNvbnRyb2xsZXJAMTRjMTgxMDAg
ew0KPiA+ICAgICBjb21wYXRpYmxlID0gImFzcGVlZCxhc3QyNzAwLWludGMtaWMiOw0KPiA+ICAg
ICByZWcgPSA8Li4uPjsNCj4gPiAgICAgaW50ZXJydXB0LWNvbnRyb2xsZXI7DQo+ID4gICAgICNp
bnRlcnJ1cHQtY2VsbHMgPSA8Mj47DQo+ID4gICAgIGludGVycnVwdHMtZXh0ZW5kZWQgPSA8Jmlu
dGMwXzExIDAgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+IA0KPiBUaGlzIGxvb2tzIGxpa2UgY2hh
bmdpbmcgdGhlIG1lYW5pbmcgb2YgdGhlIGludGVycnVwdC4gV2hhdCB3YXMgdGhlIGludGVycnVw
dA0KPiBoZXJlIGJlZm9yZT8gV2hhdCBpbnRlcnJ1cHQgaXMgaGVyZSBub3c/DQo+IA0KDQpUaGUg
Y2hhbmdlIGZyb20gaW50ZXJydXB0cyB0byBpbnRlcnJ1cHRzLWV4dGVuZGVkIGRvZXMgbm90IGNo
YW5nZSB0aGUgDQpzb3VyY2Ugb3IgbWVhbmluZyBvZiB0aGUgaW50ZXJydXB0IGl0c2VsZi4NCkZv
ciBmaXJzdC1sZXZlbCBJTlRDLUlDIG5vZGVzLCB0aGUgcGFyZW50IGlzIHRoZSBHSUMsIHNvIHdl
IHVzZSBpbnRlcnJ1cHRzLg0KDQpGb3Igc2Vjb25kLWxldmVsIChjYXNjYWRlZCkgSU5UQy1JQyBu
b2RlcywgdGhlIHBhcmVudCBpcyBhbiBpbnB1dCBvbiBJTlRDMCwgDQpzbyBpbnRlcnJ1cHRzLWV4
dGVuZGVkIGlzIHJlcXVpcmVkIHRvIGNvcnJlY3RseSByZWZsZWN0IHRoZSBoYXJkd2FyZSBjaGFp
biBhcw0KZGVzY3JpYmVkIGluIHRoZSBkYXRhc2hlZXQuDQpUaGlzIGVuc3VyZXMgdGhlIERUIG1h
dGNoZXMgdGhlIGhhcmR3YXJlIGhpZXJhcmNoeeKAlHRoZSBhY3R1YWwgaW50ZXJydXB0IHNvdXJj
ZSANCmFuZCByb3V0aW5nIHBhdGggYXJlIG5vdCBjaGFuZ2VkLCBvbmx5IGRlc2NyaWJlZCBtb3Jl
IHByZWNpc2VseS4NCg0KPiA+IH07DQo+ID4gSW4geWFtbCwgSSBjYW4gdXNlOg0KPiA+IG9uZU9m
Og0KPiA+ICAgLSByZXF1aXJlZDogW2ludGVycnVwdHNdDQo+ID4gICAtIHJlcXVpcmVkOiBbaW50
ZXJydXB0cy1leHRlbmRlZF0NCj4gPiBUaGlzIGFsbG93cyBib3RoIGNhc2VzIHRvIGJlIHZhbGlk
Lg0KPiANCj4gDQo+IEhtPyBTaW5jZSB3aGVuIHlvdSBuZWVkIGJvdGggY2FzZXM/DQoNClRoZSBv
bmVPZiBzY2hlbWEgYWxsb3dzIHRoZSBiaW5kaW5nIHRvIHN1cHBvcnQgYm90aCBzY2VuYXJpb3Ms
DQptYXRjaGluZyB0aGUgaGFyZHdhcmUgYW5kIHNvZnR3YXJlIHJlcXVpcmVtZW50cy4NCg0KZmly
c3QtbGV2ZWwgSU5UQy1JQyBub2RlcyByZXF1aXJlZCBbaW50ZXJydXB0c10NCnNlY29uZC1sZXZl
bCAoY2FzY2FkZWQpIHJlcXVpcmVkIFtpbnRlcnJ1cHRzLWV4dGVuZGVkXQ0KDQo+IA0KPiANCj4g
QmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==

