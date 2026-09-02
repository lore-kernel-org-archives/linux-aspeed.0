Return-Path: <linux-aspeed+bounces-4929-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FBCC624D4
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:19:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0b40jr0z2y22;
	Thu, 03 Sep 2026 10:19:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788379698;
	cv=none; b=e7iM/dIGuURqklBV88obtoU1TFuW8m6y3sUEiitgTHdZvYUu8+xdAK5kwSsuidibC1eKi/5DlsK+dK7UZzDADRNZNjXJ+7YijzzwmPmP33f4Mb7USUtdjqjWYqBtqskphWNj2U71ToWrMqc+4Nv7TsDqT2VYGTBj6AFRIZxsqZpDFMMhp9As9fBsFyGTwwj02cErRLAzcOycxRsq2D1yla3sIRF6cN2CpyeOXVrK98mm7W1XcHAiYOmeb4w4VWj7Bm6qFzSa06mQbg1EUkWmF9l9KMjDb8dQDGkSVrzLdNqsjZOcNLdXOtUrljdEXX3sgJyYM8/gLwStWuaYDUvf2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788379698; c=relaxed/relaxed;
	bh=iYuD0uDqzSwHU/LAQJijWaTr64DX3VL/giE1/pE1aNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wyvuqg6dFLHjkLbsw2ViayiRNHTQZPSHqzhGZE1NVdw+cfasqRit+0OsmQQPjRAHYh2hfN1D//hZbxvaAsHloSLAXm8re6ku7ustpMBY4dBiiZTSQEzQPwcqXHUBOE7z9lzhgq+6FLDg1+T9ogSJBx5nTmJ+Gp1urxmWL32r8ZHHxyWpfuQ2OWYpBVTQB82hCEb5JvdiVCc3b63je8blvtzrOevb0eyuA3ijeoMIqieIP40+PP9RusZ8Vho5rt1g0IeTWaV1iMEK571MC4SS35525EuwW//yBR79BAGRpf2TAYYfDHROEmB2QWXwH3SX2+887TxhJcC3Z4/LixLDcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M+qVvV11; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CQDA1omR; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M+qVvV11;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CQDA1omR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZv1G0DkVz2ypW
	for <linux-aspeed@lists.ozlabs.org>; Thu, 03 Sep 2026 06:08:17 +1000 (AEST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682Hr8sJ2373358
	for <linux-aspeed@lists.ozlabs.org>; Wed, 2 Sep 2026 20:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=iYuD0uDqzSw
	HU/LAQJijWaTr64DX3VL/giE1/pE1aNo=; b=M+qVvV11pixl6KhVG9hStD56ULl
	HhKND36J+s25d8SnWLfEnCsAY3W2C+ZhwEZvtp7qAul1VrhtgDfrrq4DaqJ3ZzU1
	z1zZQu9vbVN44CrHCtmJU+rAK+B1f0vMgFdTAr7FwMGklBBSqneXiL8iZGWwEqXh
	UKPvlcpUK9dyrnYdJkNRcw7esBUv8iKEk/AQRSCskMJq0bPHgq21fdTbJ32poy2+
	nMQeKmQOL7itoHtqWbqTWimQkXWx/kGoao7+tLDMxjUAW76/aGKeVdqzanROnKgS
	lo+j+Cfv5Cx+MfNlIJRB/dUJu9xj5DWvLtvOl+rDuVSDntH2ZqBUk0bbQfA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gejv8a79h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:08:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-395543dc382so2061667a91.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 13:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788379694; x=1788984494; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iYuD0uDqzSwHU/LAQJijWaTr64DX3VL/giE1/pE1aNo=;
        b=CQDA1omRURtp6TmFYoacgGJ4FJpL0SMmkO5YuQFK5L1QEIXPG4eeEHvB1XwolkYgRi
         llFUtnB1FoOhzVKLjBUo9VOjnEmqKdtono7LHh56q5Ma9VJhOutM0yZL2I/h1Zw+PiDm
         /+GgN/YV0KtNJR8Ashno6jYRm1kv9Uo9EvDqpWlUmYxV33AtBlvjTTUr0fq95utoj8/Q
         wVXZd5+95YYS5VUI1tsDeAHQRysnOO0VxEJL0VhTUkaONgtPmrvtRJOXa8KOoKBQ0Ej0
         frz9r+JCkRcGyDHDwK2c2Uj8gQCLyIWAZNVhUrj1m/mYn4Smeg9knJJbnfQNiNyb/tnG
         R4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788379694; x=1788984494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iYuD0uDqzSwHU/LAQJijWaTr64DX3VL/giE1/pE1aNo=;
        b=gB1K3fgNanKAepq6f6KiTOsbpos31kC+fQOINq1zWjvG+ttdRAq0upAAwzC29j1tlr
         njsXGOH12Ee9lOAVESD5xK3TzMAKlrdRtlra623LeN7ajkqttfduWY2F+HEIhUVnO8M7
         /5TNwH8wt3MIbMpu1VqBkfd8234UcxEgPJbsQ/oOK27mcpzP4edD6BUrm3bhP9Y1o6zj
         IBfzXCFfm/bRT2cUwTRN+n/UuAMK5wFqSvGKTrPhgychMhqgl6RFOFvSpeMINlT2jQt/
         clvf/kQDVXE8Na3OylNEbq49IVYXVGxZCKQC6KdoLPWhW8YtTme57HTHRnOO0GdUdjl+
         PNrw==
X-Forwarded-Encrypted: i=1; AKwUvBzG6wRET4M9rvOAcDmlwt2pD+EBUB16XxH0u/L3+qvwlllWThtX4gQw2liKE/wVZVyxRQuDYPIs/qoY4LI=@lists.ozlabs.org
X-Gm-Message-State: AFuF++ntFQ2fVeWSYB1d5umNVsWyMHRPTwEoHLpOVo/O2Kvopz3Ao5RH
	u4qZhnSLxxBscs8zKN23rDJ8y0NF+wLioN2Zyhd4TyFTY5qQ+9EGO+tf8Ar/XIuUAvMunZLTKiO
	26ooxINfRR0gWASarLRZEH/B8DJa5arSUbr7YsIrS4EaeXtm2cRPAgwhbbWoDmqbtld/+
X-Gm-Gg: AYBFou0upP5viqUUPDTdZ+dvXd+DVTAa7LY03R3l0+x76Yl3PaeT+/t98C+WITsGCDt
	gEikekd0Uhhmhbi+2Wil9CjfzsuqXpz8VQFb3pyKKO/+Ni9y8o5MFknbgYErwLn9WWiPh3z36wC
	ZEImM44oRyNm+LxT9m4SvpGCUh7LWOAP3FHhfgp1yAY2+kT0wm6bsgUUahDIyQxpFRYF+ZXPAaI
	Ik4Uio8pCT3G2D+e586X40BvvkKgZd0NpVdZSiZWYTUZnGAz3h0f/1ooCoLyNY4SutNkSebAohN
	AhoXD+UkfNMUmappGQOnZ9miI8jnvSfbPIGhaeBp6mI+WJTuva7q7UarZ1r7bKQyW/YnYHMMOcy
	vwqR0mg4X/e9LYL9KA8wS+TUBo3I=
X-Received: by 2002:a17:90b:4c05:b0:398:d93a:b343 with SMTP id 98e67ed59e1d1-39aedebf901mr10811248a91.3.1788379694181;
        Wed, 02 Sep 2026 13:08:14 -0700 (PDT)
X-Received: by 2002:a17:90b:4c05:b0:398:d93a:b343 with SMTP id 98e67ed59e1d1-39aedebf901mr10811125a91.3.1788379693552;
        Wed, 02 Sep 2026 13:08:13 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33255f2981dsm434360eec.19.2026.09.02.13.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:08:13 -0700 (PDT)
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
Subject: [PATCH v2 5/6] media: mediatek: vpu: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:37:02 +0530
Message-ID: <20260902200703.2016410-6-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-GUID: wc4pjSeZ53FCh2j_t4oq4UlMmPLJnXQu
X-Authority-Analysis: v=2.4 cv=L+wtheT8 c=1 sm=1 tr=0 ts=6a98822f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=gqQKJLWYzfjTGvuwkdcA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OCBTYWx0ZWRfX0hsWR9Qgg52h
 ARcmiDpwhQcWgfPis9IFlVvlw45MzOBrtn0KtIZwk5M+Jzv+I6vA2cfSVcK9KpfGRgszcvdeBzT
 X6iGQFW9okcyXylNwSNLTCF4OKB2SGXNEBuqfdPi+pg/g/YWdgicmPs+ZD09YhsuWxXSfSljeDN
 8vGtp+/xswi0LDZbm+g/umx75V1CjUzh8jMyx1q9ydt2qyW6KHqd1FizOTnN/1fhtKtvSvlLK0f
 Jaj+nacX3ENZPmtLc17zqBGYcNsARUWgR0EbSQtuNwIc/bq56gS//nZ7sa0Kz1TL7+LU7XrIU8g
 Q5miE7VHeAFZanxilcYxmMYd8xIzpVT10QRTprtwWymxmZC+UgJaZaLof0jO092yGXcINbncrmG
 kH6No6ghaBouP0LdR6yDoi8gEeEVLH8oZIOUzAa2oVvB2R6dqurqVhc1JIWEQ+XXKu3tT/8OhHv
 mLIMr71AVWQTncBBsBQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OCBTYWx0ZWRfXw3CAXk7fcyyy
 WQEkjQX+Shc9cM3cDH/Ey6neT5Jfj9ko+ZX9dVWdB0mQ1EYfLmdL5xKZV9RVzlKtAD5XWFk3+ED
 qNkzGBe/vYWUDh6IsqeScqlRWAWUncE=
X-Proofpoint-ORIG-GUID: wc4pjSeZ53FCh2j_t4oq4UlMmPLJnXQu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020178

Use the devres-managed devm_of_reserved_mem_device_init() instead of
the manual of_reserved_mem_device_init()/of_reserved_mem_device_release()
pair, letting the device resource manager handle cleanup automatically.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/media/platform/mediatek/vpu/mtk_vpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/vpu/mtk_vpu.c b/drivers/media/platform/mediatek/vpu/mtk_vpu.c
index 8d8319f0cd22..557bffb2c2f1 100644
--- a/drivers/media/platform/mediatek/vpu/mtk_vpu.c
+++ b/drivers/media/platform/mediatek/vpu/mtk_vpu.c
@@ -888,7 +888,7 @@ static int mtk_vpu_probe(struct platform_device *pdev)
 	dev_info(dev, "4GB mode %u\n", vpu->enable_4GB);
 
 	if (vpu->enable_4GB) {
-		ret = of_reserved_mem_device_init(dev);
+		ret = devm_of_reserved_mem_device_init(dev);
 		if (ret)
 			dev_info(dev, "init reserved memory failed\n");
 			/* continue to use dynamic allocation if failed */
@@ -930,7 +930,6 @@ static int mtk_vpu_probe(struct platform_device *pdev)
 free_d_mem:
 	vpu_free_ext_mem(vpu, D_FW);
 remove_debugfs:
-	of_reserved_mem_device_release(dev);
 #ifdef CONFIG_DEBUG_FS
 	debugfs_remove(vpu_debugfs);
 #endif
-- 
2.55.0


