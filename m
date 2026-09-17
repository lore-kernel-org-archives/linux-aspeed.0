Return-Path: <linux-aspeed+bounces-5020-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E69C88E72
	for <linux-aspeed@archiver.kernel.org>; Thu, 17 Sep 2026 20:55:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hm7Lp5j15z2yD3;
	Fri, 18 Sep 2026 06:55:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=192.198.163.17 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789678530;
	cv=pass; b=cGgIA3t654SfRTTMRnATIQWDpcuGjAVZyE/60W+I7NfxbIGBtc/4ozRDsxmlm0IypjSqgtJO+XD/tMpi1npBx+i+TXiwLEu03pumXIrrRrU2pGoevp6+0KGNXYLfXUYJjTpd0iBHEMiDXzbpLSRHUI23MrKDS0ewBqGe0zkSlOf5vzg6652yMEDNLIK1KTWDM/93NMEI2KVaKFsB/2v2icAhq8rIyKmkkhqXAOc6tYHpgkxlSLAqy10HOeyydFdtw5MjbjdN9ekMnYGTM57ZvG6MuWBAmaRa/609fpXIcIGEzJXEprCDGapEUkksp0QcOlQe6fXXM2LeZXEDxTveTA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789678530; c=relaxed/relaxed;
	bh=wiryaIfGo1b6TTknA4RdSPsvV5+zCP3YLqfFmIgdQLQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nRnaXc8HanwQzFDuBvqgaqMxt75pKlX2ZhjBTQ3KiHCDObOX392fIfBDdVB1dVsPFEzPyds965M71dnS1c0dxX+KHthD5QLNQ8yW6aO16yqylZDEbh+nPvn8P3NDKPNAh5qoHb2SFEHNlnrGc2XQYEgSxxdN6Im6+iQd26pBsT8PrNwHGFGdLR6aSt4HrH9w7EZPj4WEw1cedkldX87flU+2b/kcT6vR6f11A/TfNIhPeLHZBC8NimcbIgbj+nVEGIte4eal4ARehOfTvj5Gnjy/YD5d3tXgXkVjarK/ugii/sC5CkMCkLbcTi+7hIo8gnNIstkFid8liMDJ6WvEHA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LPC3/oTw; dkim-atps=neutral; spf=pass (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=iwona.winiarska@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LPC3/oTw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=iwona.winiarska@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hm7Ln3rT5z2xbQ;
	Fri, 18 Sep 2026 06:55:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789678530; x=1821214530;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wiryaIfGo1b6TTknA4RdSPsvV5+zCP3YLqfFmIgdQLQ=;
  b=LPC3/oTwJpbVj7N6O4X45eDMbt53X3W8BwIk434ta5sPr9huSzBszZbf
   9GRzf/tp5wQYobraxaZpgEh/q3naZDhVZU6rfEMKJw3S7HBo369gkzCIy
   TNd8PNGgG2gw2/uef80XSxWDQjKr2UoR9f0tJrBrsybyrUQAMt1K+Ti5i
   H2QMSyHS311+lkiM8WAA06sYqKEXuEuKnuQGMP86zaCjP/iWs70TSKSU0
   wmpdLfEX7kITsPyjjetfI0/Vki1vt4tBgDwKCFIcSH8dzAjfY7hD+llto
   IYYVXqtvkvk+6mMl1eC8URiU/fFqhBv5gAjpkU4tTUPlDWeqFKb8yyLnq
   g==;
X-CSE-ConnectionGUID: xlHcCsiWTqWzglL1qSACCQ==
X-CSE-MsgGUID: 4b7LRs1zTS2s3ShUSXChIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90010687"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90010687"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 13:55:27 -0700
X-CSE-ConnectionGUID: qqOmuhLER9yTWFA/7NtULQ==
X-CSE-MsgGUID: r08um9/7RTCbHNXDrNafaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2446499"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 13:55:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 13:55:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 13:55:26 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 13:55:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ByTQvhLeAWuZoWZxv9SXFZiIe7v3ECTFWD3On3uF6yO53iRq37DMsVvsVZ+Jb/Rm4qUWi1zX5vqFZ/p80CQlrUvdVD9vrwuOYF+x9ubPcfa9qnjCGgXuE9MZND9eCcw4Wzr+XNJn3JBPiRz+VP7iGWxXcHjiajHgmTq8qEFnUVLYc830GmiAQ+Z3zuD3MkJjzL4xa1uBGbGfnorXuhI0TOTsJzkalEwXSpDObocDw7KP7sgbmIZYOHY5BUqmS/w09bIe6GaJWi/TzsAKZsJahal/2hX11wS/ERnSNCbVuuY/ggsxC0zLvCNWe2qGLnvmj3CzxH5fR+AClvmf24mgkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiryaIfGo1b6TTknA4RdSPsvV5+zCP3YLqfFmIgdQLQ=;
 b=aiIrhxsV2LrNqpd/aH0zMmOCrSO2fo76QI+3nT5LfoFEHIeeYHI3B3rpfCOkia0qvJmsbWRTwt/xPFfMD2XVIimNeqlSUR1TTuAN9c3k9gdYx777iwGdduLuoAjMk0b2U8tzmoo4KZX8qLDX0QdRiUhGe7vodjr6pl0SajFFnDDdgRuKRh7rAUucy8cE/oK3bi636a+vowvbmo5i6EjmogdELYsl7GpI+J/Yvijo64hdtNiEO8n6fL9gkrrwhTe8Sz+I+baYF+UbmQUln//W6NsoaWWT2Gf64eU2FfZy2exMw2v8ykCedqYmGaQNafj4J0zeBRAshLTRJQn/PoKx8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5330.namprd11.prod.outlook.com (2603:10b6:610:bd::7)
 by IA1PR11MB7296.namprd11.prod.outlook.com (2603:10b6:208:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Thu, 17 Sep
 2026 20:55:23 +0000
Received: from CH0PR11MB5330.namprd11.prod.outlook.com
 ([fe80::9d32:3dfb:c2f1:40e2]) by CH0PR11MB5330.namprd11.prod.outlook.com
 ([fe80::9d32:3dfb:c2f1:40e2%3]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 20:55:23 +0000
From: "Winiarska, Iwona" <iwona.winiarska@intel.com>
To: "runyu.xiao@seu.edu.cn" <runyu.xiao@seu.edu.cn>
CC: "jianhao.xu@seu.edu.cn" <jianhao.xu@seu.edu.cn>, "joel@jms.id.au"
	<joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Chen, Ryan"
	<ryan_chen@aspeedtech.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "billy_tsai@aspeedtech.com"
	<billy_tsai@aspeedtech.com>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>
Subject: Re: [PATCH] peci: aspeed: Initialize state before requesting IRQ
Thread-Topic: [PATCH] peci: aspeed: Initialize state before requesting IRQ
Thread-Index: AQHdOucN6bGnLY6uBEqdi25PeCFhpLbTV+SA
Date: Thu, 17 Sep 2026 20:55:23 +0000
Message-ID: <94b5b07248606ddfa02b189442dc81beef423d5b.camel@intel.com>
References: <20260902142600.3580382-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260902142600.3580382-1-runyu.xiao@seu.edu.cn>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 (3.60.2-1.fc44) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5330:EE_|IA1PR11MB7296:EE_
x-ms-office365-filtering-correlation-id: 65775670-6788-41a2-288c-08df14fdfe6e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: OnKBCY2PsQAeh7TS3p+WbRIOFE2nMJvkJvxxhbe3PgOMz+cE+6yDr9XUP/uvaocmjfyDVV6L/3qZKZlcBAbc0Lc2hv28zEFLgRUGpviz0QQAjBVaf4AMP2AaOBb3z9dVNGX2D5dAzTL4p9U9kNBJyF/Uzm8B3qxbmGSYnua5C+VJnkaNatemerZJFeYpTU2RZx4TgiP0e0nNP1e0+V7wkrWQjecggll5nwn59azAZcFjoy82PBNiR4TwokodL9cKiXa1WqY3HfffoWQjfkgfG6jtmietT0it/mXlsYa55MbmlX8jK3by2OaQju1yGryTQTkz7DcarD71Fh7qX5obFhquczV9780l+GLmRZer5cQU5jPsBe55T1E0ndbI4l9m8w+n5WTgHTGqIgSFICsztSfoqXH3s0H6frKyFPNRljXcLtLmYhozmGMk7xv3ckPO/NiX7c0gIl97Z2P+v59k2Utwd8KRzZSqOUiAAfEGx34hv/+atzRDtofURpAaFtgqpw8ovEad6tsUxF4wbwsOCh7KsaFbbv0NENA3RslKCmEH8efv0SxUdtSm47lGj5V8Oju7XfagJRbVP4Ug8i/SkWMp/xJVBSS9V9HgIbg+URZmRDyhIPr8QB/r7bLweuqImvUEsvyoTYXV3gnWpneR+J9LwatfdEUf3f6xQ7oLkYG4GS/nnT4XdWAi1jgqBPr91ykM3u6dk5feuTf0D33Odg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5330.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TytSU1E2clBYUUZoQ3c4VXFmQllJR1l4Zkc3bVUvdlQvRUJWcFp1aGdybzRT?=
 =?utf-8?B?ejJmWkZtVEFBZnFrZXVPbFRhRnp0dDc5dUNQM3BIQ0JaSHQ0b0tHbGpLeUgr?=
 =?utf-8?B?OHFxM0Rpa1NPYWNCSGZpOThQWkxVWlpIa0htOEZxcHlZU1hLcGdITUwwRVg5?=
 =?utf-8?B?SDlyZXBJak50TnNUZ052VlZ5SFdPcFZZYnloczVha1lZRGxONDN4Z1NJN3lq?=
 =?utf-8?B?MFZPRTNwSUdVVGd3dGNrUW9YZjVJVzQvK0hQdGJEWWF0R1FFcWZuY2crcWFY?=
 =?utf-8?B?TnpyalE0eXVhaTdFakVaM1ZMOUFBQUNRSmxlam1ZbS9uaWpvL0s2dFV3M3Vl?=
 =?utf-8?B?dWtmSzI2dGtXaG5HWndrM2xkdFZFNE4vYVo0UnlrQlB2K3JBVjAxc0dzd3Bl?=
 =?utf-8?B?VFlRNmtLaVpRelNmWk9IYW85ajh4eDEzSUNnUVVKdzJJYzBvQ1gyc0R4c3Fk?=
 =?utf-8?B?TUdUeTd0ZTllU3V6VE1pODVUTVhrUmJHQ0JJU1ZLRVllUWVVaEZLZ2VRTmVF?=
 =?utf-8?B?YTJBcWVYaG4xNUVuT0RKUDk5Yjc1MzY4OVhsLy92R3N6L2V3eFRhMHJGZjV3?=
 =?utf-8?B?U25Tc2o2WFFsOWR3T0ZjSVl5NnNWQ0lNVDJiKytsd1lybHcyTU5lMVRRWHZ0?=
 =?utf-8?B?TVA4dVMxM3pqczBzOVJUZU5oeHg3OERZRkI2YUtaVU9yTytURjdKcWlwcmJS?=
 =?utf-8?B?RzJOa1lnWGszR1ZtZkNXUkN3NWk0czNzdzlqOHpXb1NiZ20yWnNWZ3hIck1W?=
 =?utf-8?B?WkdJM2FEQWd4V0todEM1WXNCSTVaT1plRkYxYVVOd3NWTXJjQSt2N1o3MG1U?=
 =?utf-8?B?d0tlY05sOWhkb3EwTzBLTWhSRU82SFA0VmtjNzhWSlRocG9CU3FUaUdVY3Zs?=
 =?utf-8?B?NnBTNzkxL0NQTjNQUGZOR0x3bEprVWIyVXJjZTFPbGl1VGIvT05rVDNXNTYw?=
 =?utf-8?B?bjlER0prcWxKTmFSd3NYTHZ1bGlRcUNPNFNQNER4cEZmRlJIQ3E5WXg5b01N?=
 =?utf-8?B?QjA2czVJZ0JpcEVqSTVHOXltQ1lwQWVCdzJ5UUMyc0JYWUlJbEdyU2hRbXQr?=
 =?utf-8?B?eWl6U1p0bGI3S1lRZVV2bERUNFRIcU1yd1J5SDB3UjlXa0lsU1hUNTBjNkNj?=
 =?utf-8?B?eVpOcEtvYktRWGs2eHhXWVN1ck5heEdBc0pzeloyWlBDMTVremhGbEU2NkJq?=
 =?utf-8?B?UjFBSVZsREM3Mk12R0Z1RGhYQjU5eVFCdTRLVTBRYWVIZ1VxMkxIeDd3NWxQ?=
 =?utf-8?B?am1UY05xTDJRYkhkdm1yeVR4RXU5V0tQTWtNSHNVYkpseXFta1RvZlNITnQw?=
 =?utf-8?B?eWpyNUc0MFFjV3k1WHA1NUhRZWgwQVN4SUgxVUt6WWc5NXBZU0hzSnlTWGJ2?=
 =?utf-8?B?U2NFZ2JwK21rSGM4SWFCZWFjNHpwZERxZGNmTlhzd01CcFZxMEFjdVdnUUZ3?=
 =?utf-8?B?MnBVT2VZT0pEbmh5L0x2UHUxUGRubURZS01YVlVGNnpEZVBWTFBPRXRiYjB5?=
 =?utf-8?B?aUE4Q1M2N0hMNDAvWkNYRGpGTDJTZWM2NGkzZ1hnUlZZUXcrdXdDVkV2Q3JO?=
 =?utf-8?B?YTRzZDE3ZzlXYTNYdVpkdW9QQTVmSE1MZ0VldTlHckdaS0xKU0JGVXNXYkl2?=
 =?utf-8?B?T1VtWjliVUR0YWJKNFhDQzJJUEpKd3dscXJnbEtyVVBtSFYxNTVNTFhYSzh5?=
 =?utf-8?B?bEtKY0hodEJGUVNHYk1TS0xHdm1HMFJqbkFaQnJtSnZXV3NPYUo2dWNpQXZx?=
 =?utf-8?B?R001L3FpOVF2YkZvNzlRR0x0a3p0THM3T29ZREFpekNucVJBZE1wSTR1WmNx?=
 =?utf-8?B?M2d2QitoNnRMdi9UektzNmZYaGFZMmNYNzVWV3dKUU0zamwyemFuWndUOWE0?=
 =?utf-8?B?TmR0bFNFTmR6WUZoMWduNjM1dkVaU3pkYUs2a2hiT09qbCt6dlJKNnB5eVNI?=
 =?utf-8?B?QUpKODdYSHU0VE5zRzA3NmZ5Tm8vUEhPY2drdi9oRjdFUVpaM1ZJd2pTdFlv?=
 =?utf-8?B?R3lKWkIxclJUNlF3T01TNFBqdldKeXI4SGc4ZDU5YnVjVzZCaU5wcjVtbHJU?=
 =?utf-8?B?M0Z1LzNUOWRoM3NxYlZ0N3JjRW42MEpZUjlFT21RTFowUFVCZTE0aDRRR3l6?=
 =?utf-8?B?MkVpZUpodG9HdmZxOTFyY3RJTEpPeVpQZ2ZHU3ZPMWZVbkI3SUVhbmtER3dY?=
 =?utf-8?B?aEJWMm9VbmZ1bDFGQjN6dllBRUdybjErUnhlMW5DaGFtUGVJY3dJeUpFK01z?=
 =?utf-8?B?VE5zMjlMdW8xR1R1bFFXUWo5RDBmU3RTZTRzUFFsZUlvNjh2eUVSdFBOaC9U?=
 =?utf-8?B?R0xCZW0vTml1RUdOdk1Ody82SzdSNVU0L05EUXE5NXh2RytFVHJCMTdOTDVI?=
 =?utf-8?Q?wdgjxo5PI73sT9oA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B600A764CA32C40B1A70C5A6DE55C68@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: a1BL2kyBJDjaS4I5w9bPkeWtWm7ybEzoVzZXD6YBKoMnkPnzFx0fMsbkqkeGFzkyJri3fZCM7bEbVSri8q5uNw0K1yMkTstF/vnzE+YruAi5Ab6iF17BjUoiYYIkyv2CYBeqHoBFkMK9+hqSFJEq9g8GErK0fOY7zK0Ppq4aM1ifJhWEOZpkze6cSkgXyd/pu279F6/lTiXpzyUCUj99b7JjvBMBbNbyL2bors/tKomv/uHY4ajKf/08BGhcNWuk+A64Y6xyeeLFEQSFBeDRAVhtkdQMdwoGl+2nUppwcUKpJc3ywjR9ATeWlMg4uAqBs7GlFQc5sP6P47CeMjf2Rw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5330.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65775670-6788-41a2-288c-08df14fdfe6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 20:55:23.7743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kmN10rDBg98YYeloKQyjysTn3Gjm8BuWEbzqrLvR4moP2qbNsQC+wnZHYc8Ku9iQ+wTaaWLd6WZ7LatWBMgWeFxNa8ID9f0k6R631q+Pnw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7296
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA5LTAyIGF0IDIyOjI2ICswODAwLCBSdW55dSBYaWFvIHdyb3RlOg0KPiBU
aGUgUEVDSSBpbnRlcnJ1cHQgaGFuZGxlciB1c2VzIHRoZSBsb2NrIGFuZCBjb21wbGV0aW9uIG9i
amVjdCBhcyBzb29uIGFzDQo+IHRoZSBpbnRlcnJ1cHQgaXMgZGVsaXZlcmVkLiBJbml0aWFsaXpl
IGJvdGggYmVmb3JlIHJlZ2lzdGVyaW5nIHRoZQ0KPiBoYW5kbGVyIHNvIGFuIGVhcmx5IGludGVy
cnVwdCBjYW5ub3QgYWNjZXNzIHVuaW5pdGlhbGl6ZWQgc3RhdGUuDQo+IA0KPiBGaXhlczogYTg1
ZTRjNTIwODZjICgicGVjaTogQWRkIHBlY2ktYXNwZWVkIGNvbnRyb2xsZXIgZHJpdmVyIikNCj4g
Q2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQXNzaXN0ZWQtYnk6IENvZGV4OkdQVC01DQo+
IFNpZ25lZC1vZmYtYnk6IFJ1bnl1IFhpYW8gPHJ1bnl1LnhpYW9Ac2V1LmVkdS5jbj4NCg0KUmV2
aWV3ZWQtYnk6IEl3b25hIFdpbmlhcnNrYSA8aXdvbmEud2luaWFyc2thQGludGVsLmNvbT4NCg0K
VGhhbmtzDQotSXdvbmENCg0KPiAtLS0NCj4gwqBkcml2ZXJzL3BlY2kvY29udHJvbGxlci9wZWNp
LWFzcGVlZC5jIHwgNiArKystLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGVjaS9jb250cm9s
bGVyL3BlY2ktYXNwZWVkLmMNCj4gYi9kcml2ZXJzL3BlY2kvY29udHJvbGxlci9wZWNpLWFzcGVl
ZC5jDQo+IGluZGV4IGEwYzk5ZWNmNy4uNWQ3ZjRmOGZkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3BlY2kvY29udHJvbGxlci9wZWNpLWFzcGVlZC5jDQo+ICsrKyBiL2RyaXZlcnMvcGVjaS9jb250
cm9sbGVyL3BlY2ktYXNwZWVkLmMNCj4gQEAgLTUyOSwxNCArNTI5LDE0IEBAIHN0YXRpYyBpbnQg
YXNwZWVkX3BlY2lfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gwqAJ
aWYgKHByaXYtPmlycSA8IDApDQo+IMKgCQlyZXR1cm4gcHJpdi0+aXJxOw0KPiDCoA0KPiArCWlu
aXRfY29tcGxldGlvbigmcHJpdi0+eGZlcl9jb21wbGV0ZSk7DQo+ICsJc3Bpbl9sb2NrX2luaXQo
JnByaXYtPmxvY2spOw0KPiArDQo+IMKgCXJldCA9IGRldm1fcmVxdWVzdF9pcnEoJnBkZXYtPmRl
diwgcHJpdi0+aXJxLA0KPiBhc3BlZWRfcGVjaV9pcnFfaGFuZGxlciwNCj4gwqAJCQnCoMKgwqDC
oMKgwqAgMCwgInBlY2ktYXNwZWVkIiwgcHJpdik7DQo+IMKgCWlmIChyZXQpDQo+IMKgCQlyZXR1
cm4gcmV0Ow0KPiDCoA0KPiAtCWluaXRfY29tcGxldGlvbigmcHJpdi0+eGZlcl9jb21wbGV0ZSk7
DQo+IC0Jc3Bpbl9sb2NrX2luaXQoJnByaXYtPmxvY2spOw0KPiAtDQo+IMKgCXByaXYtPnJzdCA9
IGRldm1fcmVzZXRfY29udHJvbF9nZXQoJnBkZXYtPmRldiwgTlVMTCk7DQo+IMKgCWlmIChJU19F
UlIocHJpdi0+cnN0KSkNCj4gwqAJCXJldHVybiBkZXZfZXJyX3Byb2JlKHByaXYtPmRldiwgUFRS
X0VSUihwcml2LT5yc3QpLA0K

