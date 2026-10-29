Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C01606A322
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Oct 2026 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=TDrZjzPC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFllL5cKHz30TQ;
	Fri, 30 Oct 2026 00:42:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c007::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793281326;
	cv=pass; b=CfKUlWSI4IN6Lsj4OZfyf6ltbWcQIyJK26vetq+1mGtJqHL3LZNblGp76VbezA7nb0Y1TBeFiWNu6FOpQ40HfImd29IOB/UkDFCo1hlQysbiDCHOpLdJ+QGu4lgc8aayA9JaHIorIhF71CnfRkx+wwveRBxAI1pM/2+pxafmMLEe76phnDjqV0KlxNVuz7JwwKLLOuMb7eIJZlGUXki02dSrs7zAjNB07kTvTWQYKWWhRc0rMDdVlZJmmbvzzOl/C2vzJtq56ForpzdwNowmjWoI13VUqV3Iif/fNg0Z4tRAU57e4dD2AyvGa+ATQFEOnBLT7I1d3QbX2Ve5SylPDw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793281326; c=relaxed/relaxed;
	bh=EMgFVzONncenVzajSBplgoSS+5bazk53iesp/vegqe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KMEPK9+hrdrXI022zN5UvvH9WEUq13Be41+LFl1IkiY92Ft31obnfwizrkAXhjZ78fDMPJGvDIhj50wtKZzDEb1MjjMQfNtDfr9NmxEiry4oeiLGWwA3Gd3AoxDos6ki37eWZj5fequXHuDOKenGvlN+rN6I4IDSXhK5R23NNC7JevlPrwHKcaV+EYo7uuBl6q2KMetaeG5yzvNPcJs2Db7MaN19uPBhtcSuM2qdQYsnLMz9SJ+bP9EsqXfxPAsYGapjLeT6FeRp+xCktNzVik+qRsGQXoa47AjxiMPock3iorQj+ahoRXkUMnRcnOaANXv0orryBosAz0WEqZjjFg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=TDrZjzPC; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=bounces+srs=x2+gl=it@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org) smtp.mailfrom=amdcloud.onmicrosoft.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=TDrZjzPC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amdcloud.onmicrosoft.com (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=bounces+srs=x2+gl=it@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org)
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c007::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFllL0lQrz30T8
	for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Oct 2026 00:42:06 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJZQyWJ15SJu+lVzzWebhTJYBhG8efvYGoBT6GqN2KmYvFbPHCijACjji2fGxprbFclVofsLlrr1Xm4pJrUxL+GsHsV+FOXkQ7q/N/HY83x3OwOmDVMDnWwEV0/9lLYOWNP9YOl9P4bCpmjHvovr1umahTAWGLjuM7Hn4ilbPE4ZtzjuqKxFMRukq65sz0W9BoseHrCkK/xc2PpCi+Jm2V7GNmQ8xmKOjeyTUFO+CQ3uMaliuIJceJlfxF2zMv5gZBedNrBsLMHBVokp0aQnB+7umt5rWC9eHqQJB7FKNjOySSeK9kwP4foYAj0yzwinjeY59dpaMkXP2ehrzgQEeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMgFVzONncenVzajSBplgoSS+5bazk53iesp/vegqe8=;
 b=C5Y0Z4rVFDGh/dnEYs/SJ7VvUKaxa+jopLXWyIQKHMpgj3N65+I/LEo7Mq74hx5KGjpiM08hfM6k3Dcxc69C8HaSX+7nBlQbf+Y2h3+Bi4H4l50FSXnVX99kIsoYO4TX5Gld5dSQ8EUXdu5SEYpoX9t0tHPbu5fvYNKL6W5IPg9degIzPSAMR2HqOYLaOD8eFub9hcX/KQK7yyu8wyOc5M9Tnq8P6+4YQYMMuUDzS9vqdQUyrUb0IUBAcaf1pZSg6rTZ/18PAuRRo/zw4o0rQx3DXfYM0LxAuTKnOcP5k+wyIBGN51s5OUtLR6m07kBozufxOibi/+Cfs7gMBKxf0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=aspeedtech.com smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMgFVzONncenVzajSBplgoSS+5bazk53iesp/vegqe8=;
 b=TDrZjzPC0PJMwne3EijTdhVvfLbD4dmC7xztIj9pju8/ZtpEH2JqEn4K/60Y/xckQ2C6PrEJsPag4P23oUtDBfxktoFEsQgP6LDPpYM7R6UIevXreGPv5s/3zW2lLnidtIVR4PTYPHw2a7RZYihkmicwoulQWHLVjzOcVFRXAxh+t3HWEQuUpgYmxVOUX04/Uar7azIU7PJScuj2SG8fRDdBsW5tsQu7zw6oIrmTt2l01yYYRlAo6+Q//ZQvZd4Kq99kDmazItwDu2iSkv3I606wICCj/zo0IEv9uAfWE99KBUVlbvCahBNNmRJt+QUqVvs7vhQV12fzARus0nCTXg==
Received: from DS7P221CA0035.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25e::15) by
 BN7PPF39B20C1D8.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 29 Oct
 2026 13:41:47 +0000
Received: from DS2PEPF00006E22.namprd05.prod.outlook.com
 (2603:10b6:8:25e:cafe::36) by DS7P221CA0035.outlook.office365.com
 (2603:10b6:8:25e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Thu,
 29 Oct 2026 13:41:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 165.204.84.17) smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 165.204.84.17 as permitted sender)
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00006E22.mail.protection.outlook.com (10.167.23.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 13:41:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 08:41:46 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 08:41:46 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 29 Oct 2026 08:41:43 -0500
From: Colin Huang <u8813345@gmail.com>
Date: Thu, 29 Oct 2026 21:38:38 +0800
Subject: [PATCH v10 09/16] ARM: dts: aspeed: anacapa: Add LPDB fuse monitor
 GPIO expander
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
Message-ID: <20261029-anacapa-devlop-phase-devicetree-v10-9-26ee3cf9d9d0@gmail.com>
References: <20261029-anacapa-devlop-phase-devicetree-v10-0-26ee3cf9d9d0@gmail.com>
In-Reply-To: <20261029-anacapa-devlop-phase-devicetree-v10-0-26ee3cf9d9d0@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<colin.huang2@amd.com>, Colin Huang <u8813345@gmail.com>, Rex Fu
	<rex.fu.amd@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281119; l=3698;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=8kEAvGR4wHD+buKRoFqsooBUH7WFB3+NHrtadmWVUT0=;
 b=qhCjLj0Njc5Y2S1KfBxyTnZ/2uJVh7xoLQAA7uUUm89m+tFjv2BWQg7/x6akY9yr0PCZ/Um4g
 01xfXTBPFGzD9RLOD+2tFYwZD3Uss1jbZRS4TEuHhqf1LP8aeiKo/Zd
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E22:EE_|BN7PPF39B20C1D8:EE_
X-MS-Office365-Filtering-Correlation-Id: 533d4dc6-15a4-40d9-c7c6-08df35c260d0
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|48200799018|35950700016|7416014|7093399015|376014|82310400026|261026140227099003|261009223027099003|56012099006|11063799006|261021121427099003|261028144727099003|10067099003|16102099003|22082099003|18002099003|4128699003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	7at9+GMWIY+45ua31wbppWZ6wUH3/JO1zeKXuLZgwahrMAwdoIpPp++gAw0NAq0z2SRUCcmVP7pI0bxBj68YrOybSVBDCR1AZt2UCpK9ODpvTJX0xkxoOYtffKeRnLQAv0ZBjvrZ2pKV3zva3uZE9OOiqIsFSeeULNdTrUQr0/EupnNlhghKSsHcQdIcZey8EqENHQV6JER/iAubjUgacAXYBjO3mAxW8klBaBYYGywxUx0Pz8zk5mxCPPABJ7EuukTzJjmRFWydwbSZo8cm1REbSehTnww0nFekctLyLxGdb35R/BTSEQgVoEVlDWf8drxN1OnPBN4bMqQzK9bCHNUkWFGMI7XK4fYHnNgNU/0nJXkLK7PJ0oFItqTZMfVhBNYA0+NLLi0xV6JgTo1nCzZdrdlDLVKyJnsZ+PEWg968vNxTXczrwuTYBJqfjfaEzCvJ/bLCxTMhXCowK5qGmGfXRzWg8C9V+ls7hr4beCKAuBgJxWUrGJ9lli3rNckOkbBbkN/0BV0N6dNwjqrZFzi63w6C0wNSe27r42RQ202ziFf/K8a2RKUsA5zw1LTEqYLpMlwjB0eHHu6hxZ/dMhNniwnkE07s0oXWJEhYDuh6iEC45cpyIXtQ+/5p8niiTD/tkn2JTGSINoAPftqFdPDA4dT76NukojRPBhQrGmmvKDq9uI1ll8rpw8kQ96CTskT4HYqx45KK8btmzWoytg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(48200799018)(35950700016)(7416014)(7093399015)(376014)(82310400026)(261026140227099003)(261009223027099003)(56012099006)(11063799006)(261021121427099003)(261028144727099003)(10067099003)(16102099003)(22082099003)(18002099003)(4128699003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5/gQkdx8+as5z2zFA0Qvzj22lW0CMcSmPBmkZbI/OXATCd+m/fFCyhg5N9yw5oHCTuW2Js0n+2/bqcKMvHyFNNoJACeTpuLsKfATe6pVNbEsAEz17Y5aGQA1u8EwknKJEdW8kNpLcXtMX7Cv2eU7DfhVSrFNmn41tCabxxDdWEGZtJHlJUwNrzo4ha5PQs4dvAS775cKPBtBKqQquluWMishTWms7mjFplbLL/XSiEMye/SzvVtX9wZ6AMskuztzxmiWi8Zu3XsnDCJ1G8XVq2fpU+uq+DqlYLzfJLmykdu4dzubferyNtPleNRM58+Qayov6VitHboPERfINkmlkmyFkfpl0eU9wLNpHL1Hh0RCAJ1FmVYWZ+866xOfWYU5dCimMNcMLr5CfK3OZtno/4zwOjiUec30ENhcYpQ0yRZqdNpQ38eCyCUl5mVFkwkP
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 13:41:47.3292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 533d4dc6-15a4-40d9-c7c6-08df35c260d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00006E22.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF39B20C1D8
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Rex Fu <rex.fu.amd@gmail.com>

Add PCA9554 GPIO expanders for PDB fuse monitor signals on the
Anacapa DVT board.

The patch adds GPIO expander definitions for both the left and
right PDBs under the i2c8 multiplexer and updates the associated
gpio-line-names to reflect the final signal assignments.

Signed-off-by: Rex Fu <rex.fu.amd@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi    | 92 ++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi
index 0509bc8bb9cd..2fd7e46daa63 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi
@@ -2,6 +2,98 @@
 
 #include "aspeed-bmc-facebook-anacapa-evt2.dtsi"
 
+// MB - PDB
+&i2c8 {
+	i2c-mux@72 {
+		i2c@0 {
+			gpio@22 {
+				gpio-line-names =
+					"RPDB_FAN_FULL_SPEED_R_N", "RPDB_I2C_TMP432_U8_ALERT_R_N",
+					"RPDB_I2C_TMP432_U29_ALERT_R_N", "RPDB_GLOBAL_WP",
+					"RPDB_FAN_CT_FAN_FAIL_R_N", "RPDB_VERID_A0",
+					"RPDB_VERID_A1", "RPDB_VERID_A2",
+					"RPDB_ALERT_P50V_HSC2_R_N", "RPDB_ALERT_P50V_HSC3_R_N",
+					"RPDB_ALERT_P50V_HSC4_R_N", "RPDB_ALERT_P50V_STBY_R_N",
+					"RPDB_P12V_MB_VRM_ALERT_R_N",
+					"RPDB_P12V_STBY_VRM_ALERT_R_N",
+					"RPDB_PGD_P3V3_STBY_PWRGD_R",
+					"RPDB_P12V_STBY_VRM_PWRGD_BUF_R";
+			};
+
+			gpio@24 {
+				gpio-line-names =
+					"RPDB_EAM2_PRSNT_MOS_N_R", "RPDB_EAM3_PRSNT_MOS_N_R",
+					"RPDB_PWRGD_P50V_HSC4_SYS_R",
+					"RPDB_PWRGD_P50V_STBY_SYS_BUF_R",
+					"RPDB_P50V_FAN5_R2_PG", "RPDB_P50V_FAN6_R2_PG",
+					"RPDB_P50V_FAN7_R2_PG", "RPDB_P50V_FAN8_R2_PG",
+					"RPDB_SKU_ID0", "RPDB_FAN5_PRSNT_N_R",
+					"", "RPDB_FAN6_PRSNT_N_R",
+					"RPDB_FAN7_PRSNT_N_R", "RPDB_FAN8_PRSNT_N_R",
+					"", "";
+			};
+
+			gpio@38 {
+				compatible = "nxp,pca9554";
+				reg = <0x38>;
+				#gpio-cells = <2>;
+				gpio-controller;
+
+				gpio-line-names =
+					"RPDB_P50V_FUSE2_TVS1", "RPDB_P50V_FUSE2_TVS2",
+					"RPDB_P50V_FUSE3_TVS1", "RPDB_P50V_FUSE3_TVS2",
+					"RPDB_P50V_FUSE4_TVS1", "",
+					"", "";
+
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+			};
+		};
+
+		i2c@1 {
+			gpio@22 {
+				gpio-line-names =
+					"LPDB_FAN_FULL_SPEED_R_N", "LPDB_I2C_TEMP75_U8_ALERT_R_N",
+					"LPDB_I2C_TMP432_U29_ALERT_R_N", "LPDB_GLOBAL_WP",
+					"LPDB_FAN_CT_FAN_FAIL_R_N", "LPDB_VERID_A0",
+					"LPDB_VERID_A1", "LPDB_VERID_A2",
+					"LPDB_ALERT_P50V_HSC0_R_N", "LPDB_ALERT_P50V_HSC1_R_N",
+					"LPDB_ALERT_P50V_HSC5_R_N", "LPDB_I2C_P12V_SW_VRM_ALERT_R_N",
+					"LPDB_EAM0_PRSNT_MOS_N_R", "LPDB_EAM1_PRSNT_MOS_N_R",
+					"LPDB_PWRGD_P50V_HSC5_SYS_R", "BARKLIP_PRSNT_N_R3";
+			};
+
+			gpio@24 {
+				gpio-line-names =
+					"LPDB_P50V_FAN0_R2_PG", "LPDB_P50V_FAN1_R2_PG",
+					"LPDB_P50V_FAN2_R2_PG", "LPDB_P50V_FAN3_R2_PG",
+					"LPDB_P50V_FAN4_R2_PG", "LPDB_FAN0_PRSNT_N_R",
+					"LPDB_FAN1_PRSNT_N_R", "LPDB_FAN2_PRSNT_N_R",
+					"LPDB_FAN3_PRSNT_N_R", "LPDB_FAN4_PRSNT_N_R",
+					"LPDB_SKU_ID0", "",
+					"", "",
+					"", "LPDB_PG_P3V3_R";
+			};
+
+			gpio@38 {
+				compatible = "nxp,pca9554";
+				reg = <0x38>;
+				#gpio-cells = <2>;
+				gpio-controller;
+
+				gpio-line-names =
+					"LPDB_P50V_FUSE0_TVS1", "LPDB_P50V_FUSE0_TVS2",
+					"LPDB_P50V_FUSE1_TVS1", "LPDB_P50V_FUSE1_TVS2",
+					"LPDB_P50V_FUSE5_TVS1", "",
+					"", "";
+
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+			};
+		};
+	};
+};
+
 &sgpiom0 {
 	gpio-line-names =
 	/*in - out */

-- 
2.34.1


