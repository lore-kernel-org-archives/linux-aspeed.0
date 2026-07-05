Return-Path: <linux-aspeed+bounces-4387-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31D0C43458
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Jul 2026 23:36:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtkQG4zHpz3bqs;
	Mon, 06 Jul 2026 09:36:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783280487;
	cv=none; b=hwLOkOhxsSr5M58ldSHsEzwJB6zZ7Kgex67feLNSe6U2WJGJQYNnU1s3UZ15fSmjSqOanGwSFZ+EfDGcSIIUfGKzpYfH8OnDm0icegI92XaoHW2qxOpXXU+NnTtGncRvIB/YtWH532RVaWdKGmdHLUtjantCgOWPaxehbE1PzlEjXcN3Ny8ZvoMIrFxB52iFMNrcHHCKxWn2NYIGzFjmw73gVVD4oLtcALm4xe+n0WY+LR8HiLvpEzP13iTlGdHRWIQUxTXJnVP5bB+iRVB2nUZRn+S1rZU/UXGR8Jxc6lK0RyW4cOYuQzKhctRPQxpiJmvhqv3tc+oZVqWfBYlsXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783280487; c=relaxed/relaxed;
	bh=NGgGvwnqAVQQEeBPG1kTtk7oaNyoX+6Tcm1yJclm2Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFEW8F3dc+Fl8s14lf+F8TRWB1DrKc8bhzTx20ezMoes2YLK01gItK7Z48Gy1YDJ8RDuebFrE5dUMHhXfAe2gSJxP+mbjptYiS1gt7qIx5e5TRFCoCYVclbWPhUNLTUMb1oJJA+QGDHBmJ4folAvv45LjxBMBzIa52yHSYUG0EYD5okOE8+1ddVWOkRLC2ThoDdBIPPXjB4DYFWVH5qFBowKWX0sGJ35s9QM8UtWmBPPD7akVubQt0kDCNlT/YTnf/LD07EHG4DKOnGEghKhiG4iwYUX8zRD0R26dtACa/lKXEk66R5oNr314lIzkPBAcx239HoFs26Clj6n9ZmDkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TLn6zhut; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OmpRfAVr; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TLn6zhut;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OmpRfAVr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtdCW02wPz2yhY
	for <linux-aspeed@lists.ozlabs.org>; Mon, 06 Jul 2026 05:41:26 +1000 (AEST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665Hi3vS2190511
	for <linux-aspeed@lists.ozlabs.org>; Sun, 5 Jul 2026 19:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NGgGvwnqAVQQEeBPG1kTtk7oaNyoX+6Tcm1yJclm2Pw=; b=TLn6zhutzCtePBXP
	eApN5L/sdm3XfMAHOZhP82YsbqE0e2xRcEAFk/+OzouZNGNfc26qhw5knDcbPcel
	BP5iZZDUvJOH4Kdt2QhgKPJOeoScqNJcXRyWCHIYBBbsIEBD0ZiVVQvHgMHBpB06
	KDdBLLvkRr12JNjMqEtNLmZCzmB3HEASAP+zwk9LWIkse6JF6XJ5aE2oTFOlREXB
	HWsjh1ZGAPgsRx3a1N+Une0Zk6nBS+M8q7Nzxb/+beCfZqlUhL0J/8be0mCDgioR
	WDJzt0GGrulk/kLFg2I0CGVxAo6WNnObMHMMKTDfE+fIZHUMdON7dtl7vgqPIl6I
	fMEfTw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6uf8359t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 05 Jul 2026 19:41:25 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88e0d11a3fso1435804a12.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 05 Jul 2026 12:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783280484; x=1783885284; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NGgGvwnqAVQQEeBPG1kTtk7oaNyoX+6Tcm1yJclm2Pw=;
        b=OmpRfAVrTcjRXESJ9FAr28Xh5D0/n6hN0Qk7c0iolafM6KFOd4IbB82gZwkard1o/T
         VpN2fjUdjVo6SBl4DiLk8uRH+m4+i8CMPEbRja9BzL413FgzhAW2RsgE1KECzZ7QG9nl
         DpZc/0FgQSOK3gwRDaK/521r7dc8/TRsznSHf+lEsDFlb3EMJ0P4ZkvV2brGqlrPc3wZ
         2TkpPXk7wxOsYDn2EQ5PER7GuTU05S1In9ObrhLCC38ERqg7Ld/LBUipHBwhoyyubo+s
         qJFfmBYRYuZfh/l+sS3LTP4a3LeHqhYjfDk4lSvfI8w48HCuJhjmk6xrK+MRPrE8GF0w
         UnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783280484; x=1783885284;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NGgGvwnqAVQQEeBPG1kTtk7oaNyoX+6Tcm1yJclm2Pw=;
        b=d+BzbiizKlMf3mW/cZySU5cQn/9R6l9dhWSv01h4k3ZqyLYPQeyIMplI/Ovof1/pEb
         8tUQsSZxV1znLlRQ7etBpPqWam73PKCrInDBwQwgpmmQ9NnrvMQQenAwmyNbPL1EubHk
         AGRYb8Z+eHKxVSdPLpt/10XnnNjtJ8L17eEzAPv6duUJ9r/nPIrvpNe6107jpXfgaLMY
         WQx/Y2hecWfsSyw2WPRo/nyWgJfsMW8EGOqZ9fjZw2L35plxfUlfXTWj9f4F+VZIbvhp
         2FbrGchehxpTWuXvx0M7iy5T5t+QhdRTGYkLBn/VWLGytfPQGKJNr8A/jDZefQyC2reK
         oxfQ==
X-Forwarded-Encrypted: i=1; AHgh+RoKi+nfQ3AnEUVTbrDIB9cA+BYm3sh0EQ2IKwwnmNAEpmmjtHAqLRYYZc9QBbisZwpTvtus61foT7zPmv8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyGONDzvSz1B3ofAPOEUOVu++WuefDDSolgcR/X20r1UT1Cs8zE
	SNelKLwBY9z45kxSX2Pq+5OQlPKvty6QPQYofDDD0NxeF27TozsVh2twb52U9HYqKnwS+jUWDT/
	r4Ozw6NEfmYIS+bVzRPiE4VqsM3IHJz38l+1Ez85Xwlrt8t+85cR54bwNYpAo/PIgcAjt
X-Gm-Gg: AfdE7cnTCRTl+8L3INxRe3NAuDI06JwuNtaeRut5kNFXGNg0EXzqhU6FTZulfvAICeZ
	N7KYmrMKs8PC974Q514CFRCQdhzzjAitPN7KxIGFhh8qsCnM4zXdEZo4T/6OvSD+b6AyP9jug2W
	RV+qKFosOi/K8/MduJK/9kGu1CAFLVfpnvg1zU1Cfom7gtHUEbKS5TUGNW4Vgc/5Ah+HTXP+qRW
	63vXA8mE+4QTWbCsEzFrydXHlsvmJJWs8GLXlKhshbyUH+CntDqHHgfjogXd4oefAG50TJZeM5p
	5teB3whbAatRdk+S/ExcWaQkoPaKUAd/zRLRQ/i0s9czStJKFyOgdxjm2JnmYn956hhA95h5sgD
	hyyF02mxA+8rAa5fG2mQfdWqNMjQdtr7B4pb8Kg==
X-Received: by 2002:a05:6a20:43a9:b0:3bf:9e25:1a13 with SMTP id adf61e73a8af0-3c03e26ff8cmr8745228637.15.1783280484465;
        Sun, 05 Jul 2026 12:41:24 -0700 (PDT)
X-Received: by 2002:a05:6a20:43a9:b0:3bf:9e25:1a13 with SMTP id adf61e73a8af0-3c03e26ff8cmr8745209637.15.1783280483924;
        Sun, 05 Jul 2026 12:41:23 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:41:23 -0700 (PDT)
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
Subject: [PATCH 41/42] ASoC: fsl: imx-rpmsg: Use devm_of_reserved_mem_device_init_by_idx()
Date: Mon,  6 Jul 2026 01:10:17 +0530
Message-ID: <20260705194019.2565498-9-mukesh.ojha@oss.qualcomm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3eimWuqVeM86LoB7Wg1d1I7MiKcrnt9Y
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX4X8K5x87Vu+D
 bys2xYcdwgANtjGgPBm5o1YUG1qrFpEDt+bhiBrPhOtJ7kNXNFu/hGiTjvCQV4EGgQ2RP1zD+P7
 rD0BUYKZdwoi5iJ3f66MlvTGeY/CuqQ=
X-Authority-Analysis: v=2.4 cv=Z4Tc2nRA c=1 sm=1 tr=0 ts=6a4ab365 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=dtkDxOtodmQ1SLiiO2kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 3eimWuqVeM86LoB7Wg1d1I7MiKcrnt9Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX69QefNBRBBTy
 oqdiZzbwNbww4+nfazKULgNLXI5K20yh4t8sfTu9fZbooiZ2lPSKGe8dBy6+bjr49Lg8Bwms4Pk
 GCuImTqXJ+N44nJoLdolW7pE8k4FTe0X31NeajIoYYQrJyYk1ZS9v9jNRIfy3ZFo+8z8Oz2Dwks
 6GbAe6vjqMAhGZOCqkQ+rheDRu9VEl1FSHtX8s0vYwMG3TNA9crrS509qf0IS4TIY8f0l2hqWrH
 ++c0D4W5BxeMK7rpAL+NejtSR8NTpcvoTUpoPbq0RZh+LftCI/e5dSqvX/eTV0Xdgkt5GIA7UvH
 l/WsksqMK5iuKSdvicSS22Ge6Wrf/Om0I9qlr7G8LRhsHPjUvy97DxNv+Pwp4cDIgJZhzM+/Wm+
 z03SYaOT1Nt3lub79PrynCXBOPHSOqGPYvjd2T29HUF7fdt+ALe8XCtg8wSYVycmmU9Vqd2XN/6
 TADmkAmX6gFUA/OfiSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050212

Use the devres-managed devm_of_reserved_mem_device_init_by_idx() to
ensure the reserved memory region is released on device removal, fixing
a missing cleanup — the driver has no remove function.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 sound/soc/fsl/imx-rpmsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-rpmsg.c b/sound/soc/fsl/imx-rpmsg.c
index 5f1af258caf2..f504d94c4f68 100644
--- a/sound/soc/fsl/imx-rpmsg.c
+++ b/sound/soc/fsl/imx-rpmsg.c
@@ -199,7 +199,7 @@ static int imx_rpmsg_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	ret = of_reserved_mem_device_init_by_idx(&pdev->dev, np, 0);
+	ret = devm_of_reserved_mem_device_init_by_idx(&pdev->dev, np, 0);
 	if (ret)
 		dev_warn(&pdev->dev, "no reserved DMA memory\n");
 
-- 
2.53.0


