Return-Path: <linux-aspeed+bounces-3973-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03167FF886F
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Apr 2026 02:09:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g512P1wjFz2yps;
	Wed, 29 Apr 2026 12:09:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777428557;
	cv=pass; b=AZwewwlDDId81XXMM2hDzLOwFlaTF+kMwHZSfnsY/69qX4P3YtOFZBFuH6SgLjfxyoJ8ISAcdQS+7OrL12BMAWBVSstEhofR4e3LdZqqo6Z3yMMBrVH5KJ1E3tJwucD3R3leRy0UNmP1VXt1NYcmbOZobVbsZSVsz+WWgVEK8FcrVEHq6mi/HgnVZ2Ufx1wfs4bylSj0P4wXTYpaZDU+rP4ULA2r5BE8BQ0UkaKatoIEBLfl0QlMwaONz3VZ3klO3JEuB4D6V8D8YWOUAcQ77B47BJJio/Qe/cRkLY2OQdaLdmQJGoJ+ZRdqhux5O8QSaeXPp4sWYWxcu8a7qXQrvQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777428557; c=relaxed/relaxed;
	bh=VA9VMcsd/GRJtKVVKvP1phNwKInKipxVIXysBPwnOiE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Eyw9jiVHpvnCu3UdQqm9ZK64N6794/v4DUaHvsswxY8ov077Psj1SzQHJVPQ8O0EM+UfufcTV9Ghj4ZyyVNst5vT0CfkOtAhDJ49iYY6LsOFTpMkAyVOCKFDOXukDHKEZx2NFCSrH/KLhvMOCyyhNdKTA5w3Q3xC+hg4nJiAOLAlsy5Bn7+TRptFEDHOSikh0ii/q5KwWPWiJvL0vGCqglK5f8WHSKsG4n0Bg29BGvzS+0R7qi4/lsk1krwgFuArqmQQC5Djl7j4WKIqLCpDGhDzRSDGH8Z+Kh7uLwvz7jxCgZPhfx+vpH15g2XcWVeTWR2DxBX3M3Ri2Q0G3GqUfg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Br0ZxXO9; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Br0ZxXO9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g512M5zD7z2xTh
	for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Apr 2026 12:09:14 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXjwX8yk5FsJ3sUOj5GJSiiLbKtrrqsUZCxgu+iwoJwhpgh5qFo00t0uzuONjWGmtEemFKEK7yQjOJBGpaTOJiHR8bfcZdoEyAix8X/qi2rQHYr4z1V6ZWXTZYMu/C9STlIwIwnoNx+WSQekbBL+32K6nvFqLV6y1YbWMt8miPZRXQr3YyQ34B2p6folDXIR7YH1ik/qkCi2XwFHtlkubyld+BUlYQ8YV3rbALa8lJvSAv+izdFyvXwpL4NsBiEua4+BzFozKb5k/oSc3TjZafFKFHWRaIUZv5CwkDLQfSJGN8QVel+VzObc83nZ1oXodFx1Ki6/fIOQY707AHOiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VA9VMcsd/GRJtKVVKvP1phNwKInKipxVIXysBPwnOiE=;
 b=pnXpoj8LTmobAt/cc1UL0YB2R7FwOlm6E+vV8nv1DZe3ccoeNvrFc0vD8K+HKJ0NBi8s27uVDmBvYrGPiTyEOhFCq7M02ac5nuABCSivcGv/Ss8f94raDpNf7EN2M6GIgs0YeEEVk34Im76UmUkbQG7kLeuIg3QY1LZrweixKqyD9UAGhlKmqqYAxhOwa5MzUc7gCdouFDqFFLV1EKY/W34c1TQIZMwC+MbB5G2xuXaTvLcRbaxKcgj/sS66TKXcKtFiTwiTW6Y7OGLIoW87zSRy2B/eYrHD6MuS3F1pm5H3V/7kELOaFW1fxx6NiOATI6poQEs8LxZJemyKGots3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VA9VMcsd/GRJtKVVKvP1phNwKInKipxVIXysBPwnOiE=;
 b=Br0ZxXO9c0T4apW6IBwER1muzWsdYNDx5P1kQOrHGWRZRf9gTuAep5T85a+yhSKcm6BOa3iKoebrTtSK/bjah5IwIufOh9W/i/pY8wZwvtCU54nHY35CZLTHSPS2b97K+KwTAqk2LPynALlEfSTsfSsip0acWDh4zYHC3RCd3FUxL85OPZAPm1sdEaqkFL/XckGNwD4zczKLfyNrTEy4OWCwKSy0n6uUBG9PebF0e0+mX535h1KaJOKGI7LKmUaviveLpRfPWFNsVP824ClOY9+h18CeYSz9TPp7noxKBN48I2chQh/XbmU5PCJ/N8l3kWDZVQW3DR/Gnro+dCADhg==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TY0PR06MB6804.apcprd06.prod.outlook.com (2603:1096:405:17::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 02:08:51 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%5]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 02:08:51 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Ender Hsieh <andhsieh@nvidia.com>
CC: Andrew Lunn <andrew@lunn.ch>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, Marc Olberding <molberding@nvidia.com>
Subject:
 =?gb2312?B?u9i4sjogTlZMMzIgQk1DIGVuYWJsZW1lbnQgoaogb2ZmZXJpbmcgaGVscCBv?=
 =?gb2312?Q?n_ftgmac100_work?=
Thread-Topic:
 =?gb2312?B?TlZMMzIgQk1DIGVuYWJsZW1lbnQgoaogb2ZmZXJpbmcgaGVscCBvbiBmdGdt?=
 =?gb2312?Q?ac100_work?=
Thread-Index: AQHc1r+GLHLcfllLBUKLNnD9hcbl4rXz0urSgADC8gCAALTawQ==
Date: Wed, 29 Apr 2026 02:08:51 +0000
Message-ID:
 <SEYPR06MB5134EAEAB53E80B69F73131B9D342@SEYPR06MB5134.apcprd06.prod.outlook.com>
References:
 <SEYPR06MB513489D0B8F5BC77258EA1FF9D372@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <20260428151416.1700609-1-andhsieh@nvidia.com>
In-Reply-To: <20260428151416.1700609-1-andhsieh@nvidia.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TY0PR06MB6804:EE_
x-ms-office365-filtering-correlation-id: 6ec332fe-c2ea-45c2-8c7e-08dea594421f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|8096899003|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 M53xlBn+AiNMpzRaOkt+yVZTGk0pim87Muz8pyKhmOTPZLfsQIDyZ0u2Lvo5oN0tEeX5PtQfu1hJ4yG98/FVN4F1Lovc9WlZNCeU6aTfrgWcZsBFMyJMZba1B+rSiISlsU9JVYqxZ3cKr0+g3XgQG3YE/Tn5nUPPIkwekW5iBWzmBcI03pkbBM5O0U/vmy6paa4vVW3LERw/6wlLUzWF2s9y/3fiDj/43aLg9UH/0hjpuyXLIjSByfCXyF2nQsz8e/LstyUVV0z9hsfX1otXCsIBw/jG+HMT/7mATNtRsgNXgFZ4MKh8RP/DJAH7leUe83ZNfobMWnOub6BeHvvADfOGhKhHd/mY8uBAOKDwVqMMcsYiBsIX0MC6H8c6GMXBe3pxZatdox6g3Ff2y34MoVMpprsZ6gKZI2sA3Z/yaEOWCbQxyzd2G1mEE0hpbDsE5AdYlKILTail+cUxh3NTKTkJC8jiJO9zSRovdYm7R4qZK7+l3HKnN73DKLXSbfW7aeihUI/s7O3mrdVd0xqik96P6Nzmcu/himmdzaU/Zby/1YvX0gjnEsruGuIwje76Gii59ktNKPjnmp+mGI5RAsWTYS6x2F7krMwx+hHP4+ytEDubOj8u7LIBi8Mt15nun1D06pXc5cHcCTdxReNGHqPpoZjY/v9v+pnQDFFRNNzDdubWmgI+IVOsgWnD1U3oRTENXu0TT9iML7FOhor28iFhUhNUL4uF7AfFu6ovdMH7O0MF5s5pCeq4XtmmnOBfwS1P6U+rxg7wJihIPEdw3BRsgm3PsCXnQfggfCHsCb0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(8096899003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Q3lPRmdtMHRwMFhnaUduWG5nWkVQWm9SYUFGMEk2cE5sdlpjRHhpdDYxQitI?=
 =?gb2312?B?QytnSlkxQnh2SGU0OU43aUY2dnUwSzRYZk5McmJVZU50VmxseFJzYXNMbzFE?=
 =?gb2312?B?cER3MjBTMjY3L2luUXVPVmhOSFllWit6cXBwaldDbTJtbld0bEhTR0daL0J3?=
 =?gb2312?B?WjEyeGkxMnkvVEpUZjU3SnNXWC9BdDJGS0d1K2ZxQ2lXSDB2dElmV3haazN3?=
 =?gb2312?B?Wmh4K1dSalJYSVArWFZQajR2Y1F3R200Q3dWZjJlOFgrd2VYLzVjdWhzTUtS?=
 =?gb2312?B?dndtdzhrb2hWTjRoOUFnRFBrbXlvV3JTTEpxbmg5ejFic1U1cTcyTElQQzJF?=
 =?gb2312?B?M0JteVZ6Rys1R0d0VlJQQk9DcjNTQnoxT1RNZDNPdDdjVVJhM0ZiQUFuUlA4?=
 =?gb2312?B?TDk2b1FId3pleWJVSVM5TXcwdUF5bElnV1R2aXpKalZyeTMzeU1PSFljUzhv?=
 =?gb2312?B?ZFdVU2V4bkxPT1p4dGxRcnR3NFc4SnprY2lYcDlPejd2MFA5WEFUQjJjUlJJ?=
 =?gb2312?B?ZnJyYmkrd2JvRFVYc25IRi95Y2ttNUR2Y2FqaWh2TGMrVVA2RkErQjBTa3VZ?=
 =?gb2312?B?ZmdKQXoxVzNCTjI1aXYrUmlLQnlra0J2YzBhTVlzY1pxVS9LaXdHM1F1YVhy?=
 =?gb2312?B?SHNOTDJCdkF6b01BSmJxR1RvYXViNndHclRINE9UbVVOaGtNRk1EcEJndm14?=
 =?gb2312?B?WERwcUUwQkN3Ry9xMnJURE8zSDRxV29iVnBiTmRocGhYUm81TzBkY3Jpd1FM?=
 =?gb2312?B?WThxb1F0cHdWbWlkZHMwaFAybUJUN2xIMjg2TmZvTklXT3BQQWplNm1qMVJX?=
 =?gb2312?B?aElkUWVqTVhZRldJVmFQeXIxM2hmM0txWjNERi96cFB1dG9URzZKNzNzcXgw?=
 =?gb2312?B?c2QrTXFScWFkWis2eUd6MDJZUWRudVF4cGF4dG05UG5tcTlaVCt0VEwyNmhB?=
 =?gb2312?B?T1VsRjVlb1lsRE81U2ZLZkhzNTlnSzdKNXBtUlhDbm0wUU9TdmNkaHlQTE5M?=
 =?gb2312?B?eTBITTZITjUrTVB5S3ZxYUs0NFdObStQSURSbkt2ZU9HYU14WlZScFNkZ28z?=
 =?gb2312?B?SXB5VWk4TWtiMWZPRE5CQmJLV3dxRlA4MnIyVmZQRVVxeTkrUmkySVJUbFpG?=
 =?gb2312?B?cG5xQnd2WmpJZ1hMRFk0cTF2amdjVVdiamg2TlFPMlcwQkNjOXJOdUJvajRS?=
 =?gb2312?B?SGE5L3FqRXVYckpGRVZ1TGlzRngzR0Y5TWZEZEx0eTcyaFB6UDRxZEc2YXM0?=
 =?gb2312?B?WVprZ3MxQnJrU1B3QjM1SUd2bW5PbUMxYVVYNjlkeEtoOHhWSC9xUmsvbCtk?=
 =?gb2312?B?QitnRFVXNnBGWGVRMkVMUVFpVjlvdVBnU2phL2lrU2ZPQTBCSmJSSmpwNVB4?=
 =?gb2312?B?Q0crQksvclBQejhUMFlJSUgyWnltV3VOS2RoZVJWVEVHekVaU2wwbWUyMFc3?=
 =?gb2312?B?ZDBuM013VGRJUXd4MFJWSFhWYy9QNWFPa3k3bk5FMEk0b3RRVHl1cVRwQkxB?=
 =?gb2312?B?bDVJYWVaNGxVOXFGanlYakM1ZStNMUc2VXFkWWV0akNQcVdIdE54SWtGYi9C?=
 =?gb2312?B?UnRPeDRyeHE4SW14L1VXZlpsMWRRbk1lUzVQblFUUVJ2TFZsVFA4SEdNSk5Y?=
 =?gb2312?B?THlXUXBOQStNYjJNck4wNEE5czl3Y3ppL3N5NUxuNFZ4K0Njc0EwMzBRTkx4?=
 =?gb2312?B?VWgwQXpidW9uQ0tpcVVUUTRaKzR5YWlIbEZUMTFxZXNIb3pxZWxjTHF0UlNM?=
 =?gb2312?B?YmFlU3BuSC9ZeEEvQ1pyLzEzWlRUNUYrLy9UOENxS2ZZQ2x2WGtEWGs0b3V4?=
 =?gb2312?B?a1Nob00zTnlhWmowdUZhWkM5UU1YQlBoQ0o3Y05NS05DQnZIV0pBSXU5eTk2?=
 =?gb2312?B?Z202K2MwR29IZTVGd1FmRVpyMkFic0owVEZuSTIrSms5T3ZoVTJTZFRJWHBT?=
 =?gb2312?B?VTF2bUhrOHRIMlBCSVdmUTVuUU4zbTRLRGhMUXhjTWExNGVxSjJhd0VNcEVE?=
 =?gb2312?B?d3Z6ZE53NWNGNHkxc24zT3BPTWt2VzhWSWhYZ2ZCWkYrRjBKallXc0xpOXow?=
 =?gb2312?B?cUszSS8wZUQvbTcxTW5pTDd0MjJRUHFUc2EySDJWekNHY3J6cmllcVFYOXlO?=
 =?gb2312?B?L3VFYk1aMi9uVHhlQnY2dWdpejE3RURiZlBxV3VtaGZHVW5ITVdEQ05jTHlN?=
 =?gb2312?B?Qm9BVlpoOWJ2L3VEWitMWFk5Sm9LbFNCemNiNmIyd1RsTGQxSS8yU3YwaCtG?=
 =?gb2312?B?QS9idThSTzNTQkJhNEZCbkZZdFdrSk8xWFYvUnlpOTN5S3ZId29pWmY3a3M0?=
 =?gb2312?B?TTJ1M0RFWjBRN1BnOUpmMDJmRE9YQmFmSkNtSXBYV3llRWxybk4zdz09?=
Content-Type: multipart/alternative;
	boundary="_000_SEYPR06MB5134EAEAB53E80B69F73131B9D342SEYPR06MB5134apcp_"
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
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec332fe-c2ea-45c2-8c7e-08dea594421f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2026 02:08:51.5908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Vy+WjZGe+HmdMdZFcfLWoKgoukqkDAmIKFc3yUNYOWp0z7yDdO+yyxbAJJs947g7ki3WI2Td7mvl15r8fkoMX7WWS8y2x0sdXfq7Gg0FYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB6804

--_000_SEYPR06MB5134EAEAB53E80B69F73131B9D342SEYPR06MB5134apcp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGkgRW5kZXIsDQoNCldlIHN0b3BwZWQgdG8gc3VibWl0IHRoZSBSR01JSSBkZWxheSBjb25maWd1
cmF0aW9uIGluIGZ0Z21hYzEwMCBkcml2ZXIsIHBsZWFzZSBhZGp1c3QgdGhlIGNvcnJlY3QgUkdN
SUkgZGVsYXkgYW5kIGNvbmZpZ3VyZSBpbiBib290bG9hZGVyLg0KDQpDdXJyZW50bHksIHdlIHN1
Z2dlc3QgdGhlIFBIWSBzaWRlIHRvIGVuYWJsZSBUWCBhbmQgUlggaW50ZXJuYWwgZGVsYXksIHdo
aWNoIG1lYW5zIHRoZSBwaHktbW9kZSBpcyBzZXQgdG8gJ3JnbWlpLWlkJyB0byB0ZWxsIHRoZSBQ
SFkgZHJpdmVyIHRvIGVuYWJsZSBib3RoIGRlbGF5IHRvIGl0cyBQSFkgZGV2aWNlLg0KDQoNClRo
YW5rcywNCkphY2t5DQoNCioqKioqKioqKioqKiogRW1haWwgQ29uZmlkZW50aWFsaXR5IE5vdGlj
ZSAqKioqKioqKioqKioqKioqKioqKg0Kw+LYn8KVw/c6DQqxvtDFvP4ou/LG5Li9vP4pv8nE3LD8
uqyZQ8Pc2VnTjaOsgUvK3Leowsmxo9dvoaPI5yDMqLbLt8fWuLao1q7K1bz+1d+jrNWI0tTritfT
4F28/s2o1qqxvuuK19PgXbz+1q6wbMvN1d8sIIFL1YjBory0hGiz/bG+64rX0+BdvP68sMbkuL28
/rrN5E6ap8v509DRfdOhvP6ho9Z41njE+rXEus/X9yENCg0KRElTQ0xBSU1FUjoNClRoaXMgbWVz
c2FnZSAoYW5kIGFueSBhdHRhY2htZW50cykgbWF5IGNvbnRhaW4gbGVnYWxseSBwcml2aWxlZ2Vk
IGFuZC9vciBvdGhlciBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24uIElmIHlvdSBoYXZlIHJlY2Vp
dmVkIGl0IGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcmVwbHkgZS1tYWls
IGFuZCBpbW1lZGlhdGVseSBkZWxldGUgdGhlIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIHdp
dGhvdXQgY29weWluZyBvciBkaXNjbG9zaW5nIHRoZSBjb250ZW50cy4gVGhhbmsgeW91Lg0KDQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KvMS8/tXfOiBFbmRlciBIc2llaCA8YW5k
aHNpZWhAbnZpZGlhLmNvbT4NCrzEvP7I1cbaOiAyMDI2xOo01MIyOMjVIM/CzucgMTE6MTQNCsrV
vP7V3zogSmFja3kgQ2hvdSA8amFja3lfY2hvdUBhc3BlZWR0ZWNoLmNvbT4NCrixsb46IEFuZHJl
dyBMdW5uIDxhbmRyZXdAbHVubi5jaD47IGxpbnV4LWFzcGVlZEBsaXN0cy5vemxhYnMub3JnIDxs
aW51eC1hc3BlZWRAbGlzdHMub3psYWJzLm9yZz47IE1hcmMgT2xiZXJkaW5nIDxtb2xiZXJkaW5n
QG52aWRpYS5jb20+DQrW99a8OiBSZTogTlZMMzIgQk1DIGVuYWJsZW1lbnQgoaogb2ZmZXJpbmcg
aGVscCBvbiBmdGdtYWMxMDAgd29yaw0KDQpIaSBKYWNreSwNCg0KVGhhbmtzIGZvciB0aGUgdXBk
YXRlIG9uIHRoZSBBU1QyNzAwIGZ0Z21hYzEwMCBwbGFucy4NCg0KQSBiaXQgb2YgY29udGV4dCBm
cm9tIG91ciBzaWRlOiB3ZSdyZSB3b3JraW5nIG9uIHRoZSBPcGVuQk1DIHVwc3RyZWFtDQplZmZv
cnQgZm9yIG52bDMyICh0aGUgQVNUMjYwMC1iYXNlZCBtc3g0IHBsYXRmb3JtIE1hcmMgT2xiZXJk
aW5nDQp1cHN0cmVhbWVkIGluIGNvbW1pdCBmMjg2NzRmYWIzNGYpLiBUbyBnZXQgaG9zdCBuZXR3
b3JraW5nIHdvcmtpbmcgb24NCm91ciB0ZXN0IHBsYXRmb3JtIHdlIGN1cnJlbnRseSBjYXJyeSBh
IGxvY2FsIGtlcm5lbCBwYXRjaCBpbiB0aGUNCk9wZW5CTUMgbGF5ZXIgdGhhdCByZS1hZGRzIHRo
ZSBtYWMwL21kaW8zL2V0aHBoeTMgbm9kZXMsIGJ1dCBob2xkaW5nDQppdCB0aGVyZSBsb25nLXRl
cm0gZ29lcyBhZ2FpbnN0IHVwc3RyZWFtLWZpcnN0IHByaW5jaXBsZXMgYW5kIHRoZQ0KR2Vycml0
IHJldmlld2VyIGhhcyBmbGFnZ2VkIGl0Lg0KDQpHaXZlbiBBU1QyNjAwIGZ0Z21hYzEwMCB3b3Jr
IGlzIHNlcXVlbmNlZCBhZnRlciB0aGUgQVNUMjcwMCBzZXJpZXMsDQpkbyB5b3UgaGF2ZSBhbnkg
c3VnZ2VzdGlvbnMgb24gaG93IHdlIGNvdWxkIHJlc29sdmUgdGhpcyB1c2luZw0KdXBzdHJlYW0g
cmVzb3VyY2VzIKGqIGUuZy4gYW4gaW50ZXJpbSBwYXRoIHRoYXQncyBhY2NlcHRhYmxlIHRvIHRo
ZQ0KY29tbXVuaXR5IHdoaWxlIHdlIHdhaXQgZm9yIHRoZSBwcm9wZXIgZHJpdmVyIGZpeD8gQW55
IHBvaW50ZXIgb24NCnRoZSByaWdodCBzaGFwZSAoUkZDIFBBVENILCBvcGVuYm1jL2xpbnV4IGJh
Y2twb3J0LCBzb21ldGhpbmcgZWxzZSkNCndvdWxkIGhlbHAgdXMgYSBsb3QuDQoNClRoYW5rcywN
CkVuZGVyDQo=

--_000_SEYPR06MB5134EAEAB53E80B69F73131B9D342SEYPR06MB5134apcp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 12pt; color: rgb(0, 0, 0);">
Hi Ender,</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 12pt; color: rgb(0, 0, 0);">
We stopped to submit the RGMII delay configuration in ftgmac100 driver, ple=
ase adjust the correct RGMII delay and configure in bootloader.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 12pt; color: rgb(0, 0, 0);">
Currently, we suggest the PHY side to enable TX and RX internal delay, whic=
h means the phy-mode is set to 'rgmii-id' to tell the PHY driver to enable =
both delay to its PHY device.</div>
<div id=3D"Signature" class=3D"elementToProof">
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<p class=3D"elementToProof" style=3D"background-color: rgb(255, 255, 255); =
margin-top: 1em; margin-bottom: 1em;">
<span style=3D"font-family: Consolas, Courier, monospace; font-size: 12pt;"=
>Thanks,<br>
Jacky<br>
<br>
</span><span style=3D"font-family: Consolas, Courier, monospace; font-size:=
 15px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">********=
***** Email Confidentiality Notice ********************</span><span style=
=3D"font-family: Consolas, Courier, monospace; font-size: 12pt; color: rgb(=
0, 0, 0);"><br>
</span><span style=3D"font-family: Consolas, Courier, monospace; font-size:=
 15px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">=C3=E2=
=D8=9F=C2=95=C3=F7:</span><span style=3D"font-family: Consolas, Courier, mo=
nospace; font-size: 12pt; color: rgb(0, 0, 0);"><br>
</span><span style=3D"font-family: Consolas, Courier, monospace; font-size:=
 15px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">=B1=BE=
=D0=C5=BC=FE(=BB=F2=C6=E4=B8=BD=BC=FE)=BF=C9=C4=DC=B0=FC=BA=AC=99C=C3=DC=D9=
Y=D3=8D=A3=AC=81K=CA=DC=B7=A8=C2=C9=B1=A3=D7o=A1=A3=C8=E7 =CC=A8=B6=CB=B7=
=C7=D6=B8=B6=A8=D6=AE=CA=D5=BC=FE=D5=DF=A3=AC=D5=88=D2=D4=EB=8A=D7=D3=E0]=
=BC=FE=CD=A8=D6=AA=B1=BE=EB=8A=D7=D3=E0]=BC=FE=D6=AE=B0l=CB=CD=D5=DF, =81K=
=D5=88=C1=A2=BC=B4=84h=B3=FD=B1=BE=EB=8A=D7=D3=E0]=BC=FE=BC=B0=C6=E4=B8=BD=
=BC=FE=BA=CD=E4N=9A=A7=CB=F9=D3=D0=D1}=D3=A1=BC=FE=A1=A3=D6x=D6x=C4=FA=B5=
=C4=BA=CF=D7=F7!</span><span style=3D"font-family: Consolas, Courier, monos=
pace; font-size: 12pt; color: rgb(0, 0, 0);"><br>
<br>
</span><span style=3D"font-family: Consolas, Courier, monospace; font-size:=
 15px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">DISCLAIM=
ER:</span><span style=3D"font-family: Consolas, Courier, monospace; font-si=
ze: 12pt; color: rgb(0, 0, 0);"><br>
</span><span style=3D"font-family: Consolas, Courier, monospace; font-size:=
 15px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">This mes=
sage (and any attachments) may contain legally privileged and/or other conf=
idential information. If you have
 received it in error, please notify the sender by reply e-mail and immedia=
tely delete the e-mail and any attachments without copying or disclosing th=
e contents. Thank you.</span></p>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=BC=C4=BC=FE=D5=DF:</b> Ender H=
sieh &lt;andhsieh@nvidia.com&gt;<br>
<b>=BC=C4=BC=FE=C8=D5=C6=DA:</b> 2026=C4=EA4=D4=C228=C8=D5 =CF=C2=CE=E7 11:=
14<br>
<b>=CA=D5=BC=FE=D5=DF:</b> Jacky Chou &lt;jacky_chou@aspeedtech.com&gt;<br>
<b>=B8=B1=B1=BE:</b> Andrew Lunn &lt;andrew@lunn.ch&gt;; linux-aspeed@lists=
.ozlabs.org &lt;linux-aspeed@lists.ozlabs.org&gt;; Marc Olberding &lt;molbe=
rding@nvidia.com&gt;<br>
<b>=D6=F7=D6=BC:</b> Re: NVL32 BMC enablement =A1=AA offering help on ftgma=
c100 work</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Jacky,<br>
<br>
Thanks for the update on the AST2700 ftgmac100 plans.<br>
<br>
A bit of context from our side: we're working on the OpenBMC upstream<br>
effort for nvl32 (the AST2600-based msx4 platform Marc Olberding<br>
upstreamed in commit f28674fab34f). To get host networking working on<br>
our test platform we currently carry a local kernel patch in the<br>
OpenBMC layer that re-adds the mac0/mdio3/ethphy3 nodes, but holding<br>
it there long-term goes against upstream-first principles and the<br>
Gerrit reviewer has flagged it.<br>
<br>
Given AST2600 ftgmac100 work is sequenced after the AST2700 series,<br>
do you have any suggestions on how we could resolve this using<br>
upstream resources =A1=AA e.g. an interim path that's acceptable to the<br>
community while we wait for the proper driver fix? Any pointer on<br>
the right shape (RFC PATCH, openbmc/linux backport, something else)<br>
would help us a lot.<br>
<br>
Thanks,<br>
Ender<br>
</div>
</span></font></div>
</body>
</html>

--_000_SEYPR06MB5134EAEAB53E80B69F73131B9D342SEYPR06MB5134apcp_--

