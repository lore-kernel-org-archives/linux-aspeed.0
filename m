Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C102C606A334
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Oct 2026 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=nlGkGwfe
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFllT74XGz30Tf;
	Fri, 30 Oct 2026 00:42:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c110::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793281333;
	cv=pass; b=KKpeTG+c9oxs7qkyMWb+skx0v5xjiG232aqzA8/xXEjAIDLtb01sXzw31QrWQtFhcAWh15z/15S0dFxHioJf2FpKoVhFpBQ8WaRkarjHWwtHkeL/bllEqc0JN5ghzmPd9ye47ndBofjf+xBp+A0gOYdXvNIq6Tw4N+zkArqVr9QL+EJfazMGijP26S5Rpul4ydNjBAOqpLQ50zM9bxhsWsoR5m9uVLqIZshSc9JMFBQzyv9YqoR0aKAkLJdfC6tPDj9IwPruccWE4bYEtP9y4bcffh0/M1FAi7zXla6wyJSr7d8CergiCkLt+BgYQt0P6VJTQ2wPazOAmKS0TvSQuQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793281333; c=relaxed/relaxed;
	bh=8JHpVGvvc0BxDXqHE+ko9RQSlW/vc4sxkXIPPE0SgRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PL484iR2pTStbt48HuHomhPDpj8CQTncKsCWU2U1uaL1AOyBdu9CI/wpdiEsrRWVvOYoxMzvIv4Q/pn/65hOYgZQpjgbpEh7obKZS1mZchdDXqNR7t8KwuV+Gonhvdu4oAr2eO6kLlUDrOTg5tLY2vSme6Jus8iACtHftkyPogW7wh3XUKk0Kz9KsSKTjn819PqOjbY2KbqqQQYrRgNnKnJOLtyhcd8o87eooJugVjTxJn0QHtlSwqVCWeN4xAFSY0EaeppGHir36SuXu846dzUcUky4d80ptrbGvWdYqCWqtsyofq9CwC5TH4/QFMVSAhOrJBtZeBPpg4GE2z4r9A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=nlGkGwfe; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c110::3; helo=bn8pr05cu002.outbound.protection.outlook.com; envelope-from=bounces+srs=x2+gl=it@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org) smtp.mailfrom=amdcloud.onmicrosoft.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=nlGkGwfe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amdcloud.onmicrosoft.com (client-ip=2a01:111:f403:c110::3; helo=bn8pr05cu002.outbound.protection.outlook.com; envelope-from=bounces+srs=x2+gl=it@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org)
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFllT2JyJz30RN
	for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Oct 2026 00:42:13 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nO6wLn6VT+NQVaqH7zfb57R2soDHPJzoK/ZrCeDM9EWVgB3gN5ODhgpgxTrnknKDuLZ5xdBC6k6oV5z0Mb1Q97hj/E0zQQrdQtveKRe0R8moPqJ5p+hfcB4kXURwjlUXyjyjNMb/ugPHMzeqsaM1Fw8pvqCCmMMhlo0DXGGrY50/cd7nxaGb9fWHxZoIksa+Pvhimkhde1ofsuId1R4cE89HlBg9KEV2Vv8ULfMsDinlDyrEmUzetz6ilpG9v43A6jr+9wCNDKXjkCgSEiu8QopxE3ESsTZHx2d2U5HeJmr9GQshefLSDw0Qg65BfrwvEf3efF0v84p4bEjYOuOgMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JHpVGvvc0BxDXqHE+ko9RQSlW/vc4sxkXIPPE0SgRE=;
 b=tbntSr2F+T3UImq6fxYxDfODfxWlg9kfN8u4OaXmZDcbIgLc+xPje1iasUyGbpEQt5lZaDZGR8c27f2Yt+pxNfz6gK109USdwV380n7F9srJ9xJ8b6SVmVJS2kllfoGURPHtUl3op8KLQ//3hK+KC43JiXFG0Nxq6dAQz/1oAX3/2b/WxjU986nysAzXVCrJWz7ArABPWoIxnXWpVrr2oAQMKKokwLMtSQBoEaHaPMpFUa1GPruyQvy3gT7+NWih405PqB46y3O4W+Sv+ePbeM/gV5VwDIsHfn6U3IuLwFWNrBtoPxvR9s62NHVzKpCiOdb11Y47XDpZmG3TBDm+BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=aspeedtech.com smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JHpVGvvc0BxDXqHE+ko9RQSlW/vc4sxkXIPPE0SgRE=;
 b=nlGkGwfeph8eupapx5QkXOlNdMO1uVs5GZolx/QDJx7N8koS6HMvql/QVvKJvbScAs9K5Udv2ZIPsluI3Gk06HXslNFRD1HsfH30AjvPypKk/hsM4UbFLMVyS9AbyXP/hzu3yWXvJ8ZniY/uUSbossvXHdhkje3s4FGQ0SwyOS8WB8CTPmsHbBJHtEeTHe7+kil0nhLKAmWph/pIOfqbJUW7BBBXExwta1mIuxByiroMRAEghj0RNa2zNj7ugicW6rIf0cszGrjaw/a+2ylMfPCwK2HPw7T/kC2gLwHlIdCC5hTRAbwUS4BZ3H9aY9zwBiGIro9sQQBTDx+VzqgpiQ==
Received: from DSZP220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::10) by
 PH7PR12MB5999.namprd12.prod.outlook.com (2603:10b6:510:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 13:41:41 +0000
Received: from DS2PEPF00006E25.namprd05.prod.outlook.com
 (2603:10b6:5:280:cafe::8a) by DSZP220CA0012.outlook.office365.com
 (2603:10b6:5:280::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Thu, 29
 Oct 2026 13:41:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 165.204.84.17) smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 165.204.84.17 as permitted sender)
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00006E25.mail.protection.outlook.com (10.167.23.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 13:41:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 08:41:40 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 08:41:40 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 29 Oct 2026 08:41:37 -0500
From: Colin Huang <u8813345@gmail.com>
Date: Thu, 29 Oct 2026 21:38:36 +0800
Subject: [PATCH v10 07/16] ARM: dts: aspeed: anacapa: Enable MCTP and FRU
 for NIC
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261029-anacapa-devlop-phase-devicetree-v10-7-26ee3cf9d9d0@gmail.com>
References: <20261029-anacapa-devlop-phase-devicetree-v10-0-26ee3cf9d9d0@gmail.com>
In-Reply-To: <20261029-anacapa-devlop-phase-devicetree-v10-0-26ee3cf9d9d0@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<colin.huang2@amd.com>, Colin Huang <u8813345@gmail.com>, Andy Chung
	<Andy.Chung@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281119; l=3254;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=xSybis4WnZ0wCCi5yNlS7U3ZxSjvjItq7krEUM0miaU=;
 b=w7oawQe3osJip1nZGfAiwO7tM76jjAAlz9M4TpQ2QArkPLE/H9h7G5L6SS31+eGsw0oFaQBhE
 r2e4hoV8jjfAHVR7ol/YoKHXHr31oodcxOrGOZ2PWb1Gm++WzhCJnkG
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E25:EE_|PH7PR12MB5999:EE_
X-MS-Office365-Filtering-Correlation-Id: c84c89e3-cf96-4a9c-29e5-08df35c25d10
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35950700016|61400799027|48200799018|82310400026|376014|7416014|7093399015|11063799006|56012099006|261021123027099003|261021135927099003|261009223027099003|10067099003|261021121427099003|18002099003|22082099003|16102099003|20046099003|4128699003;
X-Microsoft-Antispam-Message-Info:
	tOLCYXpuNz21Wskh2+pBno8Vuh7p9RUgo1cV47eGUW6gGT5S+kMMl4K09v2ZqU8qnk+ynR85S7RJ/gwB75fR9FweCeBlshdhKy/+GWOcqTARK8oOqkDdcSzWepSzd0Pf2RSlcZAAcaMHv2Y7iEo8RkoMt4yyMNlCDFn3b/oJXpHTYry2hAo44+FNIA6SLg7rbHNbZGrurx3K6rG+hqRbLoZ9AvIjd+t665IM3HFEYSVwHiOG2Q0/akhAwQ0dm0W7WbJOCZXu+c3QwPL7T7S06G9YW0d4v8oFhcDFARpgGVkJG8Q7S3RgdgHQDuOhg8tTzE1dGQnAWEZQ+KV9Q31ddINtJZVIVtnWk1ES+i8DLIX2DWW4UVS9pswdtpeGqLE7aIPeoyYVhnUjrvy8Oz+JH+YU8YHPlngkAFSP/QNDU4akFnl/QuCo8g3n9e1eKtJWKDrspocJCarHgF4KyjkI6dQAxuXpcF2obsYPmMkTBXCBNtiucJe7pRFBmNVme/Hah5ueWkHzbm1PPRikjaxPkgceyL7cQzMVKH3C7czyKy+8aMw7AIsRZG0vwutGOSrkmf5eclW520J4l1iLZJJrwacVDNQ6bvEPSCLejwH4VYN1Lo/92v5+QANXixpXlVtfzl0CUZEt4YagXAzhmtCJUvIzt0oyNMQCZ8W2exOfWK2ytgnbRSd46wOPGiixQu5CEGvfxhgzMxuCCZ+7mGPM3w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35950700016)(61400799027)(48200799018)(82310400026)(376014)(7416014)(7093399015)(11063799006)(56012099006)(261021123027099003)(261021135927099003)(261009223027099003)(10067099003)(261021121427099003)(18002099003)(22082099003)(16102099003)(20046099003)(4128699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wiYaEp+ZXSOeyiS9arLv4MWej6VnWqQ+j+G2xCTCb8kt49+gaDbduLRSBTKXMqSWrfNEGriJZseFfC21SLvhwnfJD1Jh9ODr2BG+HuIUUDF+Gr/u38BNcTLs5/Rz2sM0ySeBbsw9dSyLWnK+7s2029Ja7P3V6VjK2G+ZnFIxd0klOfwczIdrpxf1wg74nC7PZ+pw5AYYQIKBbpSw+XBKvkFXPWM5aG3PF2DtqHok185xGjNE6whgxdDDJw9fPq9aZGWHgn7dy6JtDPhehPOCd4uuGguXRQ4J11Z3s1mw3YxA1sioUBg8tC7DytaVZL/5qo0Zns/SVL2MdHfxA8Blbbu+wwM2khwSfKCbNg/0CZFYPkpbPROrNlFXGLTq1+B3gf+8V3zMq/7GllQUcPQ/cfpGzyO4SW4JGydPzdL4RmGfQsvkI/G0kTk33Qpw3qwv
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 13:41:41.0362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c84c89e3-cf96-4a9c-29e5-08df35c25d10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00006E25.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5999
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Andy Chung <Andy.Chung@amd.com>

Add the mctp-controller property to enable frontend NIC management
via PLDM over MCTP.
Also add EEPROM device for NIC FRU and reorder the I2C virtual bus
index accroding to the system silkscreen index.

Signed-off-by: Andy Chung <Andy.Chung@amd.com>
---
 .../aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi   | 137 +++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
index 3ea5d67865d4..ab16e5ad5871 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
@@ -2,6 +2,25 @@
 
 #include "aspeed-bmc-facebook-anacapa-evt1.dtsi"
 
+&{/aliases} {
+	i2c36 = &i2c11mux0ch5;
+	i2c37 = &i2c11mux0ch6;
+	i2c38 = &i2c11mux0ch7;
+	i2c39 = &i2c11mux0ch0;
+	i2c40 = &i2c11mux0ch1;
+	i2c41 = &i2c11mux0ch2;
+	i2c42 = &i2c11mux0ch3;
+	i2c43 = &i2c11mux0ch4;
+	i2c44 = &i2c10mux0ch1;
+	i2c45 = &i2c10mux0ch2;
+	i2c46 = &i2c10mux0ch3;
+	i2c47 = &i2c10mux0ch4;
+	i2c48 = &i2c10mux0ch5;
+	i2c49 = &i2c10mux0ch6;
+	i2c50 = &i2c10mux0ch7;
+	i2c51 = &i2c10mux0ch0;
+};
+
 // MB - PDB
 &i2c8 {
 	i2c-mux@72 {
@@ -50,6 +69,124 @@ eeprom@51 {
 	};
 };
 
+// R Bridge Board
+&i2c10 {
+	multi-master;
+
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
+	i2c-mux@71 {
+		/delete-property/ i2c-mux-idle-disconnect;
+
+		i2c10mux0ch1: i2c@1 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c10mux0ch2: i2c@2 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c10mux0ch3: i2c@3 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c10mux0ch4: i2c@4 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+	};
+};
+
+// L Bridge Board
+&i2c11 {
+	multi-master;
+
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
+	i2c-mux@71 {
+		/delete-property/ i2c-mux-idle-disconnect;
+
+		i2c11mux0ch0: i2c@0 {
+			mctp-controller;
+			// FE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c11mux0ch1: i2c@1 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c11mux0ch2: i2c@2 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c11mux0ch3: i2c@3 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c11mux0ch4: i2c@4 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+	};
+};
+
 // MB
 &i2c13 {
 	i2c-mux@70 {

-- 
2.34.1


