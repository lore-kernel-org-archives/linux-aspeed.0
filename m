Return-Path: <linux-aspeed+bounces-1221-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F0BC3ABC9
	for <linux-aspeed@archiver.kernel.org>; Mon, 19 May 2025 03:12:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b12mc1xGCz2ygm;
	Mon, 19 May 2025 13:12:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=148.163.141.152 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747624352;
	cv=pass; b=ZhF5STxg8+WIKwb6Uc32OLj+YiiO0Ha1SW6uidzsbClOApVIup1d1TuuaFv0CLwtC6q7Bd91aMnR1qMZPdzupNVjgQoRGC3OFRd7zLbo/gRHQgZiwZaobRFYfK8r+/apoPK4GMSuKEr8Lo2BaOWFmjh/IwmJ4ZK+Z6eC2/r0da/boNJRjXMxxucBumPxYwqUNiDr6G8RffB0kO69Azn3VCcj3m66rMHpsrD88lRfWkn6KDVeiZBI3miEPq3MMdnXqiZ9b7D0XpaO8lonvWGpQJRLRGEgzFVmlUoZE/mgQuaXpSEHTI7mqr4zFdR6UEzzWB8yh+8GQEHltIV+7nXlLw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747624352; c=relaxed/relaxed;
	bh=bCLEV7KkM6Wk27Z6GRbaq0koBeER3YTsfyOFro69GGU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SOJ3uLgddDpxcuGa625d9j9runaeVuLeyQYUbKYyBN6oSUJthklii2mN/GIlUwYOKgpSEqRsPh9Y0iF5bDvzGe+oHlyBVuCjzabRXea0aNUlm1zWD9Ii6f9WRP63FbOEa274weZloIlaccp5Xnvjv6fJo/uJgOhRFvD6YXe+u/rSue76eMkilGxhWgP4Cr+r4of1AVFWBNKbTZATYQ6IXnhDGh5f+CxFcF2AjmKUvMvC5DyM6zz+XX4rpeNiUaZ65yqYM3VbuEvzZUt5noUxTsANhXiZXKVuc7ytOGWTp/0qfWoh/UwBpO2K+AAaneVujUk4DxaQVxU8W372ZQSTIA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; dkim=pass (2048-bit key; secure) header.d=wiwynn.com header.i=@wiwynn.com header.a=rsa-sha256 header.s=20250420 header.b=gIBwyCKh; dkim=pass (2048-bit key; unprotected) header.d=wiwynn.com header.i=@wiwynn.com header.a=rsa-sha256 header.s=selector2 header.b=zjEK+qXG; dkim-atps=neutral; spf=pass (client-ip=148.163.141.152; helo=mx0b-009a6c02.pphosted.com; envelope-from=delphine_cc_chiu@wiwynn.com; receiver=lists.ozlabs.org) smtp.mailfrom=wiwynn.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=wiwynn.com header.i=@wiwynn.com header.a=rsa-sha256 header.s=20250420 header.b=gIBwyCKh;
	dkim=pass (2048-bit key; unprotected) header.d=wiwynn.com header.i=@wiwynn.com header.a=rsa-sha256 header.s=selector2 header.b=zjEK+qXG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wiwynn.com (client-ip=148.163.141.152; helo=mx0b-009a6c02.pphosted.com; envelope-from=delphine_cc_chiu@wiwynn.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1378 seconds by postgrey-1.37 at boromir; Mon, 19 May 2025 13:12:30 AEST
Received: from mx0b-009a6c02.pphosted.com (mx0b-009a6c02.pphosted.com [148.163.141.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b12mZ4wnHz2yFQ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 19 May 2025 13:12:29 +1000 (AEST)
Received: from pps.filterd (m0462407.ppops.net [127.0.0.1])
	by mx0b-009a6c02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54IMnjBu000509;
	Mon, 19 May 2025 10:49:04 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=20250420; bh=bCLEV7KkM6Wk27Z6GRbaq0k
	oBeER3YTsfyOFro69GGU=; b=gIBwyCKhokxTGdvSHGugzId4OhrJmIWUgFaIW7W
	Aq/72pWENMjM7vBwY9s84+7D/XxROck13dNOvWy8eIUas3q9ceO/ubuc4l5LDUmY
	JOZ9ekelBLP5B5C33IOoM8JCGISp0j0K/OrQF6k+BAUoVz52ZG7qeM5E2YD5/rdr
	D6E6yqnEZMXqZbbNwYzZAglAgkWe7O3G9YJ1DBV8NswtNYArVkUgPapboUEfNpji
	PDMwn+RDpL+T1r2xOULjLPuVb7FGxi7adwa6Tgdab5aFUYSZ3KEeLpSrBkiiR0so
	/FQ810c4gNXmzRQ0COtrDK22OHp5QW8x+7thpOq7xSS1O+A==
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazlp17012052.outbound.protection.outlook.com [40.93.130.52])
	by mx0b-009a6c02.pphosted.com (PPS) with ESMTPS id 46pxra8y84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 10:49:03 +0800 (WST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qHTocmvZzjyEL3rv/O2C/Av1P1mkO6pZcTFP62AKFcy2zi+7Bn46xgpBGgnp4M8+nIKIx1akZYEL0dMZo5ir0al/SajN2VLIcW2NMq+sJfsvx8ddV/54GdnbYQgtRLNqv8Ze7GrZHZ2Mvgi/BZ9Ikmx4OXSc23aasW8Pkul9ttG2TnyDrCEu7kiOZe1hkPNBgslLwzOt4asxmLlPRNUlXNqwRzNhTfOb+7SI0ZQZCJDhP5b4E8g2mSs2RTI18tpXLN+xJyU4hwlObf6QMqpfH+16qKngiyX8JH+qPZ9eUQia2h7HOLbCv0rsZ6b2cbMA5K0mWqQFexkljV/RIZO2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCLEV7KkM6Wk27Z6GRbaq0koBeER3YTsfyOFro69GGU=;
 b=pGalSDzCXGOmdXl8KHoBSyjHDWAYbjTTeS7KKegLHp1wCgVFVlD1JDO9KaXczuXCDFa+WTcp7vbFofjmyAuU+VeRCM28OJbiw0s89nU3SMwKN1mlW6jF58h5ct2Bhi9/AdAV9EG5CMeJu9OPii2/iASPZ30au4lYnVAhp5hCyou+7rINPMcRPR0l4F3/3NRmU5NVSRbmrBHg+W8K6TvZHbvg7tAJ8UG47/peVHBAMLD1UwOi9rMlZeSeU49ivd+nx0obKqdsu6H5Mb/TeSC5/olUC2IOhFY9+teSgqumJZjK0zAgXa18aeFyEpnPGqo987d6spYhfzwYhZCvPGmhgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCLEV7KkM6Wk27Z6GRbaq0koBeER3YTsfyOFro69GGU=;
 b=zjEK+qXG9e2FnqGDJaoZOmA0VA4VT2tfjxih88HifHmZ8hTIUV5/eihyXfy55A4RONnl7OpYvkCuxxYHIqHy0AoQ4jeuCY91V1zYm/ZYJ6Z1Sr1pvkV9ONfWIN6H3qfkns8ZKDceo+S28H6qNBHGR5W2NPF6xc8o4jWhxeMsW7QsS+lqlVbHdOP1PXpTrPrP/E8iWdVaxMo9gQsY+Zxaja9DUyr0iDT48gI+XFQXj4d6ya6cvxJozxN/0OrCuAyG8DIcYaoTiE1Hz1oErmjV9S8n33xB7eDGT/fCIWoDK0AI5GGZ3yM6GQ5yTvEIpxYBWvInPM43izuDxaaKhB+EZg==
Received: from TYCP286CA0232.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c7::18)
 by OSQPR04MB7910.apcprd04.prod.outlook.com (2603:1096:604:290::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 02:48:54 +0000
Received: from TY2PEPF0000AB87.apcprd03.prod.outlook.com
 (2603:1096:400:3c7:cafe::5) by TYCP286CA0232.outlook.office365.com
 (2603:1096:400:3c7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Mon,
 19 May 2025 02:48:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 TY2PEPF0000AB87.mail.protection.outlook.com (10.167.253.6) with Microsoft
 SMTP Server id 15.20.8769.18 via Frontend Transport; Mon, 19 May 2025
 02:48:53 +0000
From: Delphine CC Chiu <delphine_cc_chiu@wiwynn.com>
To: patrick@stwcx.xyz, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Marshall Zhan <marshall.zhan.wiwynn@gmail.com>,
        Delphine CC Chiu <delphine_cc_chiu@wiwynn.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm: dts: aspeed: yosemite4: add gpio name for uart mux sel
Date: Mon, 19 May 2025 10:48:49 +0800
Message-Id: <20250519024850.2894895-1-delphine_cc_chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
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
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB87:EE_|OSQPR04MB7910:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 09ea8e30-495a-47bd-9b2c-08dd967fb1ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WrtmSClM+jq0pYmVA8kHVxfwlQ2xYw2C3iCSuQIBher46HSoto3XzjPEPuiE?=
 =?us-ascii?Q?fi6Ja9qsenunDZqm+B2NFuwARX1PWEfejPx6DYWcPvzinj4rRaSQ/GxL/9Zb?=
 =?us-ascii?Q?2XdzHU5+zLCaJdBpRIZ3ak1j6Wm99gpbOrlJO+ALNnLG1wxh9SekaVJvvcRm?=
 =?us-ascii?Q?qjjRza/QSD7MQaNKelWsXX3atDduZkctEWYtDCr9xaQbqxOCUnXeCzOQQBUR?=
 =?us-ascii?Q?zMgAHhe8iWCnVwBQWuX6RQ6fEhOgPCG/6YHHpTGznzdUqAVRWwHhTboNw3Ui?=
 =?us-ascii?Q?VC3PkP2lIIA0k7iU1Wd6DP5rOm7JdKqEY1QbLmh1dvcXP7GAaKhfKij/mHBf?=
 =?us-ascii?Q?rg/fAchC/EVqQKnnhMk+fHZGk/sxIgW33jByIsB0joUr+YsNEwZNpqMwk+3g?=
 =?us-ascii?Q?0uvObDBCk1C5nW7bNZzZAwC814I2yLE+KJGmQm6dt7L/k8lP8yKzjnRXbLbM?=
 =?us-ascii?Q?vFNSg2kaCjdvKOqq0dQWzNZ9Bmfb5VCzV6FfOilwuE31zZtZpk1EF8QLoRKL?=
 =?us-ascii?Q?mTUUSIOBUnFJBXS9ppRLwobc3jzhTJuo8btstVFQyT16+8jcaPgbUA2SpiaK?=
 =?us-ascii?Q?Jx4B8idUIGw3htNWbBQiNA5Ze9/ySO+JEiqAA9difqod6ANSr7B+MV8Y+Ayt?=
 =?us-ascii?Q?648qv3IIS+VzEVnZU7lbh07meWNWeHWBcshqr8fEtp0LWy5qcbuwCK7H3ZI2?=
 =?us-ascii?Q?euTW8nO59myzH2pJhuIfperaGettGuubSkLXsbaSJmOkmBQ8oxbB28VwE9FV?=
 =?us-ascii?Q?eHU+IXjXBNa5NP5UvYqvC2Uodbgj0cNW7OEQqZXGrFWGrteQrDbho76U1JHt?=
 =?us-ascii?Q?OseNvntpCMGf34fBvtETguGwE7t/Z4gOZEbhK50IfFeb8LPS6Wn8GGTTBChG?=
 =?us-ascii?Q?Rc+lhBNziITKQawoaT3/ywBXbit4E5AjA+xp8jqn1jpTnXb5WqmvMaO3FWdo?=
 =?us-ascii?Q?LhM6ExwFt0o1GUGmnyo0B987CLvn/CcCEKqrIVrQ7+bwx4oBLA2rDCezinBd?=
 =?us-ascii?Q?+E07BvWLWIsTDeq77Kh/L8rGRdlT8xKQKd4BKnB3QZChE2mcwSIr911xlUD6?=
 =?us-ascii?Q?ZFRzz1w/fWvbZ21b+nX1a3mO2RXdjYSBYvltT8HtVBhokuhk2h6DE9yzA2O7?=
 =?us-ascii?Q?e3MBXnTje6lDCPy46M7syax5F7OS6UOkuu1dGRky1Mw+HXb3jzWdvSPBnBb2?=
 =?us-ascii?Q?qczjSulronP7MOsO2/H1SZWCsR/b3LLjqIlseiD19DnZh0HpiTvVMfDy5GnF?=
 =?us-ascii?Q?hcydU9YFJjrmlkjWQBHY2LCmFVOR2s9BnbJrMKZ6hd8xTzyIXat9HXSSMbB0?=
 =?us-ascii?Q?Ig6Q+VDAvvIMy1Y5mrzZKG8MhKmy1iy/sCDv+uXp21FMOr8avOMtnwxNW/PW?=
 =?us-ascii?Q?OQKsUMzUWdkSLAur20Uf4am3orrT+ry7/GqoWnMd1V1gCP6FBYdq7EuckXU9?=
 =?us-ascii?Q?aGi4kWc3goNYfAJo5XgUj9UO7TDM7XQSfQWurlNe9uLz5xDW0ZktiJysnReo?=
 =?us-ascii?Q?XTFHUnh7fxiQqAqZHhtKR7xjia4PI4P7rxG5?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0cg2+NEOuaU7YllK7Lw6JMpM1wEDsVQpcXjqg6K9UpoMvXShahozV4FFakTWqboTzmYGAr4fovH2xGUqojIG0dVsLYBJMkJJ1FvpdaPtX4jvpshufoWAn4R+FExptxtOZUofFTraJeupwyCD4GiLMAV4ynY4nRh/5oHufV6UeFu/ErzjqGle1yC2Y2faPSj6BMgBOfw6UldYkuW5XNK0avObfzgF7lOtqH+VrskDINVj6eX0JA0d1H9LoSFikF2+HUUicojz4xEa4SID+jvpl8BLNnydh6xC05k6spd5tmg/EUFKcNaDWkRV409c8hywI3+UaAivY3xu7MSekY+HuAkXCG+Y8lZt6h2opm696gsy5g7kQ5YDqAOX6xa9D1zXq/7Fnx1reY3MXGBle0zC6IjKzzzeSJSYMoB++22P6CCUHcdwETvB94N6K/38943PXaAggb/C/YkM/VRfGg/jj+OqfGEV3bpOOkcfwM8IiQp3UyZRtCut4EJ9LVWpSCUrXF/Hyu/Ul8nQBj3Dd7RgD7tc+4wd8yff8EZmGdsMHwwT/EJSZxPc+yybZnq0bhXEEh2fF8X5NI9gqfGw6Ae2Jj/9p6n3V1o8gyktymWZMi585PD9I6uzPy2VUgoSbLIe
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 02:48:53.8549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ea8e30-495a-47bd-9b2c-08dd967fb1ba
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB87.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR04MB7910
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDAyNCBTYWx0ZWRfX53RBFHSIC21r 8cV7IwoxbIwqoFzHRz5TJXXWhssjn9eUwvmc5zNFs6ymxVTN2XQ4LCuphwQ6WTOXUXz7TZRHPtD qzqN+qVA3q8QJy6tfONTnZVHiEW7BdwE4b8zCoxj5+85L1vmwjOCWvH322mGTzb3/AAc/rjOJHk
 BOi80U9pK2VKGz9GURup4v9NilJ/J+cMnHw7I1m0mGEVVVLYH2UNkuGkBo1XA/1tDuEl4ZfOi7P ttxbmtWS1PqYx71qA3qlcifl+qduZL09B0ZnVFHoHPVylME/kPauKNN7JpzytQy13baJHLTzYVx Knq4yb8SjpByYetJY9/U6O51w+UNtnkpLsnuja89FpjVAt/ZAgu5W6aPsMtelsVHRveQOuaibC7 Rkw9peA3
X-Proofpoint-GUID: pJwXHJi0yCxLTXEm5Z8hnp0EzPMigK72
X-Authority-Analysis: v=2.4 cv=bqNMBFai c=1 sm=1 tr=0 ts=682a9c1f cx=c_pps a=I+j65ROInpFcKU+zCE/nCA==:117 a=6rDDh2uRNVCE5HFPCIqeAA==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=dt9VzEwgFbYA:10 a=4AL28aEVfeMA:10 a=pGLkceISAAAA:8
 a=cPYzWk29AAAA:8 a=4NkRDkXW3gmRkeDejOAA:9 a=oSR2DF9YFqZEN4IGatwP:22
X-Proofpoint-ORIG-GUID: pJwXHJi0yCxLTXEm5Z8hnp0EzPMigK72
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_01,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 clxscore=1011 spamscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2505070000 definitions=main-2505190024

From: Marshall Zhan <marshall.zhan.wiwynn@gmail.com>

Add gpio line name to support multiplexed console

Signed-off-by: Marshall Zhan <marshall.zhan.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <delphine_cc_chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/a=
rch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 29f224bccd63..aae789854c52 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -189,6 +189,11 @@ gpio@22 {
                reg =3D <0x22>;
                gpio-controller;
                #gpio-cells =3D <2>;
+               gpio-line-names =3D "SLOT1_UART_SEL0","SLOT1_UART_SEL1",
+                               "SLOT1_UART_SEL2","","","","","",
+                               "","","","","","","","",
+                               "","","","","","","","",
+                               "","","","","","","","";
        };

        gpio@23 {
@@ -235,6 +240,11 @@ gpio@22 {
                reg =3D <0x22>;
                gpio-controller;
                #gpio-cells =3D <2>;
+               gpio-line-names =3D "SLOT2_UART_SEL0","SLOT2_UART_SEL1",
+                               "SLOT2_UART_SEL2","","","","","",
+                               "","","","","","","","",
+                               "","","","","","","","",
+                               "","","","","","","","";
        };

        gpio@23 {
@@ -281,6 +291,11 @@ gpio@22 {
                reg =3D <0x22>;
                gpio-controller;
                #gpio-cells =3D <2>;
+               gpio-line-names =3D "SLOT3_UART_SEL0","SLOT3_UART_SEL1",
+                               "SLOT3_UART_SEL2","","","","","",
+                               "","","","","","","","",
+                               "","","","","","","","",
+                               "","","","","","","","";
        };

        gpio@23 {
@@ -327,6 +342,11 @@ gpio@22 {
                reg =3D <0x22>;
                gpio-controller;
                #gpio-cells =3D <2>;
+               gpio-line-names =3D "SLOT4_UART_SEL0","SLOT4_UART_SEL1",
+                               "SLOT4_UART_SEL2","","","","","",
+                               "","","","","","","","",
+                               "","","","","","","","",
+                               "","","","","","","","";
        };

        gpio@23 {
@@ -373,6 +393,11 @@ gpio@22 {
                reg =3D <0x22>;
                gpio-controller;
                #gpio-cells =3D <2>;
+               gpio-line-names =3D "SLOT5_UART_SEL0","SLOT5_UART_SEL1",
+                               "SLOT5_UART_SEL2","","","","","",
+                               "","","","","","","","",
+                               "","","","","","","","",
+                               "","","","","","","","";
        };

        gpio@23 {
@@ -419,6 +444,11 @@ gpio@22 {
                reg =3D <0x22>;
                gpio-controller;
                #gpio-cells =3D <2>;
+               gpio-line-names =3D "SLOT6_UART_SEL0","SLOT6_UART_SEL1",
+                               "SLOT6_UART_SEL2","","","","","",
+                               "","","","","","","","",
+                               "","","","","","","","",
+                               "","","","","","","","";
        };

        gpio@23 {
@@ -465,6 +495,11 @@ gpio@22 {
                reg =3D <0x22>;
                gpio-controller;
                #gpio-cells =3D <2>;
+               gpio-line-names =3D "SLOT7_UART_SEL0","SLOT7_UART_SEL1",
+                               "SLOT7_UART_SEL2","","","","","",
+                               "","","","","","","","",
+                               "","","","","","","","",
+                               "","","","","","","","";
        };

        gpio@23 {
@@ -511,6 +546,11 @@ gpio@22 {
                reg =3D <0x22>;
                gpio-controller;
                #gpio-cells =3D <2>;
+               gpio-line-names =3D "SLOT8_UART_SEL0","SLOT8_UART_SEL1",
+                               "SLOT8_UART_SEL2","","","","","",
+                               "","","","","","","","",
+                               "","","","","","","","",
+                               "","","","","","","","";
        };

        gpio@23 {
--
2.25.1

WIWYNN PROPRIETARY
This email (and any attachments) contains proprietary or confidential infor=
mation and is for the sole use of its intended recipient. Any unauthorized =
review, use, copying or distribution of this email or the content of this e=
mail is strictly prohibited. If you are not the intended recipient, please =
notify the sender and delete this email immediately.

