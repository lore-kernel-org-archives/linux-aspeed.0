Return-Path: <linux-aspeed+bounces-4392-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79FDC43458
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Jul 2026 23:37:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtkR400wZz3bsS;
	Mon, 06 Jul 2026 09:36:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783280456;
	cv=none; b=U86Oi3pSFdGnXOOj0LC8dSxtXPkNU4rheHvBJH5rJfHwG9sjqc+upFr49y+J2DWwQVQtQ33vkIIaWccThI9aT4nLlBHpvZBHVszFEa3KQgIQxCyOvAbEkRVCtNLHTOSQtLscaDE9zIdxC5TW8435OdXlnQdmsuctTJXhRrn78+VrCgZnhbGfFEPy5uy8/mzteIDBocyg+3Ldz6s6n3nY5dzqHOzeE9n0IsJgZvCFZ5ORk3dTt41Czxq9RmhwDmVDJmNsa1u8VLbRpmNE7m1qBpFbI27WB+LIadkb/yKqi+55haycK3cPhAV7uyjYOLVsE84+gQtUpAKH7x8sIlOrKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783280456; c=relaxed/relaxed;
	bh=hN6fEXJ0a4tH3MRwTjmjwBZxQ0G8Nv14FZEH67BaPoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEmcPJe8UVDcaai0BG/FufCBVIOyQr7mtSrNMJ2cqiTqRAEL+EJfVPfOKZL+QQ63uEMWTRLqh4AkGhv71R+BS8E2SKUHW8XOeY5ikQWeLpXMw+rUoWIltaTeELbzv+SBucUzLjvImNZ8a7ZIDiLF/KaQLWNPWFKmI3XIIZz3jDCUC5POjC1l7gwoUYKKJZweMWW73Tq1LjIEIfZrYWKyV6oknRV1487E9oHr+qUjRzNe0GYE76c0rcFn+tak3sWdXxidoW/vhutgNcNcOh5FRVX4BK69NVDZpoxTE9DX+21F+eYp7OI9zkQtaQMD/iGe1+RmsGQssbPgI/VWafDmZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FtgGyEI1; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZJrjYBG9; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FtgGyEI1;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZJrjYBG9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtdBv3xQmz2ydn
	for <linux-aspeed@lists.ozlabs.org>; Mon, 06 Jul 2026 05:40:55 +1000 (AEST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665Hj8vw2317385
	for <linux-aspeed@lists.ozlabs.org>; Sun, 5 Jul 2026 19:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=hN6fEXJ0a4t
	H3MRwTjmjwBZxQ0G8Nv14FZEH67BaPoE=; b=FtgGyEI14vKK9OqT430xUfOmGLF
	J5bdRwGnYlPPVp42isHulDlrVXRumzlXOnWaKAvEqFlOMf4WK0t/UVb0tPS4H/wS
	PtxzMba7S17DNMo9ExtOcv+rJsW93dNgj/CIpMpvyCzFyneGj05+u1GK8iECoqyK
	WM1mPqrqXajrrVrH8/J9pdvK2VoDaXNIt2t74egeo5x9BAqNhYqqiB5QdwrFv+QG
	jv/TZ5nh6enGJUvvqqxYx00YdVL+37mb/7PnZAc+8iS+maLp8PJIHST5NiO92D5M
	ugD1/b8iFPnLJM/Dv5JgaqSUO0Jj7Rg0n1nlkl2C0BeSOL69BMELnoL/dgw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6t8uk9t4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 05 Jul 2026 19:40:53 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c9667280edeso2774969a12.2
        for <linux-aspeed@lists.ozlabs.org>; Sun, 05 Jul 2026 12:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783280452; x=1783885252; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hN6fEXJ0a4tH3MRwTjmjwBZxQ0G8Nv14FZEH67BaPoE=;
        b=ZJrjYBG9YSUTtG4KJ3Eij59kTqyM01kkR8kQk0erLCloD5h6FkOYakxNMsOyf2eftg
         JsNtsXtc2pM4Xd2sYntXRwSHg7wQ2HvHR5rLdkNnGkKvroOzZYEeGgI8ooBlQCMTtc1e
         1wFXdYylGg/QqTWTjqkNg5T/J2O+eNO67ey2ruLOSXdcWH5ReYSseMuak98AbtgrrDFh
         oDrPDaUzqUrTrpY9mKMaYpLW22KpvCOMQ1IW8pfeW2PStnCdjzW6a7HzioA9SOT8tKE/
         FYG4H/k5Jd+OEIuxqXaAQ/xjLL6EIIEB0Q/0D91lOQcciGchWnIaQaf3CC+LyB0BBUuH
         3zcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783280452; x=1783885252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hN6fEXJ0a4tH3MRwTjmjwBZxQ0G8Nv14FZEH67BaPoE=;
        b=VlL0sgMCrXGx2ehbfYr4DexlEaPtpNxZBEgGHxm3scocLuZ1XgMw8sKbiIKfO1FfTP
         LYNhxIIYFeyHlhSkpxEBPd4UYO/0ul5ertrsLsUTTZzC/d5372myvS6sJhqiwFu3T/oM
         jvGYxW/MI2/PvpmWMXWYabPNVNWbwf6y/vUFPeal/NCU5cgbQKUZKzKPTysd+oooBMw/
         9UdcaF3Rfx6qPO3DvWC7DKZwQgtLwxJfMFSlHwis21T0xXqFNK4weOFoTdDxJksRRoQ6
         M4/seTxzstBj9MQHWh686poayc0nvgH+wHngF48HFtmhW13jnLfKNlatHFuWwRAsHKMx
         fGZA==
X-Forwarded-Encrypted: i=1; AHgh+Rpf5t0bj84wa0XlNT/5IjRqF31WO7P3xRkQxSNl3xKe/m0rOM9EUmT5LkjL4l6dqt1g/WnqqDJRVPQGyXQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwLeuzUIDSIaUEcdClkKzUf6hvCoZJWd9Q/HZ+wfXNQBE6sizPV
	m070i4r87HxcDuNzLjqCCn+RX5LTNOyjb7akIco76caIu2XATGpQRLfciHyA0dI6cmq0//NCAfh
	TA/RjkVXGrPuwR4ev36D4LwB6cjyANtZJTDozt1ALbccDlPNAZEX6U8Ohy+EI+J40Ordp
X-Gm-Gg: AfdE7clbna6wO2b42vquX4uqEoXrzuTXdrXKOhlxyx4HENHim86ApBd1sJgGzf4ZDoB
	8Nc397EfmWJcTG53qGpQBg+O522K4glkARB0nLdYS8+5JCEZOICehs/4L3M0XnT7ALiEV5Yo24V
	G1mIWQUGMZmRwCs7ITK2JQGTT30N4eIgvmNNc+mDIbdlb1zWhQd50ETxaLzN4Pve6I/K2Ph2ZfG
	zbOyxaBAxkbAj9gvnfwIRBUfdRXvBqh69QBHgsia34n1L1HAiZ/qsyhCjL3NYb0OWqtcNW+raYy
	/wz6oSWAuzSYmWDa7SaoHVv6MK4K7Q/N7+06zijCXiQpaUy1+8QxtWN3iRnWXkhRgHgPL+G5f9H
	oKkuzhkKqi7/3rdMadIH5zjAI71wp2dvd1Ep3tg==
X-Received: by 2002:a05:6300:670a:b0:3b4:9171:2573 with SMTP id adf61e73a8af0-3c03e4218c2mr7386827637.37.1783280452363;
        Sun, 05 Jul 2026 12:40:52 -0700 (PDT)
X-Received: by 2002:a05:6300:670a:b0:3b4:9171:2573 with SMTP id adf61e73a8af0-3c03e4218c2mr7386810637.37.1783280451853;
        Sun, 05 Jul 2026 12:40:51 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:40:51 -0700 (PDT)
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
Subject: [PATCH 36/42] ASoC: mediatek: mt8188: Use devm_of_reserved_mem_device_init()
Date: Mon,  6 Jul 2026 01:10:12 +0530
Message-ID: <20260705194019.2565498-4-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: D0CsqwSlvFYwQB1kRnDkbuPRBlJgtuO0
X-Proofpoint-GUID: D0CsqwSlvFYwQB1kRnDkbuPRBlJgtuO0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX+l1Lv8e6XBvk
 +Ec4yxyqYXOWhZvGVOw0hZbGyeXWjiOnv/3iEFSU/3BLfS2tX9PceW3aKB4u5qR4kcaWiU7WehV
 77gOwBiPXG9JPK0tViQk9wtBuxqQu3o=
X-Authority-Analysis: v=2.4 cv=MZxcfZ/f c=1 sm=1 tr=0 ts=6a4ab345 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=16fIdGUa3qEwhQSg-dQA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX8cT8slg2V/cX
 S5xcK4h7sTQSLYOoJIyjVAerLIiHlnpylO1Posu8VeNLuhHx3zpht+HKqBePQ+ZH3CjYYZ773sz
 zkCp8ZjkKs2MjXlVVUkUXxvQjEnlX/3UIkLWL5TeBo503SABWf2prHRWA2ur+jPyH2adThnu4r8
 J72mftOBmke7J6QVxThVIqGySx9Iltv6g7D/OhOpuj1BqHnxJuUeSyuIwV/vFfNRjLdILcGlMj0
 S24/CZYRCoN8PNUVmudJRcOKmOCKuzOpz5wA+ceaNAO+EOBrDgaBs1FbcvHrMxXczGGMrUOuzh5
 mIyVtEvG7KbKhVYDrZZG2SmPq8yAPFgEPIPT1bXkr2543bngFfFS/D23Mk30KozEMPtBfI5dx2Z
 IOE0JmZMymXP5ZSJNzQbzEen6PWgdA3cChWmBMG48ALwrHhyTzStBWhZry95cfIF51aJ0PWQIa/
 DqTCR30CEpvjuBZZ3rg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050212

Use the devres-managed devm_of_reserved_mem_device_init() to ensure
the reserved memory region is released on device removal, fixing a
missing cleanup in the original code.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
index 7b1f5d05f4d6..ab4ce5e86b9d 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
@@ -3199,7 +3199,7 @@ static int mt8188_afe_pcm_dev_probe(struct platform_device *pdev)
 	struct regmap *infra_ao;
 	int i, irq_id, ret;
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret)
 		dev_dbg(dev, "failed to assign memory region: %d\n", ret);
 
-- 
2.53.0


