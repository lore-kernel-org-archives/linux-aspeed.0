Return-Path: <linux-aspeed+bounces-3990-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46A7FF8875
	for <linux-aspeed@archiver.kernel.org>; Thu, 30 Apr 2026 00:16:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5ZSZ754bz2xLt;
	Thu, 30 Apr 2026 10:15:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777471974;
	cv=fail; b=H6fMnRxadtFmU8/IAlxStfF6hsBd+BZwcgyOtOPI3PGlAu6r2wt4nwsfaws8ScLMakUrr89+ktMHtF/AcazqPjpAd5ZqIxDE0iR0byZ8PbjoVEzdjH4ODCp56PT+Eh01cueNRBSXqJ7fw0pjDx538J86XGS9xLe/t/ZJ+Bea7yVsxcj0JROInJOSPVKM36Lz5GHqoy8olO6t2kRlzrzIX6/Q7FzVxG5+1gqZDOvt50XegGU0+ii2UBj6i/ogq9kjhxJBuPlUZonJILDBfI7HZ5juoWa3gOmN2FcYUV8HwPW0WfzsVLBlCR5avTNfzUztebp15E2hbyNJiS8CXnbJew==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777471974; c=relaxed/relaxed;
	bh=XltusBiz7e2urTdE8wyj0iOtFdXmHdB1/0DqNTJg8JQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IplhqiSMRclNTlRR785HPGTP35StVv3ziiGIvc/p1CU1BmhWHDPyPpQOK420H5qhqAFf+EZuoU6yydTVo+cIY50uu9Cf6tNAhw5IXzwzX4TQxaZOucEc6MMoNtAXox9Uv6u0f/cUwklHnylqbD7G3bCFTHOtJDrYKIyjzD8o1EjmBSTc9hiPLKwv/OXjM2DRntWAfbfqErTGOiq828s1qyX4O3yHQr61witD14J8HCb2QpTADSpTOxzXuPr/sq20ypvg6EkNI7u4GwHZqPe67rco0z8lB41Tm5H3lWUoqVmJzPcTqjLNkYd4/J1h+EyvucRATSclrLDiJcXlPk/Q/g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PVvFJqM1; dkim-atps=neutral; spf=pass (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=oleksandr.shulzhenko@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PVvFJqM1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=oleksandr.shulzhenko@intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 65 seconds by postgrey-1.37 at boromir; Thu, 30 Apr 2026 00:12:51 AEST
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5K5H4knXz2ySf;
	Thu, 30 Apr 2026 00:12:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777471972; x=1809007972;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D+5CGdVnlqIu7uDuIke0sDcRiNDAJ4gElf2w9s8SRzs=;
  b=PVvFJqM1m8XRKSRBoVylmY5pom+6kgFId57jIy8SWumlCcg63wgFossR
   Uimipegspwoqn6aPsCzfgdTvdK6yG3o0n9irFonwTK/F9SEdKTxE1/1vV
   +qTSwYnNko2mX7OBC8jfer5zUC47QeD/AxTnz/7GHu3whTY0tIY6Ekffb
   1emn9mDhtDXQYKr5lz7r2o9fUNtnZ/C86OOG9f86NihR8JDlJRm3XXZ02
   +ooVf6BbDmv3Beh1BGtVFTrS5i+pRguisSsyaQ+I9vDceW5rwuiTCT05Z
   h3IbHFI+n23aUF03BRIcnZ1pQzOh0nJgRNRlkJG7rQmy2Q6UsV9IqqOn4
   g==;
X-CSE-ConnectionGUID: avRrmMQPT62IzhYAIH1n3A==
X-CSE-MsgGUID: UhNZ5zUSRwSfNR1MpnVprw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88997966"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="88997966"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 07:11:41 -0700
X-CSE-ConnectionGUID: +cjcPFUyQy+UZYn1mycI4Q==
X-CSE-MsgGUID: ovEQzn2QTEqn6oiauBZOCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="233254625"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 07:11:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 07:11:40 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 29 Apr 2026 07:11:40 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.54) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 07:11:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l71mvkNmsOjJ/wpvruf1WiQ/I5P2ioOsV4jqi4ytAl+d9xcCL+KsKV4lMauvtvx2RWIKQpNg3d6jqWKjuaprDcT3u6Y8XMVHa3QlP7OK0kqoSfjaSK0u4AbGJEBgX3XpJdx0tTnjv9k1+a+3dkgtNQpny4d95h9QSLXfnkZM4yTEJTj11brVdXe/HqrniU1Q7heACUjF9JfLzocOsHtrpoJNdv1MKi/EUIToWNq/7Qg9eibwJFRFdQQ0b0rvVXk1uCuYMM0r8wmF2eff+VWFRkUUiC8buIjoPq3QL3ADkoJw6W9I4ggBo7XQv2THZjLZGjkTxXhqCid2GiEjUdhAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99z3XM1OacO7v9zG/GBi5xFUn+7+3clZaQEpFf/XC/8=;
 b=h7tZzX55W1/KRj+I2DoVCbLbJru/n25LmTyomJ9Q347ggK5DFsG4yI5699Ust5sSRYKPwRWYX4Q325vQJQOLac4Jy7Rgt6EZV4CABASMfjcnE9fhDTunZpKQHmqV78iffB6W6KEMmy9WGHcfhKymtUvJXQVDwzB2jdVR/YrC6ms5w9CQ2nlzgwnsCMHzqnxZGu3QQ8QJsOTpnRYIy1npSEa9Qd9mPm6muO8LM7mZuA0x2C0u0kSSBxn1C0aCcsbaf5XPyzamAZnG9oIYeU5GZmluFdVFZ9DNKDg0V9Qej+xYpVx/UCIjgN0mX7oeJ0QtOX9S+fTR4vJ8OmqMiqVt3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB8152.namprd11.prod.outlook.com (2603:10b6:208:446::8)
 by PH0PR11MB7614.namprd11.prod.outlook.com (2603:10b6:510:28f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 14:11:35 +0000
Received: from IA1PR11MB8152.namprd11.prod.outlook.com
 ([fe80::4895:dd55:dbe9:73bf]) by IA1PR11MB8152.namprd11.prod.outlook.com
 ([fe80::4895:dd55:dbe9:73bf%4]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 14:11:35 +0000
From: "Shulzhenko, Oleksandr" <oleksandr.shulzhenko@intel.com>
To: "yh_chung@aspeedtech.com" <yh_chung@aspeedtech.com>
CC: "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Lawniczak, Maciej"
	<maciej.lawniczak@intel.com>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "robh@kernel.org" <robh@kernel.org>, "Chen, Ryan"
	<ryan_chen@aspeedtech.com>
Subject: Re: [PATCH 2/7] soc: aspeed: Introduce core eSPI controller support
Thread-Topic: Re: [PATCH 2/7] soc: aspeed: Introduce core eSPI controller
 support
Thread-Index: AdzX4fN+YKg3om1DTZm2LDYCOnmpsg==
Date: Wed, 29 Apr 2026 14:11:34 +0000
Message-ID: <IA1PR11MB8152C8DD6B4E738C8F86E94F99342@IA1PR11MB8152.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB8152:EE_|PH0PR11MB7614:EE_
x-ms-office365-filtering-correlation-id: 72c4b671-2d93-452a-16d2-08dea5f938aa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info: F7KJskXKQZyaojxsxAHW9qMJTPdzTfJwhhHmxUmtBWb865DmozPI+2E70QbuwkLONz5UfcnzqGEBl1t6S7s+01bXk+G/V282v6FmyF7PaK3DieIWzSG8ed4rmJrja4OiHioGfJAa4Z4+P+FCi8g1HTkgCPVDa5AKZ7yXMdZfyN51UxKeV/6bHW25VzlHCbkmMkKj9jTrPSHx4qfLbOTW4dPKJbfTqlW9xPpDrNpPfx/0b4PNuZ5epImd50jZFmoKjHyqPofgAGFh3rZOAF4biVRrsre9wE7SWKFr7TW3L8Ps+rTQoAWPjNFugH/u8dMpiS+ywcWygpEzezOXBbdOAiAfcRlbJuE82GcRvfnrf2tANzbua0rdJfd9cRIRJSmFjXbNdMqNfDrejMvkPSnygn0keTXFIRAg/hj7q7CNxXMG02ev7Yz2wSPomnenGDIYV40fpESZDZ+A3QqH+lUPo3H0/iFwx7rarKsycKdyI6UmYQQj8DNuI0vOzPyLW4hiVbYdwtRrfjxuzZXBPvHjQ6eZJiv4NhEB+k7KFQsPPFZGtKXnCp9ciknHdUYHPdRBQnoPDVt8HWbyzufChNFUmmX6LwCQPnuX2+PVwgIPzu6Za/Ex7eIgUo+vPEsNOK4IulxH7PGQmkKU+24gpXApI7aQsokwwS3eQfeb+wq+97Xi6h1e5/46PCE1au60PgA8ILePV9iEJ9L1c33tj6ejVrrRDalrWJgVg0PJZ9PZdAmQRcWe5WCK597Y6N3vhkuU7WHcerFaxrLzZPwUR2TP/7JAPYg/K87LdODihNKP8qg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB8152.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EdsvysvwSqRwSTYlUWY5dBTw7+fQexHFIR4NlNjC1jdd19vH9lDq9UQqbauq?=
 =?us-ascii?Q?0FjZ5d26vjzOL+an2tZGtAsvosdFCsmQs96cczceA3Gn4N7dJHwTq2jg9kr4?=
 =?us-ascii?Q?8bhhs7C2hmjWDGrFgpKmLYBzX+Io9logepxIZwIgUW8ADw88cxpxkEoY3XLB?=
 =?us-ascii?Q?1Z99Cbt5feoBOO2fBlXaNJ6eYcWmfyOtB5O0lHivJOMsA+gzvEQLj8NmtNlw?=
 =?us-ascii?Q?82SBdz4OndXi5CJKsKLLa9nadlnSaSl1GRFOuV8+5H3e1E5gB6QvL99fcBSU?=
 =?us-ascii?Q?POlhgNxmnDSUjxGbZdQGPABK4+l9TYI59X2j9MPskm1Ma92BPuQd371EhNXV?=
 =?us-ascii?Q?Kwnw06stgdG9jJYKennTJLiZZ3otLHqNC3jXxj/bW3rol8BPWfFPUZ278B/v?=
 =?us-ascii?Q?xlcHlK1p2pFwU08dCVoP35y7EmIvswUgo72Fb0n56cPUswwD1istqiX9l0Z0?=
 =?us-ascii?Q?fAewjXUJ80mS+7Ib5j0AapqgobomOHZY4RcxTSN++5mVmjx6zTulg1pTPod2?=
 =?us-ascii?Q?fjD7ssTRMchJMoDOTI0PP0ijJvkmIGrMfwZIxTffimU5M+7PcX25pBezjBNz?=
 =?us-ascii?Q?wNu+Mh6ONvofE5e46FTC08+EsSmmOvcq7ZyRHN00RfIlHhilHisriwh4QQ0Q?=
 =?us-ascii?Q?DV+hEqxlgpXImSZ+ejvTb/aagmSw0URa29sr9oRmMSleeCRkOuLn3YIeXQif?=
 =?us-ascii?Q?Gnte2vyo2QnVYQ0+QU2mLAvd1YVnV94BcBSsIZYrZwHyeIJHR0kUuFYIAqWn?=
 =?us-ascii?Q?YYDF6GCjse/lX//BUkM1dLIl/ZQC0jUBxIz3D4swuOpUNSSkHJxeZ6ncwnPU?=
 =?us-ascii?Q?YYIUnbk6FGS1GahGRNmojwMXX6MqcM/yziJ7JVt6+NdaEawHC325WOGjN0QW?=
 =?us-ascii?Q?x8GCIOxnXA56IN4EcbS4q/lT/8IKJBVqKKLHnj+Yv3Te5uI5HHErYNMBysI/?=
 =?us-ascii?Q?UtzMNpN5vQyIwhsFUnQcA5Z5aZD3NCF2L9TXEDHNDbw+A1jyGT+ZhFxNIoSv?=
 =?us-ascii?Q?8RIpba8IhXI27g9RJluZoWrJsCFWLQicXo8jXWI4ijV9k1IZSIffBMkRYmPJ?=
 =?us-ascii?Q?Ef6WGnP2EW6ps/fC4AWLXKZAusnNCz5C9LzsDD6btc1PYUh8BNod3kBBXk6t?=
 =?us-ascii?Q?XwZe4+Om7IvhHy72/0mx+84xrQRlyEZebSKcz4lVzKcrLaXuNQcn+CoaF3h7?=
 =?us-ascii?Q?9hRNyl9SL9Lo0yfTQu+cwO5+EaKFIACzR9vrOuxilsoRPpSO9G7uPtPrT6I2?=
 =?us-ascii?Q?XcCrRCVl98gGFP8F8d3ezvoWNuwMW1RG69nMmgBv+cxJW5qSZPhnv9sc+ph9?=
 =?us-ascii?Q?BDe3eKO2dp+NXo4JpDmZZKrHloVMT7XXDYhwHh3YV+hrBq9vMfbzodoxV3SH?=
 =?us-ascii?Q?iFRQC08y60/8Le7hM/PZVLu2BbPSZqQEgOOm2xID44a6rm3dhRmkNZIe+Qjj?=
 =?us-ascii?Q?Op9PggFfboXEaAPpHUjNi8T3Ijfc9cbT0Z9lO8eCspb7J6Vr8GzobOKL4Duh?=
 =?us-ascii?Q?i4qqfA1LeWRES1mR2CitwXKYDcE1wjayYgAzDKo76e8rBut6SuYL6EaWbb5c?=
 =?us-ascii?Q?9+ae2q0X+niUOBs2XY3zTdz+ZL+TCqA2Zkc4Bi8fktVzFZJWtbhleKkATtxu?=
 =?us-ascii?Q?fL5jGrcFwGmj0vTFDMrICuLMGflS8wL9Nx2FbySwwkLPcf10vW/3OS660DQX?=
 =?us-ascii?Q?MuO7fEIkvi64Js+ekb54LWnTcVzPQVKal026/VuBOyMXI1qSnVllU9VC79/7?=
 =?us-ascii?Q?WKNmu8RWe7zzcyvV0D7CRzXQtchA69E=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-Exchange-RoutingPolicyChecked: RT5M7EiN+FCdXpvO9W8OC0hh+5mHPMSKgbPkWDRR49cLFABFkA5gL06hmEcB6WXwLcw06X25evrO6bQ1+RQbJcsWL16WPcYJKmYexEUw6Sbhjk225UcGaCp0YIDcZ/6cohvDximxCYcL8SExoVP4RfI7mbB/QT0iVFzZOWm54T0IqJW3Hjfv+Epx9DSVoFTy1WEEbxm8P/ukpJBlpz9GAPCwdV04KeuZEjyodRA3CP2pIGr9XQsM8TosP5QCBpH5PkNEzzwPmsln3ez4EtTmDj8MmzJm1GNJ1iwoM3wh119llZsD6R07UBBOkQpBBfB5HaJzuGQaUh5U+za1WedBgA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB8152.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c4b671-2d93-452a-16d2-08dea5f938aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2026 14:11:34.8854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GhePVE4WSDc4Cn8KrsdGZ3svb0btY/XURIKcNvXHu/CNXgH+Sy9zSclv3TxhMJUiWxMoQrqw7fqSThm56PFoRU7hlgN4OLtC+w0iT3ZB6tQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7614
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: quoted-printable

Subject: Re: [PATCH 2/7] soc: aspeed: Introduce core eSPI controller support

Add core eSPI controller support and common code for ASPEED SoCs. The
eSPI engine is a slave device in BMC to communicate with the Host over
the eSPI interface.

The initial support includes basic eSPI driver probe/remove operations,
and provides operators for ASPEED SoCs to implement their own eSPI slave
device drivers that are different among SoC models.

Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
---
[...]
diff --git a/drivers/soc/aspeed/espi/aspeed-espi.c b/drivers/soc/aspeed/esp=
i/aspeed-espi.c
new file mode 100644
index 000000000000..15d58b38bbe4
--- /dev/null
+++ b/drivers/soc/aspeed/espi/aspeed-espi.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Unified Aspeed eSPI driver framework for different generation SoCs
+ */
+
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+#include "aspeed-espi.h"
+
+struct aspeed_espi_ops {
+       void (*espi_pre_init)(struct aspeed_espi *espi);
+       void (*espi_post_init)(struct aspeed_espi *espi);
+       void (*espi_deinit)(struct aspeed_espi *espi);
+       irqreturn_t (*espi_isr)(int irq, void *espi);
+};
+
+static const struct of_device_id aspeed_espi_of_matches[] =3D {
+       { }
+};
+MODULE_DEVICE_TABLE(of, aspeed_espi_of_matches);
+
+static int aspeed_espi_probe(struct platform_device *pdev)
+{
+       const struct of_device_id *match;
+       struct aspeed_espi *espi;
+       struct resource *res;
+       struct device *dev;
+       int rc;
+
+       dev =3D &pdev->dev;
+       espi =3D devm_kzalloc(dev, sizeof(*espi), GFP_KERNEL);
+       if (!espi)
+               return -ENOMEM;
+
+       espi->dev =3D dev;
+       match =3D of_match_device(aspeed_espi_of_matches, dev);
+       if (!match)
+               return -ENODEV;
+
+       espi->pdev =3D pdev;
+       espi->ops =3D match->data;
+       if (!espi->ops || !espi->ops->espi_isr)
+               return -EINVAL;
+
+       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+       if (!res) {
+               dev_err(dev, "cannot get resource\n");
+               return -ENODEV;
+       }
+
+       espi->regs =3D devm_ioremap_resource(dev, res);
+       if (IS_ERR(espi->regs)) {
+               dev_err(dev, "cannot map registers\n");
+               return PTR_ERR(espi->regs);
+       }
+
+       espi->irq =3D platform_get_irq(pdev, 0);
+       if (espi->irq < 0) {
+               dev_err(dev, "cannot get IRQ number\n");
+               return espi->irq;
+       }
+
+       espi->rst =3D devm_reset_control_get_optional(dev, NULL);
+       if (IS_ERR(espi->rst)) {
+               dev_err(dev, "cannot get reset control\n");
+               return PTR_ERR(espi->rst);
+       }
+
+       espi->clk =3D devm_clk_get(dev, NULL);
+       if (IS_ERR(espi->clk)) {
+               dev_err(dev, "cannot get clock control\n");
+               return PTR_ERR(espi->clk);
+       }
+
+       rc =3D clk_prepare_enable(espi->clk);
+       if (rc) {
+               dev_err(dev, "cannot enable clocks\n");
+               return rc;
+       }
> +
> +     if (espi->ops->espi_pre_init)
> +             espi->ops->espi_pre_init(espi);
is there a chance ops are unitialized? In any place you do this check
+
+       rc =3D devm_request_irq(dev, espi->irq, espi->ops->espi_isr, 0,
+                             dev_name(dev), espi);
+       if (rc) {
+               dev_err(dev, "cannot request IRQ\n");
+               goto err_deinit;
+       }
+
+       if (espi->ops->espi_post_init)
+               espi->ops->espi_post_init(espi);
+
+       platform_set_drvdata(pdev, espi);
+
+       dev_info(dev, "module loaded\n");
+
+       return 0;
+
+err_deinit:
+       if (espi->ops->espi_deinit)
+               espi->ops->espi_deinit(espi);
+       clk_disable_unprepare(espi->clk);
+
+       return rc;
+}
+
> +static void aspeed_espi_remove(struct platform_device *pdev)
> +{
> +     struct aspeed_espi *espi;
> +
> +     espi =3D platform_get_drvdata(pdev);
> +
> +     if (!espi)
> +             return;
espi pointer is unlikely to be null here, I suggest removing the NULL check
+
+       if (espi->ops->espi_deinit)
+               espi->ops->espi_deinit(espi);
+
+       clk_disable_unprepare(espi->clk);
+}
+
+static struct platform_driver aspeed_espi_driver =3D {
+       .driver =3D {
+               .name =3D "aspeed-espi",
+               .of_match_table =3D aspeed_espi_of_matches,
+       },
+       .probe =3D aspeed_espi_probe,
+       .remove =3D aspeed_espi_remove,
+};
+
+module_platform_driver(aspeed_espi_driver);
+
+MODULE_AUTHOR("Aspeed Technology Inc.");
+MODULE_DESCRIPTION("Aspeed eSPI controller");
+MODULE_LICENSE("GPL");
[...]

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydz=
ial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-31=
6 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu usta=
wy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w trans=
akcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata=
 i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wi=
adomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiek=
olwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the s=
ole use of the intended recipient(s). If you are not the intended recipient=
, please contact the sender and delete all copies; any review or distributi=
on by others is strictly prohibited.


