Return-Path: <linux-aspeed+bounces-965-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8D2C28B28
	for <linux-aspeed@archiver.kernel.org>; Mon, 10 Mar 2025 02:16:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZB0qg41nhz30Sy;
	Mon, 10 Mar 2025 13:15:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741572959;
	cv=pass; b=YDwNLS20eii84JrBh/Vn2huLpIh9as0TqseEymZBDlV1CJnT1BueVfAZZv6KGS51tRKZxEtKjBAHoiMdMZFaoUdo4OkqVknwKLcf4RalDfgarDMcH2EThIGZzl5G0RuFFZpOsjV4FgQvgheZ21mb7ZqHuGmS52QBftoazJY7yzcU2LzUY9i18mO8VzCMm40/Aq/wRpNYxROKB5+SN+NHbDEv/MyZbV/1xDcAqawIp/HNmbdXM3Ak/FI1HJJ07/SVaKaPEhAEp9o0Ws1jYSZ41hCnsIc63/88SV4T5QwVLDtcoFE8Wn6UT6Y7U0AN0QiwZ20RViAIR9Du7M6QqVlWCQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741572959; c=relaxed/relaxed;
	bh=ahyRE5mg4ZhW0B9srz8NAOxCqtEHretB32k9c1Ch9k8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FfFtGEKc6CEyvMINEAQpGxlBWqnSe/gASoez89beZSuy6lGYBKGYTNy3as/DHyCS/8bJKGAX2ed9UIzRp+a9mesczrNkQKf+BUqH1hodutNGXoBiIkJo8I6wl6RovBoUWzcDMS+0Xnc/ijZk+4Am/EnADhqsn2dD7QJrtLz6GUiOI5wycsnam0EUYJ3tUi9M/aY+IPNSVnEThPJ+1pmy54FwYYI1xWXX3nGhPbUT2vLxj22mFZ9URZJEPC+rDlPC40XikSdbS6qd+UB/Uo3lQytIoJOuvFuAoV0MhM1bP5gUMUT4Dxi4nm1srS7JOyY3ZlETMiVCh/Pg1IgEdXKo3g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=PytevGxK; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::7; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=PytevGxK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::7; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZB0qf4W19z2yk3
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Mar 2025 13:15:58 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epogSh97mDy6In2NbRh3KgEbJChdnJFNIHdkY9Aoo/59l1kv0raHKJFIH5mPc7QDTKNv4YlG8M0VS+tu6yBmXMzebh9muQ2p7r5itJbDK4g958qtKAGPcM+O6Uzazw4wPTlqvVzuFUqIK3Iyd0+AMZXwgZMvAF1AHEDSMCrGduRT0fOLOFOKDRxP+nMVBL/56seYc75KedoFFezsJQn7sR0ACZwkCBwPI8VfOvI2BReRp/Wu8SS+OXWmIiQRJpAP9//bxIxr6Zy5or3gI1Cot43u9Gdduqx0j10QWErwEiSFkdWcECQL7Hy5v3wdxH2a5srbn4uRCNvrDNKf+wQxeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahyRE5mg4ZhW0B9srz8NAOxCqtEHretB32k9c1Ch9k8=;
 b=aTYxIUZGVSursyCL4j/4NjP8FN+0CTa5JJY12hccrTLhsBptnO1JOozl6AhzeVB/9dfTQcgDQpY8dgoY1qT10e4tAqmYv70G/JNYMaLgJAMFsTRJfBnGKtX4esA7Z36z/kq0keIlK7WoTBZzg+a10QTT56Eh3K4Woz77KFHw++eTYCshA7XLMPKtWIOixEWNLgAO3WrhHQk+e6mtifbqxzsRyi6bFnUB6dEErHaSNdUKXuMoAPsMx2F0dZk5Ntndb/7zO6aU8qXQZPBpITBMyFB2/KEOaesWq8zz3f7ccKTiZfNTEESPoCybZ0kST5XHNnLMcl4F7otIjjIqi0439A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahyRE5mg4ZhW0B9srz8NAOxCqtEHretB32k9c1Ch9k8=;
 b=PytevGxKWXUCYSNc+w+gnpnbfk94JJ4JOnC7JkvDMrQHSeV0alBKcnNG85cJQah3aSnjuund1qHu8An4zSjSxTGF3RRQL4jdU6/MK1rjFhivb59nmlXYuvCJi8Nwg1ccfy4rztHNl5NVUzyGvz0i06U2io77ng7zDnBzLE05sjQkgg7cF3UEYVvkhhm5XvQfUQ59519B0b/tKPP8/viCSR0Mk8aIChSDUExJXiMIoudNfbkp1lLNxaZIOmATx8Z1ldEZOBzzKBzOHMpzeF52l8LJPPp0xjqD8keid/Anw87ueoj0jQuRQoH8g5dldhcO89ngi+jNcFdbc4QM1jxTew==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by SEYPR06MB5986.apcprd06.prod.outlook.com (2603:1096:101:df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 02:15:31 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 02:15:31 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, "lee@kernel.org"
	<lee@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "derek.kiernan@amd.com"
	<derek.kiernan@amd.com>, "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Mo Elbadry <elbadrym@google.com>
Subject: RE: [PATCH v2 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
Thread-Topic: [PATCH v2 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
Thread-Index: AQHbjPJ07+dHDPFFS0aC2kKgLnBNFLNjfMCAgAgtnJA=
Date: Mon, 10 Mar 2025 02:15:31 +0000
Message-ID:
 <PSAPR06MB49497EF12121AA18F21361A289D62@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20250304104434.481429-1-kevin_chen@aspeedtech.com>
 <20250304104434.481429-4-kevin_chen@aspeedtech.com>
 <7ef88ec2-24a5-4aa7-a601-d605a12768ba@wanadoo.fr>
In-Reply-To: <7ef88ec2-24a5-4aa7-a601-d605a12768ba@wanadoo.fr>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|SEYPR06MB5986:EE_
x-ms-office365-filtering-correlation-id: fb00b746-fa28-4e23-7880-08dd5f796ed9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?RmJnaGNJQ1cvSnk4Mm0xazdQQXdkckNaTWFsdTFyM05iVzEzTXhnRHZ2WlBG?=
 =?utf-8?B?TzJQNG5MV0JCYldMRnNmVkNOTThUaWtjbWduNHZIcU5na1dsUllxVmhxcFRx?=
 =?utf-8?B?VEJ6WmUwQVI5T0pEajVUd0wvRERmZm1LRFJuaVhJeWVsSWtFUWJkdDl2Sml2?=
 =?utf-8?B?UVZ6aHY1RUZ5Z3dsaWFQTktrN1FiV1cvbU8rdkgxcE83TkMwQTlnNnNXVlRi?=
 =?utf-8?B?ZzBuekJOeVRUVVBaa3lRVUF5QnFxQ3JRbHE2SENUSllrdkp5U2o0Rlo5MXRI?=
 =?utf-8?B?VDVTa2U4T0pVVXp6czVmUjBpRUtIMUhhTFhMOVJ0aTAzb3l1QjJmTWlPTEtt?=
 =?utf-8?B?MkFFRFVnemR6OGJsTnVGUmNVdzFaeG9wSFFLb2s0WnM5eXhIaDdLNmFGdXV3?=
 =?utf-8?B?S1A3TkNkT2crNjJqVlNJcFo1czJCRGNNcE80WDlxdVRyVURkcWw4WEkwbnR4?=
 =?utf-8?B?Um1TcElFUHRicHN1ckhTOXBYc3pkRFBYMWZlUmJxVGl3L3VSbjcvN05vaCt6?=
 =?utf-8?B?eHJPZHhCQThsenlDandsQ0RGOUdkME55SkRNL1ZZcmptNS9lL0V6eDY3VzNs?=
 =?utf-8?B?M1NQclRpY1AzNWM2UnQ0aWFQVjROak5udis4MDJFMDlWTEVXckhXNEpjYlJF?=
 =?utf-8?B?RFZpZ3lpQTh0cFE0U1RGVVY2MHV2TkRBY00yZzZyTURjajJQTnFZYjlVa1NQ?=
 =?utf-8?B?Mlp3UkFOeXV0c1JvejJ6OTRXSE1wVkFHQTh3V1VXM0hnSjQ4NVhaK3A2N0VZ?=
 =?utf-8?B?MXpDaW16T3paU0pxR3hNUVUzeDZBU3JoVDhWbVpIbGl6VjlDWVNhZnkySEtJ?=
 =?utf-8?B?M3dZWHlqR1A4MU5aTThGOFlkd21DQ05rdkNKRW9RNCtkTVAvMXNHTld0dmJ3?=
 =?utf-8?B?UTd2NG9WWXFVWjlLNkd0ZFhmQkJaR1dGNWpPYU1tSlNjcE1aU1YrK0hHL3E3?=
 =?utf-8?B?cC9uMjUyOUtBUGs0L3F6L1k2MXl6NU0yNm15aVhwaWo3WWxLTGhLODIvUzFC?=
 =?utf-8?B?R24zcVVXRkU2aFR1S3p6TS9FeUdhT3YwUXFKUGMrdG1vRHlEc05tY2F6eDRW?=
 =?utf-8?B?MXV2MElUa1YxTUFNdG9FNVNrZ1A5Yy9OQkdhNW5lOUtwd1JMU3hFZWczVUl6?=
 =?utf-8?B?RWU4ZDNIWEZaRnVGTHMwQjFkbFVpdSs5VUNjWkVUSWR6UnY3a1U3R0VYWVVT?=
 =?utf-8?B?RGlkNW93YzY2YVdVZmg4UGRDenc0YUlHb1dJSHFiZ2xPQ2xqY2M3VHdXV0lS?=
 =?utf-8?B?dlpnRm4rOGp3akJJMlJqenZ6NWQ0aTZPeTU5RkhMWFlxSkVBWXNpdlZXMzUx?=
 =?utf-8?B?TUp4dHQ2dTYvY1h5T2dDMGlZTldnWWlBaXl5RkhIbDdKT05JTlg0eDRwdlN2?=
 =?utf-8?B?MkZwTytyTnhpTlI4Szd1d2ZyeHhQMHUyL05QUHhMU0ZodFFhb2xyQi85UjJk?=
 =?utf-8?B?eG44VVdDY1M0UzJkQVRERGNxZEVsUlp5VUFRQllIOXkybU1aRTBlb1EzUHhs?=
 =?utf-8?B?WFltUmhHUVNMeW16cXhNQlV3NUR1amRuSkRPSEZEb0ltUzBTeVE4d0dXcm9p?=
 =?utf-8?B?Szc3Uy9PVFdQUmFtZVBybDRwVTQwVmp1SVNHdzRMS1RtZzAxYk40TDE1MUVH?=
 =?utf-8?B?eWF0dlpKWExSSzNiV1d6bTdzYzVJT1JHZnIwaEJ2K1FWbUxrNDAzWVBuSWc4?=
 =?utf-8?B?Zkxubks0c1EvdzJ0SDI0ZjhaUjlydXpEL3lTRDNqdkNKMks3eGZ1NEEzM2J2?=
 =?utf-8?B?bnkyTE02eFJITXh0eFFXRFhHbWsydHV3WEJRaE05cWtsYUhqSStKUUpWeXZX?=
 =?utf-8?B?c2ZpREx3T2V4RzEvWWVCUGkzYVpjNzl5RWhjVU5LMk5oRTNpOVNTV0tYeUhG?=
 =?utf-8?B?aFlJOUl5RzJHK3lYcGM5U2h6aXRseTlhZjNmNnJXbXFSUGovRmhXSDJTU1RI?=
 =?utf-8?B?SDFYWlY2aWt4aExkaWIrSmlIY0owa3JxdmhqQjFpM2xBdVJoenY4c1JxdS94?=
 =?utf-8?B?YmNhdmVqckJBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHRvR1c4dDFHTU1raWZBcExrMWFVTndVbE1qMzNIRzkzTmFTUHQwejVTN3Zt?=
 =?utf-8?B?azNlVzMwUERKOGFIMUxycmpHTGlwZ3g1TFV0blpGYVllRnhsVTloZndSendS?=
 =?utf-8?B?NmJidWl1U0h6TjZNSEZyTjRWT2hTWnJXVXRaOU5yRDY5ME8zK3RQcmhaZ2s2?=
 =?utf-8?B?VzZZdEZqd1FUbnF0U1dJRGRsZDdkYmx2K2xHVkVwUFE1SmRTSHNydm9RYnhB?=
 =?utf-8?B?VzdIYWNpcXJrb0JYckxXYXl5NkdPZmJ3OXpPMTRVT3BTc2dldXNNcnU3T1JU?=
 =?utf-8?B?RGJNc201Y3BudzRJcHY2Y2c1SHgzVWJnTXVCYjBxKzJGWERlelY4RkNPemN5?=
 =?utf-8?B?blUxREsrL0lEb1pqL2JKSDNBTFpJVmxlclRtdmlNOGZoZHoyWGgzakZjazQr?=
 =?utf-8?B?djdZME92V21NZW83UU1SbFJHaGlPYkp3YlNUNHh2WjZGdWNSSUZ1ZFNKbmlw?=
 =?utf-8?B?ajRFR0xPSExna0NhckZjSEtOZktHb2Y0ZEluQ1ZSd0F1YjlZUEVCUFVBSEhu?=
 =?utf-8?B?ZU9Ka3MzWWhIZWljNjdsdkt0M1hkUXRyWlorUjJlSldrRkFOV2VtOENoK1RZ?=
 =?utf-8?B?TCt6RVBXV2JucVN0L3ZpeXpCUlVuSmI5MkpuR2pKRnB5TTRrTC9FRjJEM0NQ?=
 =?utf-8?B?MFRjNWN6Y3lTUlBQMXhDOTB2cUJ4U3BpZmZqbEtJVURIbWZLZGhyMVJDTita?=
 =?utf-8?B?TW1neG92U2IvMXVzeklIQk5FdGttNGtONVlqbEJUS0Z1UGZsb3oxNnBKaUx1?=
 =?utf-8?B?ZXVUY2ZDelp0RDQwMjRCdG1meVJscUZrd3JpK1VzZEI0NkZRb291bGdBOVBm?=
 =?utf-8?B?ek9xRlp3Q1p3eUl3WnhlSUF1TEpxNEhWRTk0Mjg1cTZnRGZhdGZzdWdqZDBw?=
 =?utf-8?B?R3QrTEN3aWNHNFh3SjM5UG5TdjdUYmpoc0JacVNXa2ZycnNTZi9va04rdm9N?=
 =?utf-8?B?a1J0L0pUYkYweklPS1dZVHo5ZmFINWdNanMzMFBtZ1pxOHM3WUlJN01SOFpT?=
 =?utf-8?B?WmNxWGIwRGVleW1EakxLaXRmWmdVcnVodzFUZS9DYWpYblA0dW9naXFQZUFM?=
 =?utf-8?B?Tml5b3BPQnFCVThnTW02VHN2c2gwcURURExyd1dhbUoxTkFCRzUybG1zNTg2?=
 =?utf-8?B?N1FPbVh2MW03VW5tUjMrWEFITDRzb1llUEtsU1hITVRhRVJ4Y3VoRXJxVWRI?=
 =?utf-8?B?RFJxd2pWUktSbEZsOE1QYUF4WENTRkF3RkZkcXRRaUpTS3VPS09EamZLNkYv?=
 =?utf-8?B?bFlHU1FBU2s1UzRIR1VmdHRpdllMTlJYcnRjSk52dEp3Zmt1aXpMaWVteHVU?=
 =?utf-8?B?bHNYdXkxamFLbnFBVUtmT2cxZXhGKzFETFl4Tm9ySHg1dXJmcFBSUTRuTEFK?=
 =?utf-8?B?TFpzTW1YN0RJazYvREdPbE53VnlTcTZLSXNDSE5UZ1pzZUhGamQwMmFkUkxt?=
 =?utf-8?B?R29xK2l2Mi9aVGxEbkllZ0hTQzQ1SXl2NmQwaEdTaURXeCtOZktGa0ZNcmcx?=
 =?utf-8?B?RlZ0dVloWWF4MVh4cFBJcmZnTXkvMWtKYVo5c1dVVjMya280dGVKN295WTRX?=
 =?utf-8?B?QlNtK0xRYXBMU1pLRjNBbnZpUXB1RzRmSnNkOU8zc00vcnBmNlJzTERYNXlC?=
 =?utf-8?B?cjZ4ekVyWk40OFFJbENqRlB5aXF6ZkpIaWw3NENRcnFFNmRzTGYxUFk3akVl?=
 =?utf-8?B?a2tVb2VDakFVaGdmK3ZWa3g0UlBscG5MYk1XdVVLdUJmMWlZcTdTazdKcGVI?=
 =?utf-8?B?UVZBTXVIZXltWGF6S2k4VnptbVZpUUpOYjB0anNLZkhWRHF4Ym83OHZybThQ?=
 =?utf-8?B?aWhSWDJLVm9sbWFJTnBWVUY0V2pzeEJjOUY2SlZzTXBmVytjeWZvaitGZjVj?=
 =?utf-8?B?YmxMTHVZUGoydFJyZTVRZFVjQlZqeGtadDFNYnRTVEpkNm9pRGwvL3JmVVpH?=
 =?utf-8?B?cFJmbHladHJzS0RTSWRKRnM0NlZHRWlFQlp1RmJ0SEd5MWN3dDFtK0p4S1J1?=
 =?utf-8?B?Z3h0bWN0S2I0QUJxN2FXbjRESlNVcWtVWGNqVFlQNXZ3b3RrK2FIQjJ6UzFO?=
 =?utf-8?B?dE9FR0xjYTZXS2s5VW5va29rc3VtMUhBTzFjQWxmTjhNa1MvQXRiZVp1eUI3?=
 =?utf-8?Q?f2XizEUBncp9axhfbm7ioOwQi?=
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
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4949.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb00b746-fa28-4e23-7880-08dd5f796ed9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 02:15:31.1551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GPOJu9dRaQWlrFphPUMH/pXt9onprRv8CLtvMBIg6bgCZdsixUH6ImNhMOInBjM92sttZuJJ15NK8xn2IQ+E3UPf6bHHHT9G2M5OsPakM+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5986

PiBMZSAwNC8wMy8yMDI1IMOgIDExOjQ0LCBLZXZpbiBDaGVuIGEgw6ljcml0wqA6DQo+ID4gQWRk
IExQQyBQQ0MgY29udHJvbGxlciBkcml2ZXIgdG8gc3VwcG9ydCBQT1NUIGNvZGUgY2FwdHVyZS4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEtldmluIENoZW4gPGtldmluX2NoZW5AYXNwZWVkdGVj
aC5jb20+DQo+IA0KPiBIaSwNCj4gDQo+ID4gKwlpbml0X3dhaXRxdWV1ZV9oZWFkKCZwY2MtPndx
KTsNCj4gPiArDQo+ID4gKwlwY2MtPm1kZXZfaWQgPSBpZGFfYWxsb2MoJmFzcGVlZF9wY2NfaWRh
LCBHRlBfS0VSTkVMKTsNCj4gDQo+IE1pc3NpbmcgaWRhX2ZyZWUoKSBpbiB0aGVycm9yIGhhbmRs
aW5nIHBhdGggYW5kIGluIHRoZSBybW92ZSBmdW5jdGlvbj8NCk9LLiBJIHdpbGwgYWRkIHRoZSBp
ZGFfZnJlZSBmdW5jdGlvbiBpbiByZW1vdmUgZnVuY3Rpb24uIFRoYW5rcyBhIGxvdC4NCg0KPiAN
Cj4gPiArCWlmIChwY2MtPm1kZXZfaWQgPCAwKSB7DQo+ID4gKwkJZGV2X2VycihkZXYsICJDb3Vs
ZG4ndCBhbGxvY2F0ZSBJRFxuIik7DQo+ID4gKwkJcmV0dXJuIHBjYy0+bWRldl9pZDsNCj4gPiAr
CX0NCj4gPiArDQo+ID4gKwlwY2MtPm1kZXYucGFyZW50ID0gZGV2Ow0KPiA+ICsJcGNjLT5tZGV2
Lm1pbm9yID0gTUlTQ19EWU5BTUlDX01JTk9SOw0KPiA+ICsJcGNjLT5tZGV2Lm5hbWUgPSBkZXZt
X2thc3ByaW50ZihkZXYsIEdGUF9LRVJORUwsICIlcyVkIiwNCj4gREVWSUNFX05BTUUsDQo+ID4g
KwkJCQkJcGNjLT5tZGV2X2lkKTsNCj4gPiArCXBjYy0+bWRldi5mb3BzID0gJnBjY19mb3BzOw0K
PiA+ICsJcmMgPSBtaXNjX3JlZ2lzdGVyKCZwY2MtPm1kZXYpOw0KPiA+ICsJaWYgKHJjKSB7DQo+
ID4gKwkJZGV2X2VycihkZXYsICJDb3VsZG4ndCByZWdpc3RlciBtaXNjIGRldmljZVxuIik7DQo+
ID4gKwkJZ290byBlcnJfZnJlZV9rZmlmbzsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyYyA9IGFz
cGVlZF9wY2NfZW5hYmxlKHBjYywgZGV2KTsNCj4gPiArCWlmIChyYykgew0KPiA+ICsJCWRldl9l
cnIoZGV2LCAiQ291bGRuJ3QgZW5hYmxlIFBDQ1xuIik7DQo+ID4gKwkJZ290byBlcnJfZGVyZWdf
bWRldjsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlkZXZfc2V0X2RydmRhdGEoJnBkZXYtPmRldiwg
cGNjKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArDQo+ID4gK2Vycl9kZXJlZ19tZGV2
Og0KPiA+ICsJbWlzY19kZXJlZ2lzdGVyKCZwY2MtPm1kZXYpOw0KPiA+ICsNCj4gPiArZXJyX2Zy
ZWVfa2ZpZm86DQo+ID4gKwlrZmlmb19mcmVlKCZwY2MtPmZpZm8pOw0KPiA+ICsNCj4gPiArCXJl
dHVybiByYzsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgYXNwZWVkX3BjY19yZW1v
dmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgew0KPiA+ICsJc3RydWN0IGRldmljZSAq
ZGV2ID0gJnBkZXYtPmRldjsNCj4gPiArCXN0cnVjdCBhc3BlZWRfcGNjX2N0cmwgKnBjYyA9IGRl
dl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+ICsNCj4gPiArCWtmaWZvX2ZyZWUoJnBjYy0+Zmlmbyk7
DQo+ID4gKwltaXNjX2RlcmVnaXN0ZXIoJnBjYy0+bWRldik7DQo+ID4gK30NCj4gPiArDQo+ID4g
K3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGFzcGVlZF9wY2NfdGFibGVbXSA9IHsN
Cj4gPiArCXsgLmNvbXBhdGlibGUgPSAiYXNwZWVkLGFzdDI2MDAtbHBjLXBjYyIgfSwNCj4gPiAr
CXsgfSwNCj4gDQo+IFVubmVlZGVkIHRyYWlsaW5nIGNvbW1hIGFmdGVyIGEgdGVybWluYXRvci4N
Ck9LLCBJIHdpbGwgcmVtb3ZlIGl0Lg0KDQo+IA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGlj
IHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgYXNwZWVkX3BjY19kcml2ZXIgPSB7DQo+ID4gKwkuZHJp
dmVyID0gew0KPiA+ICsJCS5uYW1lID0gImFzcGVlZC1wY2MiLA0KPiA+ICsJCS5vZl9tYXRjaF90
YWJsZSA9IGFzcGVlZF9wY2NfdGFibGUsDQo+ID4gKwl9LA0KPiA+ICsJLnByb2JlID0gYXNwZWVk
X3BjY19wcm9iZSwNCj4gPiArCS5yZW1vdmUgPSBhc3BlZWRfcGNjX3JlbW92ZSwNCj4gPiArfTsN
Cj4gDQo+IC4uLg0KPiANCj4gQ0oNCg==

