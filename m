Return-Path: <linux-aspeed+bounces-34-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E923DD0C5F4
	for <linux-aspeed@archiver.kernel.org>; Fri, 25 Oct 2024 09:38:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZd511K8lz2xjP;
	Fri, 25 Oct 2024 20:38:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:2011::719" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729849109;
	cv=pass; b=GHYaLIkWwfCP8W0Yn8JcTD3cFiAJuDLWOGvYHgDvQ1gXNZEPrpBk4N28YkSYU/noYTEb+Y6McmoZ0TZO5cAUK1n9+c7Z5S+k7FKOHOQ6Qp3d8tAxZC2mCFPA30f6BeQx1Uk1tGGjZo7Zxtfjn4nQjMHSwUrRhCqlFjZoaf18qefUbRYBhtBt5KqGjw6JTbUHv1hv7CaTMHmxZ6kLoOToJT8LmZ3zuMf033GSytbCjSYB2MnNNjiONhT4lJjIw0IH47Pu6sdMZ96FjUGcBYaBo14VWGas5AaCHtZESm/1X+zOtoi9yn3k3ZA2gOWKHgF0AxFkbZRqPrfp91sxCxLvPw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729849109; c=relaxed/relaxed;
	bh=vZSMgEtWauGIfDtccbwBCL+u47zr5C7kixQqJapWNFg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ICqKl5VJYuXlmpYuJCx8u071H7TyYYmUoDhsz9ZtCHbqbkUSlTlk+CRa/lt2HFUYqGWLT5u36QCRv54WrMPMePvtH+dvMYPktWtuiYduSSOTYJ01S7X63xq5cM9dK2DYiZY2bbEC4O8PLIupRhYVMI3c9S2xciLH4pChLnDdmXBdw2FIo+2C9jvUAiQrCKx9381KVgCUsJ8l2yLDLSD5V/RBt/WXYDU06WONAH4a9Yn3WtwqRK/Z0j0TG6b834FyVJRc4S5qDVwQDwsv7L9VPi9Johg5GgmzUzUx3B+Lw5qfHApdzoHcPyYj6AyhQSOER3xiFdOPYoPL1fRzApxXjw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=2a01:111:f403:2011::719; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:2011::719; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20719.outbound.protection.outlook.com [IPv6:2a01:111:f403:2011::719])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XZd4t25sDz2xjL
	for <linux-aspeed@lists.ozlabs.org>; Fri, 25 Oct 2024 20:38:19 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuDMqsx4N/WONV3NcKQZ0fJMyeYul1Nu2q588MB0ge7LvlFUVPNMu1WTAm3y5JU2IUx0V61UMmKW1+lzo2+2iSsO9kCOLAEUBNmo6z2BeC5/n9kvDpRMV6HRckiei7VAVMKDJhyWPxiXTjYtTGSrllLQF0yfop4zq6Bv9oaIMHPLzyff7rtZMcpXnCPIx9xUEJ/rLtKU3SKZM4IUOPG9EH1uyDRKe7E3K9LBlJcOTST0MbHm2jSBCbGBfDOxch/WOuv10vQsUch3oHZNviuXxmjRQt6yVHrCUgs7wWdRirU7g0kH2aJ4+zrR+h6+s1HQa1PIi7l3lh+vplNrXiYTcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZSMgEtWauGIfDtccbwBCL+u47zr5C7kixQqJapWNFg=;
 b=Zcn5DbCeNbWnX2vxeox1B+jpbVj33H5dOD0OFQbkTkHd1xHLrgYlglSCjem9yx3oVyxTCc9MBkoByQ+j8lD1jvKSziKVD0txH4vtUmYM6LALALg57D4z2SpLJBN+Ibu4j4RcTJ33MIW/VGhO3hdH1ZII5ngb50PlWUKMiUlwcWQxdCkjKJWZFhjyov5DAplfosBafgk6lSN3ciw1FYgDyt6MkH6ihI/6fOun5Qr38jAUmPXPGVGg26qsoCrKBnDXRrqOrafjRE+Hh1HvjKHCY1CkD/kzYMnJ/bHdQP1ZHQxR/7TpAzhx4Ze8KPeQr8gryJUHLV1fiJg4kU+eU6NCEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZSMgEtWauGIfDtccbwBCL+u47zr5C7kixQqJapWNFg=;
 b=O0YHdYA04KIMDsLoDMjNrh0eLU7p5Ki//UsgHLInnKxU+F6ylgZSQOXNimqyk1CL/wNSxtC28adtTdXAlbOdjqtp+wBKi2cvOXTribY4JJyIt09UzVsJDnT2IEQ42zunU2vph9oBwv8c+rhmlbqpF2sQAHvkc9xr12vTp5hJKVYZoVgjSK8/ZmsSAuqFuushRDObh6Q+0tKFwUxHS2kjZGuaiE+2WF+LjX8/qSxEi4qP1Q9UwqfZpHx+DwtStLteBsThrJ4bo3ybTdNq1Gl5mQE+xJxwo6UwVaxZMyH0FEeVQYpips5z9c+fPAc4r+13POAa8DKQHr8l0CBYajSk4A==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by SEYPR06MB6984.apcprd06.prod.outlook.com (2603:1096:101:1de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 09:37:54 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::814e:819a:7d52:7448]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::814e:819a:7d52:7448%7]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 09:37:53 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: =?Windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
CC: Guenter Roeck <linux@roeck-us.net>, "jdelvare@suse.com"
	<jdelvare@suse.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [PATCH v1 0/2] Enable WDT reload feature
Thread-Topic: [PATCH v1 0/2] Enable WDT reload feature
Thread-Index: AQHbJeSSyha0WSkjXEyiFAbwEDTDJrKWCnCAgAAHbgCAAKOQ04AAaXgAgAANFv4=
Date: Fri, 25 Oct 2024 09:37:53 +0000
Message-ID:
 <OSQPR06MB72521C20B39B1469B5C6DCBC8B4F2@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20241024071548.3370363-1-billy_tsai@aspeedtech.com>
 <nm4ckxv6swajr6hnqlkq5uoo6ncjzlg6yfxroftat6dubiefyi@xbhi4dvqacxm>
 <ea1be8af-0948-46b1-a1f4-fe572861cde4@roeck-us.net>
 <OSQPR06MB72529E67E67D0D07E59AF1C08B4F2@OSQPR06MB7252.apcprd06.prod.outlook.com>
 <6hkiqbgqkpdlr5f27drs7vcee7pb2uahek4zz5pd5ndativk53@42otb625deil>
In-Reply-To: <6hkiqbgqkpdlr5f27drs7vcee7pb2uahek4zz5pd5ndativk53@42otb625deil>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|SEYPR06MB6984:EE_
x-ms-office365-filtering-correlation-id: 9044e3d2-7ea9-4677-2358-08dcf4d8b33a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|8096899003|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?X+zXlpJM/rRgAq0byqDDSU91eAqziXhKntWB5Xbm1IbBQfXC+ZshFB0v?=
 =?Windows-1252?Q?EW4ISJCoWCR1roHLZ6tkud9fJmU9iQ/Q5o76Ojar7wo+1fY8cyeQoIjR?=
 =?Windows-1252?Q?b8exnI52r0AC50A6t7TQqVfL0PRHtrnTePzXwgbJnygHUqfmpjGVsalF?=
 =?Windows-1252?Q?TUIbXpZZkRIDhcri8GUv2wi3Np4EAs1UOwJM0SZ9P51jYKC3jWWYpYxw?=
 =?Windows-1252?Q?d8Uo7u9N4bg5ttgipi04Ib0pYsbjiWw+bOEcXWIIOtcum40bY2uJm+eT?=
 =?Windows-1252?Q?zhzq6fEoBzP77E9e5lDmS9XdjmI/ScmxxnkW112h7mkNFjg+WtR2W2DY?=
 =?Windows-1252?Q?A8PuicKf2WjCC1MnemVcPVVEfKUSycdDbMl3Cns0QOTTRSYEQDeCjloi?=
 =?Windows-1252?Q?6cv4KPFavEejxL2QaG0EOR3cDGSdJSHu2SAZP4kcX3Zj4jOVClgqnU1p?=
 =?Windows-1252?Q?IU3nkWbXtbqfWYdsr32Dxw/quRfsixzCpqr6CObM9Rm9yXtcJxeV/L57?=
 =?Windows-1252?Q?PR2LK5JBKeesjI+2VM7oIaS6DfHYO8O7AbZR6ESfAI/8Sw4e5i/4+hNd?=
 =?Windows-1252?Q?aksKgEPADRGhYV3bXZ2KqsbfCa/utbSFuum+YbsuB0R6GyTDeDZNgtaj?=
 =?Windows-1252?Q?gkYdKeVm0lysXq+qO5XSEzvZjzJzCub+F8AGf8lJRvgZxguf5TA9tkeA?=
 =?Windows-1252?Q?xG25DHehHrgMpr3YXL/jcXfLsh+BSARFlJre+v+xg+GwMOn50Xgchh7P?=
 =?Windows-1252?Q?pgsxPzQFip+VkqVMIQEHUsFDhNIz78NMrFFDp3jFkYi6JsGH3OOpfmxD?=
 =?Windows-1252?Q?FLeSfSh5QWHJbNd8A2vYqm2dY8Z1uBA6H9k8vdcfruI1IwGwtR7tedfL?=
 =?Windows-1252?Q?68cIBY7x2fPGiN/mSHHnNjKYi2/x8nQGZKOoX+JhacmnfEHHeS8vhy2I?=
 =?Windows-1252?Q?oiGIsJ5sH0RTQKH/wmIBqvagWahuNQ2q9iwX0HrM9y1gdmXQSIB4UXFB?=
 =?Windows-1252?Q?CtrcdA9Mycfi2FzlSQCuOYWL/rAw00bdWWqUhCbyoA14mpHfmN1BEik5?=
 =?Windows-1252?Q?YQMs+kHvzDCRpKQwVKuRiQXrtkX12HK4P6laZgZqaaZlO4WJekq48rDA?=
 =?Windows-1252?Q?noqV5vssmkMWqqreEgnUR+wP0CsoTb26F1tk0e+3EZKO4UpOpK6KFQgZ?=
 =?Windows-1252?Q?9v5zKDgOzmtw7MGF+j1ckOsdg8D9juvTplHSSWLSpgmjtrdwd+GzYP75?=
 =?Windows-1252?Q?FI8U/tXerdxYXfrCwRzmQP4IHZ+MLw79VKsH0TDnjQH/kLZLDPicX+fm?=
 =?Windows-1252?Q?2PdMaG8e2DIiI1JC+vzwGKnmCojNOhX6gnV74JnH9gbyu6/+RbTf7hSO?=
 =?Windows-1252?Q?IM/HDGTQmeEf7ox07ciGBQ89lz2g4fteoUv0PfMw9zpxEfZDHcDjQZY3?=
 =?Windows-1252?Q?54Mh6zbKFun3vJ9XD9P+JJ7byroDLMG7i4vwgB7Hc+Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(8096899003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?7Bwjw8e81k4wn9CCGqckgJULeUG9OGMJYVsO1E2ceEquzRnvWJEVIN7T?=
 =?Windows-1252?Q?eSRWB7PJ9pfiuDLPfCWuP5AbxbOqpCr3PUI4Cau0jB4OcL7SkjX08jG/?=
 =?Windows-1252?Q?/eSIcKIvjUJomokLLn0FKOi7wnGbXtc4xLb8qyRcu1CrhtTZxrIG5rsm?=
 =?Windows-1252?Q?M8TQRItViRLdUM9i9scEfEwYB10f6f6FdzSg3JZ5FyUabnxQ8D5sWKYv?=
 =?Windows-1252?Q?+IaCnCubgsuCGbuYK3wO4Sz7fsMZYQ2wrE+7OW6v4yMgsIwH2HjRXZIv?=
 =?Windows-1252?Q?apOzSnjs/bK8WnP0ChFVNoU++Wh8Xfe+UuQe/vZbDw/bQAOcx6dMQFfW?=
 =?Windows-1252?Q?PsGDDMKOIuXif0QeYgZjmfj5m5BO0TpZ5Zv+lSHVaWixPP4xjORNjy2Y?=
 =?Windows-1252?Q?cTGWo55W9eftrqX5xBuWzMi4TaoybT0V5VZpFeRC6RHLjPTzTJkfPJD2?=
 =?Windows-1252?Q?yzQsMtvH7g72JOe1yw35gaB5tdEr+/eeaXaFVCfAlx/rCk3c9MbNeIfV?=
 =?Windows-1252?Q?N08hce6qSCItqJROjCe2xJPzPg0RJJWAgfur47rhHorOexwdQTcP7pqN?=
 =?Windows-1252?Q?XrEK8cNiFcZ/Su/qFPghIQtCSspYUEPAkq1ogiapxUH+SReWh7d1Yd19?=
 =?Windows-1252?Q?96QY62plyMREqR2lRsgDEHKgAWdJhHy3LBbuPjTEMMvM+BrqDOEgbJ2b?=
 =?Windows-1252?Q?7F+FOLRsOvpdpDvfhzdTWi9ljjIUTHbx/jsRGyNhgnAcCCUHXeHmhC0T?=
 =?Windows-1252?Q?cme4H12l96nAZq1wCE4xPdXZLqA2jZnzQvDxQ24AqnQL15IcJqeBD33d?=
 =?Windows-1252?Q?3JTtpHNG2wK9sJd1VvRLkLseEL08F1SHcxnMAhw+YSHL9AOVaqHD4txc?=
 =?Windows-1252?Q?8jC2yEM5SD/tI1lKvKRafmbqH5yic7KiiqCmFj7g3iHP+wElC7HpPJek?=
 =?Windows-1252?Q?orva8FQ+IaUAp3xScGJUpHnyA/CHOsmyfYtlqpVK/6uX/5JsO/nR8Npk?=
 =?Windows-1252?Q?G2Bn9I6pB/QKGIY0gZdQQvAZcn/6vnJOAWdVPMOFe1FQko5bmsg/DAjN?=
 =?Windows-1252?Q?gPaxlGweatW2h0/WMcl9PUqTlOAfGYJLezPrlXZ4+CaDBVWEon4OtoQi?=
 =?Windows-1252?Q?gPWqgaD3jivDbhxK77GplzIcE1D+/30b6VI8xdV0t6Tt+vyQqRr/1H5f?=
 =?Windows-1252?Q?oGS3mxUcA1tN7YHEUfIBHBhc2xdWArCB8NKz332bCzOi49H1zkCKk+A2?=
 =?Windows-1252?Q?nOLcnFh4qYu/IYEw6vLOcuMSQLDL+2PgQDlAZohHsY4O3me0yPHyj17Z?=
 =?Windows-1252?Q?w5N+oWyQOgh/d1bYoJ5vT7jCIw3RN9LXWP0M1Pp5mPA3oS/FWVYCpZg8?=
 =?Windows-1252?Q?08DWyuND4m94sFqaRGAF8KKotpLwxn5d6yhRv9NJwH9vtDgn0ZqjXC5C?=
 =?Windows-1252?Q?tgSsIp43a0OTvIim9v5ertMPTorxmIASHoh0ixbD8zCvyZSmtXOLEma5?=
 =?Windows-1252?Q?Fd5VFlcLqg8I/tfPpS8vk+Uqy5vyjlN05SOyP0ORxy9l5g47WpXnTHAB?=
 =?Windows-1252?Q?pC/xm4YSbmDnto3+SUt0exsrly6rzsf3uyqZwcww8woDbtFxXRjM9RHZ?=
 =?Windows-1252?Q?RcWw5D1XZjUU5uN6VK58GlNI3v6L4JzVZSvO6ArFvneAz67DEwGqcPGJ?=
 =?Windows-1252?Q?Jr7j8f28YJNs4jNQnZF7BMrlkmsbBbz4?=
Content-Type: multipart/alternative;
	boundary="_000_OSQPR06MB72521C20B39B1469B5C6DCBC8B4F2OSQPR06MB7252apcp_"
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
X-MS-Exchange-CrossTenant-AuthSource: OSQPR06MB7252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9044e3d2-7ea9-4677-2358-08dcf4d8b33a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 09:37:53.6771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AHxUGJqePh160KfjVCLCkp/tequ4QbOSkaBLnZgWLVRgH0AfTGzyDZHd4sQyNLY08HaIlTb550F4V0O0Lols5zA2R2IEidpxUAVmocSb+cI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6984

--_000_OSQPR06MB72521C20B39B1469B5C6DCBC8B4F2OSQPR06MB7252apcp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

> > > On 10/24/24 08:40, Uwe Kleine-K=F6nig wrote:
> > > > On Thu, Oct 24, 2024 at 03:15:46PM +0800, Billy Tsai wrote:
> > > >> Aspeed PWM controller has the WDT reload feature, which changes th=
e duty
> > > >> cycle to a preprogrammed value after a WDT/EXTRST#.
> > > >>
> > > >> Billy Tsai (2):
> > > >>    hwmon: (aspeed-g6-pwm-tacho): Extend the #pwm-cells to 4
> > > >>    hwmon: (aspeed-g6-pwm-tacho): Support the WDT reload
> > > >
> > > > Huh, I'm not convinced that extending #pwm-cells for that feature i=
s a
> > > > good idea. Unless I'm missing something none of the other supported=
 PWM
> > > > chips can do that, so I hesitate to change a standard for it. I sug=
gest
> > > > to make this a separate property instead.
> >
> > Using a separate property to enable this feature is a straightforward
> > method, but I don=92t understand why extending #pwm-cells isn=92t a goo=
d
> > idea in my situation. The feature =91WDT reload=92 can be set for
> > individual PWM channels, and the PWM subsystem has the of_xlate
> > callback hook, which allows each driver to define its arguments for
> > the PWM consumer. I=92m unsure if I misunderstood this callback usage,
> > as I couldn=92t find examples. If my understanding is correct, this
> > method is better for adding our specific feature, rather than using
> > child nodes or separate properties to indicate which PWM channel
> > should enable this feature with the corresponding duty cycle values. I
> > think using separate properties to achieve this feature would be quite
> > cumbersome.
> > As I know the arguments for this usage are as follows:
> > First: PWM channel index
> > Second: PWM period in ns
> > Third: PWM polarity
> > Therefore, I extended our feature to a fourth argument to avoid any con=
fusion regarding usage and added the description in our yaml file.
> >
> > If my thinking is incorrect or doesn=92t make sense, please let me know=
.

> It might make sense if your bubble only contains that single PWM
> hardware. However if you extend the pwm cells semantic for your PWM to
> mean "period if the PWM watchdog triggers", i can hardly refuse the next
> developer who wants to extend for "period of the secondary output pin of
> the PWM" or a step counter or some property that defines how the duty
> cycle is modulated over time. And should the next one also use the 4th
> u32 for his purpose, or should we consider it reserved now for your
> purpose such that the duty_cycle modulation goes into the 7th cell?

Hi Uwe,

In my view, the order of arguments=97such as PWM number, PWM period in ns, =
and PWM polarity=97is just
a convention for PWM consumers to follow. Even if another driver doesn=92t =
adhere strictly to this
rule, it shouldn=92t be considered an error if the YAML file documents the =
usage of each argument.
For example, some PWM controllers set #pwm-cells to 1, where the first argu=
ment isn=92t necessarily
the PWM number. In google,cros-ec-pwm.yaml, it=92s treated as the PWM index=
, while in marvell,pxa-pwm.yaml,
it represents the period in ns.

If users want to work with these PWM controllers, they should confirm the p=
urpose of each argument from the
YAML file, rather than assuming the PWM driver follows a conventional argum=
ent order. If the YAML file doesn=92t
specify details, it can be treated as described in pwm.yaml, which is fine.=
 However, if there are any differences,
I think recording them in their own YAML file is sufficient (Like google,cr=
os-ec-pwm.yaml and  marvell,pxa-pwm.yaml).

> Today the bindings are (well nearly) used in the same way for all
> hardwares and I want to keep it that way. If your PWM has a special
> feature, give it a speaking name that the occasional dts reader has a
> chance to understand without reading HW docs or dt bindings.

Using another DTS property to achieve this isn=92t as elegant as utilizing =
PWM arguments, which will only
be applied when the PWM consumer uses it. This is another reason I want to =
extend the PWM cells semantic.

Thanks

Best regards
Billy Tsai




--_000_OSQPR06MB72521C20B39B1469B5C6DCBC8B4F2OSQPR06MB7252apcp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; &gt; On 10/24/24 08:40, Uwe Kleine-K=F6nig wrote:</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; &gt; &gt; On Thu, Oct 24, 2024 at 03:15:46PM +0800, Billy Tsai=
 wrote:</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; &gt; &gt;&gt; Aspeed PWM controller has the WDT reload feature=
, which changes the duty</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; &gt; &gt;&gt; cycle to a preprogrammed value after a WDT/EXTRS=
T#.</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; &gt; &gt;&gt;</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; &gt; &gt;&gt; Billy Tsai (2):</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; &gt; &gt;&gt; &nbsp; &nbsp;hwmon: (aspeed-g6-pwm-tacho): Exten=
d the #pwm-cells to 4</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; &gt; &gt;&gt; &nbsp; &nbsp;hwmon: (aspeed-g6-pwm-tacho): Suppo=
rt the WDT reload</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; &gt; &gt;</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; &gt; &gt; Huh, I'm not convinced that extending #pwm-cells for=
 that feature is a</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; &gt; &gt; good idea. Unless I'm missing something none of the =
other supported PWM</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; &gt; &gt; chips can do that, so I hesitate to change a standar=
d for it. I suggest</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; &gt; &gt; to make this a separate property instead.</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt;</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; Using a separate property to enable this feature is a straight=
forward</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; method, but I don=92t understand why extending #pwm-cells isn=
=92t a good</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; idea in my situation. The feature =91WDT reload=92 can be set =
for</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; individual PWM channels, and the PWM subsystem has the of_xlat=
e</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; callback hook, which allows each driver to define its argument=
s for</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; the PWM consumer. I=92m unsure if I misunderstood this callbac=
k usage,</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; as I couldn=92t find examples. If my understanding is correct,=
 this</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; method is better for adding our specific feature, rather than =
using</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; child nodes or separate properties to indicate which PWM chann=
el</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; should enable this feature with the corresponding duty cycle v=
alues. I</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; think using separate properties to achieve this feature would =
be quite</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; cumbersome.</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; As I know the arguments for this usage are as follows:</i></di=
v>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; First: PWM channel index</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; Second: PWM period in ns</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; Third: PWM polarity</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; Therefore, I extended our feature to a fourth argument to avoi=
d any confusion regarding usage and added the description in our yaml file.=
</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt;</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; &gt; If my thinking is incorrect or doesn=92t make sense, please le=
t me know.</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; It might make sense if your bubble only contains that single PWM</i=
></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; hardware. However if you extend the pwm cells semantic for your PWM=
 to</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; mean &quot;period if the PWM watchdog triggers&quot;, i can hardly =
refuse the next</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; developer who wants to extend for &quot;period of the secondary out=
put pin of</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; the PWM&quot; or a step counter or some property that defines how t=
he duty</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; cycle is modulated over time. And should the next one also use the =
4th</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; u32 for his purpose, or should we consider it reserved now for your=
</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; purpose such that the duty_cycle modulation goes into the 7th cell?=
</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
Hi Uwe,</div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
In my view, the order of arguments=97such as PWM number, PWM period in ns, =
and PWM polarity=97is just</div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
a convention for PWM consumers to follow. Even if another driver doesn=92t =
adhere strictly to this</div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
rule, it shouldn=92t be considered an error if the YAML file documents the =
usage of each argument.</div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
For example, some PWM controllers set #pwm-cells to 1, where the first argu=
ment isn=92t necessarily</div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
the PWM number. In google,cros-ec-pwm.yaml, it=92s treated as the PWM index=
, while in marvell,pxa-pwm.yaml,</div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
it represents the period in ns.</div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
If users want to work with these PWM controllers, they should confirm the p=
urpose of each argument from the</div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
YAML file, rather than assuming the PWM driver follows a conventional argum=
ent order. If the YAML file doesn=92t</div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
specify details, it can be treated as described in pwm.yaml, which is fine.=
 However, if there are any differences,</div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
I think recording them in their own YAML file is sufficient (Like google,cr=
os-ec-pwm.yaml and &nbsp;marvell,pxa-pwm.yaml).</div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; Today the bindings are (well nearly) used in the same way for all</=
i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; hardwares and I want to keep it that way. If your PWM has a special=
</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; feature, give it a speaking name that the occasional dts reader has=
 a</i></div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<i>&gt; chance to understand without reading HW docs or dt bindings.</i></d=
iv>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
Using another DTS property to achieve this isn=92t as elegant as utilizing =
PWM arguments, which will only</div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
be applied when the PWM consumer uses it. This is another reason I want to =
extend the PWM cells semantic.</div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
Thanks</div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
Best regards</div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
Billy Tsai</div>
<div style=3D"line-height: 21px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<br>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_OSQPR06MB72521C20B39B1469B5C6DCBC8B4F2OSQPR06MB7252apcp_--

