Return-Path: <linux-aspeed+bounces-4928-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDDBC624D4
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:19:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0Zx5Pnkz2y06;
	Thu, 03 Sep 2026 10:19:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788379709;
	cv=none; b=oJ6VYhdrvL8y/DISdPHUPSEefeScN2tDwYL4DLDa1FYxFK/p94Sjr3VRcqHiSnwWtCHaFMUnQsNUrKTuSsdbwCVAsjmVOldLZTEPzTLN0HMRYwex6xveI3r/2ySblNNnOHE9OiNuj1cvY3iA46P3Zv7UluURl//Be+1qR1RIrOePbmzPb0U+nxnu8Ei0JcnhnH2gns3yC/NfBJ03ILixe7ZTujt4u+tk6Z/PsmDtktjKsy1lLa1BvlV6sz7o22QYrcMTPsxSCtyqifiK7x+qP5iaN5scKCIU6o+qByf7dBEtpfI+xOo/Hh6bnBHG1V4j1IHzTB9Uj10UsdvD2QoJiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788379709; c=relaxed/relaxed;
	bh=a6ghP9glQZIjLasHwBOsrO1uiVG300zETw/KSJymUtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXDr5RIepXzFeN7BJVchUSJamLTubsRgc4XfaMCNHpXwk5Y5P8z5IS9+G30zjOQSI9uzXzyqzWQSJ6wewClpKFboOVnfSl6NAlGi0Jb8hiLo7Q1a9BY4Dxd5wYKHQxbxtPj8xy+KjCvOz9ZUBbQxeeCUqaNQVdWYtY2lOHCl5GYAoNtPpUpGQtllK3R+q7FD6PNisT0pE2aF41aCLkqbNnZovD83Ax1ID+wFPGeD3fkXhD0uJfw+h9lIPVkx5Lw+gyUiJYQqC5AxgwNP1VthJd+w0/XqP8fATFU+Oojq84vdWvMo4E/wqF55tuUO2J744L46tXhoLYh2TxOv8mhyow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oz/tv1sR; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GTQLtUh8; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oz/tv1sR;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GTQLtUh8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZv1S3GyJz2ypW
	for <linux-aspeed@lists.ozlabs.org>; Thu, 03 Sep 2026 06:08:28 +1000 (AEST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682Hr3hW2372899
	for <linux-aspeed@lists.ozlabs.org>; Wed, 2 Sep 2026 20:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=a6ghP9glQZI
	jLasHwBOsrO1uiVG300zETw/KSJymUtA=; b=oz/tv1sRl/3WsGWjrvJ22sIWBYb
	EK44Eaj/gx7eSgTeGrFcBt5xotgqCYwj204u2D0Ndd3sEk1CT566XOJaRzl5VqpC
	EbEiiC/Sm70Il6ZcpQ1Ov/NdzUMXu1/Qh5WISHG1p9iAn+cPO5nWSkGhU+MTBev2
	tRFRmXaaICjuberKDCp9omSoB4vhP9evTmwK66S0w45DyWz7Iw8r8xrQISBK1dmi
	fkEIEA2g/dFwWupDcNawXcQpj0E0Wo9XOuag+STbTcUpHqLyXrUTMbOIJszCF5rK
	DtB+rd2+Is6sHEHgkmy94RiOKEOgofNKpIiX38htK6gO7L7l+GjQ7AdMY9A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gejv8a7a1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:08:25 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-398e1f7d1a5so2377510a91.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 13:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788379705; x=1788984505; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a6ghP9glQZIjLasHwBOsrO1uiVG300zETw/KSJymUtA=;
        b=GTQLtUh8pXeLm242m5CgroRgT3J6fcr0nOHuidCcf02taojqR0Yndb1ZyvpG7Klvvp
         AlizSj693tADNTkg82RnSE/lmnxrxfT84SbDCINPS+7REsfP6fmClWpF8A9vPMmlmQ8m
         KVpHB9Zp2vtNcWLqORm5EI3y3KS9M4AmcPle85X+MXbHYiVk2TGH2SdpsPzNEC71YOfH
         ytgC0n6nEm5at3xZmXtoiEQ5u7FjZ0a9li0FwXxrfaNwqUmSiAnlnDGgNc03rJz2OeBK
         D13JDQVX0zWTQbLooc1Nk0neCKc8RCtkKgvT9a1dKoiZD7AK9Qafk5D8QFsfRUlwaeAP
         FCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788379705; x=1788984505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a6ghP9glQZIjLasHwBOsrO1uiVG300zETw/KSJymUtA=;
        b=hed+wIBt/dbzQiPGRxy6UVaVClbaN2SretwG79d9gZ+eJLjLPRx/YFDV4TbTpF1N31
         d8Pevw0LfHmXBqFD+HlDxmh0kfcC3YKO12hVvOwfnlba2nuXx2EbEXtiDcU5dlxeJWrt
         iVWVlxokE6wjZH+HpYhR2+xhbm19GUzUbRhpgAMLIPmdXYTzKamlM2Vo6YLmP8cuAFW1
         A6wQXTwqWXV2J8+AxbrW7jcxdDY9MsFQBjr/xM6Sj9s6R07iu9im21sh3nRK233obXBr
         R+qZQG6w71FbGD9ABh/dQDdwn0bIgYeRszCjawia/DofJRYDPZF+fN07BU1m1S0ePw+s
         DVyA==
X-Forwarded-Encrypted: i=1; AKwUvBxmCth9z386kYFSdYptQMaZJ+AWizBj7DywH722CXgJQ1Tvtt+RdBd26wKsi7fCxomzh2Z8X4Qnc3ytZVk=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lXxt6lMeQ+pQ1n6OPF6j+lDtxNWdBYsJ8wcek6ey7dogCO/zYL
	qUIiMvRQRmgxGGgSPYO1sDyjOde1UmueHoMstXA3GnxVNTVfxY3d5YoQk6wSrIslx6C4anRrx72
	JJIZ4kV18Ch1BLaDFP4WcYFYbTR8NeicIuMQVQ/9BxtC33e9paFMjWN57fZh2Ya4T9rdq
X-Gm-Gg: AYBFou3oSch/kj5zNT3mJVm3Pm1qQFodCWd7v4lYr+LUiHM0QohswzgaeQ8gskA/1A7
	jzjRE1UGg+v0GMJuwUgje3i1Z/jgi6c6rbiVWaTLsVL6hFpb0Ge9eUlr4cFobsIEWGSoimchqIh
	5/cVTrVYWcst7Zj8A3aMMsgY5quprOoEc9kTfTRvM2igC7AAakna1Om0HIhoov+8+Q+MEfZ6XoF
	IpFz/xMeOb3trEQKofac/txQmaoP2lBdKQ0vT4QtVrCaicN8cfy7pQbZt+NIUTQlqu6FkOh1WRu
	nUhrj94Hw0wFAW8BWvvZXKbvtYoBolFimAxpFLKTKl4hmqvlIpB6LoGeCJ5LNQfy+85Eaj3F+bP
	pxvvw50KQIM7MaJ/IMSlU+Y1umhI=
X-Received: by 2002:a17:90b:2cc8:b0:398:dc16:3c29 with SMTP id 98e67ed59e1d1-39aedf7733emr11293385a91.7.1788379704642;
        Wed, 02 Sep 2026 13:08:24 -0700 (PDT)
X-Received: by 2002:a17:90b:2cc8:b0:398:dc16:3c29 with SMTP id 98e67ed59e1d1-39aedf7733emr11293267a91.7.1788379704103;
        Wed, 02 Sep 2026 13:08:24 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33255f2981dsm434360eec.19.2026.09.02.13.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:08:23 -0700 (PDT)
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
Subject: [PATCH v2 6/6] staging: media: cedrus: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:37:03 +0530
Message-ID: <20260902200703.2016410-7-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-GUID: 3CfsWZPprNR8lFEoaC41dpiZU2HaTPaC
X-Authority-Analysis: v=2.4 cv=L+wtheT8 c=1 sm=1 tr=0 ts=6a988239 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=mTAD4mZO0xO8FHYJIeoA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OCBTYWx0ZWRfX8VaLqykcmYTQ
 wSI/MFsOx4A7lUDXsm/z32LeL0JcX2sqR3ETlGOXQzhaAaWX81a8Eo6xcLwSgW7o8xjVsRAtUph
 9PMe89DQjOcc6uQq1r6fViG457966gbItYL2qkCHHWXcYGJC+2XlKOUkq2KZA8ohjCKPilnPRiK
 fvZaoZe299H1Z0rn8a+oHXNpsIL9pPuMNfSaAdWgzmYOfJo4YYHAAmESsNJnn+yhrk5DNjsv1TQ
 Wj67Ibim4OdCOJGSqeFPphws6wubDHgrmALNS8fOR8RWuTJXd/pOkXr60ItDoy5MKXadiD6iJDr
 Dd7FYABACqTDoO3yf7367iNWl787zDYu/0jGYI+482kIX7gMpnaWKL8lqKVdkIAq7a2DAjZN6Uz
 sTpsm7Ll1kjc0NdM7/n4fkjiVlELqfTKtA3RNjdPVfrJ85PNIMRv8yrSaRzD/0bGTwlyrO2W/cR
 mdFWb0Ti0tBRU6DzCpw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OCBTYWx0ZWRfX2iyM+BSuFszt
 Kbleo3JA2dx++r/4kZU4Zr6/IwR7mkgR/8kzPFR4KzvtPxagqWnAn9lJMHs9zGpVZWnkVUKfz0o
 Zq0/hQCKNuqPftC2vkiob52MT+y3qlc=
X-Proofpoint-ORIG-GUID: 3CfsWZPprNR8lFEoaC41dpiZU2HaTPaC
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
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
index 444fb53878d1..4a15f45ad077 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
@@ -266,7 +266,7 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
 		return ret;
 	}
 
-	ret = of_reserved_mem_device_init(dev->dev);
+	ret = devm_of_reserved_mem_device_init(dev->dev);
 	if (ret && ret != -ENODEV) {
 		dev_err(dev->dev, "Failed to reserve memory\n");
 
@@ -277,7 +277,7 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
 	if (ret) {
 		dev_err(dev->dev, "Failed to claim SRAM\n");
 
-		goto err_mem;
+		return ret;
 	}
 
 	dev->ahb_clk = devm_clk_get(dev->dev, "ahb");
@@ -340,9 +340,6 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
 	pm_runtime_disable(dev->dev);
 err_sram:
 	sunxi_sram_release(dev->dev);
-err_mem:
-	of_reserved_mem_device_release(dev->dev);
-
 	return ret;
 }
 
@@ -353,6 +350,4 @@ void cedrus_hw_remove(struct cedrus_dev *dev)
 		cedrus_hw_suspend(dev->dev);
 
 	sunxi_sram_release(dev->dev);
-
-	of_reserved_mem_device_release(dev->dev);
 }
-- 
2.55.0


