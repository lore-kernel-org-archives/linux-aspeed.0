Return-Path: <linux-aspeed+bounces-4930-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D95C61DD6
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:20:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0bX4BM5z2yqT;
	Thu, 03 Sep 2026 10:19:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788379678;
	cv=none; b=WebXlA+6ZJsF7Lfa9NqjzV2rmLbC1bpU6KgED8E7opcQlHv4/6ub9sax7mPPwBpjqUwIozM7fDfesWHSF3umZ4NLRmL55ruW5TqmIu7GmHb83mnUJYGiGuJUknIDSYrOT7QKSAPXulTtdp57IFsCcAomnFNJ8hwrIfWaU/m2OGCuFmzlITenNzA5JFwEe1nc8YTGN2Qxsh0tCy/52n7DWjqQbCrWTaIN4iz7hJ6hImId8FmLgzLuxtrGrN4wiv/YKNYFLLi57fJ9UmG/a5PfLMZLyj0qhEZTGEwHedz+HhfaSqg8CYZBGjAHESjCo1DzASYhNMniWpx1J/oKdg5EKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788379678; c=relaxed/relaxed;
	bh=nNFPGVLFvx/AoejV7EuP46spvaHGIWdJXEE92/o9lnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxuGYEU6FRSiieBDxInwNghXD3ZuwiN5KRhEBdxLiGBEYcZbD6+K0462Dvk3L8gl+2EzK2PxSmHjJb1zwNi63eFZJDiXOlU/MJgF3lAD7ETGaRYIHOMHyy+uBLBN0G+ejKzYOKbO3dO2A5MKanE5t33NHp50ItOA1cSkZJIeqx4OictSum94O0YXv2UzQ+qXugUQp0yQbGoqcBIH/bGKZh9BTS3ABsKfGHBE5x9/EWfc/pyvG3y65+qBPWoSeRTTOQBmUnfNxucaxofNvGB9uwnvun8PE6SSQPjdV+kbQpvnboy7LcvvNeWvZ8C/hlRpXiVgM7SDCkgJqNtMx4GddA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RkLi7WnJ; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UwAu+1GL; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RkLi7WnJ;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UwAu+1GL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZv0s3SB5z2yps
	for <linux-aspeed@lists.ozlabs.org>; Thu, 03 Sep 2026 06:07:57 +1000 (AEST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682HsP052485892
	for <linux-aspeed@lists.ozlabs.org>; Wed, 2 Sep 2026 20:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=nNFPGVLFvx/
	AoejV7EuP46spvaHGIWdJXEE92/o9lnU=; b=RkLi7WnJT32eVWIHPuqGyOBqrKx
	lRcdCPBgHIjmgPf3yvBqtGbaQixnj6ftcYW0RJFHwL1GxlPgt8fDs7l5XahvDSXv
	GBzLzbnu6xQhFr9WEDKDxSv5ov5rp0a2WbO3TpWzXL2SluF/ACdKwDJ//vR0sczS
	dlp7itw01lxD0F0CYFvVxThG3wBhuSnbxhVD3HCV9DzZZwH9kFX9l0w2JiCQUvOh
	9B5OowQg2lXl+5sIheMW/+4e3m8E4zXF/O5piBworS15amrwo81Cl99TqwmFfXPT
	UxdW7ISqBefM7BMGUp2qga0M4hsnsK05gBLNm3AWfehEX8FVad/Q6GKSY9A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemjh9p98-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:07:54 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d9336581a2so25349765ad.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 13:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788379674; x=1788984474; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nNFPGVLFvx/AoejV7EuP46spvaHGIWdJXEE92/o9lnU=;
        b=UwAu+1GLosqLuKsBK7x6uX9U6ZaU0DMQOuLK9n8Jm5begq4J1p2xUwLLyaBxOM/M5Z
         7/dvEpENBJq7JSeITkbo0sfSl3Jv3SoL73NBJIkZLR61e0Q/1Le4QB3m2kfR/5YyGOMW
         sbhRFZxsKdSbHeC1f+uFEWg0dbRRubxrwk9IJSl5weWds6rrRTFw6JZa7YdZsIlYVtRj
         UkkDu2NLm4Ud3WeHs76XBV/Kovs8G/A1i7lXQWAmeSkhlWsxmnU0lu37wsWvvTd6Eudx
         pJYRL2sYiH926x6Lto+0EcZF4p9eIn3fOsPzTFleKV8oKsuprswqBnRuN0w6zUN2PDxs
         FjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788379674; x=1788984474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nNFPGVLFvx/AoejV7EuP46spvaHGIWdJXEE92/o9lnU=;
        b=Uglt3XsTtnxoLrq84HOBcKYdqW6Tk7lONM8fLoop7zb9YXcE9Ssuz2dOmwdb2YLMtf
         Bdpz6GJrndR26t6YVfVFtmjYGwh9A78wwia9ffnmrufXxLy4BiP+J3FpqTs1J0hmNkKz
         nMUP+VPGEE6enyMzaCmXUg37OZ7awzi3X/xVGKiR1CQROXstiZ+Tr0vB92Del5aNrtOs
         ncSYkuwxW3FVyqd5XB2fw3ztRikYIBM9Ma6PUd3P8KlSXOgTCnMeb5SqbpMCkgimp2UI
         luL5xfyZzfiKEHqANlSMGv2zzZyPD/2gh6/2lIQiwXWdr4xPXMJc0mk/fC1eSszi2UNq
         0TwQ==
X-Forwarded-Encrypted: i=1; AKwUvBwE8EzQMtGsYpURXWfvqLF1zheJ+Lq68HFouj9CGMK1EwwWLwANSyBY3dki2qrQPltRKpP0Qp4vqWZIMhE=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l46lD6OvN6RoscW2/jIaR3P5WHg6OYJNSBMz7+0PS1WEYw3N8J
	GoNBi0PL4orflZFka7/RD3Y2P3yTwbv1r3jqrN60X/nmmr55WgqKeKS2+N2Mbfsjd8Ap7I/1grn
	hWU0XGvPNRxzteV3CT9Voo1zIPyHNxpTKGsPinq/+x9d7eRWYnqAP5Kx6p5AAz6rpkznl
X-Gm-Gg: AYBFou2HpqfiMxeJXTxGEn4jGIcOcUIyCNZ6HbbDEDBw4bQdpd4ucZIO+uoEkXrfSv6
	Ww83GfGpEz2tSI37aj9Q0rcjKsown1+abgJPrvjjGfl4pzsNeqfLazGgeKFfs1sJHR2QUySmM31
	iNMJeIjxQYkXEHxmhksK5EgqAQI/ZxDDz7eEcg86ftVESviQR+3WFO57cFfqq2vrR63at891NUs
	EaU7FXgOr33DfsqMes+U816d9B6FtqjyEdCSNJVDTBCl3JtcEWm8Lp+8Abw9jgx4KVCjO5fpkn2
	+FKVrzbG4F/+K1NB+mDaVZNGd/8DxZI53RZ8DVrxms1vDNL/em4bdzwiJm6iW/tRhHAmO41Jdli
	5P7AhlyD7yEZYlNKgw9gOQJFDLdc=
X-Received: by 2002:a17:903:1a30:b0:2d9:2688:8be6 with SMTP id d9443c01a7336-2daec71ddddmr99505615ad.19.1788379673740;
        Wed, 02 Sep 2026 13:07:53 -0700 (PDT)
X-Received: by 2002:a17:903:1a30:b0:2d9:2688:8be6 with SMTP id d9443c01a7336-2daec71ddddmr99504475ad.19.1788379673206;
        Wed, 02 Sep 2026 13:07:53 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33255f2981dsm434360eec.19.2026.09.02.13.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:07:52 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Daniel Scally <dan.scally@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paulk@sys-base.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        linux-staging@lists.linux.dev, linux-sunxi@lists.linux.dev,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v2 3/6] media: nuvoton: npcm-video: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:37:00 +0530
Message-ID: <20260902200703.2016410-4-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902200703.2016410-1-mukesh.ojha@oss.qualcomm.com>
References: <20260902200703.2016410-1-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-GUID: nV8mKO0paIr3wetdDoVNOpMB6wtbYN1p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OCBTYWx0ZWRfXwGee7NSiEBKx
 +jvhID/bClC8gF3hsP90vRVweQNl1osQkotbG69UX4xe2Do0Y+psyfD+BRAQknBFU57qwZrr3Hl
 ZbGoqYMe/Na+Gpt5T19N7z9/02jRQRrN6IgIjWHinnnPc3ZKf8EZL/Phw3+WEGoENGaCHA/hiR6
 0mxAtn5stFaYzY7QQG1rDG+vZrqqiilm/zqQIi/seFuh1e8z9ukpDjWzES9ta7vFvqz3c0SIcRT
 tWac127gTeQZk+Zq11ws2OSfMFBc+TrOy27sq8oT5S7SnGrS2ayQtvv9Hlx2x5ZMfgh/WcR1QBh
 YxL+W4D5jKLGvZdm+seLAeuZo9T0/HIn1epbautUq1avML132UaWg/o/93ycqC5KMJ7z6X900Eb
 2QeRkSVVZL5QkE48hBk43VntjtKVclWzhcG1MCzIH3EK/OHjw2b6RbNB1P4NmsTCZPLfdjBc+0v
 mP933wG8f2jnOKNlm0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OCBTYWx0ZWRfX3L01tlcRE963
 Jeg54gjmfxTLu+OOaT06bsr3BWaTDNUvONmTzckux+AOcfG9CCGOzP3+F184se2nDJEZmCDu95e
 a8El1X0DGW2eWkFxiuhELNtBAr7Ytkg=
X-Authority-Analysis: v=2.4 cv=ErHiaycA c=1 sm=1 tr=0 ts=6a98821a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=iFm4xv_JmjgOdRhw77YA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: nV8mKO0paIr3wetdDoVNOpMB6wtbYN1p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020178

Switch to devm_of_reserved_mem_device_init() so the reserved memory
region is released automatically on probe failure or device removal.
Remove the four explicit of_reserved_mem_device_release() calls and
collapse the now-empty err_release_mem label into err_free.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/media/platform/nuvoton/npcm-video.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/nuvoton/npcm-video.c b/drivers/media/platform/nuvoton/npcm-video.c
index 52505af35c08..6786736c8f07 100644
--- a/drivers/media/platform/nuvoton/npcm-video.c
+++ b/drivers/media/platform/nuvoton/npcm-video.c
@@ -1715,17 +1715,15 @@ static int npcm_video_init(struct npcm_video *video)
 		return rc;
 	}
 
-	of_reserved_mem_device_init(dev);
+	devm_of_reserved_mem_device_init(dev);
 	rc = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (rc) {
 		dev_err(dev, "Failed to set DMA mask\n");
-		of_reserved_mem_device_release(dev);
 		return rc;
 	}
 
 	rc = npcm_video_ece_init(video);
 	if (rc) {
-		of_reserved_mem_device_release(dev);
 		dev_err(dev, "Failed to initialize ECE\n");
 		return rc;
 	}
@@ -1789,13 +1787,11 @@ static int npcm_video_probe(struct platform_device *pdev)
 
 	rc = npcm_video_setup_video(video);
 	if (rc)
-		goto err_release_mem;
+		goto err_free;
 
 	dev_info(video->dev, "NPCM video driver probed\n");
 	return 0;
 
-err_release_mem:
-	of_reserved_mem_device_release(&pdev->dev);
 err_free:
 	kfree(video);
 	return rc;
@@ -1814,7 +1810,6 @@ static void npcm_video_remove(struct platform_device *pdev)
 	if (video->ece.enable)
 		npcm_video_ece_stop(video);
 	kfree(video);
-	of_reserved_mem_device_release(dev);
 }
 
 static const struct of_device_id npcm_video_match[] = {
-- 
2.55.0


