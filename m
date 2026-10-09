Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D589606A31A
	for <linux-aspeed@archiver.kernel.org>; Mon, 19 Oct 2026 23:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=NETORGFT5377951.onmicrosoft.com header.i=@NETORGFT5377951.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NETORGFT5377951-onmicrosoft-com header.b=rAnjiAaY
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7sjr5sqmz2yVT;
	Tue, 20 Oct 2026 10:50:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c105::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791553541;
	cv=pass; b=fRSh/+3hBGHMFeiZeEXJvsRMwVIw6+M/kZH2ZAAKeQGllVqazQgAKVl2fEqORUW2k9gnzjTXPaptPcIuLy+GJ1kjcB0BfSNDnnAPkdx8hsfCZ2ek9pH2ylt/QywTVKLTy7j8nIYSecTD43uXiEZf65FoiC9ioQje1QvF1FHzM7IuicZzc+yjdEUc+AEmbKewHZD99LO06LsTTVZLnjRGA00d+o7uRkQKy+on1qGF4Q137ud71p0y3fsHPPlHTSgngIGCUVMoItnLnTkTrcTwy4JmcgVM27VPvpO+6WKbUzpLXZNotfhgdemHSsC+fPL1Oq28ff0GGxLWusT0CXBhvA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791553541; c=relaxed/relaxed;
	bh=07xaFjE5G3xzKBIeTTG27YE4V2POVhFRuvj/GpT+zso=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XFMJD2fOdRm/po5F+7r6qLNKRhY9ZANcGww3eM/JRsM2mijq5huXR4TUwN9Hi+gOPoIWo8DoLOEEYZSpKq2jjFYN7ebURfkMSDGPIBf0RxqneBivWD6d0I6PObM0wNbS268+QtCFh+0k+RuJCbFEMDb9Z7ysrx/qmWRdUTe7FI+tetcDGNgnljUrypcyNrno4shAHH7qjwv8C40xOKX2Ri6snYb30a51e3UZ4G02Mwfg+mBol1QbaF3/WhRebf44xFsR0z8ZIMhDMYWMNGsirt6iKR2AQGj8ch7gemVJAGy3O6iti+wuGYLna/LfGtAQZ2vOcFBIQAcveqZNiM4+zQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=phil.gs; dkim=pass (1024-bit key; unprotected) header.d=NETORGFT5377951.onmicrosoft.com header.i=@NETORGFT5377951.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NETORGFT5377951-onmicrosoft-com header.b=rAnjiAaY; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c105::7; helo=ch4pr04cu002.outbound.protection.outlook.com; envelope-from=phil@phil.gs; receiver=lists.ozlabs.org) smtp.mailfrom=phil.gs
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=phil.gs
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=NETORGFT5377951.onmicrosoft.com header.i=@NETORGFT5377951.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NETORGFT5377951-onmicrosoft-com header.b=rAnjiAaY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=phil.gs (client-ip=2a01:111:f403:c105::7; helo=ch4pr04cu002.outbound.protection.outlook.com; envelope-from=phil@phil.gs; receiver=lists.ozlabs.org)
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c105::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1Smg0VRZz2yjp
	for <linux-aspeed@lists.ozlabs.org>; Sat, 10 Oct 2026 00:45:38 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJI5Tz+LFd+Kkb7IUpCB8tcWUHXlRJOuaaZ8rxIV3KbIknzzxzF1hn0u1EssYYCNEbyHiNAl5u2BP5Ivukd+blpK7BQjysIigTxM5jL13PI27TO/z2kzg9elWePm8dq1TPXLqbWMX+Hcz04FRPEYMdNkFZm7sKVasYr40RKqY9CP7VCu1ehTjeLcNYLGmnQnqAMNEBFmWIidnymFZDNaF2SaUMvIzCOq/VbuEek9X770LOHU+FW9yDhAnigFOY9z87dxVZg2Ao1VS9SjgwQiaS/Gv6fXofBqiLjWde7wIpCQ0bvjHVS0cKx0ycyi7v2aduTT0RA3e5XCFWxvDBh14A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07xaFjE5G3xzKBIeTTG27YE4V2POVhFRuvj/GpT+zso=;
 b=BMCaXVSCwYre5lx29T7X+NjZ22tZQNxr/7n/v5zVlcmha+EXN9P2jcY6PFQvhYkZSUC8IOHuoQlNzR75Tl6eCeP/ilOpHN0uoV+OnpmiNy+qZFUXhua2tEwFGmSMWk0k4f//dwEivR6stIO/zuHELoPOMdmQF0zuDe8J9lAWkdSwiV4QEjsvvu3EhQzw7jwPYMF52CwmfYkFppRxbhPMQyiX6lNuMRnh/IecWxRfp4FVLd/daq2rk4Q93zmeEHxFG73etkxYKz4jN0O3Bs70C/9NW1jdLe9XtnN7shd/FDGGesss1+5fvxuLvgXnSEd5dNu1XLVeo+SPh4+BnaPisg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phil.gs; dmarc=pass action=none header.from=phil.gs; dkim=pass
 header.d=phil.gs; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORGFT5377951.onmicrosoft.com;
 s=selector1-NETORGFT5377951-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07xaFjE5G3xzKBIeTTG27YE4V2POVhFRuvj/GpT+zso=;
 b=rAnjiAaYoudxzJIgF5zLcLEmjsj6aH2vrSD+s6W8MKcbz04bSAluDBbU88KK5vUzTLDUIGy+n5koldpcKfeZXwdrtG9EJiNa/bmcbPEbUOdAdz9q07z53ot7vTYh0RdHse+PIx4lU6d9YNH2McmrHTEw4UQa61n7pUtMGwJFA00=
Received: from BY5PR04MB6472.namprd04.prod.outlook.com (2603:10b6:a03:1eb::10)
 by DM6PR04MB6475.namprd04.prod.outlook.com (2603:10b6:5:1eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 13:45:13 +0000
Received: from BY5PR04MB6472.namprd04.prod.outlook.com
 ([fe80::3a9:9dbc:2aeb:8827]) by BY5PR04MB6472.namprd04.prod.outlook.com
 ([fe80::3a9:9dbc:2aeb:8827%6]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 13:45:13 +0000
From: Phil Rosenthal <phil@phil.gs>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Corey Minyard <corey@minyard.net>,
	"openipmi-developer@lists.sourceforge.net"
	<openipmi-developer@lists.sourceforge.net>, Andy Shevchenko
	<andy@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, Ninad
 Palsule <ninad@linux.ibm.com>, Andrew Lunn <andrew@lunn.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250_pci: Add support for ASPEED BMC VUARTs over
 PCIe
Thread-Topic: [PATCH] serial: 8250_pci: Add support for ASPEED BMC VUARTs over
 PCIe
Thread-Index: AQHdVyjD7y+hjU8szkKNfIrsjPkQ17b06hAAgABQYgA=
Date: Fri, 9 Oct 2026 13:45:13 +0000
Message-ID: <60996F21-A12C-4FCC-9D5E-9D188A4ADBEA@phil.gs>
References: <20261008-aspeed-vuart-v1-1-d2be17c99cd7@phil.gs>
 <CAHp75VdiO9tPX2vLqsX2-omNvs-YjkWWD-HOiqyDSzpJrrZ_5w@mail.gmail.com>
In-Reply-To:
 <CAHp75VdiO9tPX2vLqsX2-omNvs-YjkWWD-HOiqyDSzpJrrZ_5w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phil.gs;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6472:EE_|DM6PR04MB6475:EE_
x-ms-office365-filtering-correlation-id: 4469c403-5abf-464a-2a83-08df260b8b2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|19092799006|10067099003|56012099006|5023799004|4143699003|7055299009|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 Snxa2I3I/xTVvx1PFsP4DDSr3FyfAQOkbxfLsVAKXZhNzBGo2/2CUWdkpHNIDNZzuQFpX9R6K7BBvW7rbqIJJ8i0DypGigwcAiGNaleG/m7Pkwv7exwAmAG1QVpEg+B7717GBBb5Q60EEMbcNc2UsYsxwhzbgVFwXoZ+rNKCQwdJ9F92flEuj2u6wgeiCuuehVDZR2QPG4aTzGBxQjJ5ffm7bZ1yftny3E/b1NEiaCTnIqbhZsqkYOneC9w9gCFYrMFsuR3e8khJU27OfxX3yRdKn935wCxyqZt3gCAXP8Kk/qHrGKTm3U3qK/EDfEZ2ljKu/8RWaLIWEvED68SoBi917L/IToaSpSdyqZWuSGMiQQj3kR9vJQhKSpZeT7+8JJg7ammzUOtMHWVmqXcc2FRaToIZKq4YmyYtE/XnHbYksxzDJlrc6fGc4C3cGNbGYpisAITdQVxt5Ap3RviT5FhExgQHY64wvP0Xpz69qX4qvwJzoiqKwCGaf3eph0wZCIzrWUmoXI4pU6CDq1g+0Q+Y0bQ/NOovGZ8O+00bSOKQroxiyi9sUzqUOGZErrj5c607XNovvTZpd8h6koEeRCvaAwBHtCKJ91SINOIBYhDsqL7u+gX9w+3gQBxlZ13MxGUZKI0zEevLAo1woQOPMtE5peeU7OcxcCAxhnRR06/RlD9LSWJt7zslmPyiVlXAib5G9tk0JAJGAuTghB1r2Hl8qlMjgci1FkqTrbd83YayA+zh/6kjZZGLGMlsCOGx
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6472.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(19092799006)(10067099003)(56012099006)(5023799004)(4143699003)(7055299009)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TW1KaEJJY0srUTlNTGtPc2FRaWliQ3VscVhkUE5odk4rMFpPcFFJSytUNStz?=
 =?utf-8?B?aXRBTlZGVTllejk3WExPd1QxeDhKcExMYlFYajRwK3l0dXBuSmxxU1F2THgx?=
 =?utf-8?B?OUpnenJqSE5qU2xiYzU4OEF6REFZOHY0cVJnWS9SbGpwK1oyODIzcVJpSi85?=
 =?utf-8?B?T2EyTlpDU1o5cVRUVzZCQTBQUDNqWHBOM0lQZ1NGemxZZHl6VDNpOS9ESm1G?=
 =?utf-8?B?b2QxeHBEajQyTENVckRtaFBJdEVDUFNpMTVKWi94VkVLTElpWUZrNU42VWgw?=
 =?utf-8?B?UmxXbzJjcDZsR0dBUWtNcGpCQ2ExTUFiMDZmZC91Mm9tQldqWUpXdGFIRncz?=
 =?utf-8?B?VW9VN3pBdzBZWVJQYUNuSVJNbHpWWEk3b1dqQzlwSjZDeVU3QlMzeS9JdEUr?=
 =?utf-8?B?Z3dyU0FsMXk1SWEvb3MzK2xweFBzdEpSSzFtbEhKem9DMkNOL3FVSHJBNnoy?=
 =?utf-8?B?UFp6aVNsdkYzbUF4SjhhdnpJb0xyNVBMcW4yd2NyZ2F1Q0lRUjVoWVN2ZHhJ?=
 =?utf-8?B?RkNCWnBVUUZISTlMZGFlQkZ0aGdFUkEwU0ExSzdWdkI5YW9LQ1huc1hFaVJZ?=
 =?utf-8?B?ZHBLS3FWSXFhTGdYMHBrT254WkZWTzY0bTFLaXFTOUtQVVBTeCtSc2thOWtt?=
 =?utf-8?B?TW1HTjYzVGdpV2EzZkNBYmJ3QVp5eXJEZmMrVFBoaG1GVW5mdzhWdlJzNmhm?=
 =?utf-8?B?NnZ3NnlIZFB3Y29ZWTVyL2xhbXFHQnE1aWVCdjlUNzlYOTlVM1NzdjlXbEhV?=
 =?utf-8?B?TGNkTTcyaUVHTkJjNXh6SGMvdXBUWk5RSHRNeGJYZk5jbEhYcDZRZDB1a1VT?=
 =?utf-8?B?TktweTVPUDBSU3B3N0RMUlRlS3ZmUVhOVlRxTjgxa3c5aThyOWlIY2FLcVRB?=
 =?utf-8?B?RU9CT0I5N0hvVXZ3ZHBOQ3pXUDhtNW9NM3V6aTZEbFUvRVZocWkxT2FHZVlE?=
 =?utf-8?B?b2lVR2NiYjBjQXdkU1F4VDlkc0VTVVVJYUxMMHkyVWtFdlRJQ21kcHRLODQ2?=
 =?utf-8?B?NENUMHFDZm5RNWEyaktaTHpkcEVQR0JTcnpjcS9EaE9mM0t3azZnK0lIcDFr?=
 =?utf-8?B?bnJYS0kzMFNTV2dwS0J3bG1Gd0pGVnFpaTVVZGs2a25WUURkdmdMRGdYa2lK?=
 =?utf-8?B?aG9tamdnRXRWSFNSZ3p5aDBydGJWMkxyemxPNWZYZnoya1NmRUVqRGFlT2Y1?=
 =?utf-8?B?c2ZjVEMrVnVoSTk4OEw4K1JVY1k2eDVhY3R2LzVqOERlK2ZNMit3eWowaTZs?=
 =?utf-8?B?cHlVd3RpNGRwNGVuSS9TTFZ4NlQ4NVpIU05kNFIrdThGNHlYdGphcjl2QWNk?=
 =?utf-8?B?S3A3U2tWbzRtOXU0VjB3Smk1b3NHTmoxNG8xeEVKek1xSS92OElnOGpYUXk4?=
 =?utf-8?B?MUFDY3Y3MmZ5dUNJS0dpTVpKYjRmZTBFMlBYOXI3eEx1cWJPN3VPNkRIaXlk?=
 =?utf-8?B?L2ZLV0hOYVpKZ2YwcXBlSkJsM0VMcG1wQ29BVHFsVldsaCttR3NTRExGM1E5?=
 =?utf-8?B?SlczUmdnY3ZFRjQ2RFNtL2d6Ykxyb3RKdkpBVE9UaFRQc242dHVoTjE5a2Iy?=
 =?utf-8?B?WTdBbkRLU25Eb1VTcFIvdHdYeGx4ZWlhL3pPaWV4NURCc3d1SXVtekFYNDVW?=
 =?utf-8?B?R0NZYmRoNHNBeVkzL05kUmNsOHBVUndobStPN0s4K1hoRlU5cjFmdWt6SU85?=
 =?utf-8?B?NFJBenRCblNLYjBCVWZUQWVQV01SYk1JWktNdyt3NGJ4K2V2elV3R2hBN2h1?=
 =?utf-8?B?WUtPcGdMSWg4Y3BZTERWRENVb0loSUQwUWloNTVTS1BZY0hWdWxkN1RJVWl0?=
 =?utf-8?B?Y2xIVjU4dnJDUk9sWE1YWElUSmlYanQyanhvQ2tQK0cyK2wrSVFsYkFiem5U?=
 =?utf-8?B?SzBSWUQzSXBOZktpeHF5UGpMUm5iSTlzdU84eVk4TnlsVGZreW1zZUZObzdJ?=
 =?utf-8?B?M1kxOEoweCt5eUFTZ3Ewb29hdnlqaW16cjA4TmUrWllQREtxbmM5a01icDRW?=
 =?utf-8?B?NU5KKzR1RmxvdGhvWHBncWRKRG1ZZ2JyV3Y4VWJvRE52ZVFNUmxudUtqaEx1?=
 =?utf-8?B?U2F2dGY0OVFMN1hOblBTZlVpSkkvdnRnU2lGbDNiV3F1RTJXSHZCQTZmdmpx?=
 =?utf-8?B?QTZxcXo4b25RRFhCYTlod0plZ0V4ODNabzNhVTRDWEV3N3BsUnpDTndPSWYr?=
 =?utf-8?B?SkFqNHlLNEVhL0tMS2lTYkw5cHo4MWVJTHVJUUc4aHVRdVRMUnlUSkY1WmRJ?=
 =?utf-8?B?UUhQSkFMRGpabUw2QzVuVVExdmN3ZjFMY1d2eWVHVlF0a2ZtbVp1RWlXb3dz?=
 =?utf-8?Q?tBEhLbfZzKdlmGfMKt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C30C7A284CED2444B452FD0FCDB880DD@namprd04.prod.outlook.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: phil.gs
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6472.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4469c403-5abf-464a-2a83-08df260b8b2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 13:45:13.1101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 47d4f979-ea6f-4fcb-aea9-39371d64bc6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pyky4f6rKlBSt8C6kUQSB+O338rT78BdqIUhe/z0Xs9T8BilKE2QuM42meIbZIQW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6475
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQoNCj4gT24gT2N0IDksIDIwMjYsIGF0IDQ6NTfigK9BTSwgQW5keSBTaGV2Y2hlbmtvIDxhbmR5
LnNoZXZjaGVua29AZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IFRoZXJlIGlzIGFscmVhZHkgYSBk
cml2ZXIgZm9yIHRoaXMgODI1MF9hc3BlZWRfdnVhcnQuYy4gUGxlYXNlLCBkbyBub3QNCj4gYWRk
IG5ldyBxdWlya3MgdG8gODI1MF9wY2kuYy4NCj4gDQo+IC0tIA0KPiBXaXRoIEJlc3QgUmVnYXJk
cywNCj4gQW5keSBTaGV2Y2hlbmtvDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KQXMgZmFy
IGFzIEkgY2FuIHRlbGwsIDgyNTBfYXNwZWVkX3Z1YXJ0LmMgZHJpdmVzIHRoZSBvdGhlciBlbmQg
b2YgdGhlDQpWVUFSVC4gSXQgaXMgYW4gT0YgcGxhdGZvcm0gZHJpdmVyIChhc3BlZWQsYXN0MjQw
MC12dWFydCBhbmQNCmFzcGVlZCxhc3QyNTAwLXZ1YXJ0KSBmb3IgTGludXggcnVubmluZyBvbiB0
aGUgQk1DIGl0c2VsZjogaXQgZGVwZW5kcyBvbg0KQVJDSF9BU1BFRUQsIGhhcyBubyBQQ0kgSUQg
dGFibGUsIGFuZCBwcm9ncmFtcyB0aGUgQk1DLXNpZGUgR0NSQS9HQ1JCDQpyZWdpc3RlcnMgKFZV
QVJUIGVuYWJsZSwgaG9zdCBTSVJRIHJvdXRpbmcpLCB3aGljaCB0aGUgaG9zdCBjYW5ub3QNCnJl
YWNoLg0KDQpUaGlzIHBhdGNoIGlzIGZvciB0aGUgaG9zdCBzaWRlLiBUaGVyZSB0aGUgVlVBUlQg
YXBwZWFycyBhcyAxNjU1MA0KcmVnaXN0ZXJzIGluIEJBUjEgb2YgdGhlIEJNQydzIFBDSWUgZnVu
Y3Rpb24gKDFhMDM6MjQwMiksIGFuZCBub3RoaW5nDQpiaW5kcyB0aGF0IGZ1bmN0aW9uIHRvZGF5
LCBzbyBTT0wgZ29lcyBxdWlldCBvbmNlIExpbnV4IHN0YXJ0cy4gSSBkb24ndA0Kc2VlIGEgd2F5
IHRvIHJldXNlIDgyNTBfYXNwZWVkX3Z1YXJ0LmMgZm9yIGl0LCBidXQgcGxlYXNlIGNvcnJlY3Qg
bWUgaWYNCkknbSBtaXNzaW5nIHNvbWV0aGluZy4NCg0KVW5kZXJzdG9vZCBhYm91dCA4MjUwX3Bj
aS5jLiBXb3VsZCBhIHNlcGFyYXRlIGRyaXZlciBiZSBhY2NlcHRhYmxlLA0KZS5nLiBkcml2ZXJz
L3R0eS9zZXJpYWwvODI1MC84MjUwX2FzcGVlZF9wY2kuYyB1c2luZyA4MjUwX3BjaWxpYiwgYWxv
bmcNCnRoZSBsaW5lcyBvZiA4MjUwX3Blcmljb20uYz8gSXQgd291bGQgZG8gdGhlIHNhbWUgYXMg
dGhpcyBwYXRjaDogZmluZA0KdGhlIFZVQVJUcyB0aGUgQk1DIGhhcyBlbmFibGVkIGluIEJBUjEg
YW5kIHJlZ2lzdGVyIHRoZW0gYXMgcG9sbGVkDQpwb3J0cy4gSWYgdGhhdCB3b3JrcyBmb3IgeW91
LCBJJ2xsIHNlbmQgaXQgYXMgdjIuDQoNClRoYW5rcywNClBoaWwNCg0K

