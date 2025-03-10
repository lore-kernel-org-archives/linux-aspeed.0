Return-Path: <linux-aspeed+bounces-969-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79601C282DE
	for <linux-aspeed@archiver.kernel.org>; Mon, 10 Mar 2025 10:07:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZBCHM0zRRz305v;
	Mon, 10 Mar 2025 21:07:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c400::" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741601231;
	cv=pass; b=R47bLu759fjb52ycyed3FdicIPd8RbFtIOkvwHoFpMpwKW1GcqsGb1pfYtLF8ka21+O+81aDZq8F+0HMSZgQ0iV5aCiWnuPRJhRWCrkMRtLyWQr2Mr2l7qcLX0pNDeN0R+HFCOK7vFCuSHEmIl4wBjhlmRaR1BNgjcM5kVKOq03U9sygVEcBALu2MGBNQ6MGsQ4S175YZQeeH2TdHLCOdjEF8FcQESl3UljwEfcZhJTEFzQwlfUrvPSlVqJbhz4tUz2l7gsodLQUujt5aQ/y5eeDYPjBcqOdZQX/i8wXJGalMSwr6axXebR2EwE2VoNUAViJardK8YKGICAxUmTxsg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741601231; c=relaxed/relaxed;
	bh=2Dgle5P3U1MzK+6xHt8YWyjEs+e7W7Ij3psohh3sMHQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UD8mXxg3QAKj7keW+NNbrpf6+6CHJ38bw2K786spnjaZYZ3IPS+rn9El7XcUXnZAzEwqwZ44J9tvKxlb525bwrKqGl/cQiS3OhD5ZTykin3wVqTHJvUCE0uyHh+GIynvCi2yVUTDODzXCKeLSbXS7siPGEkAJgOCTaFugkcx+8lT3RUQVfQAEiQaLbGUYwx2ZwRoG78s2mZ5r0+YuU1YVgu3GKrEUMgq2Ts0af0J5/ftQoJC4ZLlFd0TS2beJ7B69aeUpUch/K+4mq34yAFSHic2vlByuQ+M0Z/7uQvArz/X68orsiK+QuPn1NXFBgSCgG04J7wgmJF8Cd4LpVyKXw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=JvtybVlE; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c400::; helo=hk2pr02cu002.outbound.protection.outlook.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=JvtybVlE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c400::; helo=hk2pr02cu002.outbound.protection.outlook.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazlp170100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:c400::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZBCHK6Wdyz2ykX
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Mar 2025 21:07:09 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhMo4ajf9+Qk6PZjZC4hvQ5UWN3pGG1CICM9t5Nn9lSOiC9tJNnVnC2gm8YQQawiUNKGMctlvLN47EkkQbQ9MFRDMJ+SHYE58PaEd35Ds2bZydqQX+TDL3Lsu1G+BfMaVfVsB9BSPFfKJDzvRO0OaXsZJ4OHHT+pqqwZvLZC3aY0WPgVoAYwwgKtbpfDlXAEWaNInKmITo2upcKLhNxd2k0RUUxuR/igMyl/lwT2L3qUTTSGoY5HH3JlghuM0ZoIupHEKGHza35Q7UgDKoCD4x3BuiofqkGvc1xPcTDTuhP71jHAtYXQZ1HKAYXxX7O4KDWVVhYWMVeOB1kzUThorw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Dgle5P3U1MzK+6xHt8YWyjEs+e7W7Ij3psohh3sMHQ=;
 b=Q8QnybkZ4ipf0RxBsO+dkM7cA+EQbvOP9He355C4Gr1D+cS0dJXLY2lLIP6WW/rXF3DlsH38nFosL4fkaCFCqvzHkD17X8+52GrDPgtomvUrW3PQioYetS0whDTcfSEpm2VuI4FNlU5LyC7So7uFC8FeQqtvQxbja2D7wOWJsdKUnfsDwrzv3r60Ld58ZV1n4BHjksM0oR+7TsfIP17TMWsrTEJoTHI48DI0lQZI+fbwJ1d0hlZJ2mjF8v4s5cCAgybyra19bKDg8xvE1T38krZyUkdaG/hZHsCZ5DiVN4uNADahitiwhicz1RWZwc/b3zyXNjQF/72U4+3wHbHkhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Dgle5P3U1MzK+6xHt8YWyjEs+e7W7Ij3psohh3sMHQ=;
 b=JvtybVlEHq5rZghD3hUZio31Tv4aUK3ft50v/ezpS4KmU5r0nlfKPkYceDoGps2o4AmGPlFYL4QFj2IkJZkYZMpmQqHQUg6TpwchSnAy15LQziN/SBtJozKEYOoQTmueDpB5UH+eAqR0jXej3lt+hMcafjmrBvxrlS+MpGmZcTqCq9xV701PtYCFn/dqPX7Ky2re472LAOU/OUAqAvlrEDr6UprXLJQUQ8nKVQCiILQYqSOnG2gfSEhzs1/VTbnjv5TFTuvhYwlC+kGiK3ydIc0BZlaqOkiCuhY5NxAH3py0TD9yVsouJ7WvuoB+FuewX0Z4Y8dodoVk9x0sKjt/4A==
Received: from TY0PR06MB4960.apcprd06.prod.outlook.com (2603:1096:400:134::11)
 by SEYPR06MB6538.apcprd06.prod.outlook.com (2603:1096:101:177::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 09:49:43 +0000
Received: from TY0PR06MB4960.apcprd06.prod.outlook.com
 ([fe80::fad5:ac3b:a939:41e]) by TY0PR06MB4960.apcprd06.prod.outlook.com
 ([fe80::fad5:ac3b:a939:41e%2]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 09:49:43 +0000
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
Thread-Index: AQHbjPJy2F3uXFUe20eiIvujFTWQbbNkGJyAgAeEr9CAAGEtAIAAJ+fw
Date: Mon, 10 Mar 2025 09:49:43 +0000
Message-ID:
 <TY0PR06MB496045B19DCB149EC902D0FF89D62@TY0PR06MB4960.apcprd06.prod.outlook.com>
References: <20250304104434.481429-1-kevin_chen@aspeedtech.com>
 <20250304104434.481429-2-kevin_chen@aspeedtech.com>
 <8740eeb8-9467-48bb-a911-e70c3da3c45a@kernel.org>
 <PSAPR06MB494973DC08A8105EA05FBE6D89D62@PSAPR06MB4949.apcprd06.prod.outlook.com>
 <e17cdf9d-ba96-41d2-9656-9e50d0e0795a@kernel.org>
In-Reply-To: <e17cdf9d-ba96-41d2-9656-9e50d0e0795a@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR06MB4960:EE_|SEYPR06MB6538:EE_
x-ms-office365-filtering-correlation-id: e0b1cc28-6a39-48e9-4247-08dd5fb8e25e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?ekIzLzlReEZBVUg5emxiUTRmVmN2eldFNkdMcG5pdjhoVkcxMllRdGNURStz?=
 =?utf-8?B?dFpEMUJDSkJkd2NaZzVsaFpHaWkvZ3U1VFc4bC95WU1IT0JSd2s5MVhaWnQr?=
 =?utf-8?B?Y1NoR3kzRkZGUy9WL2ZyQUo1RnR4S1BKaWkyOUgzRjc1RjZERnFqSjUzdkRL?=
 =?utf-8?B?USt5emRFYlU4WnFsNHEveEpEcVRlQm54end5UEt1cjEzT1U5WnM0QzlDcFVJ?=
 =?utf-8?B?TkpycHZKT25EclVRbHhiODloVlV6QVVnUHJPZDVreUIyNE1qaEtyNTFBb3lL?=
 =?utf-8?B?d1dTOVpmUUZFellyRVRrWExBaFNEN3FOZ1orRS9OdHJYWG1pSFVIU1BlTGxj?=
 =?utf-8?B?VXJEMUJhUndoZ2EzVEszb1JLTTNqNHRnaUtqc1E2aHFSam02ZGJBK0Q0TE96?=
 =?utf-8?B?S0U2SEw4Uk9ES1dybytOSkpSQXdjRjRCUkF0ODJHb1hGZGlSQkJPNVl5VTVr?=
 =?utf-8?B?QWZHLy9LNVBzU1VCNEFPZDR5QVBtUnNpWGEwRXBhbWE3N2p4VTR0cThhQms4?=
 =?utf-8?B?VlhVcFJsNlpadWYzNHRWTks0RHdnS0RlSE1ZVVBjN0xMb2p1cFVPSWFCbTB1?=
 =?utf-8?B?a1dkMTRmalJHZnBVTGRFZUQyYzBDZGd1T1NQSkdxckgvT1NOb2pQdlJNdUhY?=
 =?utf-8?B?QkpENnduWWpndHdmcnpkdmRLN21PVHRWa3ZKS0Y0NXVHdDBxdElSNkpxTHk5?=
 =?utf-8?B?dzFMV0dhT29HaHcvQ0tYc015K3hGelkveC83aEduTzBNL2xOaHpvaklKa3BL?=
 =?utf-8?B?NTlrUEtGcExSN0VCbCtmc3lBUnpaTEU2YzZPMTZxR0o5MnFwNjFETDN2a1RH?=
 =?utf-8?B?ZzYySU5zMklZaUlHUmRLNmFzT2hpYzhZSTZMUG5ZdXNrUTB2dFZhUUg4RUYv?=
 =?utf-8?B?Zi9VQWpqY29QK2FzWmYxQUJUZEhyVEtjdXM5ajlzNDE1SExHbllTandOWEV1?=
 =?utf-8?B?TndFTWtVdGpNYjRzeXdJUGpSZlQ4RGoyTnBiZ2dlUmd6S1RzaFNjbzR4Z2x2?=
 =?utf-8?B?bWZPNm02TlBCOG9YTzZyb2RpSWZGL3E1UmJwN0EycjRPYU55N2M3b3FyZ0tu?=
 =?utf-8?B?Q2FWVE84dzhzc1hpTkdEdzhGbk1MSFZOd29PRU5JTEVWdWxJMUhoNURnalN1?=
 =?utf-8?B?dWhHR0EzTDV0M1pBZWRmeiszb3NpNSthcUlOZEhZTWszVFdsZkpENGJ3NGZG?=
 =?utf-8?B?dHRUMGQ3WHBpWkJGZnNYNDRpa1UvQTEydUI0Rk1hZENSNmM5WklNQkJHYXF0?=
 =?utf-8?B?b0VBL3NqNVJTTlh4ZTNJaXJqb1hPQ1QySk12Y3RValJXM0NvRG5IVmZuVHpt?=
 =?utf-8?B?Um5pZytuWHlZYThBcmJPMG91cGk0TGZMVXNzdjUxaHl0QU44L2R1OFZFUUtC?=
 =?utf-8?B?QW5ZdndLTWVXVUhRbEV3bE5ZMkt6SlpYVWxWbnBXWEtRMVhPSzUwY0lHZ3RC?=
 =?utf-8?B?dlV5T29TQi9mV0ViNHlMajZobTBEaUVheDIzWnozQ0ptaUh5VzZEQ0JVdUgz?=
 =?utf-8?B?Q3pDeDNPTGRPdFlTYlRxNlVPUVVMZXZUN0t3NDlsMU1PZlRTTnFDajZhRzVE?=
 =?utf-8?B?MDRjbTZJdWRzZUhHVnk0WG11NjZOQlJGYkhhT3dQb3BOckVZcU1QaGRkZGdp?=
 =?utf-8?B?STkvaHQrRWxzM0NoZUlmNkMvMnlEakFYTEJlOVhTWnZWOUh3Ynl2dFFFTnFG?=
 =?utf-8?B?RDVkYmltcHVRWDFJNUJWSDNTeFJHSDFpWmYvRC9VS1JVVWNXTUJvV2VqbzFl?=
 =?utf-8?B?ZTJ3azVlVWJFdjFKNkRFcEZzdlliVFpSN1lwTzVheW9wTVlZQkJQejk4U1Fo?=
 =?utf-8?B?UmFMczZDQ0hLVU51YVEyZ0JDZUlZcGVKMmMyay9VQVB3ME9wOTI3QllQaldB?=
 =?utf-8?B?bkZFQ3lRVnNhVTVFVkV3S2JIRjZEZEZEYzI0aEllc2FiclBtbm5IUjhiUGhh?=
 =?utf-8?B?L1ZUS0xGSGZHdmtvUkhFRmRQS0plbitVSHVaRXliQjdsSzZYYk1mdWZBTEZH?=
 =?utf-8?B?Y0ViNVZ2a3FBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB4960.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?djB4SzQ3YUxRc2NXdDJ3WHNDdEdIdHFPbUE2c2lMam9jLy96b254VXRweXQ0?=
 =?utf-8?B?dlpQRERLcmIxUElVbUFmSVRlMnpuUXloQzZLT01tc3FaUlc4enY4ZVFLRmlT?=
 =?utf-8?B?cVJJNTQ1M1FpSXE3QjVLTUFaOUFPdXpQYlk5emZUc2JQTGFyZ3VUWXFPaStX?=
 =?utf-8?B?N0pWS1JxVGZWT1FQUWhmNHBjRDU1eDg5MEhtSjZJUDFsZUpBalh2MUJaVHZR?=
 =?utf-8?B?eW9rc1Nxc04yVVdWM0d3U1FNVXI4d1gwOWFNcVhYOWIySTFYWEtFcUloTWJp?=
 =?utf-8?B?azc4REZUMmdmV2MyeW83V2tPcCtuWG9uRVEwMUJCWUVxZU0xZGFvMDlJUnNF?=
 =?utf-8?B?YndLcm9LaENzOFBtek0vNFRnWjlCVU8vZGw4UjZHT2ZUOGpSNUZVYnF1MUVL?=
 =?utf-8?B?QkZ3citTNmtTUUR5VXpCWXJOelNWQlBHR01kVlQ2NXNFRTdVaWtPY3hyNU9u?=
 =?utf-8?B?Q3FSWFZpTVNBOHZmek10cGJxODB5R1lqUEk2VWYxdWlGYUxwc0pzS2pyaFky?=
 =?utf-8?B?UkVENEFOVU5RSTRsSzN5SnFlYjJmNFhuWDZ3VWRwd2Y3SmFUMi9OdXhQellv?=
 =?utf-8?B?Tlk2bm9rMVFzY1Arcy9kTXRVYTRNRW8xRE04UUpkVHdZTW81WVpCcWR0azJs?=
 =?utf-8?B?Tll0eFNOd3dGakt1NXBWRDhUeUthUXZOMDduSk95V0Z2UmVJcjBpSXZaS1Fy?=
 =?utf-8?B?eUtWcnZSVWN5UlBtVXRtbU5vWmlzR0xVUnpyKzMySjNYZVk3OXdWTGJyT0xm?=
 =?utf-8?B?eHUxL2J3TjlWaXllQzlmZXpBa0pjcTBBYkttRXQydDhJTVJJMUc3OWdZTkts?=
 =?utf-8?B?SjBnUmwyWmh2RW5CWm5xMWJ1QTN2aGFSalVLeXFXRU1Sck44ZmhHV09Ecy9W?=
 =?utf-8?B?WFcwUjJmRXV3QUt6aFN1ei9QNVJnTk00MHlBakRrMU8vV1BiSWxWVUc2SXBo?=
 =?utf-8?B?TkJmQUNodTlKQTV1bCt2SVZ2aGJHVlpyaWQ3LzJ1V1pKam9DYm8xbmwxODhI?=
 =?utf-8?B?RXZ0b2liRkRtSmdQRUZoVjhZT1lqVW16TE40Wll0UVo3eWJSMUdoZSt5cVBh?=
 =?utf-8?B?cFhPMWxZZlByR01laVZUcTZnd0RNdDFVSHR2alpRSktSUlQvUUxtMWhTK2hZ?=
 =?utf-8?B?ckwyQ0NBTlNZK3BEWjFLYVEvNzl4Ty8vaXBiUCt4WE1raGxiMkZYQ2dKSCt3?=
 =?utf-8?B?TkJKNitZS1lsb1I1RHV2d2p1bkdYY1V1SnpkR2JWWHo4Z1ZkM2pTMEZHeEtG?=
 =?utf-8?B?MzZMVDVMN0l5TS8wemtlcDZ2S3ZwVU1sZ3hZbUdqK2FBUlUxNExLZ04weU5S?=
 =?utf-8?B?KzM0VW9yT1lUdVpibStjR0F6QlVEbldnR3BlRyt0SmF5U0NBSmxoMG56cjZG?=
 =?utf-8?B?Mzh4ZVRYM3lpUFhWemIrd0RSM2dmM2gycE9CdnJkb0VMaUJIZm8wajMzTy90?=
 =?utf-8?B?TGNKbnFpZU9oY0VDd3IydlBsUjNnbFh6VHQyTEhJaXFLWTU3aTduRU5iYzZJ?=
 =?utf-8?B?WnZXbklIUjgzLzVQR1U1VDQvRDNUR1BmOEVwN1lnN1NUZXp4NWhocTZHbWU3?=
 =?utf-8?B?anJZZDRybGdRZFNYNjBJOVBTR1F2QlEzb3dwT2N5V1NkM3o4WXFFV2s4Z3pT?=
 =?utf-8?B?UVZpQ1Z1bERuUnk3ckFjVm5obGc1dlhySGlXMFFJS3RmY0hweko5RGJVbUVy?=
 =?utf-8?B?dERXYWNFWlVtQ3I3bkg0S2VQTzh3Z3diTmtEVXIxUVcxbFQrM0lYaVdxRG9p?=
 =?utf-8?B?SGI1NjcxRzJaK2svOGNCMHBMSWZXbEZ4TC95YittQ3ZlbEhtQS8vZm9yL09r?=
 =?utf-8?B?TkFXVEl4MS9FN1Q2VzNYSHBGSEJwZDBtYWx2VmRPVktPMXdLSXRkV2h5SmZW?=
 =?utf-8?B?cGFOcHRWMlRxMmZGSmhWQjdKQ2tKWDJOU2g3MFBNdk5LTDZtSXZMNVdoMkxO?=
 =?utf-8?B?ZUxSVFliaEpuMms4MEUzeWxWTFV3NFhPaW5PK0dodVJKdUxTelFoMGNYM1lE?=
 =?utf-8?B?TWJYbHgwMXdhQThNZVY3RnRFeEZJU3RUai9Cd3ZsWitWSEpqamtwTlhOMnJ4?=
 =?utf-8?B?cUtiR0g1Tzl0MjNQL3ZQYkVITjV3c2phWTlrNjBaRi8zN0RDR2t4c0JMWnky?=
 =?utf-8?Q?Z8rx5fmuIegU3OWYpMv/YmfjR?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB4960.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b1cc28-6a39-48e9-4247-08dd5fb8e25e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 09:49:43.2703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hD0fwx5xDRMQDEKC72KGT5h3W0OesuFl3bc/GIPqsKvShLh8MBQ3+n3LMP9FMOrCezGDiuh1yn2qkFm8eQAcAeTnzz5h/cwBq6NPYid+qU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6538

PiBPbiAxMC8wMy8yMDI1IDAyOjUwLCBLZXZpbiBDaGVuIHdyb3RlOg0KPiA+Pj4gKyAgICAgICAg
JHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyLWFycmF5DQo+ID4+
PiArICAgICAgICBkZXNjcmlwdGlvbjogVGhlIExQQyBJL08gcG9ydHMgdG8gcGNjDQo+ID4+DQo+
ID4+IERlc2NyaXB0aW9uIGlzIHRvbyB2YWd1ZS4gV2h5IHdvdWxkIHdlIGVuY29kZSBJL08gcG9y
dHMgYXMgc29tZQ0KPiA+PiBudW1iZXJzIGluc3RlYWQgb2YgR1BJT3MgZm9yIGV4YW1wbGU/IElm
IHRoZXNlIGFyZSBwb3J0cywgd2h5IHRoaXMgaXMgbm90IGENCj4gZ3JhcGg/DQo+ID4gRm9yIHRo
ZSBwb3J0LW1tYXBlZCBJL08gaW4geDg2IGFyY2hpdGVjdHVyZSwgQk1DIG5lZWQgdG8gaGFuZGxl
IHNwZWNpZmljDQo+IHBvcnQgSS9PIGluIHRoZSByZWxhdGl2ZSBIVyBtb2R1bGUuDQo+ID4gU28s
IEkgbmVlZCB0byBhZGQgdGhlIHBjYy1wb3J0cyBwcm9wZXJ0eSBhcyB0aGUgc25vb3AtcG9ydHMg
cHJvcGVydHkNCj4gPiBpbiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2Fz
cGVlZC1scGMueWFtbA0KPiA+DQo+ID4+DQo+ID4+IE1pc3NpbmcgY29uc3RyYWludHMgLSBtaW4v
bWF4SXRlbXMsIGRlZmF1bHRzLCBtaW5pbXVtL21heGltdW0gZXRjLg0KPiA+IFRoZSBwb3J0LW1t
YXBlZCBJL08gaXMgZGVmaW5lZCBmcm9tIGhvc3QsIEJNQyBhcyB0aGUgZGV2aWNlIHdvdWxkIGNh
cHR1cmUNCj4gdGhlIHBvcnQgSS9PIGZyb20gdGhlIHBjYy1wb3J0cyBwcm9wZXJ0eSBkZWZpbmVk
IGluIGR0cy4NCj4gDQo+IFB1dCB0aGlzIGluZm9ybWF0aW9uIGluIHRoZSBkZXNjcmlwdGlvbiwg
aW5zdGVhZCBvZiBjb3B5aW5nIHByb3BlcnR5IG5hbWUuDQpPSy4gSSB3aWxsIHB1dCB0aGlzIGlu
Zm9ybWF0aW9uIGluIHRoZSBkZXNjcmlwdGlvbi4NCg0KPiANCj4gPg0KPiA+Pg0KPiA+Pj4gKw0K
PiA+Pj4gKyAgICByZXF1aXJlZDoNCj4gPj4+ICsgICAgICAtIGNvbXBhdGlibGUNCj4gPj4+ICsg
ICAgICAtIGludGVycnVwdHMNCj4gPj4+ICsgICAgICAtIHBjYy1wb3J0cw0KPiA+Pj4gKw0KPiA+
Pj4gICAgIl51YXJ0LXJvdXRpbmdAWzAtOWEtZl0rJCI6DQo+ID4+PiAgICAgICRyZWY6IC9zY2hl
bWFzL3NvYy9hc3BlZWQvdWFydC1yb3V0aW5nLnlhbWwjDQo+ID4+PiAgICAgIGRlc2NyaXB0aW9u
OiBUaGUgVUFSVCByb3V0aW5nIGNvbnRyb2wgdW5kZXIgTFBDIHJlZ2lzdGVyIHNwYWNlDQo+ID4+
PiBAQA0KPiA+Pj4gLTE3Niw2ICsyMDUsMTMgQEAgZXhhbXBsZXM6DQo+ID4+PiAgICAgICAgICAj
c2l6ZS1jZWxscyA9IDwxPjsNCj4gPj4+ICAgICAgICAgIHJhbmdlcyA9IDwweDAgMHgxZTc4OTAw
MCAweDEwMDA+Ow0KPiA+Pj4NCj4gPj4+ICsgICAgICAgIGxwY19wY2M6IGxwYy1wY2NAMCB7DQo+
ID4+PiArICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhc3BlZWQsYXN0MjYwMC1scGMtcGNjIjsN
Cj4gPj4+ICsgICAgICAgICAgICByZWcgPSA8MHgwIDB4MTQwPjsNCj4gPj4+ICsgICAgICAgICAg
ICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTQ1IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+Pj4g
KyAgICAgICAgICAgIHBjYy1wb3J0cyA9IDwweDgwPjsNCj4gPj4NCj4gPj4gU28gd2hhdCAweDgw
IHN0YW5kcyBmb3I/DQo+ID4gSG9zdCBhcyB4ODYgYXJjaGl0ZWN0dXJlIHdvdWxkIGFjY2VzcyB0
aGUgMHg4MCBwb3J0LCB3aGljaCBpcyBtYXBwZWQgdG8gdGhlDQo+IEJNQyBQQ0MgSFcgbW9kdWxl
Lg0KPiA+IEFzIGEgcmVzdWx0LCB4ODYgY2FuIGtlZXAgdGhlIHBvcnQtbW1hcGVkIEkvTyB1c2Fn
ZSBhbmQgYWNjZXNzIHRoZSBCTUMNCj4gZGV2aWNlLCB3aGljaCBpcyBuZWVkZWQgdG8ga25vdyB3
aGljaCBwb3J0IHVzaW5nIGluIHRoZSBQQ0MgbW9kdWxlIGluIEJNQy4NCj4gDQo+IEFuZCBvbiBk
aWZmZXJlbnQgYm9hcmRzIHRoaXMgaXMgbm90IDB4ODA/DQpUaGUgcG9ydC1tbWFwZWQgSS9PIGRl
ZmluZWQgaW4gdGhlIGludGVsIGxlZ2FjeSBkb2N1bWVudCBhcyB0aGUgZXhhbXBsZSB1c2FnZS4N
CkZvciBleGFtcGxlLCB0aGUgY29tbW9uIHVzYWdlIGFncmVlbWVudCBvZiBwb3J0LW1tYXBlZCBJ
L08gYXJlIHRoZSBmb2xsb3dpbmcuIEJ1dCB0aGlzIHNldHRpbmcgY2FuIGJlIG1vZGlmaWVkIGR1
ZSB0byB0aGUgaG9zdCB1c2FnZS4gV2UgcHJvdmlkZSB0aGUgZmxleGliaWxpdHkgdG8gbW9kaWZ5
IHRoZSBJL08gcG9ydCBzZXR0aW5ncy4NCktDUyA6IDB4Q0EyKENNRCkvQ0EzKERhdGEpDQpCVCA6
IDB4RTQvRTUvRTYNClNOT09QL1BDQyA6IDB4ODAvODEvODIvODMNCk1haWxib3ggOiAweENDMA0K
U3VwZXJJTyA6IDB4MkUvMkYgb3IgMHg0RS8weDRGDQpTeXN0ZW0gVUFSVCA6IDB4M0Y4LzJGOC8z
RTgvMkU4DQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=

