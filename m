Return-Path: <linux-aspeed+bounces-4391-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649EFC43458
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Jul 2026 23:37:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtkQr71fyz3bps;
	Mon, 06 Jul 2026 09:36:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783280463;
	cv=none; b=BkpVongbTN9pDVEK+Ny4eQQG4BqDl6eHOAU9qBS6OTma1yWr7/5utUuo4UbaiJCOWEOwzAhr8QuWmZ+Fmi2nuzm7zH9Tu9epkTrPVKKcEO1xM/zvmVJUXlqijnrn2ix0oUl27AG9m6QOStctTnyGRhQzR6h6QWRzKKy4289ZEMhZ3i74VyBghgWXM1NR6RrWFfkhySNzbkAGg2yCAiQHAEf/IfVlYr7zO25f8uXRP10vxjhxsFVTho96SIK1hApcp6iFVoXm9H5mX7RKxkLT0aO49hP+pC99fCN3x1SNavXWUHhcpxFl7yPbuFEaWn/Nvz8V4s2QrfX/t7J+fP3i8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783280463; c=relaxed/relaxed;
	bh=3J7+oNMk7WMQ4KOiVM1+PpfhqlleI9nCGCg735LegyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QuRwcSGVdDraP2cu8tXkTa69Nlx3rA3am8SusEl51HroSmFOCmEU73IDEG7lYS+FIz815xviztOggI9naygaAknjQB16f0gpnbqPTj3IVZucH/sWy3hK/SpGSmryZnEV0nxb50uTZO5GaGZj5Yt3StLMwsZ3D8BxyG8t0jA9OtL7yifd5X5FFNPHw1ZbaW45pvXd00QZEj9HJKpIbLmjaq6xBNfabHiK6ano7zATeLLw64uN1bcFb8DEnV2dDVDyEWcOpbCWJ9l/JMgjlbnt8ptxS1+QzywhQ6xI7s9kaTnmPrNxP2i7eizyRvo5Nw38xwpd6nvKaITCe0WQyPhNyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hPcw2XE0; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ALuLumaB; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hPcw2XE0;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ALuLumaB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtdC22G5Kz2yVZ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 06 Jul 2026 05:41:02 +1000 (AEST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665HhsAM2168636
	for <linux-aspeed@lists.ozlabs.org>; Sun, 5 Jul 2026 19:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=3J7+oNMk7WM
	Q4KOiVM1+PpfhqlleI9nCGCg735LegyU=; b=hPcw2XE00hJiXGUlPJdzgAHVQzT
	3IKBxTpsdM3YltXY0Gb00tp8cyyqr2jLji+CKNDBWau5JTu+BreuyR01af4GFyfv
	ngpGWe//C62ZWMgkGJk4zSl0S0wOJ9lpQw3JAKnLg2fIs5pZCB7N4aamjssEjqJr
	56eMgt2RR1Wu9uGyx458onBujfZX4GqD+UxQKYZvfMFk6K6CooiLxTXLejKO9W0R
	0jkXD7cR55aEXj06BsfreVAtJNhMuxZgvDsgw5Rbn8a2yz3zzklaCOw3S6PIDyNi
	LSZAc2ZKjYucaa8JgIZQNxudHkYVpBDXyT4e5CmqkA1zH01od7f0TWn9fNw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6tj8k8t3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 05 Jul 2026 19:40:59 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cca5e0a0c9so1029525ad.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 05 Jul 2026 12:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783280459; x=1783885259; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3J7+oNMk7WMQ4KOiVM1+PpfhqlleI9nCGCg735LegyU=;
        b=ALuLumaBNJyhxKuzx8HNWcMlsEDVOOxZKWCyvrFUllKF+4eedBRu0u6m9VJ8kQoEAU
         CMkgAtBORhTb2ifMdEdQ/eYZ6Vz5g6uODGbcbCtwB8V7TmGzPQg+W422j90efgMYEW66
         cE2N3xubrc9qG0b29fCJN6ScstGSIO2VW/1LJWUxuInwrz2DjgFWsirQDjafEAPFn3p7
         +6bfPhL37mkdK0LDxM8IPqKjjqDDqrg+5CN6b12nHPD2ACtvtyrRqvG+/tvbVq2lU8nf
         CrE29fe38oQbu5tiZfFTWtHqdlCudNq7P+zYF+0H4UJYMvd2pH46v+Zn7Xn+OphBC1Qw
         qttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783280459; x=1783885259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3J7+oNMk7WMQ4KOiVM1+PpfhqlleI9nCGCg735LegyU=;
        b=cCHUt4wPf2U/CgD1CnMD6Py6I54rCQkF1JCb6u+hl56YF87phFfOjXZldE/ODGbZ2N
         oWwSEJfMWOetrrDymr04tn/LWYbfKX5Nm57cfqYeX3WGDZ2BjxmVwkiRJfiYzq7sFC9S
         oNCOEThffiNh8URylcATw9QRrWgM6DhAiU7ZLijEbqjqmC1MKGMqJjpgv28qnM6jLFhO
         UYwirx9NNaPwQVgfVmH9AnignTxc34MAPrB9UbjFxsbKCMU576jlAf3RWVhsNcl0ikiR
         g8CpXWxRNvoBwaOE82uJRGfFtHx0fvzBT3Fo0LA3eYtQJnO0lbSD8OX8IMav5fkhafZh
         0r3Q==
X-Forwarded-Encrypted: i=1; AHgh+RoBYcJAhG213imEaGrZVLd532HQVEkoiw5bwjR66t+gGNH2lCpCqN9P41hDnRAHeOVNbnVXdrCogIuwReI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzlbFG+j69ifPzLLnnaoLfrLOZL4Xl0Ea/gVraY4JNFL3bYuae7
	TrJ/34awzw4S9GV7vw4rbCRcfT+seUdykwYWHVgxmJHr5Vo0oAOk1yM0uruCN74yeDeGFHsYP1C
	9jBPqRHBvxyyqAkn8kJmy1MFJJSrVIiLuBzxRZHum+wUs3K0yFVr+lRm2lscTbyBBx/RK
X-Gm-Gg: AfdE7cnnLkFW/eC4pOtJrLbvsDeZfSxrXtfRrdaEKgiKmntFdBsNrOIaPcGWF396M4Y
	cYYHcSwBDGFIUG7igbNAZIh0qUw1tsJlbWrLrunagSkEJOfnYPAb1wQUnEuFw979ONaKplvp3Ux
	ZKDhrnubE46hmr62o7swiW+W+exjXNxm9b84cT3K3nYluZdYXvSmvWd9WWtgJCwZttiZzkiou1Y
	Q05JLPoTrXx1aGtPH/wm9MlILfp6hvmOVSRXqMATsb7KWhNXlJ9zID+C3UA+byakSge7ZYQjR47
	t0eKCQeRm9FAsgz4DbPvbaVimjTXxYNy1N2l36FEDbN52enTZLOtAvWuRoG/LXAbBbiu/Vspy5I
	zw0PsW6FYYbR3vfWmaSbOFyCKthcqsWBVus4Nag==
X-Received: by 2002:a17:902:db05:b0:2c8:1f1e:6922 with SMTP id d9443c01a7336-2cbb9ee11admr72369355ad.37.1783280458791;
        Sun, 05 Jul 2026 12:40:58 -0700 (PDT)
X-Received: by 2002:a17:902:db05:b0:2c8:1f1e:6922 with SMTP id d9443c01a7336-2cbb9ee11admr72369145ad.37.1783280458256;
        Sun, 05 Jul 2026 12:40:58 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:40:58 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, sound-open-firmware@alsa-project.org
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 37/42] ASoC: mediatek: mt8195: Use devm_of_reserved_mem_device_init()
Date: Mon,  6 Jul 2026 01:10:13 +0530
Message-ID: <20260705194019.2565498-5-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
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
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX1m4ME0vPsa6b
 qHAdMS8ePwS4CCkJ2fIkyzcjIRcI4KwYdgvmeBWBb3BdWbhtCnx/eiLCVpa+czspN8whFKuAaJx
 PMuja95IaRSLzzMGv56ApRRMPvfuWVOFmnBAi5OgnJuK2eCux7VEY+qqwxVELBYB7kKODiW+9Cl
 AIKrYc0yI57Gh29aN79WONOfPVCcakKg9mp/fpWBWfAjbW8VgKRFgkqC+7s7yTYUMrKIDAG/S0I
 DnXGW8efDctXijNj4LCfhnLQ1VJvR4ocygXAYUn6VbnnOt+q1x0TqTHBLx8fc+ko2sTuIlK3ufD
 ECBV/Km4zjC2AHt79RQkvDSFpC1S9vHVkVsLeF2IXf3Rb6KSZDoH/4PhGF0eAG0cMAAGttPxzmg
 F43B5kgSivGp89sX7zXbGc62ZkBR8AptBDPDGRJ91BNMhyxOoi5pDB2ZCtSV5dFGMNee7RRXtGk
 uWx/XxWZ81eXqiFwLVw==
X-Proofpoint-ORIG-GUID: -u-VcOJ4nia16p9w1Ot-jTNUY0gTddWM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX4ZFSRg84D2aY
 zLqEUcJQJ81NIsZS2GFIaoeaHvMStbsioLXZMKBkh3/7Gycy5gJ3h2tipqIQL9iOrTQTL65Xgpf
 Wn6wT47KMOZtbn7PsRYOMyt7JFhv6v8=
X-Proofpoint-GUID: -u-VcOJ4nia16p9w1Ot-jTNUY0gTddWM
X-Authority-Analysis: v=2.4 cv=H6TrBeYi c=1 sm=1 tr=0 ts=6a4ab34b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=FVZLpNCcgjzkSGVc8gUA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607050212

Use the devres-managed devm_of_reserved_mem_device_init() to ensure
the reserved memory region is released on device removal, fixing a
missing cleanup in the original code.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
index bc0a63457cd7..52c3381e6766 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
@@ -3013,7 +3013,7 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
 	struct reset_control *rstc;
 	int i, irq_id, ret;
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to assign memory region\n");
 
-- 
2.53.0


