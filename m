Return-Path: <linux-aspeed+bounces-4952-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3060AC624D6
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:29:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0pK2nsjz2yrt;
	Thu, 03 Sep 2026 10:29:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788379668;
	cv=none; b=mwFFXZ1/wDjd9IA3j+nWqDhF20vOZmHhksIkOjiN6O3wLoWE2lAT5P3po9SfzE7SWQ6D2oE9QglO82sPFRIbNs3TrRadb7x5xEl3atZikbR0KKrq7ljJu89Uea9YJv26hGMHIB0Uha/bpYkJOh0gnr0JbeKwAqc0dYdJ8mo5OB3G4dGm9pqx6TRkb9bs8krqBYS7uUntvNwjK3Dq24HFHiDOyZBjMwCtzSfS3UmAjzExOHUpFoZDiGa5ngRdiMt9JfmLiqxJ6kseQNhBNbjA+LW9DYOcSTRAG0zFswmm+AyGL6ZX4QFv4v/d62EwZbDz5jc3mGMizBx9xyw8JyES5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788379668; c=relaxed/relaxed;
	bh=J9W8P08UQPfJw5C78sAv5RWAvY1aWehRnRIhk1Qi+vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKzxIo5Gp+A1+n34u34bFlDZ4u8VQAP6mt55GU5WAJCKy+AoU1OzmZRcdw79jedwTF49LoGcGDWwQIMy4d0x93JvUeVsWh1y0mKmEv3r+9DIrN41TaJUM8XIUC5k0HaU2HvCOWQIy7X6ZLE1goLMGKifYUCRQkuHckhdqr24g76YSUpU933tSSfXLZ0ajrs5tlZAuZ2YDrelM+/I+RNTKi0ACmRDKIZEoqujydTcrkF6OiNTbbPZEbseUJV3nT15WDtEf1aIkUkYxV7nEk6yosiXleFcrucoo3jpSTd/IXmpoSWYF5M3Bx6oMS3sU4iwNrFlztKSTa9shoV0X1DqFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P64iHGeU; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SkQ7OBvp; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P64iHGeU;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SkQ7OBvp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZv0g0cXsz2ypW
	for <linux-aspeed@lists.ozlabs.org>; Thu, 03 Sep 2026 06:07:46 +1000 (AEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682HqmlZ2270341
	for <linux-aspeed@lists.ozlabs.org>; Wed, 2 Sep 2026 20:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=J9W8P08UQPf
	Jw5C78sAv5RWAvY1aWehRnRIhk1Qi+vw=; b=P64iHGeU+wqitnO2yOTz85CPPMC
	Nh9EN3gs+0SkmrParjRLd3P0cOTDHlUIuwGLTuKjTJxj2CRNpFTYEG6MPoVkvEoN
	KRHTCcUMHiCjR48T3RBTIkIlHfwEfHUJn8w9LZX6cIPl6V72APy3F7KN8w5EZhOh
	JmIfKfn1M9o8qLLLslSCCHkih+JlFWsLs5eIut+RLMcZtwCohJ/vch0JdGhdKGlx
	05ci71hJL1xR4/y/O1dq2OyMXjVfwO3NqnxZVBv4QnG1GPIFy2RU34XcrhpbqbY2
	dqXpMxp8akRJCDdTl+S71BL///ZwoRsnXT5kuM5vJcaDjuDRWHNG9Ls4ndQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gej2cafy6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:07:44 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so2596587a91.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 13:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788379664; x=1788984464; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J9W8P08UQPfJw5C78sAv5RWAvY1aWehRnRIhk1Qi+vw=;
        b=SkQ7OBvpfrqc7OyHy5AsSkCYDNuvoY0X5RBhzxOLuqDNiafJDlAH3AyWtP1HVSMbvh
         XMYaYfDPba4pyng5bGCKb1tU/KDIq3i5LfHUMNc9MH/xjy/IPE5tlC1QoQwTGWbFd2Tc
         QnzFsedL9PHQ2kxu7qg35Ukf+yKD0rk4JmHLraCHy5JWuXFGDWs/VxniS6imY77e4w/K
         4Z8HaO7s2ux4YbRFzmiPM0J6q9UaC3irq3Z6IMnRkGqw2ZSgGwwt2hFh+2A9KM9v00lQ
         CilIqg0HfBhpKYC6LvF6FQjKx+gVwHeZwROBppD2dAuwCEm3TxJrRTSIUWImG7Cil1WM
         0k0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788379664; x=1788984464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J9W8P08UQPfJw5C78sAv5RWAvY1aWehRnRIhk1Qi+vw=;
        b=oUUdX5L5riYrH4SGCKZPjkYZweTMXGVBKMYtmNSuMD5veXKY5Vg5JdGeMOLYy1arvF
         1ftkkmIsCP78JmEHMEPZcpIBhYKUE64TCFWUICgHklMplmWCZ9H7FYa7WdvMDT4BA/+o
         fgM8Df+2mfR9z+89Zf8uiukleSlbPLoVRXUg4k5wJJcOt9GNLf+zVpPd917WjVTL5GwS
         VcbpUhh062Z80acA4MMeYFE+YMR+BYazAlLz3zarAQnDJvaueGoMKcMQ9MAjljh4GRxQ
         PFDvNuQVSHBghbEjRNVzNxPiqZILl7/WqQ88igT9DujNw24zenS6+XkUp+uAxyVNKIlZ
         8alQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+d5rqMKYMqAyR9WCXzhrGO0WLjOoOu9IBi0obDu8vZy7dpGHrY2gx2Gx1LW3mvfk3g/O8H82kH6uaokU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mTVPo5483KTr6ZS51qW/VnaFHd4YpGZXW1VRJ5RRGuy5oKaH9Q
	I4SKKK/cF9SjqJn7FDkwfkKts8kyHqJSIAPFTZEWR0HAeFD1x6ET7qsapUSPt5ESKyoJcj0is+F
	AFyrf+zqmFFalOLDWGeOsE86wf6WSTZ+gj7HgiPIO9r/RHhJI3vLq9RXuHpbu4lyTLf+p
X-Gm-Gg: AYBFou1nbuoWayf0n2ceEuoIC4rFVio0ErjhlUFLLN0accdf6nPongUY5eU3lKS0jpB
	hdJhHmy4CuG8uFCDqbmXdHKyRtq/7J5eWI4HBynzUcERe6kZTtB71quaCtvXOxe1bqTVY8UN9Vy
	iwwP0I6eH10PMoL8dW7Mx6e4lVqO6ixK3CcLHcZA90hwcCD+mxedborP/KnggCYUFO7p2AwFziR
	ZJapILIU1zsWMgWcjR8XySrh+bb+nGZba5NmGJ5ERidy7uXS9KK0U6jdCun8wnWPl2OAA2WJ130
	loBhXWdSqiP3KB0tAVLnUViC8m2aue4Uuy12QoiuuBcq4cWbcg3pp74RL2wVm86HWbR8p7Gpu0O
	+cMfewW9xROWC/Vxe54XBEuNmBtM=
X-Received: by 2002:a17:90b:2644:b0:38e:9045:babe with SMTP id 98e67ed59e1d1-39aedfbd99amr11639278a91.7.1788379663613;
        Wed, 02 Sep 2026 13:07:43 -0700 (PDT)
X-Received: by 2002:a17:90b:2644:b0:38e:9045:babe with SMTP id 98e67ed59e1d1-39aedfbd99amr11639151a91.7.1788379662903;
        Wed, 02 Sep 2026 13:07:42 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33255f2981dsm434360eec.19.2026.09.02.13.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:07:42 -0700 (PDT)
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
Subject: [PATCH v2 2/6] media: aspeed: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:36:59 +0530
Message-ID: <20260902200703.2016410-3-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OCBTYWx0ZWRfX1rQnKpOZH/8T
 kMXv7cjpuDnh6vwSzEp93gP/xDfJpSHH+GuLcMaRoYmy+G1ntEZPuHgBJPr8v3gpvz3GRg7Lcm7
 NFVS1rkUwjZEku8B/RfO6i5KlwCPfzw=
X-Authority-Analysis: v=2.4 cv=G+ss1dk5 c=1 sm=1 tr=0 ts=6a988210 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=gFEuJ_os7HuwQwkCt6UA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: ska3twP59ZCeK-pRc6jAPa0MslKmrZ8U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OCBTYWx0ZWRfX/Mi6oEvY9rzV
 /cD6Mu3MTFQ2achZuNXSyEzC1exbsP06HKkKxQW7FCQI1v+5BAcGImyAdsUtrKZIp5b117MY42x
 8AqEwWpzQJYWD5KWqdlp2bqQVjlO4ThDE1DXXOPNwbpKVOrzTEUoih4xa7fWFQMVZrb2+ZIHdPe
 UDmFQXOMFBgT8VAHHv6PI8dXGSwhxKbnf7e9sekcnBTtinotLZpNFPiqafF4TDPLzBoJb1XWBZZ
 sOqw4KHrer3qQ5dlKQUrkmF2XnASNWvex+aUoVkW3k7W3bKhv55sdQsBJXw00+b/W2xl/aWfQ8/
 MEvWAWpcTN/SMBuI/vPMKQdOBJbU8ErqvX4Zu+VjiiZslQeIPrmRNPAG9vd44QE2zCLIjG6249+
 4oOfOE5r5zA00a0OIB8JD6PZSvXhSP7Id9PEdkApzE7/cOyXoVqX2Hxa3ToUndTH4hauS+dvhqd
 JlzwUwk7CK3w+UR38hw==
X-Proofpoint-ORIG-GUID: ska3twP59ZCeK-pRc6jAPa0MslKmrZ8U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020178

Switch to devm_of_reserved_mem_device_init() so the reserved memory
region is released automatically on probe failure or device removal.
Remove the three explicit of_reserved_mem_device_release() calls and
rename the error label from err_release_reserved_mem to
err_unprepare_vclk to reflect that it now only unwinds clock state.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/media/platform/aspeed/aspeed-video.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
index a292275f6b7b..7ba9314fdbd2 100644
--- a/drivers/media/platform/aspeed/aspeed-video.c
+++ b/drivers/media/platform/aspeed/aspeed-video.c
@@ -2267,19 +2267,19 @@ static int aspeed_video_init(struct aspeed_video *video)
 	if (rc)
 		goto err_unprepare_eclk;
 
-	of_reserved_mem_device_init(dev);
+	devm_of_reserved_mem_device_init(dev);
 
 	rc = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (rc) {
 		dev_err(dev, "Failed to set DMA mask\n");
-		goto err_release_reserved_mem;
+		goto err_unprepare_vclk;
 	}
 
 	if (!aspeed_video_alloc_buf(video, &video->jpeg,
 				    VE_JPEG_HEADER_SIZE)) {
 		dev_err(dev, "Failed to allocate DMA for JPEG header\n");
 		rc = -ENOMEM;
-		goto err_release_reserved_mem;
+		goto err_unprepare_vclk;
 	}
 	dev_info(video->dev, "alloc mem size(%d) at %pad for jpeg header\n",
 		 VE_JPEG_HEADER_SIZE, &video->jpeg.dma);
@@ -2288,8 +2288,7 @@ static int aspeed_video_init(struct aspeed_video *video)
 
 	return 0;
 
-err_release_reserved_mem:
-	of_reserved_mem_device_release(dev);
+err_unprepare_vclk:
 	clk_unprepare(video->vclk);
 err_unprepare_eclk:
 	clk_unprepare(video->eclk);
@@ -2343,7 +2342,6 @@ static int aspeed_video_probe(struct platform_device *pdev)
 	rc = aspeed_video_setup_video(video);
 	if (rc) {
 		aspeed_video_free_buf(video, &video->jpeg);
-		of_reserved_mem_device_release(&pdev->dev);
 		clk_unprepare(video->vclk);
 		clk_unprepare(video->eclk);
 		return rc;
@@ -2374,8 +2372,6 @@ static void aspeed_video_remove(struct platform_device *pdev)
 	v4l2_device_unregister(v4l2_dev);
 
 	aspeed_video_free_buf(video, &video->jpeg);
-
-	of_reserved_mem_device_release(dev);
 }
 
 static struct platform_driver aspeed_video_driver = {
-- 
2.55.0


