Return-Path: <linux-aspeed+bounces-2587-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B522CCD193
	for <linux-aspeed@archiver.kernel.org>; Thu, 23 Oct 2025 22:52:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ct1WQ6SGfz3bf4;
	Fri, 24 Oct 2025 09:52:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761202364;
	cv=pass; b=BB1v2StG6pyEPMUP6Fci+J07aLTGAD3DKySDQ1z6+kpqB13AvWHwGLrO4ZwDUuaU5WeEh+KuGJ5xxBvkKzJaZj7TK6XAYQ4qrxH170vt7rYwBISoo9eYrWXXCdZhIrgiardm0nleD+XLfERvio4R2qMrXFyeEViH8JDU9B8kGdLvlmxiS2K+qqSS88rP/mC1jILVUhG2pYcdmaJ+Elabe1GKv0RKIWPaJvRNqg3YoEjiDJbhmQe6dFOygw4L/bqaLZVj9kWgKYWJVPQHrGyjSLQyjqWdHjj7Kw3BMGyU5bW3O3b+2qoldUk7wFd0m0ITVu+ke3ulZiafZRSGp1fpdg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761202364; c=relaxed/relaxed;
	bh=ClCLLk9xsxoAI537LV7WcTGKljAdZUkHQxGLe9lX+KY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lG0vu9MWbAHN7HSuF3RGII7N0DNnqO2ZTiE+v/q6bQxA191SFXlCUUEI8eoys/tJ44tvr0JF1wJ2JogciOqDLD2ZoF+wBCIT0O4RQcZMl1W7YtQ5+lbjCLeGM5E+WsGWI+oxXb5ua2TW/dx7afR++kJ9mlRABSlScZzdbjKRaQG0AcQoitRVa/u3kSwGTGKZbO6Nd2GTEYgXHU7F38XGh4yLTpTzoeRw7PRKb5q2FFGsZ8rXd2IWI1k6C3SIJdFsLSddF2R5h4V9HT9vIcKnbU7cujzGAt1iaxcK3eFCDXbPTtZ6D/B+RyQJLrX3DkMiuKZCoca4Oqr5iF3DKVDpgA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WpoENhF7; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::1; helo=ph8pr06cu001.outbound.protection.outlook.com; envelope-from=peter.shen@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WpoENhF7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c107::1; helo=ph8pr06cu001.outbound.protection.outlook.com; envelope-from=peter.shen@amd.com; receiver=lists.ozlabs.org)
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170120001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cscDB2CdYz3bW7
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Oct 2025 17:52:41 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPd8VV4Q/QchvMpeZ9QUNptEuXPY7AZ5KdupbmxmY9MEuz9lUzyss2nwDv84wasyUngsaKEyicT56GCuDxk2nQPssrHgdtK+dFQ5Ppk/v65QigswOT/86UVZHbeLJppKDkNdlu741UPyy9SXNkZlobr4tl2ygoSwqXGDxDjnT0z9QJEPwc8ycYB0a6++gTnLWQNSXsZCDMhl1IqPKz+2ULeabL2zjo7+YvElU/8jz3LCRw2ZV+97I7yOcjPrWdgaEWugQgpevIekQ6Ox6iYj2QosscbzeCnjl2fKQleasMBWd1cZNLerRPvvDN8AFi2cKNP3/oOjtvfDLXTBuCPT+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClCLLk9xsxoAI537LV7WcTGKljAdZUkHQxGLe9lX+KY=;
 b=ohO7tqG3OL4DqpKirPrTJ2zrNusON5c35HOhavHBoVonynXNQApcJaGSWD5IHG0eWOokA9vZ27xUjnI3x6uqgZHO4M3I7N9TXbSe275cfxrW0nk1m7MCaTq4yySLpjyByprxNRFNZtXKwyuN22S5vXYmXk6Ao7AGZfk7wgPLCGEKdZqn4368yEJSL436X19S5pa1iT42t09Osl9LReXsDdWGEy5E6pcly3GFA7/FECmGgbPZusjFdgOKKGlFDoFvOYzxT3EDoeg5jKrFYUUkcBA72ZDXk/CVuBpr+lD1/nK8tndgrOPTMNCQOvOJMm6R/w2a0MrgOorODqkORLsCAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClCLLk9xsxoAI537LV7WcTGKljAdZUkHQxGLe9lX+KY=;
 b=WpoENhF7QjaUMD66qrJukBcZ8r02JWLGVTkqby1Y/gqt2+w0t9YUuCHqXvudHs4iNGJSbgKT2DNZ9HdJrNjf2ah7BNpOHUvoMaL/wr5LNrsI3h+HnS/VPgEUl/zRFy0dinnWLfJ1YseWzpVPWYW3OHdX/onA3HJt7bBghiYyqws=
Received: from DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) by
 SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 06:52:18 +0000
Received: from DS7PR12MB6118.namprd12.prod.outlook.com
 ([fe80::a9fa:4735:e3d3:a0e5]) by DS7PR12MB6118.namprd12.prod.outlook.com
 ([fe80::a9fa:4735:e3d3:a0e5%2]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 06:52:18 +0000
From: "Shen, Peter" <Peter.Shen@amd.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
CC: Joel Stanley <joel@jms.id.au>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Shen, Peter" <Peter.Shen@amd.com>
Subject: [PATCH 0/2] ARM: dts: aspeed: Add Device Tree for Facebook Anacapa
 BMC
Thread-Topic: [PATCH 0/2] ARM: dts: aspeed: Add Device Tree for Facebook
 Anacapa BMC
Thread-Index: AQHcQ+U20Tux0Ku/XEi9oh8eAHpj/g==
Date: Thu, 23 Oct 2025 06:52:18 +0000
Message-ID:
 <DS7PR12MB6118DA052F4933ED157EE9A795F0A@DS7PR12MB6118.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-23T06:52:17.873Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6118:EE_|SJ2PR12MB8831:EE_
x-ms-office365-filtering-correlation-id: 8f2f1068-783e-46a2-ca44-08de1200b532
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|8096899003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?4IltON9TKjZTFzi/gCMsotFaTM8wUK0m24INkFrHnbFNT2EQmgagmXS/zI?=
 =?iso-8859-1?Q?hrGYDdetLf06nvIMlOMKB5vcPfcLXhAJjfI2WJ5dqmVNEdOWGRf6dl5vz+?=
 =?iso-8859-1?Q?/ARzVtVuH2hr1k4sVRYHlPkfD9YY+mfFj1lYa9cnQvFEcXUTWBClyK0DwI?=
 =?iso-8859-1?Q?v1XbnoCUVGIeQ/8ZyIXeGx0ArnQIuF94+EUUik6D0aZmpTjRsptJVNweHL?=
 =?iso-8859-1?Q?RzSpGr/Hl33XT8nm7w0n1B7gdqcEJyREL0IM37UO4cmsHRvUPdb0w/vEYx?=
 =?iso-8859-1?Q?xJFntntDYa9jGS7pOSLeWiJPmBkQPIU0YBRvBsyvwt0VEY78CRQfVnYD8r?=
 =?iso-8859-1?Q?rmb57SizxSFwxKs9Tk8ecDHEmDY8MMN2vgivUKYCOdtbZpO4oYdiNFJBBR?=
 =?iso-8859-1?Q?unDDVi/hH/QeE+BtaaEoX9Q5tB9d19lpLU5JdgYwuvjmshuDsatiEcuDdd?=
 =?iso-8859-1?Q?iUu17/ucw2mbDgLqhK8vqFsBl9j6Eji36AdZ85lWKWRtdRvV92GIA5T0X6?=
 =?iso-8859-1?Q?sOOE51ThZtLn2tNVGub1grS+jufVOcVFOvjvwYYEJF4b2qFJQ+6KMjWjEb?=
 =?iso-8859-1?Q?5DqHiLPrLiLqlET7fEoXY2Z60uR6Z5DtIPmyjXr9goGy1HroCEmP+Vj4lY?=
 =?iso-8859-1?Q?v8M1AaclAbGyNS3b12B7ofer8RsG7Er3HbMwsKOVJBpicMXW6sUIjc1uEQ?=
 =?iso-8859-1?Q?iv0bmg9q/FpIJ/5xLi3xFguTt4THkIrJ64iMRVf+MBq41R48KXjPGLiw2h?=
 =?iso-8859-1?Q?mAQbvOBRmyWkMq6gLHzclp16dsTTdcQfB5ZOxfczKeuwfYpspNXERX4vH1?=
 =?iso-8859-1?Q?AdzhPAnUgKiEPHe+UlgxRaV3SWB125JhoAz+ckRv+wCDBSwt0qCUGCMe4q?=
 =?iso-8859-1?Q?JIBcFLrJBVCLdbwkMx7wHWG4mvBRLz0EMPd5VgECYv/2Y54VGSaDzE7l+5?=
 =?iso-8859-1?Q?6XfFtRGeJjhsKMPEVZqDcyKeugEcs7TxSORLykjsNYUeR7hH1Cay4eh45s?=
 =?iso-8859-1?Q?C/Bsl3Ld22nTBOri94MtfGUN4EQSmliJWLjUUl0ylEkEwHt50yhRzYwaGO?=
 =?iso-8859-1?Q?NSKiHPVzGtrf05aX/4pkNrthnBaPOhnbt5nEOFr0i6hUuKha33/aPT2xEc?=
 =?iso-8859-1?Q?jIGylk/CWJf2nenyOgWfARe6ZhtaFFpxDpQ3R2aDzfFF1copWgxIgK48sX?=
 =?iso-8859-1?Q?bsvnUaQTowp8f/ITIA+rvLCLKbgeNAybH9YtGnqqGwOagXYHcUXCnSHEpM?=
 =?iso-8859-1?Q?d8OTIeaGI15gGS02WeN3QhI96DjQ6JMD060oY92Gf8NDos1cH3I6r5h+sP?=
 =?iso-8859-1?Q?fTJ5wGpCx1oIXwgY9Xj2G4GlPSBbSU1vNzV/+5oKVAzmy8mfenQC8+wr8A?=
 =?iso-8859-1?Q?xbgO3sMpaZs9rEmlfXrGdIBnxoWG1rwP7uiJ2JRgMYdz8usxZ1h08sQz+Q?=
 =?iso-8859-1?Q?/TcJJ+fS93M4MM8AxquObpVwXLx6b2UakM7RkVROuL6MZcMG80a2hx+U9a?=
 =?iso-8859-1?Q?2JP2ZqgMixWjpLdQlfl6A5UTdOMbPGDMCKLs7+V+KrLDmgZvS6nSf08Qky?=
 =?iso-8859-1?Q?vGYLe1kGTc7haU0R9PqiUk5xu97y?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6118.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?wD7V3rPv7wyTsJYs5zTTS1fhQaw7SvrzYStFCv6QssJNfquSNBc5CQ664t?=
 =?iso-8859-1?Q?UAUGVIbAfhjMTfiUfQW8kR5kD4YIeB/pr9iVqacgrw9J0ehK9iwh2Zf6OC?=
 =?iso-8859-1?Q?idzwWQXFsiiTXMnn2NTPSwwZUhR2G+6n9aebQmDubnxFjoQXWPrU/jgZv4?=
 =?iso-8859-1?Q?06XpqXNjRciVjHEZg0y6YNemhPuQ3/t/0OIJxU5rom9/W5RBGo3kg6il7X?=
 =?iso-8859-1?Q?otqfKHX7l9ho7YgkQGyHD3py6axebrQSznufXru1+eWfeBUZh51EYmOarv?=
 =?iso-8859-1?Q?jYXGtbcnAuUVvK0qpCiJUb8Ou7FsNoQtAaqOQK/cgkWTfeWvmZqM/TRbrX?=
 =?iso-8859-1?Q?nOu9445cwmPP6fQMc59za4gGmRHaTaYvpGmaAWZ6UaAHR8rGAIQewCjHSq?=
 =?iso-8859-1?Q?DfDAVdD0Kr0Uxj8gbT5oDo4MtACFs92AN9k9RvhoAO5que3KNdxo1IxPxI?=
 =?iso-8859-1?Q?HA73P/JBqY6GPHN/zepV2y2EdC/GSmla5QzT3cjRWbaHAwnGQBFURZ07xB?=
 =?iso-8859-1?Q?0Sw7gbmYVy5jcdQSFTmxcxnkTwdUtzm9jrK5nDRWtHzqAfzGF/8l8rEbHM?=
 =?iso-8859-1?Q?2HZ2RlS3Nz1teMr7QnT5SlU9cAE8tqKYui9jJmWYIJDrqjXzlSsVT0CSKz?=
 =?iso-8859-1?Q?r+1+kgqD9EPq0ItPOlMS/Mv6AQJchrUaKl9IL4x8WxT5wpnJbIqdcjeAn9?=
 =?iso-8859-1?Q?lYaTsNcquqkGdqUkuEXJsutxhG9LLfVHDLZnmaoUUuCqg1RjnoXaiNMRPW?=
 =?iso-8859-1?Q?1lz3AaSmQ29wBmRcsau2ItraHSr1km8orczKcH5puMzMtskcIX+bTidzH3?=
 =?iso-8859-1?Q?sBZBpsxuBZNrV3O04EViKFaXqcnOJAPahVuT9iG/im2lVd5LkMpVWUBbZK?=
 =?iso-8859-1?Q?kd+Ji9p+QOSkfPaCYevEpeT6fQ0pqpqqXKM8kFYSjLl3p6Qt99F7H3X9zx?=
 =?iso-8859-1?Q?sQvdqalSwD8yZEFMb9RvtB3nGF51eQjeC1sFqmbiZ65OTuMSmWDRR9iulT?=
 =?iso-8859-1?Q?8wvvlfA0k3eq90MofWNk8QUqfrqUZ5pvFkbHA+0HVOwVH10gy9yJvHAw0c?=
 =?iso-8859-1?Q?Y2LgMwUPLsiVTd5tkvzXi8AEXmX4PugbzRMuqpowpviPWazd0mjS9jFC5w?=
 =?iso-8859-1?Q?sBa/PtD2ODe8NruDjCOqC+BzkPjoc/cXrZIEo0FaowXCdnNjJ4+YKJvpPY?=
 =?iso-8859-1?Q?374S8cmyC3buJhcL8S3Xk1OfSOTA+ffAGltH9upm3NdHc2Jucb8wRbsPCW?=
 =?iso-8859-1?Q?fQHG+bcHIDJZZRFhE9mrqSmuN4qkLTHp//X8yBy/7cybTITLEEA0DKVvaw?=
 =?iso-8859-1?Q?D7/y9+Eh8tS4tJa3QhqRwKQk2jExjwCIgi5w+rZ/u65PFRduSeuI/UGvgC?=
 =?iso-8859-1?Q?xoYVpGAXRXlLy3WWeKDqFhYEsmtYyJOnrlm73PWkCem8kzaMKI/F6JXRWj?=
 =?iso-8859-1?Q?TjmvKTQ702dNVIJXbtqTUiF/WrU0XWucHOnmhNvMFNhyA06G6d1tZY0uZM?=
 =?iso-8859-1?Q?cpKfxujr5e1r61EZUZEYEEhlv2Wg2KaKVqyxCAFV3BvAUf+C4AVoZJjVLE?=
 =?iso-8859-1?Q?rPekg9vcsS6WT55DOdWuNyglsMX4OnG1SYL5tdkFrbdYzTA+VpjeT8JrZi?=
 =?iso-8859-1?Q?yx8MS+HXMxU4o=3D?=
Content-Type: multipart/alternative;
	boundary="_000_DS7PR12MB6118DA052F4933ED157EE9A795F0ADS7PR12MB6118namp_"
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
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6118.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2f1068-783e-46a2-ca44-08de1200b532
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 06:52:18.2450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HgvonaTl1AGb8VWgH4PeF/d8bGVOfYBOVbOuilUERB2q1ctqTThJ2+C0uNw7yjeqaT6iQY3miZkqvQNt9hUnvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831

--_000_DS7PR12MB6118DA052F4933ED157EE9A795F0ADS7PR12MB6118namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Andrew,

This series adds the necessary support for the Facebook Anacapa BMC
platform, which utilizes the Aspeed AST2600 SoC.

Patch 1/2: Adds the compatible string to the Device Tree bindings.
Patch 2/2: Adds the initial Device Tree source file.

The Anacapa BMC is based on the Aspeed AST2600 and includes the standard
peripherals required for BMC operation.


Thanks,
Peter Shen


--_000_DS7PR12MB6118DA052F4933ED157EE9A795F0ADS7PR12MB6118namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
0pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Hi Andrew,</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
0pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
0pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
This series adds the necessary support for the Facebook Anacapa BMC</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
0pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
platform, which utilizes the Aspeed AST2600 SoC.</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
0pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
0pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Patch 1/2: Adds the compatible string to the Device Tree bindings.</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
0pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Patch 2/2: Adds the initial Device Tree source file.</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
0pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
0pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
The Anacapa BMC is based on the Aspeed AST2600 and includes the standard</d=
iv>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
0pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
peripherals required for BMC operation.</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
0pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div id=3D"Signature">
<p style=3D"line-height: 12pt; margin: 0in; font-family: Aptos, sans-serif;=
"><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-size=
: 10pt; color: black;">Thanks,<br>
Peter Shen</span></p>
<p style=3D"margin: 0in; font-family: Aptos, sans-serif;"><span style=3D"fo=
nt-family: &quot;Courier New&quot;, monospace; font-size: 10pt;"><b><br>
</b></span></p>
</div>
</body>
</html>

--_000_DS7PR12MB6118DA052F4933ED157EE9A795F0ADS7PR12MB6118namp_--

