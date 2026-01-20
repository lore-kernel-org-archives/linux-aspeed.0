Return-Path: <linux-aspeed+bounces-3416-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91A4D2629E
	for <linux-aspeed@archiver.kernel.org>; Tue, 20 Jan 2026 20:30:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwf8v6Rbhz2xQB;
	Wed, 21 Jan 2026 07:30:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c105::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768941039;
	cv=pass; b=jmzQ1+9WuN7rhkRFMGXkTYGqk+HArFEnaU01HkleNp9ouktFIt2A3Mr9Gqeh98qRqd/sZy5goZJFcF2aV96j6ieVXsxI7IdC8ZjJ2v8t1F0sZlVmnY9Y8zaRfLuTi1ls0/bdBrcNrdK4zXRqF1I1KaPpX2K6SxN7OkWpS2usWafLu8YCJCvhO3TFcS6ugrcn3mETR3fo7f6mN+jIyOCIDjMhQk3TJOY0VsUTwKjP1nAv06cgRrEJi9yk1YepQ48rCSq1Z+lf6UpT8SomXx4jyH9v4IAkgN77970USvvV+6JEVh9yOXd2MTG5amfguzeBK5R/kbdaG4j940WRhrsYFQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768941039; c=relaxed/relaxed;
	bh=MoWpla9QNcdL14prCL8ahQ130tQk/5DVfNG22+kP6Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lh/SNquwBTugdpKtpW3Vj4US+r6bIlDcQSdLPZVDNGqYd9B/a33Bk8NKvgPCMFcxkDocHKG1l6opT9v4dI1OdQ6HlSIpUJ8RBvjFAoZlzn0IWy/IFQ+ynIEaRutRZrrjvub0wbzA1c8/kgxxVr42u09uYM3BlREg7ljjmop6+fEWy1loO++3UVU4HA2E1hCPV/q4hPQ7xrJ92Kll1XdlWOkHUb69qheFsE3HDk9n6AacSKVLsVprM+OEI+SUT4MFGuD/WWuU4H++Nzh+oW5GlHHzwLBmZ3Jd0NzwvdB8rPFLw7eqDuSR34rxQ5Um2IDIfs9ZV/CLEhYgwd/VLSYLnA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZTLwi0ZQ; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c105::1; helo=ch1pr05cu001.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZTLwi0ZQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c105::1; helo=ch1pr05cu001.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org)
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c105::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwf8t37t8z2x9M
	for <linux-aspeed@lists.ozlabs.org>; Wed, 21 Jan 2026 07:30:37 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTUc5dtxdyiyXtdw5jjc9W0vo2y7K5Foo+iCjealSMpmCVtpV4r7fLwRhGbeKQU+2EeWF9VGIonZrs7q6G/rpBnG7wrwpEhfkoU1fXaYRI08Bis4sr2kzVGRx70hKy0N32Wp2x5TTHP9IbP1tI1KjGCDd5GhnVDf1/mF+eQV/XOp6GjIlwn89B37iTXGKgazszXU0bZ6EmDgV9GxbJvgsPw6mrgR1OcHdV+xfVBDWgEyhY/4+YNzaLDIQVl3T2DNL7nOUvvOR4po7pFyeCxWZ3jvfz81+VMV2qDDuzh7ITAaei3Zf+3F5hX4rKdx/dnbga5FIhtIQCzSl87AATyJMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoWpla9QNcdL14prCL8ahQ130tQk/5DVfNG22+kP6Xs=;
 b=SDvEkTTwDcoY4ZQ3sY7Oxk+CHA1BXnbWGCeu+kM7KgFEPCrigyeJsKfOrj2QEPRzn8qPpUL+ODY3usGC6UwWaybVcTzQoiaH3mxD2hqF+QInEbt9LjYYOPpGLbzPpBiC6H4Wln5tS0bPVdFSbMTrODZKE07yq/bAIHc8k7XCsblAu8sg5eI4KsChtNXp2dwqiTMfPg90GyQMBaM+3Evkbb8tfaa5BvFbX5tZdIPGAC7nb7LDgubIBICttIEgm+4bf5JpY6wADa3QCPMH7bJrnnggwZA3szy3XTENBLE7VWvJS7NqFQvi+f8PuHGj1iI3gFFxGEDxkqlJSLlF8bGx2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoWpla9QNcdL14prCL8ahQ130tQk/5DVfNG22+kP6Xs=;
 b=ZTLwi0ZQVkAR5E5881xSwEspMKAw5T0Ji8ZV58u7vljm43aSkvGWX+9kvAO7sM5TcmjViMyCKCyVNXMj7q9KFDOVcSSermzua8LZfNm4bIiIlMT5GX5DnIdTwCKhBdiYIPPlZZKxCuubwn3C4nripXNY/tMHbhiweSDtH4DoweAyQH6Wg47ADN/102EXOU0TkQExB4kD5CQFzgvGjjE/DO/P5H/fTXCfZuSEhs2MKY7DdZcvou6bxs8CgrsWHvPkFTxZ5NMCUxMERJ+0Aw/fnP51rk3s7Q0n01na+MJo++ykzZznDSVkKh0nwDpWJ3I5TV1d4tnoSQ4zkN6j/EAxEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) by SN7PR12MB6689.namprd12.prod.outlook.com
 (2603:10b6:806:273::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Tue, 20 Jan
 2026 20:30:12 +0000
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9]) by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 20:30:12 +0000
Date: Tue, 20 Jan 2026 12:30:08 -0800
From: Marc Olberding <molberding@nvidia.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ARM: dts: aspeed: add an alt 128M flash layout
Message-ID: <aW/l0LbCbfxvwXZz@molberding.nvidia.com>
References: <20260120-alt-128-v3-0-a81bdafc00a7@nvidia.com>
 <20260120-alt-128-v3-1-a81bdafc00a7@nvidia.com>
 <b7d27dc1-05c7-4525-b483-1712e9d497ee@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7d27dc1-05c7-4525-b483-1712e9d497ee@kernel.org>
X-ClientProxiedBy: MW4PR03CA0289.namprd03.prod.outlook.com
 (2603:10b6:303:b5::24) To CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627)
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
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PPFDAD84AB72:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf4d14c-00b2-4fd0-32e9-08de5862b54b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zcQp94BMmvsfeiHcqFu6GZnLku9c/zd+i2Pwn9VaZkFD1WjSHA8zQhG7uM/o?=
 =?us-ascii?Q?Bx8h9qxGBYtIp0/tCUz/MQBcT6+Gd40iNkumbCPh5nNeIG6ExrTwU0b9K51x?=
 =?us-ascii?Q?5DXL7z3o+sUuEFXUNaoq0Zi9yL10izi8jU504rIfUnK5T8zot7w/MOn3jcBl?=
 =?us-ascii?Q?g7dfluLSF8Kl7LzwtIVOSIt1u7CMxgUnMtdoPiPx72iUA4SXHug1QwDyWle+?=
 =?us-ascii?Q?DiM//geAnKzl+AZPwN7d6EK/0aXQaSfLEIcsuepwAexu6eFhIopJU/TkunXu?=
 =?us-ascii?Q?6LHfKyVDhI2UZZX3A469FToJOu1K5NaGV2nr98vmiPT1sHIOSFz1zaO1/FIb?=
 =?us-ascii?Q?n1jlMCzHLY9kUjNIlE+q8XvYv458b3m3Lu7kvmUgGH30vC4gk4LuxPnpJlpw?=
 =?us-ascii?Q?ZfbfioJV9gXJ9Nnhe2MYbqf12zdF2blNa3yxo4oe3UrOq2ijaJ9Cq65r/QrN?=
 =?us-ascii?Q?uTNs6AeowxujJw39doE6TiWM459EB9qaOljWos6oShyM/sv+TOqxC2kJ1JpU?=
 =?us-ascii?Q?fdi+ZlxUU2e/OmY1+q9iCVSxXfixRaW/URIvHBB1ZqDJhaN+PblowEObRgH1?=
 =?us-ascii?Q?EBOevbIF7F3lJhQV0P8sJFNu4/OGe9GUHKthfFBUqaV6iDxUNsM2Evr7i5WF?=
 =?us-ascii?Q?ypVRPIY9MP3DpdNCA7dsijG82bws0f6v9SfiqpNOQeuVo6O2BecaHPac+9HX?=
 =?us-ascii?Q?rRibUpkEQb4Jjp4OQFq/YGOzxfAlVIGl04LzE8YNiKJIf648FlFPHQcGHsVO?=
 =?us-ascii?Q?x96pp+PFCHK6Pq3WR71ncuurVp6pdMVuxdbmYrF1fvJ/GhJWVlqAg6UJnYCZ?=
 =?us-ascii?Q?QjM3retud5OLlhaAFLjBVMKauwbX5Cu8SD4YOYJT23ojzy1YiRXU8xSWeXIa?=
 =?us-ascii?Q?MTlD/AFyuAXE5gbxkES4sUAgMTMkeoKI2VhSAL9V4wU7w50SZFcC80CkXKdf?=
 =?us-ascii?Q?IcPy2XPcf09gdOsHuterbcCkcugcNWD6pz+jSzAXbqL+k0rS9Yhw1LFz8zJT?=
 =?us-ascii?Q?LXOGIWRdvIwIsP4l5kvfRtpE82+ankzl2uL37UujpjsyONF8pbL40qIVjDnt?=
 =?us-ascii?Q?N1wb1FWFkZHJhPHeX8rZKiTWQQOcO4wwxjX50lW4hTldhggUaB4eCL5Iy5lQ?=
 =?us-ascii?Q?nNRJ7ti85ZPXP+Jm9PI6bK/9kEuFq4u3JyVNRHE2lbVYJYhiih0vhQ3wxaud?=
 =?us-ascii?Q?2fA7QnOWegoZCXCGUXuUCnHJKzwNDfZnAWtiWUHE1R5dIPT4t0Leu6ovBFKn?=
 =?us-ascii?Q?KwPF8qTWQjqabBMkeegNLzhwohk479KptNJ2wH6aLeUHMkJ9Ip90neJrtdup?=
 =?us-ascii?Q?Xy3xAp/laFvG/e3NcraNdzQb5ncVs8guhtxzshZFnyl6QcqK/7DEQDPvZrQY?=
 =?us-ascii?Q?LZ+4sJ0GVcawgZcI/Clq4RUG/R6TnJc+VOdz+fC8jHlTRoMa47K3KDo8nLaY?=
 =?us-ascii?Q?YzimU9bJVD7veybcMByINIkzUypHyTULtFnCYCfENkKHl99hgbRGZGUdpXD+?=
 =?us-ascii?Q?F/oEKvf30K8RRLNLGo90HUtaIOaC4XyNfM9fKDcf9PzHiXTYiQUeX1Ky4jZj?=
 =?us-ascii?Q?g27Dtcrp4cANFwSyREA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPFDAD84AB72.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0/5qsEEobCSYxg9+PL+Ey7/rzyeiM9ScptjIEoTfmS5XpUxdccqgFdLi60OO?=
 =?us-ascii?Q?yTsLUl66xKR3rLwAUCjLFK0pu623Ae7uH1+ricCmjiXKW4u3K9DHChaZk7YF?=
 =?us-ascii?Q?Aiq/qNprxlLbqDQgoo19hD7AoSqnMuRc6BrcQTsMXZlS2n8OC58M6b0i+NLF?=
 =?us-ascii?Q?2Qw0WMi8FUFjX5Dll/0An+lLdQSvYBfFRtjOVASN+AILcy7zHL/rtDSDx5pr?=
 =?us-ascii?Q?f3UwDShc0TNVZVYr37wUNFApDIDV7OV7RJQTN9tjpqHEB36WHlN6uKnvDseH?=
 =?us-ascii?Q?ZoP+4D4Kz4g24YvB8tV9uAdZNzTl7pRb/04ax89GXL+Pmdx7SozeqKHpgxTP?=
 =?us-ascii?Q?slbIPviHlesa+TLEKN9KtSFUOT5bUVSMyYMLmfzFCWQVUaE7ocR7/c0Eulux?=
 =?us-ascii?Q?oSL6garnAOB+XQtj1HH8I2wQeRtQTjVQST90zopGKk3D2W8030k+bvUKz4Wa?=
 =?us-ascii?Q?JjieFdP3nFDujHvS+oQffHat+doVs1tFCrGaal0u/GO6jAkDluH+/hFEulId?=
 =?us-ascii?Q?MPchVnqirmIV1oRYdtKWhZc157+XO5vCBt5py6RuqPt+B519hmu9ltmjs0Ll?=
 =?us-ascii?Q?6I7sWXRkkfeNcSJTn8hbpePU1E7IS8D6xoYswwbyssH5n40TZFtpSJq5mBVz?=
 =?us-ascii?Q?/5kqOBQvR0/S7icVUR1uQboblbd2oaXg5ovBdiDrCWzy+n8YBZrPUGlx+b7Z?=
 =?us-ascii?Q?Luz3H8cBfTg8cI4RFLB4sqF4Jxa1brdhmjwOJObPrhRfF7FMqMrgLBVc1XPL?=
 =?us-ascii?Q?B0dl+tlFokhbKFobmiuZVaLfljCYEgTvBG5RRQS0B0tQ/epTN2h8F3A0y/14?=
 =?us-ascii?Q?XmpBGDd7YZ+88Ynema5+2Pw3mltGOTTZZfvGE9IkdqI/wY+bux6xCH2/Bpp6?=
 =?us-ascii?Q?MhGLcLmaBCfZc6fu2icYTfHpr90XB8I60QOinC73NmNPDCYfZI3F4JXJmyxb?=
 =?us-ascii?Q?Kvt50kKGjmk/3FLUyguQBKFEnhWsieHN/E6XB8iVTFWpMvByRXQDhBz+hOeb?=
 =?us-ascii?Q?gRCo7vl6xeoXlshrQn6uBXmc157+gl87BHoYEMEBAcs3W8Tv8bUQH01QCDDd?=
 =?us-ascii?Q?I6y3nK1UHQIrZG7+jhVCTRShxJDj4TZFEjufc1YNqbqx5+VXXtN0+jnz3Xkb?=
 =?us-ascii?Q?07cvX3OgeNTXpHW5FjSaP5X4u0+WHhcNRUc7PusZRPP3SQt/3rNuOhKixsHQ?=
 =?us-ascii?Q?FtkSkzKXnjHSUgJknz8oF5zvgdJyaByF8uw/KWG/mxhdkV/w1Dgc3HBfXHDv?=
 =?us-ascii?Q?YVJkFkafFianlKU5D01orKa7oH39r4kp5//ALAc+aqKHQ4GQHX/9FgSiILZf?=
 =?us-ascii?Q?av31wyNHPfPMeWLqUSUh3O321j/b8mGeYPU5d3bOBQKRipi3sD/mK4Fppnln?=
 =?us-ascii?Q?gPsqDA3grx0ZDilrJy5brmDZadgtGDt6MNrsyBeaRke3zwdyHfAwEIw1Kiq9?=
 =?us-ascii?Q?Z5J3yDR/uWRAfWIm8ue3Y7tzDNJ0nIa9YIo5c/yPmpiitLSN9vGV0PhiyFY5?=
 =?us-ascii?Q?GBju2vkXn3f6O/BhtrdhDclrW4tE8/zLOMubhHg2Nz46otot92GRO00q1XpX?=
 =?us-ascii?Q?7Wp3Zs5O0Lp8e8enxn9vij2XwDbKQz1vXT7h/Q5NX+q3uebLk7WKHaaW6q9E?=
 =?us-ascii?Q?eklwzIkTS5aWO+qHITRJM4JBUcX4GT8R5YaOVtVK3sFg2pK8Sv/TPY6LgERm?=
 =?us-ascii?Q?p1T7cWcEmjMEKnymepbPdA8C1maIBJrXrNU/lHvv81kfFWNrAYgN4DnqJ8Mn?=
 =?us-ascii?Q?o5bndvvq3A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf4d14c-00b2-4fd0-32e9-08de5862b54b
X-MS-Exchange-CrossTenant-AuthSource: CH1PPFDAD84AB72.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 20:30:12.4566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5VwkFNo6qliVtxoMnaQXMPbt2Yk5215voDBshJTR5XOAynOd23HrTQPXm40F41hsLql9UWAvx19cE6q0HgciZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689

On Tue, Jan 20, 2026 at 08:40:29PM +0100, Krzysztof Kozlowski wrote:
> On 20/01/2026 20:26, Marc Olberding wrote:
> You cannot test this patch that way - DTSI is not included by anything.
> This probably should be squashed with next one because makes little
> benefit on its own,
Ack, will do in the next patch series.

> > 
> > Ran dtbs check, no errors from the msx4 dts
> 
> Drop this sentence, it's implied. There is no point to state obvious,
> e.g. that you build source code, in the commit msg. It serves no purpose
> in the git history. You also have changelog for such things, if you want
> to emphasize.
ack, will drop.
> > 
> > running diff between the main and alt flash layouts shows that the only
> > diff is alt prepended to the partition labels, as expected.
> 
> ? Not sure what you want to say, but please do not explain us how DTS
> works (in case this was about DTS).

I'll drop this piece. This was a recommended piece of testing by Andrew,
the maintainer, just to show that the alt partition and main partition files
are only different by the label names. That said, its redundant with the testing
on target shown above.

Thanks for your feedback
Marc

