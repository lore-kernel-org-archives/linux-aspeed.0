Return-Path: <linux-aspeed+bounces-4388-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D28C43458
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Jul 2026 23:36:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtkQQ37MGz3brP;
	Mon, 06 Jul 2026 09:36:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783280481;
	cv=none; b=iPXusNCDiL2euCD8Zov3Fu4iJFZ5IZFG5RzHg7GxM9KFinHzxnS9ti4GwYKpskPpzD5DVtQpKSSoam70jvRM9fjiPEQg/vrJZRc4K4rPfQ0ojMJLEqT3ljkKmL+/DqKNN7BsrI0RH6NSAZWi4Nbu/kJ7fRLALnDKtABrWzuuqBVsZ1oCIfSp1q8FBUDOsLfhBm/L+nbA3sAzc/e6Fii6BIiLtjOogOntSVqKKVy+pD8t3DwFUBpj8xCio7hzxM/CcxY2uvu4B7SXpWtF3nBqcknk2/F3SWWtK6/WBFRkBTsBspcZBfMPzmM8/A2jP1XN6MwxdSENFar+1B4o82hXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783280481; c=relaxed/relaxed;
	bh=VVldA6NTRnpwPp0U9xX7eE/7+mcCmlhnYAOTkmKf4Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNOfbUBXIYwJM/49jw/VoO0NgKBYKIxA7PAXEsz4j1bg6krsS4s7iJVuAYGfBcV6K9gZFyA8gf5VXyWl1vAdxzW3e9sbq9ihQvj4n5fLzz71yZwvZUEW4hhMxn+VPlBE8RHNTFPoujsylLhEOAOb0pExw3kD4UNi31JsOgxByrbpiA63/U7m01n3swfP+gC7Ec0vMWW7/Ubvyldtt72wLRbuoVj76+bxFecL2KI5/LgcbjOH3GHJ5j0kJvifwh4dDOnMmNGaKvpUJaBPXt01b+n0/0nWimalIHqITMb5VU8pNNQiFgLPJ8bLXJeY6C1seQy/YY2FUViZjORfL8WlpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PVhvB4ar; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KSckZslR; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PVhvB4ar;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KSckZslR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtdCN507Zz2ygg
	for <linux-aspeed@lists.ozlabs.org>; Mon, 06 Jul 2026 05:41:20 +1000 (AEST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665Hi3pt2200997
	for <linux-aspeed@lists.ozlabs.org>; Sun, 5 Jul 2026 19:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=VVldA6NTRnp
	wPp0U9xX7eE/7+mcCmlhnYAOTkmKf4Os=; b=PVhvB4arTRaJVhF2SofLv+u1aVD
	jK8zIqELdsOTMECr0irbXF13Py7AAvUWwCcgloBqNe5sydVgobN3ykdNbR62SDhl
	xSdi8gXykZAYDggG/l29V+pDv8vxNl/8bfs3RsFDtihqoBwh9TvV8ccwG6jurLqz
	hXyA3tzVzG/9j/LFOunKeib03MEp2rrcHiuWykXLV2BW7biJwWZULRxuE/380H/W
	jxvEJrmSgF/oSVLpQz6WOjtRFsfVbrSe0a7iY0325hYiJ5tqlT9bhtEQhpDaeG/2
	q5Zdnz1hGEN80AyPY0gPhol8PR+yZE2CguSboTpYR821bg4icMzfKXPz3+g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txek76u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 05 Jul 2026 19:41:18 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc77a6943eso38160315ad.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 05 Jul 2026 12:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783280478; x=1783885278; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVldA6NTRnpwPp0U9xX7eE/7+mcCmlhnYAOTkmKf4Os=;
        b=KSckZslRm6q7yjX3w3e0u5FUbpqQ9UaWsVLeC+zgwjVyLKkGqb5y8E7MsnzSlFsDyP
         4ZjkuFc0oy1S+a3V2xwLCjPVSwkY//AIBMdnJcVF9sYqqLtFIYqzwP6PCRmTWtnwbbLI
         vHEAtA8woI+G09Z3sJcMvgO4H/gTvNHJi8GpDrbyo39D5fP2j2hXjECq7/yufd0JCPG1
         uJ1WqQdwfvbSRrLojOFv8OZ9WvOeekhhBD4ZZvgQVRJtwM2wEGXTWcp7EzMmhOq8KTAk
         I8vo2kq/gaTZqHHfzQlHCv7euZ9cuaR+TLEj33MJu+j5FNDTQPSywjGata4YpgvEClaE
         3AQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783280478; x=1783885278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VVldA6NTRnpwPp0U9xX7eE/7+mcCmlhnYAOTkmKf4Os=;
        b=VHgv5L1kN7qTNDiHkJJPIYHh77ztZP4Dz3sTHU5pegIf2ETs4oonVplT5Ie4jtNFSB
         3XHmkUYH6EiP4mdkddK4XVUt1JvYzGPYZ+y5CO1Hpsukz3wzEyGN6afKtfjaGzlkF/F0
         pIb3lU4mm6EY3zswfc7KnvXgMlSvovXS0aDfkooTBN/MWa61k72zAsVFSLaVVe9vy/Qo
         DyYQtNZ2fiMdBgIBs52eEO9jwHcP3mIedSrxtD8/8b80fjg5Spof3U3FMj37tFUQ5qrk
         TS0R4G/hyuawpaDLgkPZGgSo95QVfoNklOtJkX6s+tHNpNLPQ7W6ZqDln4ks2EwjLIQ1
         VL8g==
X-Forwarded-Encrypted: i=1; AHgh+RqzT4eo8H7NL9323KYeVbzDedp+vGuz6tV8zmVetZ6Q6Fnnd0QmC30HtFfqltQd9aOYRIJaOAZUHjXnvos=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwbHntt7HtfPbfnnvg9YxXPe1j4jy6ua9VGuhztsoLxDprbc3hn
	P4/chqTBd297Cse2yqjPaG5q4bc7wBqz9WL5zTcA4W0cj+fIjRSuKqgo7UqsVLSQnubQv1QV+ls
	jUhdR0DcbZSKekbB4UTvavBjTxPu7zUM+od+QVyNQ3bbc+zKphwbPy8Pzk4gjPdtaoHsQ
X-Gm-Gg: AfdE7clrVFZ6hsgi2DmMRYv98E4T/Jw9Uj3JriqYcWclbPjewut0wSymbawPCQ2i05C
	AA2rG0rY1BLMDvR6XMACarca0dBBFkKQPP7SVrRjkFQFQZ1HAqQ4RFbyZvJuX7elG6iYqndowec
	cx3aetpJwIl8+5sdSmtNfPpZ56HikeHb+I9ltphpR1KHh+nY+Xe8/WLpTnOzm6HrBU0F5mXtOql
	g5Tu5mgIh4vNTrp/0XnHUC6RMGM27XLVGztHlgnqxwB/B+4mwmzzN96l2n9vgIiBMSNCv/1cETe
	KsEgvXeWcLc/6TqGjW9JON2aDmfU+f7/1ENf61moRTVSQ8Rveat7BH/kXOHEohJAC16uwpQmpcp
	9wspcVUWxM7KRloOgPJ+h8Me7JR4kq1+5zfP9Qw==
X-Received: by 2002:a17:902:ce12:b0:2c9:c46b:1286 with SMTP id d9443c01a7336-2cbb9eba53bmr79826015ad.34.1783280478033;
        Sun, 05 Jul 2026 12:41:18 -0700 (PDT)
X-Received: by 2002:a17:902:ce12:b0:2c9:c46b:1286 with SMTP id d9443c01a7336-2cbb9eba53bmr79825855ad.34.1783280477546;
        Sun, 05 Jul 2026 12:41:17 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:41:17 -0700 (PDT)
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
Subject: [PATCH 40/42] misc: fastrpc: Use devm_of_reserved_mem_device_init()
Date: Mon,  6 Jul 2026 01:10:16 +0530
Message-ID: <20260705194019.2565498-8-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX/GW73dZ6XBQe
 RAjshsPbiMblJwomQElrUGTit9plIwBbDl6/eZM3VU2SjbDkVT4tYXvBJiD0o7HqDFHuuwZghHl
 6Ea8uHjm2DaFcL6GSwTpCate6yRDdkU=
X-Proofpoint-GUID: YAQNu4thN4lVKX2bVpn8XEpw6QdyVCP5
X-Proofpoint-ORIG-GUID: YAQNu4thN4lVKX2bVpn8XEpw6QdyVCP5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX6GteQ8zUEbxR
 uKFqMTDRCdBvyzRX5ihiiNILgWBvsMM8p3UBic2YFcLSXErkdSXjksn0GmddYm2DMi7a2XvLIkL
 cfhKXH5IMVTWf7a9STuIa4/vUl/Lyv0SUjuCcdgFkUsy/nJs02L/zAqanLoYxbMqapDopPz66rD
 DPQowxuzvG46djhRJeOHcQkQRQzhUcCeJzvHcl7RZJhDqhjp4vc/i4nWVtm2VZVUu2sUCoBOM+1
 f8/bzUHwYDVxTrZiLxJwIzixwSrKHd5oWkenWOEM1cWlArrRE1L9wPHnQz8tg3T856wxyz468zu
 yHmZ95bQEcn/zp5Xin5cTOGK9JpZ69sLjn7nByli8mfoCKWI04K/7jXdUCXrXd8788VmyFHAaAj
 /8b2bYLH0PKDKCjJZHJYeUanJFYHCw0K+tq9tf1AVwqKKn+qKLY+68z2A8tgKuJf5guUzqB0NVd
 7BE3vtbq9jLaHpDyVTA==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a4ab35e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=2vM2yDDFhuSsTauGYd8A:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050212

Use the devres-managed devm_of_reserved_mem_device_init() to ensure
the reserved memory region is released on device removal, fixing a
missing of_reserved_mem_device_release() in fastrpc_rpmsg_remove().

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index d86e79134c68..c4e05b0db527 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2396,7 +2396,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		return -EINVAL;
 	}
 
-	if (of_reserved_mem_device_init_by_idx(rdev, rdev->of_node, 0))
+	if (devm_of_reserved_mem_device_init(rdev))
 		dev_info(rdev, "no reserved DMA memory for FASTRPC\n");
 
 	vmcount = of_property_read_variable_u32_array(rdev->of_node,
-- 
2.53.0


