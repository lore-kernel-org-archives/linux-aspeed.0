Return-Path: <linux-aspeed+bounces-2615-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6318CCCF9E9
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Oct 2025 02:44:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cvyXK2rHMz2yyx;
	Mon, 27 Oct 2025 13:44:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761533089;
	cv=pass; b=dtPkklpXJjLS8ZFlS8HvtxbS24xoWVTntcYbeiqVUltjKQPBRL4/jDg3dNGDnXBKz8PE4bA7jr4bwmIRiRKfc9dBpmCiIvAAcIdp2uFVAsJ81Q1AMKY9blEzzdNB0xtchkvrUA5+4oE7asurL+xg0oIgafjIYKki4MwWcI0iQgkMdNJtoKWSXA5NzO0mgrmKHGcMAS0y52MTcqbqHD03nvqtGRlfY28snNKSJa3c75FBtAaGl7knMXnq8QT5ZYenexvOIxWSV3sP7nlOi3kHOOJofQz2WJCtTDvfuFusjR8RM6Ul63/Dq6IIQirBG66L9OexK/aDQE9PVBj+3ARPtQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761533089; c=relaxed/relaxed;
	bh=TQhVLYz6sthzkcunYQ+S2MV6n2/kotmtd9hveZpo9PA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TWQCv6KI0r9HfIMBN6LKlLefOvkcstdyjudbbfYuSThMMKsecnZjsUFr33mF3FZKBNHEiYOBBPNJbZvTZkA1yLbGCQkNgf9hDRclTntnzcOGLZTEgeUUCeT4eo6UzlXVPiyoAl9e7EiQa6yLig8ZZeLCSiMqZBcwts6fyBeYiKwOtukqzyN8FxZalcfU2l321k8VPG3cnToYJK0qRfIQ4EbaFzS8PumlAixAqlA68QX3rOpX7QLk6qcp4VQiF4Yq2tt2UOzqiVYZUGdA0VyTOIVcwkao+jkxs6QTEYqIRJFcwLFOGQm4lX1pupRAXEXdavXUR8FY7nAvhokO7CUzXA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=I8nPIPEg; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=I8nPIPEg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cvyXJ5KZNz2yw7
	for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Oct 2025 13:44:48 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPOQ5xqm3wURO2XOcjvl1QKf6PpnMnjlpm4f9xOyg37TrAxPtXwmw6BI0TD20cID7itpdExeLxgaWxU746AzLdT0Nd1nwVexS7itUCLjqPc5b7796/u9DnCXpDu+zvrsIaqIaBsQGlYYJeTaOFEd0HA5D6zqpN3zhleJ35yLvuswJFBoxJPRZeUSSuj4OcN5nS9yqAt0nRb4UzjqYhi3SgTosIyDCSibUMwUrgs/1G1fgrmqldVKcJ8vQf+EjAJ1qbfMum4LUwUzegvrEfdIgdscOL0GFqNazqaROPh/OM4zGSggdjFyMiwHrf9q9kPf4d+taPXHHMucV7hOZuIC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQhVLYz6sthzkcunYQ+S2MV6n2/kotmtd9hveZpo9PA=;
 b=zT5p6mItU1Y2K2eeIJXJlStLRKpwspxRgXQljzDNfDyY/ygLLTSc0gbOXG1cxWNDEi5SFpYMD3I2h+N83jImbgD72bcrtXvqP6bHkH6Mo61FZ5+N9pxzo9Zx8HIODJObpL2s+MQu/TUfGV+YWJlHHBI5JgYmJw7QYRgmFTltRykLk0clFYT4b12d8wyZi70/0qx1VX166QEpPHD0HAovzDFL2dklSRwB7KFMGtpHfzoQQOMWYzy+Nf75V8t4Qg1f9QbPW6mR9GfIRbhK+Wtl81iENIhUX5m4IgJejELAnbxLKQBEKT+iIjNGwWfpukEcvbd0BqdbRkocFfGc21kKIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQhVLYz6sthzkcunYQ+S2MV6n2/kotmtd9hveZpo9PA=;
 b=I8nPIPEgO0yJkmRGPhO0gbz7L2a2rfxkPgTpxIbwc9Ls7Vtay3qzc4p2FZwSOw3yv+/8Sjhp601Jd+WbUbUtjHDayUMhHtbQ5E6Qhy+25+ZLYcocj1cL+Dqgjivzb14eR7nLm4x6fEZ/OvVBU/QMjhjTxSXd7u2sJhu4ZVupg3dXtJJ+lri+nrW3XS9gWKBMp15ft5ox57ny7h+8Xkkx6EkSEgsyx/YuPDfmfYCl9ywMbUE8A94WJEgl+Cid1aGqY1qjnOJarKtOZODJ9hk589WH0Z5a4FwRXtET67OkAKm5Nsk1BzO02Jvv8JTpnpCr2hhuk7/ZtAn+I33EgFmcEw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEYPR06MB5961.apcprd06.prod.outlook.com (2603:1096:101:d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 27 Oct
 2025 02:44:24 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%6]) with mapi id 15.20.9253.013; Mon, 27 Oct 2025
 02:44:23 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>, BMC-SW <BMC-SW@aspeedtech.com>, Arnd
 Bergmann <arnd@arndb.de>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0DogW25ldC1uZXh0IDAvM10gQWRkIEFzcGVlZCBHNyBNRElPIHN1cHBvcnQ=?=
Thread-Topic: [net-next 0/3] Add Aspeed G7 MDIO support
Thread-Index: AQHbOadJpi6fxSNzsUeMszvV5wuaILK912EAghmG4js=
Date: Mon, 27 Oct 2025 02:44:23 +0000
Message-ID:
 <SEYPR06MB513478C462915513DE7BE1AE9DFCA@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>
 <7368c77e-08fe-4130-9b62-f1008cb5a0dc@lunn.ch>
In-Reply-To: <7368c77e-08fe-4130-9b62-f1008cb5a0dc@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEYPR06MB5961:EE_
x-ms-office365-filtering-correlation-id: 7e4429e5-2bfe-47a7-8478-08de1502bca5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|8096899003|7053199007|13003099007|38070700021;
x-microsoft-antispam-message-info:
 =?big5?B?bGd3MDllaDFBamx1NXo5RnVucm10aURKM3RUVlFnN240citGcmpoTzlsV3NRQjNS?=
 =?big5?B?cWdtZU4vWFRMdlplVzZNOWoyUDllTVpFRU51T2ZWdGswRHZBWUNndnlwZTRwVEZ5?=
 =?big5?B?YWxnU1NjSWlLNlJkSU4ySEU3WXFyV3NnOXNhcXFROUtSd2FXTlJiT3ZWaTRSMUJh?=
 =?big5?B?UTB4N3NCd2JydTFjbVdtdGhtdW5iVWwzbTlRQkpHSnBBeTdOYjhGbkkvdDRMdlBD?=
 =?big5?B?RUdpRUxVL3NLQ3hPaWIrVWpLK3ZOV3dpUXB1dlRrR3QvOFRpZUJoZzJ5R0xtaEVW?=
 =?big5?B?SExzMGczbjc2L0RyaTQ5eXJ6QzBWNlhOL2svYlFYRTJyRVZqL1V4cmZUeW8rUFZ1?=
 =?big5?B?OU1rams2dUxRdURJTVR1UnRQTFFKZVpNSW1iekhHNGM0RTRoRTR4WUJqSUpFZW1X?=
 =?big5?B?UjFMdnlyMkZ1WnNLVVc4RWlqTnYzcDcvVWU4bkQ2dDlEYXVxS0N0WlhBM0hSRjdX?=
 =?big5?B?dnB5OEN2ejJhTWVMUzBPcmtwZTdoQzRCclQ1R2dOTUsraFJWajV3OTRHd3JVcG4z?=
 =?big5?B?Y2pXNHRFdHc2U1k3MWhmTXNNUDVWSGJZcWlSbld1UTFtUWJqSXlRenJPYmJ4VTJI?=
 =?big5?B?K09FUUd6aytoVVkxdENBN2grTzNsMG1rbThaRXN1RjFMcG5HZWhxNkdNaDdRdyti?=
 =?big5?B?L3B3dk9pNXg3K0t1eDRMTXJjaEJZL056NjlJSTVUNXhZdW1wbllVMkVJb3ZtMkI5?=
 =?big5?B?WTZQamprVTRpUUdXRFFUWndpZzNCNEROb0hZQ1FnMElZQzYzQUZyT2tvRk9RQTZo?=
 =?big5?B?cFNJemtqNzhGazRpWkU5eWNHRVdpMDVGL1hDWkdoT3FxbUZxRjUzVG13QUFROE04?=
 =?big5?B?bUtQUGhkUm9ET0RmREFJdk5hOE13RFJnZytnQ3VobjB1aEdmSU5lTG5kVkQwSERL?=
 =?big5?B?SnJSYXNoaGxNcjZ2L1kzN2hGN0JEeEoyNDl1Q0hzZ3owSUlWVkk2VFhWb3BBaUhz?=
 =?big5?B?eHpudHkyazVXb2EwM1IvanI2REV4TUV0UnBTUktPamhmWDBTRjFKaTNsdzJhNyt6?=
 =?big5?B?V1MrRkdFL2hYTHpPZFUxLzV3MEF5ZlNuQzk1bk43TXlWcDBySTZMazk3dkFwbjd6?=
 =?big5?B?M3BMSWpKZklvZWtIV0xLeDZHNHdSQlJNeFBHRnFpQVU0TzU0ODZ6aUl2MWE0OHZI?=
 =?big5?B?VjVFbGpRVmczTVlOSkFTUEJnWWlUaGY2Uzd2TzVJRmh6cHhRd001M09KVGNQZGt3?=
 =?big5?B?QVNGamZPdjV5Sm9zWmFySUh2VWhabERQNUZ2dWtVbFNOTlBuTmRFN1dNNGpDaTNw?=
 =?big5?B?YXBmRkVuZ0xuMHVOMHJXUTY4cm5hUFdYbWtKU3JLTUJKQkpwczB5V2x1UG1xMGh1?=
 =?big5?B?VUNqK3lEUHoxcU9pK3RpS3A0NVE4MXJoS0Juc05UbFN3NDJaaWxuRW1tc1pUcnYy?=
 =?big5?B?ekphUk1FNjhyQTY5Qlo0TkptN1R5eW1XeThSaFVWS0d5YzlLRTI0cmtFQmJ4cGNZ?=
 =?big5?B?S2tTdmdUSk1tL2duczdiQm5RWmp0b2M5cThhOTdnS0hkYkZ4N3crQ3F1R0d4bVZj?=
 =?big5?B?b0V2SGxHOHUyRk83clNqNFNyZThybTZYamhuTVZkbi9PT0M5TGM2SStTckFKbDM2?=
 =?big5?B?TUkxbDVIM3NtVWZTQ0djNjZuRUJBSis1VXdKZ29XbW93Rlo3U0hPSWJMVXRuTVFx?=
 =?big5?B?Y2JUR2g1UXVuUU9nL0lTbnlrUTFkdG9VeUdZVDRqTCtSOFRnWjk2K0xYTTJNV3cy?=
 =?big5?B?RFZEZ2s2WEtIS2ZiSjN1SGFBalV2enVEUTZFVi9rYlZuUXVadkJTbG41YUdMSW1z?=
 =?big5?B?Zi93L1NPR0lUUG43djhETHhQWmJabXRseWNQdmRsQXJmS25OUTNROEJhMGcvNE1w?=
 =?big5?B?elA0bGVRWlVKbVpUS1RNMzVIaTVkS1YwNnBITWNsYTBpSGNBL1lkaUxPaHNhNEgy?=
 =?big5?Q?V0OR4EfZzUrLKgWw+nrFIcZ0/HIubMx6Ehi7Pi+ofVClTOLU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(8096899003)(7053199007)(13003099007)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?cnlzWGV3OEl1dTJGc2hKd1NnRVhXUDBsSEx1aUpOVUw1dmFaZ01GTXA5dnJxSU1w?=
 =?big5?B?UXUvTm5WdklhZ0JpY0EyTzhwUyszREVzKzZCclZvQUtkTnRqaVpkSFE4dEpnUDk2?=
 =?big5?B?RzBFWDVPcnBTbWtaZ2pJYnNHZytZbUNVZmRlcmc3R1lFMy9CaExDdmRyNyt4QlQr?=
 =?big5?B?cmJCcXVMM2NWWXBqYWwxN3hBc2cyS3RWU1I0a2d4T3JNUTNVVGJxNXVTanVSdzdo?=
 =?big5?B?bkNzMnM4eGw3MGVoOWRPaFVadGkydVZLN0tkVEZldDdQdHRBc25UOHJVNEtaTlpv?=
 =?big5?B?T3JyVnZvMTh0QVBCenhKdU9qbk5hMGFZUUVBdk04a0RtVFB2NWNEdHhKZlFnY0pT?=
 =?big5?B?NWllcDRtQ3dyT3QvcmJEWlpxUElIa2tFYTZpd2pReXlpeFNTcllRWHAyMEROZENx?=
 =?big5?B?TmpLWWNhRHAwQXM2cllXRDBLVU9MNFB3R2ZaQ1N1NHBsUENaY1dBOTZvR0NTS2Rx?=
 =?big5?B?Mi9EQnBKeG1KaXJhUGNzTmVSa0JvVFVvZVorR1VtYmNoTFpuVDRGVmlCb0czY0pH?=
 =?big5?B?dW5WVUt1K2NMZWRPYlZ6bUJmZC9VVmJLeUpHVzl1UE56eXFsY1A5WTIvbHhHSFAr?=
 =?big5?B?SUwzQzM3TStneWlSSEc1SUR5cTFEZUN2SFJqSGZPTVE1cFdWb0ZLRHdRZTFjWndQ?=
 =?big5?B?ZUVwaHJMSFA3SFo1cE9mTFRMa1JaYXQwVWdhaXhjT0RIUFd4MDQyUjNibEI3YXZz?=
 =?big5?B?V29xKzlsR3JKc2ljYkxZWndpV0djTHFHMnNyWTc3anE2ZFQ3Ym5KTFRTQWJqbW5S?=
 =?big5?B?amlETmlHdytIaVpuMFMwSnlwamt4YW8zUmYwUlZ3d2srM2g1MGRuN1FjL1k3eE5W?=
 =?big5?B?ZmhOVDd5dHhYNFc0NEU2RVpJRXVLL0FqSXBBamZnNHlCNGJxMzUxQnJYTGFNZUZF?=
 =?big5?B?bzZKdThLQUtQVkdLUmswbnAzelo3YmQyc3h1dHRDMjUxNlM4enV4TEFYVzUxMDE3?=
 =?big5?B?NDcyNG5ObnQ2OGh6VmFzMlc1OVNFL2ZQRnhxVVpPclZ5TVJ5Y0Y0YnFtN3d1QW1y?=
 =?big5?B?VFRNNE5kallFdHJVdVdyU1VDQXlHMkZFZUFGblVtT0taM2xFZnpHZlFXcUxPaHNa?=
 =?big5?B?UDZxRzNETkNzUERGMkdCc0p4c2ZOZUpWVDhUSzR2aU43SnFDMC9jbEo1N0ZQRHZi?=
 =?big5?B?QTIydmdHVVBwZEFNRHFaUWNkcTdvUXl3dE1DbXhsUTJPTTZPeW5hSm1oSVhZTmJC?=
 =?big5?B?S2JhaEMyR0dtK0t1YWYzS0oyUFBERXc3MXpFSzMyc1lBQ1hONGJMTlpONTJaS3NI?=
 =?big5?B?QnIwMUx3QW1wNHRiYkdrZncwa2l1ZzJjWmp4M2xTeGU3anBnUTNvUkc1b3JkV25U?=
 =?big5?B?c0pCUy9MV0xiRXp4QU5hU2sxZFJLZFVCVDNJanFjMlU2YnVTVXhvZnZlZVZTV0Fj?=
 =?big5?B?aTVmRUhOcG91U1FIV2t4OERNaDFlTzg1eHh4dXRkNmtkd2xLZnBaQ09hQWdKZ2Vs?=
 =?big5?B?ZDVraHRmQWQyaVF2WUN1Mk14YXlQWUROV05UWmRVbjF0TEVQdnppUzU1bUhEdGl4?=
 =?big5?B?dy9VVVNpOUtqQnJqaWRxWmZkYkFjejhuUVpmWlRqY2pMMzNYSkVoaHpjUHZxbHJD?=
 =?big5?B?QUEyYjZ3QVFnTVlrSGZxM2JrclFGMWFVYllLSEt4WW9IWi9uVDRWenhDeFdTL2J5?=
 =?big5?B?d0hjVDZCTDN1c1U4OGx4Sk1aUWYzVEsvNENoMHlhMk9qUWtMUFlIMHdJUkZRN3Uw?=
 =?big5?B?aG1YTWM2QWxWVll2SXhCcEpjRzhuRHpDRFdEREwyWG42Tld1UHlIeWo1Z1NBVXE2?=
 =?big5?B?ZzgwMFZUWmpqK043aGhrZER0NVZBR09xS2k1eU9oVyttcGUvZTgvR0lTTVVRNUR1?=
 =?big5?B?NGpUY1FUcnB4VXkzTXVyTHJtb2lkK1FLaVVTbU1TcjlOTVdSZUZ0SEhudnltV2lE?=
 =?big5?B?L3hIOGtvWndPaCtkUWVqU0Z2eEZ3WkJyRGJSWWlDR2dOZTlGMWFsbEJRSDB6bTZs?=
 =?big5?B?MERRWjhkTzQwdzN6V2tHT0pqQjc3azV4U2dKK1VxRllXQzBMTjBGc1U2OWlZUzlv?=
 =?big5?Q?2oybzXKmPLkEPj+g?=
Content-Type: multipart/alternative;
	boundary="_000_SEYPR06MB513478C462915513DE7BE1AE9DFCASEYPR06MB5134apcp_"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4429e5-2bfe-47a7-8478-08de1502bca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 02:44:23.0817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1XdbWk3hqBsiVmZg/OhrdwxNaUQpShhERGryV5dDFiZ2uVfCxQ2eGuS+nDEvevFEubp5J4QhH5GIkeQJv+4l+Tn1jxrrdftUqXORwV/o/GE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5961

--_000_SEYPR06MB513478C462915513DE7BE1AE9DFCASEYPR06MB5134apcp_
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64

SGkgQW5kcmV3LA0KDQpUaGlzIGlzIEphY2t5IGZyb20gQVNQRUVELg0KTGFzdCB5ZWFyLCBJIHN1
Ym1pdHRlZCBhIHNlcmllcyBvZiBwYXRjaGVzIHRvIGFkZCBhIG5ldyBjb21wYXRpYmxlIHN0cmlu
ZyAiYXNwZWVkLGFzdDI3MDAtbWRpbyIuIEF0IHRoYXQgdGltZSwgdGhlIGZlZWRiYWNrIEkgcmVj
ZWl2ZWQgd2FzIHRoYXQgaWYgdGhlcmUgd2VyZSBubyBmdW5jdGlvbmFsIGNoYW5nZXMsIGEgbmV3
IGNvbXBhdGlibGUgc3RyaW5nIHdvdWxkIG5vdCBiZSBuZWNlc3NhcnkuDQpSZWNlbnRseSwgd2Ug
YXJlIHN1Ym1pdHRpbmcgdGhlIEFTVDI3MDAgcGxhdGZvcm0gc3VwcG9ydCB0byB0aGUgTGludXgg
a2VybmVsLiBJbiB0aGUgZm9sbG93aW5nIGRpc2N1c3Npb24gdGhyZWFkLCBpdCBhcHBlYXJzIHRo
YXQgdGhlIE1ESU8gZHJpdmVyIG1pZ2h0IG5lZWQgYSBuZXcgY29tcGF0aWJsZSBzdHJpbmcgZm9y
IHRoZSBBU1QyNzAwIHBsYXRmb3JtOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2IwNDhh
ZmMxLWExNDMtNGZkMC05NGM5LTM2NzczMzlkN2Y1NkBsdW5uLmNoLw0KSSB3b3VsZCBsaWtlIHRv
IGNvbmZpcm0gd2hldGhlciB0aGlzIGNhc2Ugc2hvdWxkIGJlIHN1Ym1pdHRlZCBzZXBhcmF0ZWx5
IHRvIG5ldC1uZXh0LCBhbmQgaW4gZ2VuZXJhbCwgaWYgdGhlcmUgYXJlIG5vIGhhcmR3YXJlIG9y
IGRlc2lnbiBjaGFuZ2VzLCBpcyBpdCBzdGlsbCByZXF1aXJlZCB0byBpbnRyb2R1Y2UgYSBuZXcg
Y29tcGF0aWJsZSBzdHJpbmc/DQpUaGFuayB5b3UgZm9yIHlvdXIgZ3VpZGFuY2UuDQoNClRoYW5r
cywNCkphY2t5DQoNCioqKioqKioqKioqKiogRW1haWwgQ29uZmlkZW50aWFsaXR5IE5vdGljZSAq
KioqKioqKioqKioqKioqKioqKg0Kp0uzZMFuqfo6DQqlu6tIpfMoqc6o5Kr+pfMppWmv4KVdp3S+
97FLuOqwVKFBqMOo/Kprq9+rT8VAoUOmcCCleLrdq0Sr/Kl3pKemrKXzqsyhQb3QpUi5caRstmyl
87Nxqr6lu7lxpGy2bKXzpKe1b7BlqswsIKjDvdCl36dZp1Kwo6W7uXGkbLZspfOkzqjkqv6l86lN
vlC3tKnSprO9xqZMpfOhQ8HCwcKxeqq6plinQCENCg0KRElTQ0xBSU1FUjoNClRoaXMgbWVzc2Fn
ZSAoYW5kIGFueSBhdHRhY2htZW50cykgbWF5IGNvbnRhaW4gbGVnYWxseSBwcml2aWxlZ2VkIGFu
ZC9vciBvdGhlciBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24uIElmIHlvdSBoYXZlIHJlY2VpdmVk
IGl0IGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcmVwbHkgZS1tYWlsIGFu
ZCBpbW1lZGlhdGVseSBkZWxldGUgdGhlIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIHdpdGhv
dXQgY29weWluZyBvciBkaXNjbG9zaW5nIHRoZSBjb250ZW50cy4gVGhhbmsgeW91Lg0KDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KsUil86rMOiBBbmRyZXcgTHVubiA8YW5kcmV3
QGx1bm4uY2g+DQqxSKXzpOm0wTogMjAyNKZ+MTGk6zE5pOkgpFekyCAwOTo1MA0Kpqyl86rMOiBK
YWNreSBDaG91IDxqYWNreV9jaG91QGFzcGVlZHRlY2guY29tPg0KsMaluzogYW5kcmV3K25ldGRl
dkBsdW5uLmNoIDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+OyBkYXZlbUBkYXZlbWxvZnQubmV0IDxk
YXZlbUBkYXZlbWxvZnQubmV0PjsgZWR1bWF6ZXRAZ29vZ2xlLmNvbSA8ZWR1bWF6ZXRAZ29vZ2xl
LmNvbT47IGt1YmFAa2VybmVsLm9yZyA8a3ViYUBrZXJuZWwub3JnPjsgcGFiZW5pQHJlZGhhdC5j
b20gPHBhYmVuaUByZWRoYXQuY29tPjsgcm9iaEBrZXJuZWwub3JnIDxyb2JoQGtlcm5lbC5vcmc+
OyBrcnprK2R0QGtlcm5lbC5vcmcgPGtyemsrZHRAa2VybmVsLm9yZz47IGNvbm9yK2R0QGtlcm5l
bC5vcmcgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBqb2VsQGptcy5pZC5hdSA8am9lbEBqbXMuaWQu
YXU+OyBhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXUgPGFuZHJld0Bjb2RlY29uc3RydWN0LmNv
bS5hdT47IGhrYWxsd2VpdDFAZ21haWwuY29tIDxoa2FsbHdlaXQxQGdtYWlsLmNvbT47IGxpbnV4
QGFybWxpbnV4Lm9yZy51ayA8bGludXhAYXJtbGludXgub3JnLnVrPjsgbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZyA8bmV0ZGV2QHZnZXIua2VybmVsLm9yZz47IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnIDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZyA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgbGlu
dXgtYXNwZWVkQGxpc3RzLm96bGFicy5vcmcgPGxpbnV4LWFzcGVlZEBsaXN0cy5vemxhYnMub3Jn
PjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZz4NCqVEpq46IFJlOiBbbmV0LW5leHQgMC8zXSBBZGQgQXNwZWVkIEc3IE1ESU8gc3VwcG9y
dA0KDQpPbiBNb24sIE5vdiAxOCwgMjAyNCBhdCAwNjo0NzozMlBNICswODAwLCBKYWNreSBDaG91
IHdyb3RlOg0KPiBUaGUgQXNwZWVkIDd0aCBnZW5lcmF0aW9uIFNvQyBmZWF0dXJlcyB0aHJlZSBN
RElPIGNvbnRyb2xsZXJzLg0KPiBUaGUgZGVzaWduIG9mIEFTVDI3MDAgTURJTyBjb250cm9sbGVy
IGlzIHRoZSBzYW1lIGFzIEFTVDI2MDAuDQoNCklmIHRoZXkgYXJlIGlkZW50aWNhbCwgd2h5IGRv
IHlvdSBuZWVkIGEgbmV3IGNvbXBhdGlibGU/DQoNCiAgICAgICAgQW5kcmV3DQo=

--_000_SEYPR06MB513478C462915513DE7BE1AE9DFCASEYPR06MB5134apcp_
Content-Type: text/html; charset="big5"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dbig5">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Consolas, C=
ourier, monospace; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementT=
oProof">
Hi Andrew,<br>
<br>
This is Jacky from ASPEED.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Consolas, C=
ourier, monospace; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementT=
oProof">
Last year, I submitted a series of patches to add a new compatible string <=
code>&quot;aspeed,ast2700-mdio&quot;</code>. At that time, the feedback I r=
eceived was that if there were no functional changes, a new compatible stri=
ng would not be necessary.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Consolas, C=
ourier, monospace; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementT=
oProof">
Recently, we are submitting the AST2700 platform support to the Linux kerne=
l. In the following discussion thread, it appears that the MDIO driver migh=
t need a new compatible string for the AST2700 platform:<br>
<a data-start=3D"621" data-end=3D"696" rel=3D"noopener" class=3D"decorated-=
link OWAAutoLink" id=3D"OWA312e4175-706b-f99d-5b28-39a257a7be24" target=3D"=
_new" href=3D"https://lore.kernel.org/all/b048afc1-a143-4fd0-94c9-3677339d7=
f56@lunn.ch/">https://lore.kernel.org/all/b048afc1-a143-4fd0-94c9-3677339d7=
f56@lunn.ch/</a></div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Consolas, C=
ourier, monospace; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementT=
oProof">
I would like to confirm whether this case should be submitted separately to=
 <b>net-next</b>, and in general, if there are no hardware or design change=
s, is it still required to introduce a new compatible string?</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Consolas, C=
ourier, monospace; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementT=
oProof">
Thank you for your guidance.</div>
<div id=3D"Signature">
<p style=3D"background-color: rgb(255, 255, 255); margin-top: 1em; margin-b=
ottom: 1em;">
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
 15px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">=A7K=B3d=
=C1n=A9=FA:</span><span style=3D"font-family: Consolas, Courier, monospace;=
 font-size: 12pt; color: rgb(0, 0, 0);"><br>
</span><span style=3D"font-family: Consolas, Courier, monospace; font-size:=
 15px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">=A5=BB=
=ABH=A5=F3(=A9=CE=A8=E4=AA=FE=A5=F3)=A5i=AF=E0=A5]=A7t=BE=F7=B1K=B8=EA=B0T=
=A1A=A8=C3=A8=FC=AAk=AB=DF=ABO=C5@=A1C=A6p =A5x=BA=DD=ABD=AB=FC=A9w=A4=A7=
=A6=AC=A5=F3=AA=CC=A1A=BD=D0=A5H=B9q=A4l=B6l=A5=F3=B3q=AA=BE=A5=BB=B9q=A4l=
=B6l=A5=F3=A4=A7=B5o=B0e=AA=CC, =A8=C3=BD=D0=A5=DF=A7Y=A7R=B0=A3=A5=BB=B9q=
=A4l=B6l=A5=F3=A4=CE=A8=E4=AA=FE=A5=F3=A9M=BEP=B7=B4=A9=D2=A6=B3=BD=C6=A6L=
=A5=F3=A1C=C1=C2=C1=C2=B1z=AA=BA=A6X=A7@!</span><span style=3D"font-family:=
 Consolas, Courier, monospace; font-size: 12pt; color: rgb(0, 0, 0);"><br>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>=B1H=A5=F3=AA=CC:</b> Andrew Lu=
nn &lt;andrew@lunn.ch&gt;<br>
<b>=B1H=A5=F3=A4=E9=B4=C1:</b> 2024=A6~11=A4=EB19=A4=E9 =A4W=A4=C8 09:50<br=
>
<b>=A6=AC=A5=F3=AA=CC:</b> Jacky Chou &lt;jacky_chou@aspeedtech.com&gt;<br>
<b>=B0=C6=A5=BB:</b> andrew+netdev@lunn.ch &lt;andrew+netdev@lunn.ch&gt;; d=
avem@davemloft.net &lt;davem@davemloft.net&gt;; edumazet@google.com &lt;edu=
mazet@google.com&gt;; kuba@kernel.org &lt;kuba@kernel.org&gt;; pabeni@redha=
t.com &lt;pabeni@redhat.com&gt;; robh@kernel.org &lt;robh@kernel.org&gt;; k=
rzk+dt@kernel.org
 &lt;krzk+dt@kernel.org&gt;; conor+dt@kernel.org &lt;conor+dt@kernel.org&gt=
;; joel@jms.id.au &lt;joel@jms.id.au&gt;; andrew@codeconstruct.com.au &lt;a=
ndrew@codeconstruct.com.au&gt;; hkallweit1@gmail.com &lt;hkallweit1@gmail.c=
om&gt;; linux@armlinux.org.uk &lt;linux@armlinux.org.uk&gt;; netdev@vger.ke=
rnel.org
 &lt;netdev@vger.kernel.org&gt;; devicetree@vger.kernel.org &lt;devicetree@=
vger.kernel.org&gt;; linux-arm-kernel@lists.infradead.org &lt;linux-arm-ker=
nel@lists.infradead.org&gt;; linux-aspeed@lists.ozlabs.org &lt;linux-aspeed=
@lists.ozlabs.org&gt;; linux-kernel@vger.kernel.org &lt;linux-kernel@vger.k=
ernel.org&gt;<br>
<b>=A5D=A6=AE:</b> Re: [net-next 0/3] Add Aspeed G7 MDIO support</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Mon, Nov 18, 2024 at 06:47:32PM +0800, Jacky Ch=
ou wrote:<br>
&gt; The Aspeed 7th generation SoC features three MDIO controllers.<br>
&gt; The design of AST2700 MDIO controller is the same as AST2600.<br>
<br>
If they are identical, why do you need a new compatible?<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Andrew<br>
</div>
</span></font></div>
</body>
</html>

--_000_SEYPR06MB513478C462915513DE7BE1AE9DFCASEYPR06MB5134apcp_--

