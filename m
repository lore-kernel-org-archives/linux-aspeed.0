Return-Path: <linux-aspeed+bounces-3316-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67B3D3CC86
	for <linux-aspeed@archiver.kernel.org>; Wed, 14 Jan 2026 22:23:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ds0xV5c9wz3bTf;
	Thu, 15 Jan 2026 09:23:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768404640;
	cv=none; b=Hu7f+JuOvhOLqsNQnW2abr+bshYl/ZHBVt1K/d1A1GwIMJBxvpmM5JPeU7JqRH1fgzcPmcjXrMFAAREityK2E5DP0OJ/L8h1MI6NNf8RampPWJIHxvQ50h1SeooU46CoYyzqe+1t83dxILeR6Wl6TvEOq3dxwX06bxyXYtorWqSbO8YcH8+zFiW5heiBGzf8DOA00oNPYcBk8DyVfzk9sz31ezO58a1LH8Ruv+QAaAlCSTWEdyFEwBmu0Zy6mVTLvI0io9X2FSIzIdX9MMHbGBOfXnTpOwGvATh9W1a658i0yhPnSX+jxUxDQJjEq7ae88f6JI0KJBjwVC8WFu6oXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768404640; c=relaxed/relaxed;
	bh=ssy8kvmbkidBSVa4bIF/Sg6F1PMs1iwvsiG9/WVtcJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X4aDD7xL8YpnhgvI6OURVY1t+cChEkM3lp+0TxFQj7RthXQstJWLO8agqW/sgp5AWKg/GpPdilWwH+/wUtAUixRi4dqpGu4GS03STcAu/KkNUIBEIjBVDc0iCvYU1T1RHda8Ps4Q3Xen8Ll7JGQ+b2ss1QfSJ+rb4y3lqJV/FGvxLtYQ0/8YXZ1VcGayWI/LNkXkg2AiZoG7axyboHZcFkrfu76KKz+lNg0jT1P/aUx4pT56u5FYw0FuNJAPYeFmtsK5Qs9puD2g1J9qKB8x1cU2YXVTcdPLoV8wprTiVP+nqdked3BJbCOJdqJguEV6zI5mDRIIQpsIBqYMZ91DQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kk8JIzgW; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FkkTufiL; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kk8JIzgW;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FkkTufiL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drqnW3XkCz30M6
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Jan 2026 02:30:39 +1100 (AEDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EB34ma3280080
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 15:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ssy8kvmbkidBSVa4bIF/Sg6F1PMs1iwvsiG9/WVtcJY=; b=kk8JIzgWD/bAHEgM
	0ls96MNXXtEja6QlnGHg+sHWfdxg9wDNaEzJfvyQq5xMnTuFWVseT9s6RLHdO5L9
	fiiRlWgh/YHepJkNkuC0AnfkwGL0Ld6YutVOHruXFFvt2zdl1KPFXN2Cdk+9raEf
	zVwyi4HdbYB1Qm3iEm8EXAmNAB5eexz3+aKnzn6LtAne6tKxrKfpmd2Pdf1s2JA6
	PGnyZKWvZl78FlUvryh6W208cUEVgEwxQtAzboLq6Fvy6bXHKAL+r7R4mbLDWzH6
	KQ/pTMq+l2VkT7Uu6Vm/oLuuz9ef9Gr2BrJAtjOSQ6YQeOgumZ7CN3XyCY0Zv1ZS
	hqsjxw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp9x8rvcs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 15:30:37 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5013be25d41so58188961cf.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 07:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768404637; x=1769009437; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ssy8kvmbkidBSVa4bIF/Sg6F1PMs1iwvsiG9/WVtcJY=;
        b=FkkTufiL6aaaKJDHucNWq/PsJVgJiYXksj79AB3sWzwYyEUvMTk8ybYf3cHBEO/Glu
         Rg/y0eiVwlZJqN/xitUdAGG0LJAgHmRa1JCuDDDge9FVK/mg2SwQZ883r/2Pcl4mKIby
         +6dGDqCSA0/HwHd2GMRYjaPCjo0EEBx7ZEs47nyAg5tuma457yzRhV1BbvDOj5tn3u4W
         C5OuOGtwIWa8ZRVvYNHgfENuTUAXcvfl0lMs+T1fJIupZkvM3BPUZjAHBtsdbbERp2o7
         mXaFAPRjEm5WieEk3C3VLbUOkrgfmEVmiLq4czY5Cos5EcwmDusEU2c47250sbEp5Es9
         woew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768404637; x=1769009437;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ssy8kvmbkidBSVa4bIF/Sg6F1PMs1iwvsiG9/WVtcJY=;
        b=rxSDeGJsWCBve0bxWRuB4lyTQLuM6aqb6irA5deXfxtBFUHwC2ZVKvSEshy08grpC+
         KYHukBMcogtsyIN6pvm2tcJ3MbckSg1YcE2+wPkwIgtu7fPf/TNxmEY2yMmG0Z+30mb6
         +P/UJ+qlLH+bvsxxQSnr7SfQbnyWcz35NpDnaTsx2nGaSflN4qryQUTME71GzL0Teisy
         047Ph2Cj7lTd0X5an0befcPZoUXz1VSongeXVJlMqSxa6mFToCDFwVXYPTm0JQ5a4snO
         Jg7CeoiuMalMfN94DTTzGiwUuGBOtZxwlXAuBDuQADCK9ZKfYbgZQk7kCeZSExf6PKjN
         89qA==
X-Gm-Message-State: AOJu0Yy+agpZjy90q5CS0J+nf+e0VqhYLIVQMcyWst4nXNYlQ72Dp92Q
	1QWbTWgmIpUN4R0Jikl3+SR21IU3kG8whh6oQ64J/oWW/UVu8+hwOkbSx8Grwyd4Oz5ozS7e4ts
	kO+QPFnvcNJqNZMAad4IVUpo66zZZ85OnLt+jBVRoMkclbSrwOhaGHZWa7LD2NX4ptZPa
X-Gm-Gg: AY/fxX42i63jvy2QMa7ngyifkuysrFVx5svR50z86jECevyyQqzXfOWceAHYSUhWP82
	Gd4Ag4u7CXq+JYUAWWbvRrySq6CoJP91yjTiokC7bMFdoJmtV/oJeiAN3PXenb4Vp2GwygDGbYT
	fTP3N5oq3l6pmrxwta1xgrYizcYc/SmV0bK4jyzEnB55YjAwxnaFEqsyESvSmX1A9GSKjOq9p6F
	/2dpIxXpHLGDjZvlEL6p78CrnvjvR72hTNhnF7U9lOnYPAdhRhKPZSrvgsH9gdWxxZDAI82Jlto
	VxX3CbCn59LJGVMV3dG0GeJaKmpyLsf0aXAgXqWqSksZHB6DvPDJYDCg/GnncVtqdDz7GimNph5
	UO/nSZilpitMvnUkozTaOJ543beFXRHPylA==
X-Received: by 2002:a05:620a:4549:b0:8b2:db27:4268 with SMTP id af79cd13be357-8c5317f0aaamr303440085a.53.1768404636226;
        Wed, 14 Jan 2026 07:30:36 -0800 (PST)
X-Received: by 2002:a05:620a:4549:b0:8b2:db27:4268 with SMTP id af79cd13be357-8c5317f0aaamr303432485a.53.1768404635555;
        Wed, 14 Jan 2026 07:30:35 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf667fcsm22812989a12.29.2026.01.14.07.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:30:34 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 14 Jan 2026 16:30:09 +0100
Subject: [PATCH 08/11] pinctrl: tegra-xusb: Return void in padctl
 enable/disable functions
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-pinctrl-cleanup-guard-v1-8-a14572685cd3@oss.qualcomm.com>
References: <20260114-pinctrl-cleanup-guard-v1-0-a14572685cd3@oss.qualcomm.com>
In-Reply-To: <20260114-pinctrl-cleanup-guard-v1-0-a14572685cd3@oss.qualcomm.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
        Linus Walleij <linusw@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Inochi Amaoto <inochiama@gmail.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sophgo@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1889;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=zRGKe5UJ9yNFcA3nCyV2yle+pcJ0o698KmnQ7j+oxLg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpZ7aG1jDmkP4a6PmHCk7jxdg6pIwc6m3a2BsZu
 jfRoWqEDhyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaWe2hgAKCRDBN2bmhouD
 18PUEACGRm9HFTgK/BMYNlKpt3lPmWT9bCXtaAiUNJGcB6ffgJheT+i457oOaT/xTx1LOOiYEau
 UWjdo7vnfye/rqPz8xYcdQr+go81raUQ3IhBxe+LqfaMunA9y3Q+s3QbktSC3PldiTWJyw6MXBt
 uq+YFH0Vtnkbp8TC6c1687wMzaJsm5xlKxC6x3Sfmws6HwZXhBuTB4Hi0wT0my3LoS8gJTHQTNq
 +qkjU0hLXmrpN6ibgVT1FxGuHDuDSNeVSEIHmrFSXVlPBywSQGm5gVuLyiQCtiarsEhPhlP1a06
 OD9Hmdkv9AZLGDb+Nyi9BewRwnASnSvswYKtqIMj+lA+fj+BdCmRx1CeX2CIRINVcIZXzU4+VMe
 uKlw9dXawo9KJHktVbqmjTBM/mP3CqYpYoLKJ/Z266veUYfVXw8zFBpEdU0xSOqRlekxTnkGZEN
 dOEKquxcczR8jUIAagMutrlY6GtaQG8YcU5pIdWXfU7Mmly/s9fuJlOFKiCuv78MnGkL2CIwOxF
 saww7DthM71jMUAZ8mCReBzVQOz3GSqWUmdqg2hOkdn6kGEQgkbdIeWBCfvFxgKmUJOw6Jx3QkV
 ceyz1gCkgjID4vnUSP0ziWiUhEXkrHazIzGuYyBPUGmzvaZk1w/COGY+KgPKeu7arJ/qiUw/2Iy
 P4nTGG0eFE6fjiA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: 2-PkXZwJ319xqLr3IZnx3jgzPcIaLudG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEyOSBTYWx0ZWRfX0vuqGi7HLP3y
 A4G3qlPK7hH8K9uzhgcsk3TfSUqEF41Za38Q/fDRiXU0Mjfwwmi2u7F6LIWHyreWawWtIFs68hh
 wIg/oq/Xe30W69teBc5qV2zMUWsototwCHLh0/wYmp9QcRk6SHZ/6nyj0fkLC2xpGJE4f7y4hkr
 cuvGphvTDZOJiGd85Az+S8z1SBz6+ZL6tVnHV55mcm1L2gDFFSWUabQ0myI9xGmuoJqapy1cV6u
 93wtsR68R6fqklrs8KRcTh3dRySMw750Vsh7iEn0F2iIiHMkbaFHIHCq8hGJ/yqvdZ16ZfpTbIK
 Qyl4eaHczwQbZ1sFcp8wazoEoFOGLMMwUF63LT13BvAHZ+rj5R/VAJwqbPaLEvY92VTktB/Z2xV
 G6tTS2Rtl89Svonp8iqFuMGbkw1nnC8A1XbQL0Yyig1w4ktmxkC7JEzRk+upohnzExewMcu/v1l
 vBVeyy0RTHjVoTCqvbg==
X-Authority-Analysis: v=2.4 cv=HY4ZjyE8 c=1 sm=1 tr=0 ts=6967b69d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Ed5BEzkqmhObfCaRRI0A:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 2-PkXZwJ319xqLr3IZnx3jgzPcIaLudG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601140129

Make the padctl functions a bit simpler by returning void instead of
always '0'.  The callers - phy init/exit - still need to return 0, but
these are smaller function without if/branching.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/pinctrl/tegra/pinctrl-tegra-xusb.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c b/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
index 49c5edeba87f..34a373f7e04d 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
@@ -474,7 +474,7 @@ static const struct pinconf_ops tegra_xusb_padctl_pinconf_ops = {
 #endif
 };
 
-static int tegra_xusb_padctl_enable(struct tegra_xusb_padctl *padctl)
+static void tegra_xusb_padctl_enable(struct tegra_xusb_padctl *padctl)
 {
 	u32 value;
 
@@ -501,10 +501,9 @@ static int tegra_xusb_padctl_enable(struct tegra_xusb_padctl *padctl)
 
 out:
 	mutex_unlock(&padctl->lock);
-	return 0;
 }
 
-static int tegra_xusb_padctl_disable(struct tegra_xusb_padctl *padctl)
+static void tegra_xusb_padctl_disable(struct tegra_xusb_padctl *padctl)
 {
 	u32 value;
 
@@ -534,21 +533,24 @@ static int tegra_xusb_padctl_disable(struct tegra_xusb_padctl *padctl)
 
 out:
 	mutex_unlock(&padctl->lock);
-	return 0;
 }
 
 static int tegra_xusb_phy_init(struct phy *phy)
 {
 	struct tegra_xusb_padctl *padctl = phy_get_drvdata(phy);
 
-	return tegra_xusb_padctl_enable(padctl);
+	tegra_xusb_padctl_enable(padctl);
+
+	return 0;
 }
 
 static int tegra_xusb_phy_exit(struct phy *phy)
 {
 	struct tegra_xusb_padctl *padctl = phy_get_drvdata(phy);
 
-	return tegra_xusb_padctl_disable(padctl);
+	tegra_xusb_padctl_disable(padctl);
+
+	return 0;
 }
 
 static int pcie_phy_power_on(struct phy *phy)

-- 
2.51.0


