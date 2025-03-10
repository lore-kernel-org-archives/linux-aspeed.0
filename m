Return-Path: <linux-aspeed+bounces-964-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFCFC28B2F
	for <linux-aspeed@archiver.kernel.org>; Mon, 10 Mar 2025 01:51:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZB0Hl1JLVz30Sy;
	Mon, 10 Mar 2025 12:51:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c400::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741571507;
	cv=pass; b=cGPxCBpXR+vum/2ycGev0rGfo05yEcCCKmX6duHxsmxBpYLOtPxGVzZgor6At6H+8giL74chtdZCkDwe+bEOI6CFdVXx1wHYZtU3T8JwWnRv9FVxCZHvpxHxpzPrqjCV52XNiUqe9o1JjJAzX6a/rw2Ltk/nZYfe01ptmGr7LIG/6gFQXDglq0CiiwtWrHaI1bLJsqfqgiU+qhQ35xzbfBh5DUwsV75/ByXroeINNnQKnvOB36Y+uD4+5K9OIFeOcEitaT4deYHlAB0WVXjSifJZMg7b4pOJJ6Q/yPW3gROFW37cbisQyvYGWtNK92dfwvfuysNGN/Qhcl0EeTz+wg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741571507; c=relaxed/relaxed;
	bh=LhsXnJ1V9R8AdOq7sKDQHwG522hLaPdnQRRFw4kL56A=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mwGcZ+80Lob/iTcwH/X3n+pHZ6jUP6yanJZK693Xc6szVI7CVt/zuE9Bk4843lL+3IT7fO+ukZ376PMjYOctgDEsHqck/RPnxEzokuCj78VlH+0c4Gjos2f8H1GaJxSVH+VrFlJ3ZBTgxu1vF3Y5zYCXgh7506BBUhLplNccSE6pY9IpYZAfDRb/Vx2Yp/4JBqLt4njDZTonqN8CkUKdg6XEQMAuUs9ooM+/HjgzncFDpjzwX07apSXKh6HedO5j8qOicG4jtqzpuXNO+r0jtrQSI4cYuGzOUt59YI0yY0um8Wgudd2ka1t/ORuYwBMTv8wKNbpzoqMSj9obQhwYbA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=2a01:111:f403:c400::2; helo=hk3pr03cu002.outbound.protection.outlook.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c400::2; helo=hk3pr03cu002.outbound.protection.outlook.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c400::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZB0HL4jMKz2yYJ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Mar 2025 12:50:59 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPGTmNhGc+XK8y9LWFCHv7mo50xCcq7n0rcI8Isjv9XNgx4QAIhc7bFb3nUlRyar8lTARsth3OLMg834RpVIM9qUGpU+8/cnuDHi5yyaKmkYqbL2P4AingRtN6EYs6YAm7ZLEMloWnaWlxo3Rw/TKNZUWwsckZS4z9eBXX3QDA0mwjKPQ72h35RIaMOSrnJ9mnpWw0ibqeHyybk1tijsNOjIX2bE/yAhNSLTt/0oaZDgqI/KLTFvff1jkYlP7gKgkWfR26G9Zgb0mtgBGQm9EFsY81HR5BxzLqQXlqNkd3yvGAUEOaJWsgMVshq2ZX3hk6knHBr2PKfhJG3akPPmcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhsXnJ1V9R8AdOq7sKDQHwG522hLaPdnQRRFw4kL56A=;
 b=TGEt/kiYWNQx6zQaD/T+p5w58Xl45jLSWMcGmII62zUi7NSiF6v7QohsmH1DvJ6C7f5yrQg73gOP6TK2gS9dvo+xMqDYvn+lNI5bKrGJrVGJeYSGrWVBwrjlMiIDfvj0nDPZPYizC5SMiD6jyy11c8MjnzVWXHNVQHO9Ro5VkN4YSPjidk6y5jCTu1IhuV38EkNP13u7UV59ZsjOhVLtwrYAuwhKQMv62t2p/bkOtlhEX1BdHmX5cj+9NlT7nbMxE3x2DRx23gn6uIkesBX5dpv0i7pMtOG0adpH8kIPjS3cim3+f+FFlVRw73K8gP6NAaeHfxQO3K2s+KG/RbBLVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhsXnJ1V9R8AdOq7sKDQHwG522hLaPdnQRRFw4kL56A=;
 b=FD5WLoyym2h+lVXW72NW7iDeqXXCVkYiF4g1IRzxzgW7ItVzyJBUGyhUHHI0sSpM//EdqjGPtenvuE69BjSWbmSiUiXFpkdrv4YvOUW6ews5favaM64+HPVIo+vbGVwcNOzwDi5gmizlN4n3DZa8b30/PLKt/elev4pahWBDQN7Rp/ljKh9aO5T1ENw42Czq19mhvUW0VqN6l96VrYB9L8xnuVLYOWu8vFUWt6V+FcTY78QhTqvYzmCk7fyiyN2QjHjdB8bMbu2ZBotfbUSd8UN6b3dxKlu6FOdPgKTlPaU/U4OomTjmqUgKkQVp4J1Xcr4yS1TqzYWiiEoSzuxRhg==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by TYZPR06MB6141.apcprd06.prod.outlook.com (2603:1096:400:343::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 01:50:30 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 01:50:30 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "lee@kernel.org" <lee@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
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
Subject: RE: [PATCH v2 1/3] dt-binding: aspeed: Add LPC PCC controller
Thread-Topic: [PATCH v2 1/3] dt-binding: aspeed: Add LPC PCC controller
Thread-Index: AQHbjPJy2F3uXFUe20eiIvujFTWQbbNkGJyAgAeEr9A=
Date: Mon, 10 Mar 2025 01:50:30 +0000
Message-ID:
 <PSAPR06MB494973DC08A8105EA05FBE6D89D62@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20250304104434.481429-1-kevin_chen@aspeedtech.com>
 <20250304104434.481429-2-kevin_chen@aspeedtech.com>
 <8740eeb8-9467-48bb-a911-e70c3da3c45a@kernel.org>
In-Reply-To: <8740eeb8-9467-48bb-a911-e70c3da3c45a@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|TYZPR06MB6141:EE_
x-ms-office365-filtering-correlation-id: f7489ff1-46a3-47ad-57bd-08dd5f75f02a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?SmhSdmY1VDdnb2JBVnJxc3pvNU1aWTFoeFV4ODNCMW5yT1VxRERkWlBoRFNo?=
 =?utf-8?B?Vnh4Z2pPdDN2SHQ1NU9pZmZJaU8rQlJwN0FzeEJMYUJ5WmtzUVNEREhuNDUx?=
 =?utf-8?B?REpXekhzUDNObkhzV1NrMzMvRTBab0cxTDRIYTdHQlhYWTdZL1psczd0eVoz?=
 =?utf-8?B?RlArSEtPUWdoN3d2MVF2aVdVWmRZblVlV3FFTGhkblBlZ2RJTEIxWm1GRWp1?=
 =?utf-8?B?VzRJMEZRUG9XaER0Vm9wQVlqUTVjdGc3OHlldlYyTXBYcWZJdkNRaDBlNzdJ?=
 =?utf-8?B?cW5YSllTY2VqanFEZ1dIeUxEbjV1T3hqMEc4MFRaSlY5bzJKRWJtbWs4TGZy?=
 =?utf-8?B?S0trTXBxcDMzZDcrQ05OUUZMNXVHTE9lQkFTWkhZYlVSRmFZU2ZTQU5qNjd5?=
 =?utf-8?B?bmovT0oyaFA1VS9PQWZ2NzhrS1VVcmJQNFM3M3BMcFZmcEpyVWRwYTBQUHhY?=
 =?utf-8?B?S3FJMGRwMHo0NWFiSUlxVHpxUlZCOGhVeGRYWXJDSHhkb2hJaEJxQ2dPVGJv?=
 =?utf-8?B?dVphTkkyT1g2WDQvNllCd0hJTmxPbk82Skx6YkFzc2FpM1RDMEJSN2ZYVXJr?=
 =?utf-8?B?am1NMTJlcGZMUm45T3BNb21Cby81Q0tuZEFmK2FKaDUzOTJOUE1sUkRpQWlh?=
 =?utf-8?B?azZlRUpsZk5nM1pRTlI4aEhNUHlZNXN5bEQydlRjcWlYQTNMQ3VHczF4bDB4?=
 =?utf-8?B?eFpUUGRxVlNKdnM3TmpJRDNZSXhzZHdRWmNSYllaa0ZUVC9PcFNwWmpCdFFv?=
 =?utf-8?B?Z0I5SlVwWldnaVA4VDhMM3ljRW5OMTF1T052anFyekY5Q1BoaU5ubWdmMHNl?=
 =?utf-8?B?ODJjMFhZd2tqUVN4LzBXZlZHS0NUWmIrNVVpYjBkQzVMRGJLMkx0dkovTmNz?=
 =?utf-8?B?eHNqUVhFSktpaER1OW9tOWxEbGJ2OXBYMUg3NFpCQk9BTTRXQmtkQjJPdkdI?=
 =?utf-8?B?WXJqN0pGOFdNWmVud3pKb0VEU0NwUTBrbTV0cEUwNDRmNUxpZ0N4ZFFkT0Ez?=
 =?utf-8?B?UFBUTXZ5Sko4RFdCcHVKWnVJTTdpMGs2UFQwUFd2RXdsYUY2aHF4TjJ1VUdP?=
 =?utf-8?B?WElIK3ovUjRZMVBlUGE3VGEwclJlZEdjOXp1ZkFuVzZGMitkc1pUWXU0by9w?=
 =?utf-8?B?UWJXSVc1Q3FZczkvZHl6elJTMURrUDZFaHdOWTN3MGdoSXYyQWpFbzB4blhB?=
 =?utf-8?B?MUlDbnNEUTF2TlR4NjEzbkJFc0EvalNLdE8rSWQ4NTExMTU2R3VaYUIzMUZl?=
 =?utf-8?B?VlBwQXMvQm9VTldqbTQ3VFh1QkpUQ3I0Q3R2MlV0cU53T3Z0STU1OUJ4a0lV?=
 =?utf-8?B?WnpjZ3l4ZnpGeERYdjZoSHI1M3NVdnRnaDR6T1NDTmdmUEk1THUyR1BNemx6?=
 =?utf-8?B?UGZIdGw5R01pekZpSTRqVk0zcWpXMVBQZkJHdnlvRTl0cDB1b3QwOFpCUHhS?=
 =?utf-8?B?ZTh3VzRhdXBXbmRvT2hKdi9xZEtxamw5U0VSQkpVL3lnTFNPWEZ0VFNwV24y?=
 =?utf-8?B?WmpqNUxYbll6ZFdLUE5DWjczeGhSUGk5WkdwRnFLY29uL1R3RENQOWw3d1J2?=
 =?utf-8?B?ek1PM1djQ2pza1AyVmpUVWtoa2tHbm9GcFA0eVNyR3N4cGsxUzEvVU56bFJR?=
 =?utf-8?B?ZjZwaFhDYTU2SnMza2xPRmtlczJmTXlRSTlHNmxnb0FWOWkxejMwbElLODBR?=
 =?utf-8?B?b3dYTytjY3BwSTBqODNZbEFHZkcrR0hJWUdtWFUrSzlSdEtWRDZPS0M5b0FW?=
 =?utf-8?B?TS9RdDVyL3NMOWYwbjdJQjFZaENzTFA3bjNJKzNkU3JqbzhON0pXaGYxYm91?=
 =?utf-8?B?M1NFS3lhSXN3K1FLSDNzYWhlYktmeGs4SVlLNDBCSmtlWVZrRXUwTEZtaFJz?=
 =?utf-8?B?R1Z2L2t1UTVCUGdkbzA4RDFaQk02dTM4MW1NSnVrME90Q2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bkVxVGIvWDFrcGFuS0YzTUptaTZ3ZlQvclZjL3JudWlUdncraStEYjBHMkdP?=
 =?utf-8?B?V2xvbkZsakV6T0U3RHBtOFdwd093UmIzYUZPYzFUNzFkVVQxblpnenJ3Zk9E?=
 =?utf-8?B?bFArQmdkK05kUEtEeTRTNXZ0Unp2dFlFaklvUmQ3OFRESDBVYWRPSWpOaGFB?=
 =?utf-8?B?ZzRCOGpHb2JuLzA1bmFXQXFUUDd1TmMvY20zMlpiM1dqZnY2dmVjdWNWUzVK?=
 =?utf-8?B?K3ZKWXF5TGxmNmRsR240Z3hyNUxlOUI5L1BueG1JSXRBU1M4VDZ4c2R2RjJI?=
 =?utf-8?B?QkdrbGZCb01vd0RzZzUvY2ZBTGdOY1RTYklzbWFSaW4yOUtENUltb05ibDR2?=
 =?utf-8?B?UVF2SVJLNnI0R3RnZHd4MlNQK0t4Y0hvQ2p6a3lKMEdTOXk3NEIxQzBUdEdl?=
 =?utf-8?B?a0hJYUpqYVVxT1RUY09Jc3VqRGRPT2hjMWFVSUxyYXF6Sm5HZXRLU3BVUU9B?=
 =?utf-8?B?SytxcUg4N1N0UUt4NzJvZUFCNnVUdTRjVDM0d0s1S095MnBrck5oa3kzSTYx?=
 =?utf-8?B?SGg4WTZULzc2b01PNXQ0ck1aWmxjSG95d0hoWnU2NWt3R2xCRW9pNWJHcGxw?=
 =?utf-8?B?T0RhekhBblphdTJEKytLbTVjcUhxRXNVVy9iSVVET0xlR2lCV3FUZmhTbW5N?=
 =?utf-8?B?b3k0RE9FYXdjdWE4VTY2THlhQjlFMmR3VzgxdXZRMjltbHFlNWJ2M3RiN2hD?=
 =?utf-8?B?dGNlajJVM3VndU9xWjVsSFpGdDVFdTU4WkNzRUhFV3FPdTZzSVNnQmNyc21a?=
 =?utf-8?B?YVBGU3NqdjNSRFhHSHhPZUtPbHBwdmh5S1pkR2NNZ0NnL0lOV1VsbHVhOHd3?=
 =?utf-8?B?bkgxd3Fkd0pGQ2tyclhmY3NZYTVqUGNmcFpla1FHV1lESVI5UDNncm1QVkxk?=
 =?utf-8?B?bFQ0c01iczlpT2pTRkVOWktsaHhXajZHbGRkNmd5ZW1CaUswSlNKUEVwaGNr?=
 =?utf-8?B?OHN5RlJDR2tNVzNzbzBFVzdlZ3FWTm4reDV3Sm9SalN6NVIwek9DZ2RQekd4?=
 =?utf-8?B?a3BXY09MbDVueHQzVGE1YWZ2S3lmUnlZck4wMHYyOG1kM2orenc2OGcyVnNw?=
 =?utf-8?B?Z3ZVNC96T20xM20xK1NWb3FjYnRYaUdsMVAvVC9VMXBnejJGZ0tUWXpxQnU1?=
 =?utf-8?B?NTNKa20rSW8vcUx4cXd6UHhHQkdVVkZJeXU2N25GZlpvYVJzL2Y0bEt0cVZu?=
 =?utf-8?B?SE45M1UyQUIvSmVsVnZrNWV1WWJSQlorMDA0N3ZmaUo2cVlZcy93TzIvTGdD?=
 =?utf-8?B?UmhIUlJQZ1AxdHhzaWU4VGFrd0FWVUc3MGxOYVpDdE8xWG9MUWFhbFBQYmVG?=
 =?utf-8?B?R25QcVJ5dm40MnpMRjRSUHFiSlBpMjJjdUUzWVhqMmZpT05CekJYSUZRalBH?=
 =?utf-8?B?TEo0UzNNZS9ZQnpaMVNPR0hzbmNoVmRDcXh3aGExYlBoNmY4dlF1SEljdmcz?=
 =?utf-8?B?V2ZIbCtiQ3QzblhGUEkraTE3aEwzQWl6QS9mclVnUHppVzM5dyt5NzFlNzVu?=
 =?utf-8?B?Sjd1V3NsZjE4ZTBadkZyalZmcEU3UDZnR09HKzk4RjZRYTk3TVRFaC9TOHBO?=
 =?utf-8?B?aUZqM2dsaG4wN2ttaDhranNjL0RnL1F3c1Npd1pDUGlrRjlPVE5SZ1dqV2xM?=
 =?utf-8?B?KzBOcjZOSXBEZEhXWHh5VHhVZmw2U3NDZW9ZTDkwSVk5ZEhIbUZ6NEt3Slp0?=
 =?utf-8?B?V3JvSWovMGxmRE9PZHdpK3NjSmprTDRITWNMMzdjaFkyaEdCYnhCN2JFRlVH?=
 =?utf-8?B?Nm1pYXhicVpWVlBvcmN5dXdOeUxTeDUxUHFkWnZNeWUrZFFjT00vdzlIYUJI?=
 =?utf-8?B?VXZGNHdtVTFCRzNFRnZLTTlGOFUyWHUwQmtrdDZ3K0VOeStKQ2FCY3VKWWhh?=
 =?utf-8?B?d1VEb1pCSTV4cCtTRUtkNGhIZWlGVVU1Q056UitzSWNsWmYyOVc5cnpGc3NE?=
 =?utf-8?B?M1lIZk9KOG5Ib2FXY0puYmxmR3NVa2dKemQ2RnpscXdFRTYwQkx6QlJ3anZa?=
 =?utf-8?B?bnJQYTdMK292aWYzMXRHVzFtVGxPUjVZUEgramJjSkg1eEpvMDl6bkZjOThT?=
 =?utf-8?B?aGpya256K0FKUllVWGRmd3lGSHBIME10NVFpZllkSzlzeHJYb1I3ZkQ3M3hS?=
 =?utf-8?Q?zHo2y7Qp8/80NxHPSzR+Ci0Gq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f7489ff1-46a3-47ad-57bd-08dd5f75f02a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 01:50:30.1430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p0ZNHGFQw+f87kJZ/YkBPrZR2/JHK5W3Ra/48axKcDpcSQ4/Bzk2xa/AYT0GlZ+s7vIqCaBVVu7HRRduJ8bpe7L9y5ER7Yw8HAGlNLDRFBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6141

PiBPbiAwNC8wMy8yMDI1IDExOjQ0LCBLZXZpbiBDaGVuIHdyb3RlOg0KPiA+IEFkZCBkdC1iaW5k
aW5ncyBmb3IgQXNwZWVkIGZvciBBc3BlZWQgTFBDIFBPU1QgY29kZSBjYXB0dXJlIGNvbnRyb2xs
ZXIuDQo+IA0KPiBQbGVhc2UgdXNlIHN1YmplY3QgcHJlZml4ZXMgbWF0Y2hpbmcgdGhlIHN1YnN5
c3RlbS4gWW91IGNhbiBnZXQgdGhlbSBmb3INCj4gZXhhbXBsZSB3aXRoIGBnaXQgbG9nIC0tb25l
bGluZSAtLSBESVJFQ1RPUllfT1JfRklMRWAgb24gdGhlIGRpcmVjdG9yeSB5b3VyDQo+IHBhdGNo
IGlzIHRvdWNoaW5nLiBGb3IgYmluZGluZ3MsIHRoZSBwcmVmZXJyZWQgc3ViamVjdHMgYXJlIGV4
cGxhaW5lZCBoZXJlOg0KPiBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3N1Ym1pdHRpbmctcGF0Y2gNCj4gZXMuaHRtbCNpLWZvci1wYXRj
aC1zdWJtaXR0ZXJzDQo+IA0KPiBNaXNzaW5nICdzJy4NCj4gDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBLZXZpbiBDaGVuIDxrZXZpbl9jaGVuQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+
ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXNwZWVkLWxwYy55YW1sICAgfCAzNg0KPiAr
KysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCsp
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21mZC9hc3BlZWQtbHBjLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9tZmQvYXNwZWVkLWxwYy55YW1sDQo+ID4gaW5kZXggNWRmZTc3YWNhMTY3Li4zNjc4NDdi
ZDdlNzUgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21mZC9hc3BlZWQtbHBjLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbWZkL2FzcGVlZC1scGMueWFtbA0KPiA+IEBAIC0xNDksNiArMTQ5LDM1IEBAIHBh
dHRlcm5Qcm9wZXJ0aWVzOg0KPiA+ICAgICAgICAtIGludGVycnVwdHMNCj4gPiAgICAgICAgLSBz
bm9vcC1wb3J0cw0KPiA+DQo+ID4gKyAgIl5scGMtcGNjQFswLTlhLWZdKyQiOg0KPiA+ICsgICAg
dHlwZTogb2JqZWN0DQo+ID4gKyAgICBhZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4gPiAr
DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgVGhlIExQQyBwY2MgaW50ZXJmYWNl
IGFsbG93cyB0aGUgQk1DIHRvIGxpc3RlbiBvbiBhbmQgcmVjb3JkIHRoZQ0KPiBkYXRhDQo+ID4g
KyAgICAgIGJ5dGVzIHdyaXR0ZW4gYnkgdGhlIEhvc3QgdG8gdGhlIHRhcmdldGVkIExQQyBJL08g
cG90cy4NCj4gPiArDQo+ID4gKyAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICBjb21wYXRpYmxl
Og0KPiA+ICsgICAgICAgIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgLSBlbnVtOg0KPiA+ICsgICAg
ICAgICAgICAgIC0gYXNwZWVkLGFzdDI2MDAtbHBjLXBjYw0KPiA+ICsNCj4gPiArICAgICAgcmVn
Og0KPiA+ICsgICAgICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgICAgICBpbnRlcnJ1cHRz
Og0KPiA+ICsgICAgICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgICAgICBwY2MtcG9ydHM6
DQo+IA0KPiBNaXNzaW5nIHZlbmRvciBwcmVmaXgNCk9LLCBzbyBJIG5lZWQgdG8gYWRkIHRoZSB2
ZW5kb3IgcHJlZml4IHN1Y2ggYXMgImFzcGVlZCxwY2MtcG9ydHMiLiBSaWdodD8NCkJ1dCBJIHdh
bnQgdG8gY2hlY2sgdGhlIHNub29wLXBvcnRzIHVzYWdlLiBJbiB0aGUgSFcgY29udHJvbGxlciwg
dGhlIHVzYWdlIHNob3VsZCBiZSB0aGUgc2FtZS4NCk5vdCBvbmx5IGFzcGVlZCBidXQgbnV2b3Rv
biwgdGhlcmUgZXhpc3QgYSBIVyBtb2R1bGUgZm9yIHRoZSBzbm9vcC1wb3J0cyBvciBwY2MtcG9y
dHMgdXNhZ2UuDQoNCj4gDQo+ID4gKyAgICAgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMv
ZGVmaW5pdGlvbnMvdWludDMyLWFycmF5DQo+ID4gKyAgICAgICAgZGVzY3JpcHRpb246IFRoZSBM
UEMgSS9PIHBvcnRzIHRvIHBjYw0KPiANCj4gRGVzY3JpcHRpb24gaXMgdG9vIHZhZ3VlLiBXaHkg
d291bGQgd2UgZW5jb2RlIEkvTyBwb3J0cyBhcyBzb21lIG51bWJlcnMNCj4gaW5zdGVhZCBvZiBH
UElPcyBmb3IgZXhhbXBsZT8gSWYgdGhlc2UgYXJlIHBvcnRzLCB3aHkgdGhpcyBpcyBub3QgYSBn
cmFwaD8NCkZvciB0aGUgcG9ydC1tbWFwZWQgSS9PIGluIHg4MCBhcmNoaXRlY3R1cmUsIEJNQyBu
ZWVkIHRvIGhhbmRsZSBzcGVjaWZpYyBwb3J0IEkvTyBpbiB0aGUgcmVsYXRpdmUgSFcgbW9kdWxl
Lg0KU28sIEkgbmVlZCB0byBhZGQgdGhlIHBjYy1wb3J0cyBwcm9wZXJ0eSBhcyB0aGUgc25vb3At
cG9ydHMgcHJvcGVydHkgaW4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9h
c3BlZWQtbHBjLnlhbWwNCg0KPiANCj4gTWlzc2luZyBjb25zdHJhaW50cyAtIG1pbi9tYXhJdGVt
cywgZGVmYXVsdHMsIG1pbmltdW0vbWF4aW11bSBldGMuDQpUaGUgcG9ydC1tbWFwZWQgSS9PIGlz
IGRlZmluZWQgZnJvbSBob3N0LCBCTUMgYXMgdGhlIGRldmljZSB3b3VsZCBjYXB0dXJlIHRoZSBw
b3J0IEkvTyBmcm9tIHRoZSBwY2MtcG9ydHMgcHJvcGVydHkgZGVmaW5lZCBpbiBkdHMuDQoNCj4g
DQo+ID4gKw0KPiA+ICsgICAgcmVxdWlyZWQ6DQo+ID4gKyAgICAgIC0gY29tcGF0aWJsZQ0KPiA+
ICsgICAgICAtIGludGVycnVwdHMNCj4gPiArICAgICAgLSBwY2MtcG9ydHMNCj4gPiArDQo+ID4g
ICAgIl51YXJ0LXJvdXRpbmdAWzAtOWEtZl0rJCI6DQo+ID4gICAgICAkcmVmOiAvc2NoZW1hcy9z
b2MvYXNwZWVkL3VhcnQtcm91dGluZy55YW1sIw0KPiA+ICAgICAgZGVzY3JpcHRpb246IFRoZSBV
QVJUIHJvdXRpbmcgY29udHJvbCB1bmRlciBMUEMgcmVnaXN0ZXIgc3BhY2UgQEANCj4gPiAtMTc2
LDYgKzIwNSwxMyBAQCBleGFtcGxlczoNCj4gPiAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwxPjsN
Cj4gPiAgICAgICAgICByYW5nZXMgPSA8MHgwIDB4MWU3ODkwMDAgMHgxMDAwPjsNCj4gPg0KPiA+
ICsgICAgICAgIGxwY19wY2M6IGxwYy1wY2NAMCB7DQo+ID4gKyAgICAgICAgICAgIGNvbXBhdGli
bGUgPSAiYXNwZWVkLGFzdDI2MDAtbHBjLXBjYyI7DQo+ID4gKyAgICAgICAgICAgIHJlZyA9IDww
eDAgMHgxNDA+Ow0KPiA+ICsgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTQ1IElS
UV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+ICsgICAgICAgICAgICBwY2MtcG9ydHMgPSA8MHg4MD47
DQo+IA0KPiBTbyB3aGF0IDB4ODAgc3RhbmRzIGZvcj8NCkhvc3QgYXMgeDg2IGFyY2hpdGVjdHVy
ZSB3b3VsZCBhY2Nlc3MgdGhlIDB4ODAgcG9ydCwgd2hpY2ggaXMgbWFwcGVkIHRvIHRoZSBCTUMg
UENDIEhXIG1vZHVsZS4NCkFzIGEgcmVzdWx0LCB4ODYgY2FuIGtlZXAgdGhlIHBvcnQtbW1hcGVk
IEkvTyB1c2FnZSBhbmQgYWNjZXNzIHRoZSBCTUMgZGV2aWNlLCB3aGljaCBpcyBuZWVkZWQgdG8g
a25vdyB3aGljaCBwb3J0IHVzaW5nIGluIHRoZSBQQ0MgbW9kdWxlIGluIEJNQy4NCg0KPiANCj4g
DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=

