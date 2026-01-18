Return-Path: <linux-aspeed+bounces-3382-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D20C98315
	for <linux-aspeed@archiver.kernel.org>; Sun, 18 Jan 2026 23:21:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvV2Y0CZ6z309y;
	Mon, 19 Jan 2026 10:21:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768759818;
	cv=none; b=BRCnWO+thSEGEmKbYqST49zMDL1Of1o8vlPi2ZxyAP6WrJms71rvSd7qQgDC+vUy/c7423HRwDy1iSv8MaNnH35Qz+LucnfH8AGuMPqTMPAaPVkLzvEAbezuE3AB2tqXpmxrVCfX7xDbLQS7uNk95R1gpWgs4i+Uq8GrlmD+WCmomYV5LjSq/KfUuNmMQGoV2tAIh/rAySN9rZM+PciXdB4ANt8VHuDEwTgxR6Urli7s7+Wdn2sT1LOxZKPTjPPiSDKRm9pXx6VgpB5TwJPbu43f24hIxa/MJkk12bh8WOzxt4rbiXOZhGofd/W0AUmYtXuCM6xWJ9QImkqk8Wf2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768759818; c=relaxed/relaxed;
	bh=N8rDVtwaqFFOKGAdA8c98jUQvXsuqYrjM/OKm05D9ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mWMtAUCAl1ZPnGErBrBr2f+nr+H2U+SkYPAobBmsfHlStr46pQRMCbEqrITnIui0AMXoEwUqYh3a2ZT7QsiM/M+em5c/0EHTPsXWb9SFu4zIcSb+ADOr1ymb2WTqb9SO44sRtrNy6Pmx+CB3Be4uzRWb6vtSaLbT78tSgWSZfFCJ14l5cnY3FP1/XRckBpcdIXo1ZMGz7NYeaSkN6gusH2N1zfElC9voV3uHuGzvW2wMjjYJrEcAaogI1LloH67/rXSbi0u89jdWj0EvLrWuLiaJ4zAoHgJec9Ew663qq4fE6aNIVRvdjQ3vWbcfZjQ6LccuyQE31jNHINCTAyg3YA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=japKNcnf; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bSuGrl50; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=japKNcnf;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bSuGrl50;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvM7t0xN5z2xpt
	for <linux-aspeed@lists.ozlabs.org>; Mon, 19 Jan 2026 05:10:17 +1100 (AEDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60IBvKq93171885
	for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 18:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N8rDVtwaqFFOKGAdA8c98jUQvXsuqYrjM/OKm05D9ak=; b=japKNcnfAcEprVtV
	0bUawGTTXZfbthfW6B3TsG8SOrANCsLkg7+/n7DXtuSnDQSKAnz3usFRiyGjxOj2
	+tPoYHPy0SDVDav2D8OMjbHMnyAIRUOJCc6YT7Ti8/Jsu0oJRI9rek6MgZf2St3c
	heEzwj4GUyubAeqSY6lo5q+3kGDRU7stWSWOAZ2olHVwkhtTkyTRJpQ1rr+wzOHB
	+wVhVSdyTbXGW4rCcE6MUCDGhhR16OCgC2i5uhHVrodFaAum1yFa5gvt3ks8eXrZ
	m2q+iBAO2sdTs4NNckCqDI+IQx8+BEUWCDxfo5lF8Ut1fbWYDdG0O/PFOwgxIs4y
	0wCOwg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br36darrw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 18:10:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c5297cfe68so689265185a.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 10:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768759815; x=1769364615; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8rDVtwaqFFOKGAdA8c98jUQvXsuqYrjM/OKm05D9ak=;
        b=bSuGrl503EY/ChbBIoH8LG/IgQbeHSU14DwKQydKrXFO3RT0c0qYFCNc5y4wkXZd/1
         GVyEeBbhAr1/Aj2lyltMhwtPb99bdxfNX43mQ8Z5sqDPfdL98XgS8KtruNrkDS6Q5hJg
         jCmNl/htBDl/zxhX0OPgKVovI6QHI25/sROQzv3k9pT2GT86EIt1YYY/c6D7nCMqT48p
         spiUSqr0i8ZApXgD/z9WyDpFXnutr9dttaKPQhgG+nkAZxM5xnZ0cQXerHfwEsGVMz8d
         flmj0uAChWzB1H5y8aGLix8H2h1QsnkV+N9PaNxxE8cjKrKSxWHXxL/NeXnpvjz5Xq61
         olPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768759815; x=1769364615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N8rDVtwaqFFOKGAdA8c98jUQvXsuqYrjM/OKm05D9ak=;
        b=EQBM79opHV8zfrXplTbsyrNhvhBLAXw9iyV8Al7w5TYv/FSVLxiB5l3Yw/aUrVV261
         nh21DyBhiNByh8WNHP64edLCaHeXFC8VO1ACEpzXrfdgC+g5cy6z4pXhsx210vxiD56d
         P94juFAX8Lo0rkH3ap+eGD/q0QfbK04rcoXrXUMGbDP8iV51INS9fvqFMpRw7lCdRDkn
         lp0NVLJYJ3ME3PAPzavfyCd5PhhRojz/3bqG7q5VqfwQRc0DNKilQjqZTIbOPyrVLiIU
         DgOZ4MEhXNj5nnM/uE+uwqZUkUw3tVJdI2Z9PT+ZvZlYvsbABDNTQHFwOufNsVZFn4RQ
         q2Jw==
X-Gm-Message-State: AOJu0YwL2AZrxQw2gpmbymYBjo0btcS+5BIpWoXNNlhF3xHjqvBRzIM2
	Aw6gncA/NafsusWuOdqqhgYicDe0OOUU4TCHykRJeoS2dC6Oq8tN1VTOEi5zg0jpgRErkQrnZeS
	BglDc5Pum0/bua64B6QRLttOKMt6w8P+wk396mJfiH5/R4+AD3IRjxCCR5t825rXDC5I0
X-Gm-Gg: AY/fxX5IJ2nKk9nwmy10f20Ehix9+Dv92NeQ4hVGgpkb4THQ5gW4GPJ9wYXv7/0DSii
	CUmnDwr2J/yHgDAGfbdfWR6xB6PPxs5TCP5PjnTwHvtweD4wjRTx48+Mkd+WTLLK7K2xGGI4Fqr
	4XsRWNHeG8IX19akWNaJ447aq4WUjIbfH8U69OR26CqkJaga4wL1HhXBIDomh9AZ5Y777jkNMna
	L7JVTR2gFcWi0iTyepWvaBGw93XAVGgl9JMgRH7X5BO/HSUseG487bLzusVG6vptoqHa67rPTgE
	GdLPHbAn6VpAN18KWpenZkF/UKZxtSWkL4iBD+30L2LNnfrKixWytdyj3xBNVpfc8h0ujvmnvXs
	KBghaRBaiVZhyEM+Fr0h7ra4BvoVo0RZ2JQ==
X-Received: by 2002:a05:620a:3942:b0:8b2:dafb:9089 with SMTP id af79cd13be357-8c6a67899b0mr1275475085a.67.1768759815261;
        Sun, 18 Jan 2026 10:10:15 -0800 (PST)
X-Received: by 2002:a05:620a:3942:b0:8b2:dafb:9089 with SMTP id af79cd13be357-8c6a67899b0mr1275472285a.67.1768759814840;
        Sun, 18 Jan 2026 10:10:14 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe44b37sm62162085e9.12.2026.01.18.10.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:10:14 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sun, 18 Jan 2026 19:09:29 +0100
Subject: [PATCH v2 06/11] pinctrl: microchip-sgpio: Simplify locking with
 guard()
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
Message-Id: <20260118-pinctrl-cleanup-guard-v2-6-bd36f681bdc0@oss.qualcomm.com>
References: <20260118-pinctrl-cleanup-guard-v2-0-bd36f681bdc0@oss.qualcomm.com>
In-Reply-To: <20260118-pinctrl-cleanup-guard-v2-0-bd36f681bdc0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=7TcfQldnwsgDeNj9THUL7ZJpvo8wBH6EB0ftex+EuCs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpbSHzNyyJB2/5YcDkWVD78wo4fivaLa92BnhNE
 zEyQbnq1T+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaW0h8wAKCRDBN2bmhouD
 1/+ZD/9dLR0GeZEUoMpu1fyeS7gbRrh/E1fAhv5P7K1Wy6+T4QuZh0GJyRvYYNMop2bEXE+o/zg
 m0aJF5TNvzHCDEzDGh3hTWMW6zhEfdRW1x+41NwBiV+jUGVIHWeFXu64AMbTDIAep3SiKsUu5ur
 USeXISCYy7enjRAKdOU7c0fmdDnDnSSlMVF202nX4sHTfroJF4BlimVIpWz9/ILOSA18ewjMxl0
 PaymU0l2amlmpZmIpE3edSB7zCVqvIGVyl1rD1g1v3Slmt66Wa0oJub3si4o9gWtDj/1mE2HGW+
 YwsGcKQ0cx3eU9jda6IccRxjIrd1gwgf91zoZT6MdePaW7LZKOUWQ3TuPyA9SppV+7mNXJ6g7fg
 5iv4i/aSKv878Z/9BjfRec+iDlhMHFlE1U/0TNLeQEiSePRFjzQkBZW/VD8h12mdLZyJ25RIeIq
 zcvbjxNdMPYNXX6zyo9KpdnIGRzqPn2eow9j7Ty/MvWaRS2UaQldkFjErgbKNlYyLyF4xueV36m
 JPYBzgnsAenS6V9TUf7bUvkG/jLLhifIhTXucaqJudGLGgqioXPok09zN5scbaryZOnU3poSZa3
 r/njGSPDgsJ/i0ZuO82abROFWzVcuRbleDiqZ1V1y6SeGIH2EV1SlND3ueBORj8RHgxVja6hguI
 G262GYY0ih+1KCQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE4MDE2MCBTYWx0ZWRfX/LO4oZkVpfVb
 afqpxew3p+gFXcVYmnnkXcKylv9p3yaDWgtzXPmY+ZuIZNGedhi/i0KMiva4B/HP4LqW6ugmCcF
 l6WFOUHgOnEyssBQkpaB3edZx+H1l9RGEhebtwCbx3y5azAr2kIZ/z9y/jvxuStKXo2GiUvP0M0
 9BygpzKZvK37kk1JRfB7EuQvNDZpRSDQWlf3QEElO9n+WspnlSlDjPwCHU8VXeft24DeiX3zqJO
 sc0ZZk11jYx/04iZGl1S5SKd0FLxvNBTONhhSaLBxJgd54s/VCapf2LChK+vzGuIgqgCD56bqmK
 RtmKE1Tyf2opcQgNDRBlxvYX1w99/cHW6PSRGfaQb9hRUROfFpbC9eToP/9ZCC+kZqmWvVqe4lW
 7QGgMYebUUbl3ZsfELIhwe9SQ8F8JjbubZ4LMI53+c9zzE/PGPCdko/BcOv2AAgy9o50NDLwRWi
 Nk1SFr7MXWJEX9bVFdA==
X-Proofpoint-GUID: vXWFjiGQDU-0J4Y75IFUtIgzaQH-3pYg
X-Authority-Analysis: v=2.4 cv=GJ0F0+NK c=1 sm=1 tr=0 ts=696d2208 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=6VTnscBjb5kX48BWP-sA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: vXWFjiGQDU-0J4Y75IFUtIgzaQH-3pYg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601180160

Simplify error handling (less gotos) over locks with guard().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/pinctrl/pinctrl-microchip-sgpio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-microchip-sgpio.c b/drivers/pinctrl/pinctrl-microchip-sgpio.c
index b6363f3cdce9..7a6cb5f502b0 100644
--- a/drivers/pinctrl/pinctrl-microchip-sgpio.c
+++ b/drivers/pinctrl/pinctrl-microchip-sgpio.c
@@ -264,19 +264,17 @@ static int sgpio_single_shot(struct sgpio_priv *priv)
 	 * setting.
 	 * After the manual burst, reenable the auto repeat mode again.
 	 */
-	mutex_lock(&priv->poll_lock);
+	guard(mutex)(&priv->poll_lock);
 	ret = regmap_update_bits(priv->regs, addr, single_shot | auto_repeat,
 				 single_shot);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = regmap_read_poll_timeout(priv->regs, addr, ctrl,
 				       !(ctrl & single_shot), 100, 60000);
 
 	/* reenable auto repeat mode even if there was an error */
 	ret2 = regmap_update_bits(priv->regs, addr, auto_repeat, auto_repeat);
-out:
-	mutex_unlock(&priv->poll_lock);
 
 	return ret ?: ret2;
 }

-- 
2.51.0


