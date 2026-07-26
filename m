Return-Path: <linux-aspeed+bounces-4566-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C876C53209
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Jul 2026 00:07:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7f6z4rkXz2yd7;
	Mon, 27 Jul 2026 10:07:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785095025;
	cv=none; b=F7b5vJGDz5qcmXNd5ef62Btu6YIPORaGPz1qjKS8vSaE7bi4OzDYD898cS/lgQaZUPnt0AD3rTW4Iyd/jU5Qx/7wTgJScOnGS2E76XmMPDE+H9QGsf6JX89lrql03Qe8ra/ATmQ1utEaHDvf58Qs5r4YHBjVB4OLLzKGvYtOMASOhvkRggTINNNhp9nvOYWWHZKed+1Tqx9n9hcWcdXW6tXUCPzZY/HzqOBomJKglTH3z043AlYiP4yQUlu+iKw+n4ygTnmCpcAgkFrrt6+g3MMauZjcr0KLIOSybvMAe8V2cbtik70EyhF/SqXakpfiDadjQ2VEGTvKyZhZ6kyc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785095025; c=relaxed/relaxed;
	bh=CNoRgYHBQCH+tsjxR75Szw9VyLMDvEKRkPSqMXEGBh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ahnzYBTmQ1GxNenstf0XkEBYs1ytKoNrmF4O/6p1I6MTkuiNeUcAf6IQT0KraFNHlf+NLh6eiqmueFwy3vAFDOBLbjHZ9e5eZH0AUH338xM0GI6Q0NsSMlapX7n8iZIFSYQLgjizPT4nWDY2upmfnUFztADfacwc+4/pOowZckq/a8c4oGjR0yl8I1KVjf0D71B2hjambgbWAGYpGtqbv6TXzDDqQ0BZCB5y4+dXs3SDAVZ5ErPY8YapgBVzsinel/ahK0MQt8TsTR3ANeujPoWqoaEHWAhn71JeH8/jpUNMBp6O7YUZoO/3TTTyckIUd0UEXnU22PRoiJZVXFo66Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NPm9kHgZ; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CzLckuQj; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NPm9kHgZ;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CzLckuQj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7XGT2Ptxz2xWY
	for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Jul 2026 05:43:45 +1000 (AEST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66QH79ms2353114
	for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 19:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CNoRgYHBQCH+tsjxR75Szw9VyLMDvEKRkPSqMXEGBh8=; b=NPm9kHgZsDf1LGlX
	jzlVHtMg0YUIG18rO33jutaRk1yFpZdsfUZVRWXI0ghtaU1/yaZpgmvF1zkkIkMO
	Fx/GEM6lleoZ2OcTLU3bCQDNV8OfTPfNjRq65BaBvGXKNXhIMzq0ln7rci/Qk6fr
	bhHa4Hm6Jd1qdtFzl/Ez17lREMOW1lrfDBpw5evnVY9Xoy1I6kuZkcMe/VXEJ+KX
	Pn0yKJyoOgri+0JqUjlVmDNy54VMgGwyHkj89PveR+TywEoAf/HLoQ7s4fPsnpUE
	ysQBHzdtZRRTpsO7e5MMXpwCaF2Eic1vfLqRYDOcebT3rm1E7+C2mEIsQneM6hEz
	vMj/ZQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmjufuskb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 19:43:43 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb835525b10so2464716a12.2
        for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 12:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785095023; x=1785699823; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CNoRgYHBQCH+tsjxR75Szw9VyLMDvEKRkPSqMXEGBh8=;
        b=CzLckuQjP5naJiIFy389TDKjbbeYLPiIRrPOpBrf5yFxeF6DjSfjLJb/XP4twtvBx0
         JM+0QfXmaDJ7zSQhMw3Q3Z9EWAJUGMxcEcd+iavZ48tzLAR80ghUIApc84Qwq9w8hc5U
         CEnUlGQG9SA+rP6wJthoT1CWXlzGbJi5yvQDTXMw6ONDJ/Ciep76oXt+elkZ7cdcpH9K
         c6De1PxS4l/NEb/da1Jc+dVgHbB+3bzUksdqgqiuaYHU2MSZE0TmwHuvq9uUSxpnVwyE
         cBpon+Uz/IJ0DqYT39nRCJs2zXhK77WUMzSc0Vn1QY1dJZcnZ/tvQ14ec7k2Ul+z1qc3
         YdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785095023; x=1785699823;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CNoRgYHBQCH+tsjxR75Szw9VyLMDvEKRkPSqMXEGBh8=;
        b=X5fmyWtSY4R7PD9wvj7kn0dauDmR5yJ0ZR4QYOUOq/JvzGYw/MEqdEnuQvoYRX6tF+
         RlfTlA8zx+2AhagxGNOHJmXqkfXlsU+TFBYLNUmwvsyPxWyy+1getGHbcWwGV5hErfuc
         7Bzbda4ZLCRNeDVyOU5h2GBc4AM8kTma36UbiPa8CxJYFdz1QtnCXqdEbPvdjfKdpcEG
         6dxIHGmvX8wUXX8AYkXKYbk/OUhgTQzqYBof1lMWK1e5CkqQXjZyfnjxqAU2P3fBavtI
         e47sL+1D8qYKNX2zPtWCth4citBa39doDWum9SMulgyURwVyAxvkvFYUq3G9f3NBEDAD
         OO+A==
X-Forwarded-Encrypted: i=1; AHgh+RpgVcMzRU5wGjtGWnyfl5/ktEfx4kdXTj1aMf7MCjiSnceGF/4qznf2yTJMIQT7yJS8NyHIvRznEEdIsAc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwdZc2hJ5JVhkcZnoBBanQqJdSo7se6tfK35xA9zIJnmo+QroV9
	ki+Aal/wrT2LpTXEkANGoPqykEe2+79kAALZV9SiSfPsr/KYTeX09ETn0gNDb2k8/ovBLAIQB7S
	UcqaD1DvNGmwJGVKB/i+h5ZTDDhI6D7j7nVtzyGloMN2IiT0Ze7iGEkfdO0PasFqcWVka
X-Gm-Gg: AR+sD13HL1mbvL8dJBzztBVHNs1EmyOLoiA3nqKYUcyoqkAH+UFYcTCrybYYLeHcHu4
	pM5jlUgmgCHeTWjcyoJGzD0OIgc16MnFkTg02vI+HmAEmP/TgnxUxTrjWHHlI+OZFLFTgNjWA9Q
	dHH+ORf1N98Pd0QeWnWEsHTF0zx4NvdowskCJRFqMrD2iKWH/38Fvxt0Qaoeq4C6IOi//lTJ4Hx
	H8/3/NrsfMSEAVhGz2ET/tM7dVSXzPWzViaoVWFw/03Sb81xjz4UFXiVvJoeL9gbPR/syqSQZkd
	Lfc8oTdK3DFwtvKDXJoVz4FS31WbzXaA9iP3md1XnUZIZc2K8qWqjeC5NIvO2JplowBPetzp55B
	pqK05K940cKjYXQpBImCq
X-Received: by 2002:a05:6a21:918c:b0:3bf:6c08:fb85 with SMTP id adf61e73a8af0-3c67e0e92fdmr5593391637.53.1785095022538;
        Sun, 26 Jul 2026 12:43:42 -0700 (PDT)
X-Received: by 2002:a05:6a21:918c:b0:3bf:6c08:fb85 with SMTP id adf61e73a8af0-3c67e0e92fdmr5593377637.53.1785095022117;
        Sun, 26 Jul 2026 12:43:42 -0700 (PDT)
Received: from le-cd01-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb66dcd38sm2312070a12.29.2026.07.26.12.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 12:43:41 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 03:42:32 +0800
Subject: [PATCH v3 1/2] drm/imx/lcdc: avoid duplicate clk_per enable
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
Message-Id: <20260727-drm-simple-kms-removal-v3-1-de36e534f7a1@oss.qualcomm.com>
References: <20260727-drm-simple-kms-removal-v3-0-de36e534f7a1@oss.qualcomm.com>
In-Reply-To: <20260727-drm-simple-kms-removal-v3-0-de36e534f7a1@oss.qualcomm.com>
To: Alexey Brodkin <abrodkin@synopsys.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>,
        Hans de Goede <hansg@kernel.org>,
        Alex Lanzano <lanzano.alex@gmail.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Marian Cichy <m.cichy@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, xen-devel@lists.xenproject.org,
        Ze Huang <ze.huang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785095005; l=1575;
 i=ze.huang@oss.qualcomm.com; s=20260716; h=from:subject:message-id;
 bh=0iliuiHXJ6h0/St/QGB8FSTuTPg/hKE4ZxbThjkpOEk=;
 b=nuCUHzR6KH+1G4beZzHutnnOVPquBUhtAMv7nYpAmPcJwkzLDxQbdplnG0zdIkeIj2bMf6cbt
 akZOj/szyIRD7rXgAh5kCjmvJ221hnITo+m6kuUDxyG75FWxOXTdMnr
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=8uGhlZHInA8NXq7G6u/g59qEcwXwuMRI7nBSnT/ijtY=
X-Proofpoint-ORIG-GUID: hL7mdHZ_pr8ZejlqLMlKjGevNAJOel8J
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDIwMCBTYWx0ZWRfX9xh/NtvTmXe2
 zaOaPDmqJCJGTPYHeZpPelsqVahyhsUxY+/d5ZxgAFPxgKvEjt+KpBgQFVzVhIYOyYGYBZdBhD+
 2ZoGV/dFzQPH1dENPFYxRgcsZReubNY=
X-Proofpoint-GUID: hL7mdHZ_pr8ZejlqLMlKjGevNAJOel8J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDIwMCBTYWx0ZWRfX0AzOiVIBV6S4
 L6+rviQ3rjj4Lq50ug1dP8Uqsm5oLFjoBvRbCS/IoUCgJwj2k18xQfnQQ13nGWh2cg16F+DAGt7
 Iy1298ryK2ml+z69b+zbNPMGSkW33Tb8NnzHsjPHHHOorw4jpZX/cl4G4dyiwDQThbF2RLh/f17
 y3IHWbuo4tBGPKGxUq4q9Kcz40L8q6Wdue8oY5X2yRcrw+smYD6pox/0uRH2CXQtCHc8HWHQLj/
 +rlaCbYKfnzAC0A2V7/9v0inEoa2UVunS+nq9r0E7pRRy3E18Pw/PGnFc0oiZ6RBHZv9RlQTBrU
 CEUOC04E+5CfAInry5gUt8DZh8UpRU1mqcMv37arawxBnsI2iArjtfZSzDZ9UvOjpRgqQrtTqeZ
 bsSeI09ovgxdzwjocN9U/YN2CBThRJ8tMjICcI87Tx/0Lv+jvPMJsiVlssHLiMg9S7JeWODwMST
 oozWK14K43pXGwlqbvw==
X-Authority-Analysis: v=2.4 cv=F5ZnsKhN c=1 sm=1 tr=0 ts=6a66636f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=xnl2VaEmiNnR3tlLptkA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260200

The simple-KMS helper calls the pipe update after enabling the CRTC.
On an enable commit, imx_lcdc_pipe_enable() already programs the
mode and enables clk_per. The following pipe update sees the plane move
from no CRTC to the active CRTC, treats it as a mode update, and calls
imx_lcdc_update_hw_registers() again.

That second call has no old CRTC state to disable clk_per first, but it
enables clk_per again at the end. The disable path only drops one
reference, leaving clk_per enabled after each on/off cycle.

Skip the register update from the pipe update path when the CRTC already
needs a modeset. The enable path has already programmed the hardware for
that commit; keep the event handling in pipe update unchanged.

Fixes: c87e859cdeb5 ("drm/imx/lcdc: Implement DRM driver for imx25")
Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
---
 drivers/gpu/drm/imx/lcdc/imx-lcdc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/lcdc/imx-lcdc.c b/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
index f52832b43aca..81024f7d9e96 100644
--- a/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
+++ b/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
@@ -311,7 +311,8 @@ static void imx_lcdc_pipe_update(struct drm_simple_display_pipe *pipe,
 	else if (old_crtc != crtc)
 		mode_changed = true;
 
-	imx_lcdc_update_hw_registers(pipe, old_state, mode_changed);
+	if (!drm_atomic_crtc_needs_modeset(crtc->state))
+		imx_lcdc_update_hw_registers(pipe, old_state, mode_changed);
 
 	if (event) {
 		crtc->state->event = NULL;

-- 
2.43.0


