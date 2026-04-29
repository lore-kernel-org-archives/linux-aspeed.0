Return-Path: <linux-aspeed+bounces-3991-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4068FF8875
	for <linux-aspeed@archiver.kernel.org>; Thu, 30 Apr 2026 00:16:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5ZSc4kbvz2yqs;
	Thu, 30 Apr 2026 10:15:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777471523;
	cv=fail; b=OD7xV4dF+l1KnZ8GCKAAGlGuzcuXA4yQSwG6t0Y1KYcw/K3U11ecPeTUMEV1p+8K6B4hA2/+gWUOOG9kUmOYXbfhk4KDjvjIauAPtyVEW0KYMqXeQJ/hXCfUKfmEa7DPtb/C/+wzXE0kPPusVcMkqhsr1gvCu1ez1mhGrxXWAkj7TZe74p2/jZlxUUKlhpZo8qBbtCr7gNSYU/MYOuIDpLKvkgyoeUGE9fFbNuBFCzbxiPaAhgmnAFvRiT0VBvkjjWp2kOW84rDJpsmfr2JvcDBGU4TcFhU/zyVv9GN4uxL1boehxYVoo7Pq5su790tmCOOX6zSLq7Nj5Nsb/Xsoqg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777471523; c=relaxed/relaxed;
	bh=0lMxF9yhFuCOWUx3jbXky2CfzDvxrPHncg6LrnDWXDs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=m5ha0UsHj4JErAXPcbgDQZle3dzHb2pXhq7Kg6io1Q1MZBuzf8qL1nSyqbvnuCoT2IhjntwvVs9YiMIugm6gwNhO2RPMtn2APgmeldqL4sJrIbcc3CVDcASBoDOLRRt5viF4wIJPD1a1gZn6ob+whniIbPN/OHY8UUgxX2vWazJjA84gCuDlFOdTdhLlKxuM6ahw8yOTjLvQM2mSsVKf5hrTfJsIyhpscFH0ByExmQGJa9pzBetmFZAEXsgQd0H8F6tQjUKhrDKH5HtHl6Z02G4ibg/5xdj/EpSGSPc7EW0yivH2dr8JCsbg5UUGpk+3k+sQwyW1VePU8bolu/8o0g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eJtUWslv; dkim-atps=neutral; spf=pass (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=oleksandr.shulzhenko@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eJtUWslv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=oleksandr.shulzhenko@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5JwZ1lxJz2ySf;
	Thu, 30 Apr 2026 00:05:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777471519; x=1809007519;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=7qUCteMeRbjP8ZSRtDp1YZdlHVxF/+4Krp9exwA7zUA=;
  b=eJtUWslvvla2+HIv58By4QlRvlfaeNsS4aoWTeAv+IyCbokfbemhUJVB
   8jIVOvM+bplsJniYbjQmnzqi+qJtxEJcfVFhq11MbBe/iE+GiDUlJ0tcB
   tpq1Cf9+akROhiZSPmKWP/oozP4P5sUgLS4o9pDrnJ5WcBrdvqFOQEd9c
   in47dNogdepbzEnUI6WaJeBnGAF2SCKW0kqBojreGzZRyNSNIuUwFRlLj
   OWl9oAmVkYOlJOWig39JZIuuAzD7UeeJWh8oEOC/3pbpBy6TqHjWmnLhG
   3v3D0wGI8vDvMgfR8zJTEkzZd+yF34xWnslUOpTF/D09XIInbz+JU1LIm
   w==;
X-CSE-ConnectionGUID: s+y/GVB3TqW47UrTTcK81w==
X-CSE-MsgGUID: G4CmBknWSqKWXqMhtKET/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="65929857"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208,217";a="65929857"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 07:05:10 -0700
X-CSE-ConnectionGUID: 6SieK2vtSRK3wgL78HNfTw==
X-CSE-MsgGUID: qCboto/0QI2iJiVjtK1B0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208,217";a="238602891"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 07:05:10 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 07:05:09 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 29 Apr 2026 07:05:09 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.1) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 07:05:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knMlk4uy+o5JPcM7vskluXkLyy5PrForetvke9cXEHWt6h6A5DoLOu7TPSqz6pRAaU//18w0eJd1og3JBfhdgFajS/HqZGB8rvfmWJkSvHBgVSqtH8QLHYD361A+euz9nylxkMiZrXgOjDy7ZC/wNUWNCYjyiyEcgCDzw/qD/tkrzpqzZLEcuH/wS4ylEQ933GfJZtdCplCya/taVqGt7GtU3Nz0mELpCenopbRhGdTEoAHEAPRnYNAMAUqs+ImPRENxPcT02+Fq4CRPc6FP24fhWfCfcY9yr9NKlocVxEYB2hr0aLBctjWsuUT99fT9TuoLJMbgp1wSu1Z3mn+ftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6IfZABs3ZAQoS9r/qJwvqXW6BQ0EmUxWInnZvobg98=;
 b=iATBBYCubxQ4ukQeIjqRgUzsomguqyoUNTZWHE1Zz4hX5UjUMP3Sz1/TgKhDhL1/C2AOqoYgcsYMGSIac1t+vKZSNZKAq6nLmogi+moFjgDuJGGEZp8u5Pc+uh0ASZ3sbCXLqo5jgd3m6Bt8Qvw/1YN0QKYHl/kygzjDMzXFeq260XYw7IyelrgmHL4rJejlO0s1j1UoDIosmpv9ba89ELcZUedynjqEDWQ96Uw3C0zNB0Z/KcIc3hKz2lIvkNzXBuM3aRbxvDfA3nS+mjcWNokoZhweWulv6a5BpBlBGHXKxBEoCxSiBm/3IML1tFZxdcXtSCrInENneeXffeSlmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB8152.namprd11.prod.outlook.com (2603:10b6:208:446::8)
 by PH8PR11MB6564.namprd11.prod.outlook.com (2603:10b6:510:1c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 14:05:04 +0000
Received: from IA1PR11MB8152.namprd11.prod.outlook.com
 ([fe80::4895:dd55:dbe9:73bf]) by IA1PR11MB8152.namprd11.prod.outlook.com
 ([fe80::4895:dd55:dbe9:73bf%4]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 14:05:04 +0000
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
Thread-Index: AdzX4O5gznii2OlWTEOwzGmIksiJdw==
Date: Wed, 29 Apr 2026 14:05:04 +0000
Message-ID: <IA1PR11MB8152D824BEBEBDD4668F97EC99342@IA1PR11MB8152.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB8152:EE_|PH8PR11MB6564:EE_
x-ms-office365-filtering-correlation-id: be6128c8-7ffc-4d5f-d860-08dea5f84fe9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|8096899003|56012099003|18002099003;
x-microsoft-antispam-message-info: xKmZ9LRjLLolgEW7IjUod00Kj2yn1UoZ9cT2nl9SlShnqBrJbbmJS4N/yhqWcUmTQvl/p1338EAU14Fzc9CtGQNSdnUGvept9GAZ9PMqrU7ymOG9bcBmDdiNOS02hUcV1+wrGf/3CTetDw/YhPKLoVEfx34tG09Wvxj2AFFc5wQQvBuyBI0P5xE6pjnkhp7Mqy/9OtM3RLgpmSVVZKHPEnmR4WRNbkAgeJem6U9FKnsz2tN9cTGeF1rX1e3/wlkIDN0MimT6iZK+PW83tKoRdMwYmqFCL1Ctl6l0e6IDlvFsQJdnQ0lu1BdfdpiIRna+7+XuWLVdJmxpzSq5N+PdTltLbbrQX6G/HqgA4x9Tr6gXXW/CrnawHxPBzkgOtIVsTyp7/H0c7f1K7T0YQMYqBPrkLpPoMq8LwLZqzagRJWlkc2ieBYWAem6nPhy3NTdhv2hNo03z0j3DxSkZ/SZQj+nAaKHncuur7AD9xwmDXs3XIe6z2Jh6U4/l2Gv9oYQLqgJPCkRtb7XF0F7R6czfuOYQ24QrmRh0Oe6TWBWsi64RS4NmRQc/JtjyrK7OZwGLO/FHl3ysPKiag98PsSU36H8MWoUKE/bzdygIr1VL/65RqEF4JJYMtPooOlT/elg61IMiEy7BnM7AJZnkVFx9PawlXYJDqHh8hhSj+8oLkRIEgwER+bH8n9VwWCuzIR+8IFcdni1QJPS/hgY2MuOkLIHnWiaWZnoH2mVKBiU3Nb5RjUjJZPBJEVE7cuIKM1ytPQC3e0wBAISHsNgjsn9OakIezuePKC1QXGL5BmMl/88=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB8152.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(8096899003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hhuSKhYLoJS+3RiIyGWYJrMIiAbWH/ZmIhW+uolfErv3WdKUsz4CMeGQpDKd?=
 =?us-ascii?Q?X/b5hw57GBJabDkzrATCU3jEjVAFFAyYukB2CgnEd1I2zdbyudXTutN4v1G/?=
 =?us-ascii?Q?fuFaO8thBGi+I9MvoJLaN3SeG4BYfSRC55l6BUvp/2QNdRXYAbhLx0EQbFvX?=
 =?us-ascii?Q?SY0f7Z1wMhcN/lTGQub+xnOWH/3B0GytYSBlP2SyfcYVl6qEumu3vAqrZ6qr?=
 =?us-ascii?Q?mc4kt7fAQ1ly3ttPet+H11u9+paFg/NAVS4dLqg5LesYphXYPaWtq9WS5ix1?=
 =?us-ascii?Q?+hw3tOvjUtE/vRTtFlGGI82WZNVktI7JvWwCMIjrpftByV6fzxAZsD5WjMqB?=
 =?us-ascii?Q?3UDtZuFrcTo71QClaUq4zFI8hCCP1T5jNRv1I7D8oYGUTCAGS47odcXICBX6?=
 =?us-ascii?Q?tFbxvesYUTW34yuaIrZRVFKt893yFwjACFDpj5uRxZo3+SUsQqoVq1VDvDqb?=
 =?us-ascii?Q?vfxf0PEfhxYJ5Zey1DrdI56sjRZt/OwLN0Z/JQ2ExCsSTdkpichdQAaLGOb/?=
 =?us-ascii?Q?ARGSFTk+YHNuzAWi+lOHw9OgMfEKAficbN8tT5C0b7EN2UGjvWh/AvPLOAtP?=
 =?us-ascii?Q?kV93SJyxKfos9jdGsOl6IyJgU3Vv015cp1/KXgIp7Hg41Bd1ksQGzibpHtJp?=
 =?us-ascii?Q?YQkKc6fxIUzeumf9C0zfQ0fl3aUWsjL7DyCE6UqwhCN0mzI0CW5LDgLTaEE2?=
 =?us-ascii?Q?sT0YL/E3IdOfvws1NcZUheiZ4opqzFWo+hzRkNJPlxG7+x0kXN20VIpwWT9V?=
 =?us-ascii?Q?7LMKZwbRxiQ/hVKIP7tzX5Bx77J12XdsvLoPKytqnuNCxulkFqOZFv9zjcGv?=
 =?us-ascii?Q?f15uYWPMk6TiKTjpobo8FVTRI5X60rx9kgX3JSqwuwAXFqqRzkNijcNenfN6?=
 =?us-ascii?Q?OYp4NZquEkb8cT4z7g43psjoHG7lvpMhja7jwXPrCyG5k/JfslovZ01XxjCc?=
 =?us-ascii?Q?1r5gV0BLfj1gqL4b0Qf8h5Lspja5FfBUnvF/52Vd2cS3n+HCkvljxs8QiEjR?=
 =?us-ascii?Q?Gak7O9CLazbKgEHz2iSZK2ig/9KIZioqNIFQWwDJFLmjw/zcICY+QnSB4OPk?=
 =?us-ascii?Q?wQuSSFLxnW9mVAu9sUqB80w8RDMUqb58GF4vKmpWeOPF6NYKPWYI527utybp?=
 =?us-ascii?Q?0tSOjFgJR8GJf6/RUb/6HKBxwKNwvNfI2sQZpidGSplu9RFq7vpEUPJfDoUX?=
 =?us-ascii?Q?als8G1WEg1iYLHqqKPC+rAtnJ381ghCOpSUE5LFxMZQ/bCNCHd+PyO/keZMp?=
 =?us-ascii?Q?c2fOj4W1DzL0GWQkVXkpiYn/X8PTznp7R7yOzRQTIfOp21SLVnlCQkX9vZJH?=
 =?us-ascii?Q?nijXQkvlv09hT7oR/8h3Hzusyk6PidWLp6Mp1vIHpjbAbDDIuBGiqoCRhZBa?=
 =?us-ascii?Q?7s3cb69WE9tI9CVyoYym1KPpp1ZoCp4KR9XTOAI2r9tFbGabn1Hon+sn/JdM?=
 =?us-ascii?Q?ok+SQx9VsZ5MeLlUfyuxPVjs+7L5QdlId442Egernu5NiOmre/L2ztsdce1r?=
 =?us-ascii?Q?V/2ddLZEP5+xLV5UKvqukqRlNkNtSrrET7bOYS41FRoX3nVlCsro0otkE7oo?=
 =?us-ascii?Q?hGWh5lsjZozbk3KqeCaqwfy7Iz3R+2ojVaLWNZNmZYRPxAnZtEjd+EDt2LPz?=
 =?us-ascii?Q?r/ZW5vbpBscGAOIiPEpWfS0yLKUnWZqAd9ioFTZeklvLmHhpv7Plgb6un9KF?=
 =?us-ascii?Q?zaYXCuspdkqJXfG6NI/cLhowc60IlTGQzwu6Z2Wf07JdThY2OCGeoKl/C/+A?=
 =?us-ascii?Q?RCaFV7WYsLBu2pRiRWNMunNngBU5W+Q=3D?=
Content-Type: multipart/alternative;
	boundary="_000_IA1PR11MB8152D824BEBEBDD4668F97EC99342IA1PR11MB8152namp_"
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
X-Exchange-RoutingPolicyChecked: iBbdoo6rYD7meZzfJhIyFlDRgTa+cSHbu4BKAFgcNPZMBjpuSVED5hkxL/LXJXnsoG29zSU6vxoH6NbND7pOxN+zDCHMSG8BXjo+XU3GbzpdmjO/+yAblxnvPCAeZxVLoF+6PZFboOEsptIGlNpBMjOagylhoh6XIzGnDIYjMin5dskeQa7dFa66Zc1yIcGlssKWkav1DVTPg0/R0ExXu2oL6IXbW7yuZj5GBp4z2qr/sHe/jQAgH0AEfzCMpi885+Eg0ggkatMrzumyhFz+8QKacKqmzvakSw3ucskAdndEHSGe0DbFVb/91FKcfA975juhcRGK5vc1rQGkrvAKeA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB8152.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6128c8-7ffc-4d5f-d860-08dea5f84fe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2026 14:05:04.3535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wNvLW19uSRT0z0HrHiSpSt2cUi6bbMlCsTD//08bhmd3xJ9VQMdrhpWW/1jkhuyWPXCVzX/A6aWiAMDiA0y3Ru6whawLE9wq0oy9hpmAZFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6564
X-OriginatorOrg: intel.com

--_000_IA1PR11MB8152D824BEBEBDD4668F97EC99342IA1PR11MB8152namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Subject: Re: [PATCH 2/7] soc: aspeed: Introduce core eSPI controller support

Add core eSPI controller support and common code for ASPEED SoCs. The
eSPI engine is a slave device in BMC to communicate with the Host over
the eSPI interface.

The initial support includes basic eSPI driver probe/remove operations,
and provides operators for ASPEED SoCs to implement their own eSPI slave
device drivers that are different among SoC models.

Signed-off-by: aspeedyh yh_chung@aspeedtech.com<mailto:yh_chung@aspeedtech.=
com>
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

--_000_IA1PR11MB8152D824BEBEBDD4668F97EC99342IA1PR11MB8152namp_
Content-Type: text/html; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Subject: Re: [PATCH 2/7] soc: aspeed: Introduce core=
 eSPI controller support<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Add core eSPI controller support and common code for=
 ASPEED SoCs. The<o:p></o:p></p>
<p class=3D"MsoNormal">eSPI engine is a slave device in BMC to communicate =
with the Host over<o:p></o:p></p>
<p class=3D"MsoNormal">the eSPI interface.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The initial support includes basic eSPI driver probe=
/remove operations,<o:p></o:p></p>
<p class=3D"MsoNormal">and provides operators for ASPEED SoCs to implement =
their own eSPI slave<o:p></o:p></p>
<p class=3D"MsoNormal">device drivers that are different among SoC models.<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: aspeedyh <a href=3D"mailto:yh_chung@a=
speedtech.com">
yh_chung@aspeedtech.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">[...]<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/soc/aspeed/espi/aspeed-espi.c b=
/drivers/soc/aspeed/espi/aspeed-espi.c<o:p></o:p></p>
<p class=3D"MsoNormal">new file mode 100644<o:p></o:p></p>
<p class=3D"MsoNormal">index 000000000000..15d58b38bbe4<o:p></o:p></p>
<p class=3D"MsoNormal">--- /dev/null<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/soc/aspeed/espi/aspeed-espi.c<o:p></o:=
p></p>
<p class=3D"MsoNormal">@@ -0,0 +1,143 @@<o:p></o:p></p>
<p class=3D"MsoNormal">+// SPDX-License-Identifier: GPL-2.0+<o:p></o:p></p>
<p class=3D"MsoNormal">+/*<o:p></o:p></p>
<p class=3D"MsoNormal">+ * Unified Aspeed eSPI driver framework for differe=
nt generation SoCs<o:p></o:p></p>
<p class=3D"MsoNormal">+ */<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+#include &lt;linux/clk.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">+#include &lt;linux/dma-mapping.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">+#include &lt;linux/interrupt.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">+#include &lt;linux/module.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">+#include &lt;linux/of_device.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">+#include &lt;linux/of.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">+#include &lt;linux/platform_device.h&gt;<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+#include &lt;linux/reset.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+#include &quot;aspeed-espi.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+struct aspeed_espi_ops {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*espi_pr=
e_init)(struct aspeed_espi *espi);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*espi_po=
st_init)(struct aspeed_espi *espi);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*espi_de=
init)(struct aspeed_espi *espi);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; irqreturn_t (*=
espi_isr)(int irq, void *espi);<o:p></o:p></p>
<p class=3D"MsoNormal">+};<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static const struct of_device_id aspeed_espi_of_mat=
ches[] =3D {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { }<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+};<o:p></o:p></p>
<p class=3D"MsoNormal">+MODULE_DEVICE_TABLE(of, aspeed_espi_of_matches);<o:=
p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static int aspeed_espi_probe(struct platform_device=
 *pdev)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct o=
f_device_id *match;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aspeed_=
espi *espi;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct resourc=
e *res;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device =
*dev;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int rc;<o:p></=
o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev =3D &amp;p=
dev-&gt;dev;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; espi =3D devm_=
kzalloc(dev, sizeof(*espi), GFP_KERNEL);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!espi)<o:p=
></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; espi-&gt;dev =
=3D dev;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; match =3D of_m=
atch_device(aspeed_espi_of_matches, dev);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!match)<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; espi-&gt;pdev =
=3D pdev;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; espi-&gt;ops =
=3D match-&gt;data;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!espi-&gt;=
ops || !espi-&gt;ops-&gt;espi_isr)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res =3D platfo=
rm_get_resource(pdev, IORESOURCE_MEM, 0);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!res) {<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;cannot get resource\n&=
quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></=
p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; espi-&gt;regs =
=3D devm_ioremap_resource(dev, res);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(esp=
i-&gt;regs)) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;cannot map registers\n=
&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return PTR_ERR(espi-&gt;regs);<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></=
p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; espi-&gt;irq =
=3D platform_get_irq(pdev, 0);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (espi-&gt;i=
rq &lt; 0) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;cannot get IRQ number\=
n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return espi-&gt;irq;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></=
p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; espi-&gt;rst =
=3D devm_reset_control_get_optional(dev, NULL);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(esp=
i-&gt;rst)) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;cannot get reset contr=
ol\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return PTR_ERR(espi-&gt;rst);<o:p></o:p><=
/p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></=
p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; espi-&gt;clk =
=3D devm_clk_get(dev, NULL);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(esp=
i-&gt;clk)) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;cannot get clock contr=
ol\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return PTR_ERR(espi-&gt;clk);<o:p></o:p><=
/p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></=
p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc =3D clk_pre=
pare_enable(espi-&gt;clk);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rc) {<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;cannot enable clocks\n=
&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return rc;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></=
p>
<p class=3D"MsoNormal">&gt; +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (espi-&gt;ops-&gt;=
espi_pre_init)<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; espi-&gt;ops-&gt;espi_pre_init(espi);<o:p></o:p>=
</p>
<p class=3D"MsoNormal">is there a chance ops are unitialized? In any place =
you do this check<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc =3D devm_re=
quest_irq(dev, espi-&gt;irq, espi-&gt;ops-&gt;espi_isr, 0,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_name(dev), espi);<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rc) {<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;cannot request IRQ\n&q=
uot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_deinit;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></=
p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (espi-&gt;o=
ps-&gt;espi_post_init)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; espi-&gt;ops-&gt;espi_post_init(espi);<o:=
p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; platform_set_d=
rvdata(pdev, espi);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(dev, =
&quot;module loaded\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+err_deinit:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (espi-&gt;o=
ps-&gt;espi_deinit)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; espi-&gt;ops-&gt;espi_deinit(espi);<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_disable_un=
prepare(espi-&gt;clk);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return rc;<o:p=
></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; +static void aspeed_espi_remove(struct platform=
_device *pdev)<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; +{<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct aspeed_espi *e=
spi;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; +&nbsp;&nbsp;&nbsp;&nbsp; espi =3D platform_get=
_drvdata(pdev);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!espi)<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></p>
<p class=3D"MsoNormal">espi pointer is unlikely to be null here, I suggest =
removing the NULL check<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (espi-&gt;o=
ps-&gt;espi_deinit)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; espi-&gt;ops-&gt;espi_deinit(espi);<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_disable_un=
prepare(espi-&gt;clk);<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static struct platform_driver aspeed_espi_driver =
=3D {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .driver =3D {<=
o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;aspeed-espi&quot;,<o:p></=
o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .of_match_table =3D aspeed_espi_of_matche=
s,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<o:p></o:p><=
/p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .probe =3D asp=
eed_espi_probe,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .remove =3D as=
peed_espi_remove,<o:p></o:p></p>
<p class=3D"MsoNormal">+};<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+module_platform_driver(aspeed_espi_driver);<o:p></o=
:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+MODULE_AUTHOR(&quot;Aspeed Technology Inc.&quot;);<=
o:p></o:p></p>
<p class=3D"MsoNormal">+MODULE_DESCRIPTION(&quot;Aspeed eSPI controller&quo=
t;);<o:p></o:p></p>
<p class=3D"MsoNormal">+MODULE_LICENSE(&quot;GPL&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">[...]<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<p>
    <hr/>
    <strong style=3D"line-height: 11.25pt;">
        <span style=3D"font-size: 9pt; color: #595959;">
            <span style=3D"font-family: 'Arial Narrow', sans-serif;">Intel =
Technology Poland sp. z o.o.<br>
            </span>
        </span>
    </strong>
    <span style=3D"color:#595959; font-family: 'Arial Narrow', sans-serif; =
font-size: 9pt; line-height: 11.25pt;">
        ul. S&#322;owackiego 173 | 80-298 Gda&#324;sk | S&#261;d Rejonowy G=
da&#324;sk P&#243;&#322;noc | VII Wydzia&#322; Gospodarczy Krajowego Rejest=
ru S&#261;dowego - KRS 101882 | NIP 957-07-52-316 | Kapita&#322; zak&#322;a=
dowy 200.000 PLN.<br/>
              Sp&#243;&#322;ka o&#347;wiadcza, &#380;e posiada status du&#3=
80;ego przedsi&#281;biorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o prz=
eciwdzia&#322;aniu nadmiernym op&#243;&#378;nieniom w transakcjach handlowy=
ch.
    </span>
</p>
<p>
    <span style=3D"font-size:8.0pt;  font-family:'Arial Narrow',sans-serif;=
 mso-fareast-font-family: 'Times New Roman';mso-bidi-font-family:Arial; col=
or:#595959; mso-ansi-language:EN-US; mso-fareast-language:EN-US; mso-bidi-l=
anguage: PL-PL">
        Ta wiadomo&#347;&#263; wraz z za&#322;&#261;cznikami jest przeznacz=
ona dla okre&#347;lonego adresata i mo&#380;e zawiera&#263; informacje pouf=
ne. W razie przypadkowego otrzymania tej wiadomo&#347;ci, prosimy o powiado=
mienie nadawcy oraz trwa&#322;e jej usuni&#281;cie; jakiekolwiek przegl&#26=
1;danie lub rozpowszechnianie jest zabronione.<br>
        This e-mail and any attachments may contain confidential material f=
or the sole use of the intended recipient(s). If you are not the intended r=
ecipient, please contact the sender and delete all copies; any review or di=
stribution by others is strictly prohibited.
    </span>
</p>
<p class=3D"MsoNormal"><o:p></o:p></p>
</body>
</html>

--_000_IA1PR11MB8152D824BEBEBDD4668F97EC99342IA1PR11MB8152namp_--


